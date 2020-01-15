-- Verifica logs criados no primário nos últimos 15 minutos --
set lines 300
column name format a100
col size for a15

select completion_time, thread#,sequence#, concat(trunc((blocks*block_size)/1024/1024),'M') as "SIZE", first_time, applied
from v$archived_log
where first_time > sysdate - 2/24
and dest_id = 1
order by completion_time asc;