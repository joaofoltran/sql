col name for a45
select NAME,
first_usage_date ,
last_usage_date ,
detected_usages ,
aux_count ,
error_count
from sys.wri$_dbu_feature_usage
 WHERE (NAME LIKE '%ADDM%' OR
        NAME LIKE '%Automatic Database Diagnostic Monitor%' OR
        NAME LIKE '%Automatic Workload Repository%' OR
        NAME LIKE '%AWR%' OR
        NAME LIKE '%Baseline%' OR
        (NAME LIKE '%Compression%' AND NAME NOT LIKE '%HeapCompression%') OR
        NAME LIKE '%Data Guard%' OR
        NAME LIKE '%Data Mining%' OR
        NAME LIKE '%Database Replay%' OR
        NAME LIKE '%EM%' OR
        NAME LIKE '%Encrypt%' OR
        NAME LIKE '%Exadata%' OR
        NAME LIKE '%Flashback Data Archive%' OR
        NAME LIKE '%Label Security%' OR
        NAME LIKE '%OLAP%' OR
        NAME LIKE '%Pack%' OR
        NAME LIKE '%Partitioning%' OR
        NAME LIKE '%Real Application Clusters%' OR
        NAME LIKE '%SecureFile%' OR
        NAME LIKE '%Spatial%' OR
        NAME LIKE '%SQL Monitoring%' OR
        NAME LIKE '%SQL Performance%' OR
        NAME LIKE '%SQL Profile%' OR
        NAME LIKE '%SQL Tuning%' or
		NAME LIKE 'Automatic SQL Tuning Advisor' OR
        NAME LIKE '%SQL Access Advisor%' OR 
		NAME LIKE '%Vault%' OR
		NAME LIKE '%In-Memory%')
   AND NAME NOT LIKE ('%(system)%')
   AND NAME NOT LIKE 'SecureFiles (user)'
   AND first_usage_date IS NOT NULL
   AND DETECTED_USAGES > 0
   order by last_usage_date;