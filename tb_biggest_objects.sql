-- Lista os 15 maiores objetos da tablespace
column segment_name format a35
column tablespace_name for a20

set verify off

SELECT * FROM
(
select 
    OWNER,
    SEGMENT_NAME, 
    SEGMENT_TYPE, 
    trunc(BYTES/1024/1024) SIZE_MB, 
    TABLESPACE_NAME 
from 
    dba_segments
where
	tablespace_name = 'SDE'
order by 4 desc  
) WHERE
ROWNUM <= 25;

set verify on