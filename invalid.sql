set linesize 300
set pagesize 1000
column owner format a17
column object_name format a45
column created format a22
column last_ddl_time format a22
column status for a7

SELECT 
	owner,
	object_name,
	object_type,
	created,
	last_ddl_time,
	timestamp,
	status
FROM 
	dba_invalid_objects
ORDER BY 
	timestamp, last_ddl_time
;