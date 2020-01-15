BEGIN
	FOR v_rw IN (
		select job_name,
		enabled
		from user_scheduler_jobs
		where enabled='FALSE'
	) 
	LOOP 
		dbms_scheduler.disable('v_rw.job_name');
		dbms_scheduler.enable('v_rw.job_name');
	END LOOP;
END;
/