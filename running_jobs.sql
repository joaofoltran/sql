col elapsed_time for a30
select 
owner,
job_name, 
session_id, 
lpad(extract(hour from elapsed_time),2,'0')||':'||lpad(extract(minute from elapsed_time),2,'0')||':'||
lpad(round(extract(second from elapsed_time)),2,'0') as duration
from dba_scheduler_running_jobs;