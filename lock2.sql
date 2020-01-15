col status for a10
SELECT vh.inst_id, vh.sid locking_sid,vs.serial#,
 vs.status status,
 vs.program program_holding,
 vw.sid waiter_sid,
 vsw.program program_waiting
FROM gv$lock vh,
 gv$lock vw,
 gv$session vs,
 gv$session vsw
WHERE     (vh.id1, vh.id2) IN (SELECT id1, id2
 FROM gv$lock
 WHERE request = 0
 INTERSECT
 SELECT id1, id2
 FROM gv$lock
 WHERE lmode = 0)
 AND vh.id1 = vw.id1
 AND vh.id2 = vw.id2
 AND vh.inst_id = vw.inst_id
 AND vh.request = 0
 AND vw.lmode = 0
 AND vh.sid = vs.sid
 and vh.inst_id = vs.inst_id
 AND vw.sid = vsw.sid
 and vw.inst_id = vsw.inst_id;