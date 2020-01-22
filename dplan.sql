-- Puxa plano do SQL_ID através do AWR

PROMPT '========================================================================'
PROMPT '= INFORME O SQL_ID ABAIXO                                              ='
PROMPT '========================================================================'

set linesize 400
set verify off
set pagesize 1000

ACCEPT sql_id   PROMPT 'SQL_ID...: '

SELECT * FROM TABLE(dbms_xplan.display_cursor('&1',&2,'ALLSTATS LAST  +PEEKED_BINDS +PREDICATE +COST +BYTES'));

SELECT * FROM table(DBMS_XPLAN.DISPLAY_AWR('ag1garw05bmb8'));

undef SQL_ID
set verify on
