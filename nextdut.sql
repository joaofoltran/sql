ALTER SESSION SET NLS_DATE_FORMAT ='DD/MM/YYYY HH24:MI';

select v.num_ident_intern,
v.nom_conta_usuar,
v.nom_prog_subsao,
v.cod_fila,
v.num_posic,
v.dsc_job_status,
v.dsc_exec,
l.DAT_HOR_INIC_EXEC,
l.DAT_HOR_FIM_EXEC
from v_job_usuar v
left join log_batch_oracle l on l.num_ident_intern = v.num_ident_intern and l.nom_usuar = v.nom_conta_usuar
where to_date(v.dsc_exec,'DD/MM/YYYY HH24:MI') > sysdate
and to_date(v.dsc_exec,'DD/MM/YYYY HH24:MI') < sysdate + 5
order by dsc_exec;
--and nom_prog like '%fcf%';
--and DAT_HOR_INIC_EXEC < sysdate - interval '4' day;