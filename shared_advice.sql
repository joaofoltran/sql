SELECT
  shared_pool_size_for_estimate "Shared Pool Size (MB)",
  shared_pool_size_factor "Size Factor",
  estd_lc_time_saved "Time Saved (SEC)",
  ESTD_LC_TIME_SAVED_FACTOR "Time Saved Factor"
FROM
  v$shared_pool_advice;
