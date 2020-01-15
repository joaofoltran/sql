-- Mostra o advisor sobre a PGA

column c1     heading 'Target(MB)'
 
SELECT
   ROUND(pga_target_for_estimate /(1024*1024)) c1,
   PGA_TARGET_FACTOR,
   estd_pga_cache_hit_percentage,
   estd_overalloc_count
FROM
   v$pga_target_advice;