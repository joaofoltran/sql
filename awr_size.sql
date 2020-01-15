col c1 heading 'table|name' format a30
col c2 heading 'table size|meg'format 999,999,999


select 
   segment_name c1, 
   sum(bytes)/(1024*1024) c2 
from 
   dba_extents 
where 
   segment_type='TABLE' 
and 
   segment_name like 'WR%'
group by 
   segment_name
order by 
   c2 desc;