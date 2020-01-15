
column host_name format a30
show parameter broke;
SELECT instance_name, host_name, version, status, database_status FROM gv$instance;
	