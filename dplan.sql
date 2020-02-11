-- Puxa plano do SQL_ID através do cursor

set linesize 400
set verify off
set pagesize 1000

SELECT * FROM TABLE(dbms_xplan.display_cursor('&1',&2,'ALLSTATS LAST  +PEEKED_BINDS +PREDICATE +COST +BYTES'));

undef SQL_ID
set verify on
