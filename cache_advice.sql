col name for a25
SELECT name,size_for_estimate, buffers_for_estimate, estd_physical_read_factor,estd_physical_reads
FROM V$DB_CACHE_ADVICE
WHERE name = 'DEFAULT'
AND block_size = (SELECT value FROM V$PARAMETER WHERE name = 'db_block_size')
AND advice_status = 'ON';