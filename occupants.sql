COLUMN "Item" FORMAT A25
COLUMN "Space Used (GB)" FORMAT 999.99
COLUMN "Schema" FORMAT A25
COLUMN "Move Procedure" FORMAT A40

SELECT  occupant_name "Item",
round(space_usage_kbytes/1024) "Space Used (MB)",
schema_name "Schema"
FROM v$sysaux_occupants
ORDER BY 2 desc
/