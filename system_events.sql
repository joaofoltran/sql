	SELECT event,
       total_waits,
       total_timeouts,
       time_waited,
       average_wait,
       time_waited_micro
FROM v$system_event
ORDER BY time_waited;