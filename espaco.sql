CLEAR BREAKS
CLEAR COLUMNS
CLEAR COMPUTES

SET PAGESIZE 60
SET PAUSE ON
SET PAUSE 'Press Return to Continue'
SET VERIFY OFF

COL owner HEA "Owner" FOR a7
COL segment_name HEA "Name" FOR a20 TRUNC
COL segment_type HEA "Type" FOR a7

COL tablespace_name HEA "Tablespace" FOR a10 TRUNC
COL mbytes HEA "Mbytes" FOR 9999.999
COL extents HEA "Extents" FOR 9999

BREAK ON owner ON tablespace_name ON segment_type ON REPORT

COMPUTE SUM OF mbytes ON REPORT

SELECT owner, segment_type, tablespace_name, segment_name,
        ( bytes/1048576 ) mbytes, extents
FROM dba_segments
WHERE owner = UPPER( '&OwnerName' )
ORDER BY owner, tablespace_name, segment_type, segment_name
/