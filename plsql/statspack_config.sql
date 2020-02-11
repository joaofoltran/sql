-- CRIA PROC
create or replace PROCEDURE PERFSTAT.STATSPACKPURGE
IS
  var_lo_snap     NUMBER;
  var_hi_snap     NUMBER;
  var_db_id       NUMBER;
  var_instance_no NUMBER;
  noofsnapshot    NUMBER;
  n_count         NUMBER ;
  CURSOR cursor_inst
  IS
    SELECT
      instance_number
    FROM
      gv$instance;
BEGIN
  n_count := 0;
  FOR cur_inst IN cursor_inst
  LOOP
    SELECT
      COUNT(*)
    INTO
      n_count
    FROM
      stats$snapshot
    WHERE
      snap_time < sysdate-30 -- alterar este sysdate caso queria alterar retencao
    AND
      instance_number=cur_inst.instance_number;
IF n_count > 0 THEN
      SELECT
        MIN(s.snap_id) ,
        MAX(s.snap_id),
        MAX(di.dbid),
        MAX(di.instance_number)
      INTO
        var_lo_snap,
        var_hi_snap,
        var_db_id,
        var_instance_no
      FROM
        stats$snapshot s ,
        stats$database_instance di
      WHERE
        s.dbid              = di.dbid
      AND s.instance_number = di.instance_number
      AND di.startup_time   = s.startup_time
      AND s.instance_number = cur_inst.instance_number
      AND s.snap_time       < sysdate-30; -- alterar este sysdate caso queria alterar retencao
      noofsnapshot := statspack.purge( i_begin_snap => var_lo_snap,
                                       i_end_snap => var_hi_snap,
                                       i_snap_range => true,
                                       i_extended_purge =>true,
                                       i_dbid => var_db_id,
                                       i_instance_number => var_instance_no);
      dbms_output.Put_line('snapshot deleted'||TO_CHAR(noofsnapshot));
    END IF;
  END LOOP;
END;

-- CRIA JOB
BEGIN
  DBMS_SCHEDULER.create_job (
    job_name         => 'STATSPACK_PURGE',
    job_type         => 'PLSQL_BLOCK',
    job_action       => 'BEGIN perfstat.STATSPACKPURGE; END;',
    start_date       => systimestamp,
    repeat_interval  => 'freq=daily; byhour=18; byminute=0',
    enabled          => TRUE);
END;
/
