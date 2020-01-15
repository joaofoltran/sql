-- Lista os 10 maiores objetos da base
col segment_name format a50
SELECT * FROM
(
select 
    OWNER,
    SEGMENT_NAME, 
    SEGMENT_TYPE, 
    trunc(BYTES/1024/1024) MB, 
    TABLESPACE_NAME 
from 
    dba_segments
order by 4 desc  
) WHERE
ROWNUM <= 10;