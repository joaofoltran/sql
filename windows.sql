column window_name format a25
column window_next_time format a45
column window_active format a10
column SEGMENT_ADVISOR format a15
column HEALTH_MONITOR format a15
column AUTOTASK_STATUS format a15

select * from dba_autotask_window_clients;