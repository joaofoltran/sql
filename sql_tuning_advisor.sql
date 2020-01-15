set serveroutput on;
-- CREATE TUNING TASK
DECLARE
 L_TASK_NAME VARCHAR2(4000);
BEGIN
 L_TASK_NAME := DBMS_SQLTUNE.CREATE_TUNING_TASK(begin_snap => 110248, end_snap => 110268, sql_id => '0hnpju2mtd6t2', time_limit => 180);
 DBMS_OUTPUT.PUT_LINE(L_TASK_NAME);
END;
/

select * from dba_hist_snapshot order by snap_id desc;

-- EXECUTE TUNING TASK
EXECUTE DBMS_SQLTUNE.EXECUTE_TUNING_TASK('TASK_453135');

-- REPORT TUNING TASK
SELECT DBMS_SQLTUNE.REPORT_TUNING_TASK('TASK_453135') FROM DUAL;

-- SCRIPT TUNING TASK
SELECT DBMS_SQLTUNE.SCRIPT_TUNING_TASK('TASK_53722') FROM DUAL;