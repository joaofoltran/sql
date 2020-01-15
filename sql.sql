set verify off

set long 200000
set lin 170

select sql_fulltext
from v$sqlarea
where sql_id = '&1'
/

set verify on