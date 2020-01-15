set verify off
set linesize 300
column file_name format a80
--column "SIZE (MB)" format a35
--column "MAXSIZE (MB)" format a35
--accept tbname -
 --   prompt 'Tablespace: '

SELECT file_id,
file_name,
trunc(bytes/1024/1024) as "SIZE (MB)",
trunc(maxbytes/1024/1024) as "MAXSIZE (MB)",
round(increment_by*8192/1024/1024) as "INCREMENT BY (MB)"
FROM dba_data_files
WHERE tablespace_name = upper('&1');

set verify on