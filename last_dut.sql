set serveroutput on
set feedback off

prompt
DECLARE 
dbname varchar2(20);
BEGIN
    select instance_name into dbname from v$instance;

    if (dbname in ('OWBA021P')) then
        FOR v_rw IN (
            select  num_ident_intern, 
                    nom_prog, 
                    NOM_ARQ_LOG, 
                    nom_usuar,
                    DAT_HOR_INIC_EXEC, 
                    DAT_HOR_FIM_EXEC,
                    (case IND_JOB_STATUS when 0 then 'PENDENTE' when 1 then 'EXECUTANDO' when 2 then 'TERMINADO' when 9 then 'ERRO' end) as job_status, 
                    NOM_SERV_EXEC
            from log_batch_oracle
            where DAT_HOR_INIC_EXEC > sysdate - 1/24
            order by DAT_HOR_INIC_EXEC asc
        ) LOOP
            dbms_output.put_line('NUM_IDENT_INTERN: ' ||v_rw.num_ident_intern|| ' | NOM_PROG: ' || v_rw.nom_prog || ' | LOG: ' || v_rw.NOM_ARQ_LOG ||' | HORA_INICIO: ' || v_rw.DAT_HOR_INIC_EXEC || ' | HORA_FIM: ' || v_rw.DAT_HOR_FIM_EXEC || ' | JOB_STATUS: ' || v_rw.job_status || ' | SERVER: ' || v_rw.NOM_SERV_EXEC);
          END LOOP;
    else
        FOR v_rw IN (
            select  num_ident_intern, 
                    nom_prog, 
                    NOM_ARQ_LOG, 
                    nom_usuar,
                    DAT_HOR_INIC_EXEC, 
                    DAT_HOR_FIM_EXEC, 
                    (case IND_JOB_STATUS when 0 then 'PENDENTE' when 1 then 'EXECUTANDO' when 2 then 'TERMINADO' when 9 then 'ERRO' end) as job_status, 
                    NOM_SERV_EXEC
            from log_batch_oracle
            where DAT_HOR_INIC_EXEC > sysdate - 120/1440
            --and nom_prog = '/bat/br/aplic/producao/vd/mit/v00/mit600sh.sh'
            order by DAT_HOR_INIC_EXEC asc
        ) LOOP
            dbms_output.put_line('NUM_IDENT_INTERN: ' ||v_rw.num_ident_intern|| ' | NOM_PROG: ' || v_rw.nom_prog || ' | LOG: ' || v_rw.NOM_ARQ_LOG ||' | HORA_INICIO: ' || v_rw.DAT_HOR_INIC_EXEC || ' | HORA_FIM: ' || v_rw.DAT_HOR_FIM_EXEC || ' | JOB_STATUS: ' || v_rw.job_status || ' | SERVER: ' || v_rw.NOM_SERV_EXEC);
          END LOOP;
    end if;
END;
/
prompt
set serveroutput off
set feedback on