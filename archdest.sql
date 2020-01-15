-- Lista os destinos de archive log e seu status
column error format a35
column dest_name format a30
select dest_name,status,destination,error 
from V$ARCHIVE_DEST 
where destination is not null;