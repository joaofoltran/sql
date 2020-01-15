prompt start of the script
set serveroutput on

prompt Inform which tablespace you want AUD$ table to reside in
accept tbs_name char prompt 'Enter tablespace name in uppercase > '
update dam_config_param$ set string_value='&tbs_name' where audit_trail_type#=1 and param_id=22;
commit;

prompt First Step: init cleanup (if not already)

BEGIN
IF NOT DBMS_AUDIT_MGMT.IS_CLEANUP_INITIALIZED(DBMS_AUDIT_MGMT.AUDIT_TRAIL_AUD_STD)
THEN
    dbms_output.put_line('Calling DBMS_AUDIT_MGMT.INIT_CLEANUP');
    DBMS_AUDIT_MGMT.INIT_CLEANUP(
    audit_trail_type => dbms_audit_mgmt.AUDIT_TRAIL_AUD_STD,
    default_cleanup_interval => 12);
else
    dbms_output.put_line('Cleanup for STD was already initialized');
end if;
end;
/

BEGIN
if not DBMS_AUDIT_MGMT.IS_CLEANUP_INITIALIZED(DBMS_AUDIT_MGMT.AUDIT_TRAIL_OS)
then
    DBMS_AUDIT_MGMT.INIT_CLEANUP(
        audit_trail_type => dbms_audit_mgmt.AUDIT_TRAIL_OS,
        default_cleanup_interval => 24*7
    );
end if;
END;
/

prompt Set last archive timestamp to older than 15 days

begin
DBMS_AUDIT_MGMT.SET_LAST_ARCHIVE_TIMESTAMP(
    audit_trail_type => DBMS_AUDIT_MGMT.AUDIT_TRAIL_AUD_STD,
    last_archive_time => sysdate - 15
);
end;
/

begin
DBMS_AUDIT_MGMT.SET_LAST_ARCHIVE_TIMESTAMP(
    audit_trail_type => DBMS_AUDIT_MGMT.AUDIT_TRAIL_OS,
    last_archive_time => sysdate - 15
);
end;
/

prompt setup a purge job for db

BEGIN
DBMS_AUDIT_MGMT.CREATE_PURGE_JOB (
    AUDIT_TRAIL_TYPE => DBMS_AUDIT_MGMT.AUDIT_TRAIL_AUD_STD,
    AUDIT_TRAIL_PURGE_INTERVAL => 24*7,
    AUDIT_TRAIL_PURGE_NAME => 'Audit_Trail_Purge',
    USE_LAST_ARCH_TIMESTAMP => TRUE
);
END;
/

promp setup a purge job for OS files

BEGIN
DBMS_AUDIT_MGMT.CREATE_PURGE_JOB (
    AUDIT_TRAIL_TYPE => DBMS_AUDIT_MGMT.AUDIT_TRAIL_OS,
    AUDIT_TRAIL_PURGE_INTERVAL => 24*7,
    AUDIT_TRAIL_PURGE_NAME => 'OS_Audit_Trail_Purge',
    USE_LAST_ARCH_TIMESTAMP => TRUE
);
END;
/

prompt call DBMS_AUDIT_MGMT.SET_LAST_ARCHIVE_TIMESTAMP regularly to advance the last archive timestamp

create or replace procedure set_archive_retention
(retention in number default 15) as
begin
DBMS_AUDIT_MGMT.SET_LAST_ARCHIVE_TIMESTAMP(
    audit_trail_type => DBMS_AUDIT_MGMT.AUDIT_TRAIL_AUD_STD,
    last_archive_time => sysdate - retention
);
--rac_instance_number => x ); In case of RAC env

-- OS level
DBMS_AUDIT_MGMT.SET_LAST_ARCHIVE_TIMESTAMP(
    audit_trail_type => DBMS_AUDIT_MGMT.AUDIT_TRAIL_OS,
    last_archive_time => sysdate - retention
);
--rac_instance_number => x ); In case of RAC env
end;
/

BEGIN
DBMS_SCHEDULER.create_job (
    job_name => 'advance_audtrail_timestamp',
    job_type => 'STORED_PROCEDURE',
    job_action => 'SET_ARCHIVE_RETENTION',
    number_of_arguments => 1,
    start_date => SYSDATE,
    repeat_interval => 'freq=hourly;interval=12',
    enabled => false,
    auto_drop => FALSE
);
dbms_scheduler.set_job_argument_value (
    job_name => 'advance_audtrail_timestamp',
    argument_position => 1,
    argument_value => 15
);
DBMS_SCHEDULER.ENABLE('advance_audtrail_timestamp');
END;
/

BEGIN
DBMS_SCHEDULER.run_job (
    job_name => 'advance_audtrail_timestamp',
    use_current_session => FALSE
);
END;
/

prompt End of the script