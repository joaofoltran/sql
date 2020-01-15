-- Lista tabelas sem coleta de estatísticas a mais de 15 dias
col partitioned for a10

select owner
,table_name
,last_analyzed as DATA_COLETA
,partitioned
from dba_tables
where (last_analyzed < sysdate-15 or last_analyzed is null)
and owner not in ('SYS','SYSTEM')
and (table_name not like '%TEMP%' or table_name not like '%TMP%')
order by 3;