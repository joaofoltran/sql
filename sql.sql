set verify off

set long 200000
set lin 170
col SQL_FULLTEXT format a190

select sql_fulltext
from v$sqlarea
where sql_id = '&1'
/

set verify on
