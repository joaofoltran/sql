SELECT sga_size, sga_size_factor, estd_db_time_factor
FROM v$sga_target_advice
ORDER BY sga_size ASC;