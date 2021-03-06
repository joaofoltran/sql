COL STATUS FORMAT a25
COL mins    FORMAT 999.99
col START_TIME for a20
col END_TIME for a20
SELECT SESSION_KEY, INPUT_TYPE, STATUS,
       TO_CHAR(START_TIME,'mm/dd/yy hh24:mi') start_time,
       TO_CHAR(END_TIME,'mm/dd/yy hh24:mi')   end_time,
       ELAPSED_SECONDS/60                  mins
FROM V$RMAN_BACKUP_JOB_DETAILS
--WHERE INPUT_TYPE in ('ARCHIVELOG','DB FULL')
WHERE start_time > sysdate - interval '7' day
ORDER BY SESSION_KEY;
