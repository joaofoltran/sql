set feedback off

SELECT ARCH.THREAD# "Thread", 
       ARCH.SEQUENCE# "Last Sequence Received", 
	   APPL.SEQUENCE# "Last Sequence Applied", 
	   (ARCH.SEQUENCE#-APPL.SEQUENCE#) "Difference" 
FROM (SELECT THREAD# ,SEQUENCE# 
    	FROM V$ARCHIVED_LOG 
		WHERE (THREAD#,FIRST_TIME ) IN (SELECT THREAD#,MAX(FIRST_TIME) 
		                                FROM V$ARCHIVED_LOG 
										GROUP BY THREAD#)) ARCH, 
(SELECT THREAD#,SEQUENCE# 
FROM V$LOG_HISTORY 
WHERE (THREAD#,FIRST_TIME ) IN (SELECT THREAD#,MAX(FIRST_TIME) 
								FROM V$LOG_HISTORY 
								GROUP BY THREAD#)) APPL 
WHERE ARCH.THREAD# = APPL.THREAD# 
ORDER BY 1;

SELECT 'Last applied  : ' Logs,
To_char(next_time, 'DD-MON-YY HH24:MI:SS') Time
FROM   v$archived_log
WHERE  sequence# = (SELECT Max(sequence#)
                      FROM   v$archived_log
                     WHERE  applied = 'YES')
UNION
SELECT 'Last received : ' Logs,
To_char(next_time, 'DD-MON-YY HH24:MI:SS') Time
FROM   v$archived_log
WHERE  sequence# = (SELECT Max(sequence#)
                    FROM   v$archived_log);

prompt
set feedback on