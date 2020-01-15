set verify off
col "segment_name" for a60

select * from
 (select owner,segment_name||' ~ '||(case when partition_name is null then 'NOT_PARTITIONED' end) segment_name, segment_type,bytes/(1024*1024) size_mb
 from dba_segments
 where tablespace_name = '&&1'
 ORDER BY BLOCKS desc)
 where rownum < 40;

set verify on