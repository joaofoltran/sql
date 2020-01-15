<<<<<<< HEAD
-- Puxa plano do SQL_ID através do AWR

PROMPT '========================================================================'
PROMPT '= INFORME O SQL_ID ABAIXO                                              ='
PROMPT '========================================================================'

set linesize 400
set verify off
set pagesize 1000

ACCEPT sql_id   PROMPT 'SQL_ID...: '

select * from table(dbms_xplan.display_cursor('ag1garw05bmb8',0,'ADAPTIVE'));

SELECT * FROM table(DBMS_XPLAN.DISPLAY_AWR('ag1garw05bmb8'));

undef SQL_ID
set verify on
=======
set linesize 400
set verify off
set pagesize 1000

select * from table(dbms_xplan.display_cursor('&1',&2,'allstats last'));

set verify on
>>>>>>> new 2020
