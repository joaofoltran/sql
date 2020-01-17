SET SERVEROUTPUT ON
SET PAGES 1000
SET LINESIZE 190
SET FEEDBACK OFF
COLUMN CRIA_INDEX for a215

SELECT
    'CREATE INDEX IDX_'||
    SUBSTR(c.owner,1,2)||
    '_'|| 
    ' ON '||
    c.owner||
    '.'||
    c.table_name||
    '('||
    acc.column_name||
    ');' as cria_index
FROM   all_constraints t,
    all_constraints c,
    all_cons_columns acc
WHERE  c.r_constraint_name = t.constraint_name
AND    c.table_name        = acc.table_name
AND    c.constraint_name   = acc.constraint_name
AND    NOT EXISTS (SELECT '1' 
                FROM  all_ind_columns aid
                WHERE aid.table_name  = acc.table_name
                AND   aid.column_name = acc.column_name)
AND c.owner = 'FOUNDATION'
ORDER BY t.table_name;


PROMPT
SET FEEDBACK ON
SET PAGESIZE 18