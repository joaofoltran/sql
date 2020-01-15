-- Verificar USED_UBLK que é quantidade de blocos restantes para rollback
select s.sid, s.serial#, t.start_time, t.USED_UBLK 
from v$session s 
join v$transaction t on s.taddr = t.addr
--left join gv$session g on s.taddr = g.paddr
where s.sid = &1
and s.serial# = &2
--and g.inst_id
;