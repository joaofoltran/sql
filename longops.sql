set lines 20000
col OPNAME format a22
col target format a40
col "PROGRESS BAR" format a35
col "TIME TO GO" format 99990.0
col username format a22

select sid,
substr(opname,1,20) opname,
substr(target,1,30) target,
-- to_char(elapsed_seconds/sofar*(totalwork-sofar),'9999990.99')||'s' "TIME TO GO",
TIME_REMAINING,
sofar,
totalwork,
--elapsed_seconds/sofar*(totalwork-sofar) "TIME TO GO",
substr('===================================',1,trunc(35*sofar/totalwork)) "PROGRESS BAR",
Round(sofar / totalwork * 100, 2) "%_COMPLETE",
substr(username,1,20) username
from gv$session_longops
where (sofar <> totalwork) and (totalwork <> 0) order by TIME_REMAINING ;