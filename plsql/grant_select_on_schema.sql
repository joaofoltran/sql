CREATE OR REPLACE PROCEDURE GRANT_SELECT_SCHEMA (user_name in varchar2, schema_name in varchar2) AS
  CURSOR c1 is SELECT owner,table_name from dba_tables where owner = schema_name;
BEGIN
  FOR tab IN c1 LOOP
    EXECUTE IMMEDIATE 'GRANT SELECT ON ' || tab.owner || '.' || tab.table_name || ' TO ' || user_name;
  END LOOP;
EXCEPTION
  WHEN OTHERS THEN
    NULL;
END;
/
