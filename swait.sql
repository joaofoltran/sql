col event for a40
col username for a15
select sw.sid,sw.event,round(sw.seconds_in_wait),se.username 
from v$session_wait sw,v$session se 
where sw.sid=se.sid 
--and se.username = 'SOE' 
order by 3 asc;