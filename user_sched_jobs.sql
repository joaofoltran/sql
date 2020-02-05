col job_name for a30
col job_action for a40
col interv for a30
col last_start_date for a30
col next_run_date for a30
col fail format '9'
col runs format '9999'


select job_name, 
job_action, 
repeat_interval as interv,
enabled,
run_count as runs,
failure_count as fail,
last_start_date,
next_run_date
from user_scheduler_jobs;