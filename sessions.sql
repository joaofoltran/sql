SELECT sid,
serial#,
username,
status
FROM v$session
where status not in ('INACTIVE','IDLE')
and schemaname not in ('SYS','SYSTEM')
ORDER BY status,
  schemaname,
  osuser
/
