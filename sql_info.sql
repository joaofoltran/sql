col parsed format a10
col sql_text format a80
SET lines 200
SET pages 300
SELECT sql_text,
  parsing_schema_name          AS parsed,
  elapsed_time_delta/1000/1000 AS elapsed_sec,
  stat.snap_id,
  TO_CHAR(snap.end_interval_time,'dd.mm hh24:mi:ss') AS snaptime,
  txt.sql_id,
  stat.plan_hash_value
FROM
  dba_hist_sqlstat stat,
  dba_hist_sqltext txt,
  dba_hist_snapshot snap
WHERE stat.sql_id            =txt.sql_id
AND stat.snap_id             =snap.snap_id
AND snap.begin_interval_time>=sysdate-15
--AND lower(sql_text) LIKE '%select cmoder.codcmoder%'
AND lower(txt.sql_id) ='55cpb8xfxs229'
AND parsing_schema_name NOT IN ('SYS','SYSMAN','MDSYS','WKSYS')
ORDER BY 4 ASC;
