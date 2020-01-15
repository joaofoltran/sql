set linesize 400
col tablespace_name format a15
col file_size format 99999
col file_name format a50
col hwm format 99999
col can_save format 99999
SELECT tablespace_name, file_name, file_size, hwm, file_size-hwm can_save
FROM (SELECT /*+ RULE */ ddf.tablespace_name, ddf.file_name file_name,
ddf.bytes/1048576 file_size,(ebf.maximum + de.blocks-1)*dbs.db_block_size/1048576 hwm
FROM dba_data_files ddf,(SELECT file_id, MAX(block_id) maximum FROM dba_extents GROUP BY file_id) ebf,dba_extents de,
(SELECT value db_block_size FROM v$parameter WHERE name='db_block_size') dbs
WHERE ddf.file_id = ebf.file_id
AND de.file_id = ebf.file_id
AND de.block_id = ebf.maximum
ORDER BY 1,2)
order by 5;