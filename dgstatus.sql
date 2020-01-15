<<<<<<< HEAD
select timestamp,message 
from v$dataguard_status 
where dest_id = 2
and timestamp > sysdate - 10/1440;

select dest_id,status,error 
from v$archive_dest 
where dest_id=2;

col value for a25
select name,VALUE,TIME_COMPUTED,DATUM_TIME
from v$dataguard_stats
where name in ('transport lag','apply lag','apply finish time');

=======
select timestamp,message 
from v$dataguard_status 
where dest_id = 2
and timestamp > sysdate - 10/1440;

select dest_id,status,error 
from v$archive_dest 
where dest_id=2;

select name,VALUE,TIME_COMPUTED,DATUM_TIME
from v$dataguard_stats
where name in ('transport lag','apply lag','apply finish time');

>>>>>>> new 2020
