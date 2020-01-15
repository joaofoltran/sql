select	/*+ RULE */
   INST_ID as I,
   sid,
   a.serial#,
--   process,
   a.username,
-- status,
--   to_char(logon_time,'dd-mm-yy hh24:mi:ss') "LOGON",
   to_char(logon_time,'dd-mm hh24:mi') "LOGON",
   substr(a.module,1,20) module,
   TRUNC(last_call_et/(60*60*24)) || '-' ||
   LPAD(MOD(TRUNC(last_call_et/(60*60)), 24), 2, 0) || ':' ||
   LPAD(MOD(TRUNC(last_call_et/60), 60), 2, 0) || ':' ||
   LPAD(MOD(last_call_et, 60), 2, 0) "Idle",
   substr(c.name,1,10) "Comando",
   substr(a.event,1,22) event
--   substr(a.state,1,8) state
--   machine
from
   gv$session a,
   all_users b,
   audit_actions c
where
   type='USER' and
   b.username = a.username and
   c.action = nvl(a.command,0)
 and status='ACTIVE'
order by last_call_et desc
/
