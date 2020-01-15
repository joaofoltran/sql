<<<<<<< HEAD
COL STATUS FORMAT a25
COL hrs    FORMAT 999.99
SELECT SESSION_KEY, INPUT_TYPE, STATUS,
       TO_CHAR(START_TIME,'mm/dd/yy hh24:mi') start_time,
       TO_CHAR(END_TIME,'mm/dd/yy hh24:mi')   end_time,
       ELAPSED_SECONDS/3600                   hrs
FROM V$RMAN_BACKUP_JOB_DETAILS
WHERE INPUT_TYPE in ('ARCHIVELOG','DB FULL')
and start_time > sysdate - interval '15' day
=======
COL STATUS FORMAT a25
COL hrs    FORMAT 999.99
SELECT SESSION_KEY, INPUT_TYPE, STATUS,
       TO_CHAR(START_TIME,'mm/dd/yy hh24:mi') start_time,
       TO_CHAR(END_TIME,'mm/dd/yy hh24:mi')   end_time,
       ELAPSED_SECONDS/3600                   hrs
FROM V$RMAN_BACKUP_JOB_DETAILS
WHERE INPUT_TYPE != 'ARCHIVELOG'--
and start_time > sysdate - interval '15' day
>>>>>>> new 2020
ORDER BY SESSION_KEY;