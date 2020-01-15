col job_name for a35
col job_action for a50
col repeat_interval for a50
col last_start_date for a35
col next_run_date for a35

select job_name, 
job_action, 
repeat_interval,
enabled,
run_count,
failure_count,
last_start_date,
next_run_date
from user_scheduler_jobs;