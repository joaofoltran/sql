--column inst_id format a10
--column sid format a10
col SID_SERIAL for a10
set lin 220 pages 1000
column "SQL/Child" format a25
column spid format a9
column username format a15
column osuser format a17
column oper format a17
column machine format a25
column event format a32
column program format a40
column "sw event" format a32
column status format a6
--column minutes format a7

SELECT
	   --ses.con_id,
	   ses.inst_id,
       ses.sid ||','||ses.serial# as SID_SERIAL,
       pro.spid,
       ses.username,
       ses.osuser,
	   ses.machine,
      ses.last_call_et seg,
--       ses.status,
       (case when state != 'WAITING' then 'WORKING' else 'WAITING' end) as state,
       (case when state != 'WAITING' then 'On CPU / runqueue' else event end) as "sw event",
       ses.sql_id ||','|| ses.sql_child_number as "SQL/Child",
       --  ses.prev_sql_id,
       c.NAME oper
--       do.owner || '.' || do.object_name "OBJETO",
--       ses.machine
--       ses.program,
--       ses.logon_time
FROM   gv$session ses,
       gv$process pro,
       audit_actions c
--       dba_objects do
WHERE  ses.paddr = pro.addr
--       AND ses.row_wait_obj# = do.object_id
       AND c.action = Nvl(ses.command, 0)
       AND ses.username IS NOT NULL
       AND ses.status != 'INACTIVE'
       AND ses.last_call_et > 0
       AND ses.event NOT IN (SELECT NAME
                             FROM   v$event_name
                             WHERE  wait_class = 'Idle')
ORDER  BY Round(ses.last_call_et / 60),
          ses.status,
          ses.state,
          ses.event;
