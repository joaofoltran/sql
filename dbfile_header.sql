select status, checkpoint_change#, 
       to_char(checkpoint_time, 'DD-MON-YYYY HH24:MI:SS') as checkpoint_time, 
       count(*) 
from v$datafile_header 
group by status, checkpoint_change#, checkpoint_time 
order by status, checkpoint_change#, checkpoint_time;