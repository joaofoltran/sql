<<<<<<< HEAD
col event for a70
select event, sum(round(seconds_in_wait/100)) MIN 
from v$session_wait
group by event order by 2 asc;
=======
col event for a70
select sid, event, state, round(seconds_in_wait/100) MIN from v$session_wait order by 4 asc;
>>>>>>> new 2020
