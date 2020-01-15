COLUMN owner format a50
COLUMN object_name format a50
SELECT owner, object_name, object_type, status 
FROM dba_objects 
WHERE LOWER(object_name) LIKE '%&1%'
order by 1,3,4;