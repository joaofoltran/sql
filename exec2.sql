set linesize 1000
col spid format a15
col username format a21
col osuser format a20
col event format a40

SELECT ses.inst_id,
  ses.sid,
  ses.serial#,
  pro.spid,
  ses.username,
  ses.osuser,
  ROUND(ses.LAST_CALL_ET/60) minutes,
  ses.status,
  ses.state,
  ses.event,
  ses.machine,
  ses.program,
  ses.module,
  ses.logon_time
FROM gv$session ses,
  gv$process pro
WHERE ses.paddr      = pro.addr
AND ses.username    IS NOT NULL
AND ses.status      != 'INACTIVE'
AND ses.last_call_et > 0
AND ses.event NOT   IN
  (SELECT name FROM v$event_name WHERE wait_class = 'Idle'
  )
ORDER BY ses.status,
  ses.state,
  ses.event;