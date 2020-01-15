set lin 200 pages 1000
col serial for a15
col username for a20
col spid for a15
col mb_used format '99999'

SELECT S.sid,
S.serial#,
S.username,
P.spid,
(sum(T.blocks)*TBS.block_size/1024/1024) mb_used, 
T.tablespace,
COUNT(*) statements
FROM v$sort_usage T, v$session S, dba_tablespaces TBS, v$process P
WHERE T.session_addr = S.saddr
AND S.paddr = P.addr
AND T.tablespace = TBS.tablespace_name
GROUP BY S.sid, S.serial#, S.username, S.osuser, P.spid, S.module,
P.program, TBS.block_size, T.tablespace
ORDER BY mb_used asc;