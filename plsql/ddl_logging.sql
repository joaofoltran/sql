create sequence SYS.DSQ_DDLEVENTS_EITI
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 100;

CREATE TABLE SYS.DDL_EVENTS
  (
    eventid NUMBER,
    eventdate DATE,
    oracle_user VARCHAR2(60),
    object_name VARCHAR2(100),
    object_type VARCHAR2(50),
    action VARCHAR2(50),
    machine VARCHAR2(100),
    program VARCHAR2(100),
    os_user VARCHAR2(100)
  )
TABLESPACE USERS;

CREATE TABLE SYS.DDL_EVENTS_SQL
  (
    eventid NUMBER,
    sql_line NUMBER,
    sql_text VARCHAR2(4000)
  )
TABLESPACE USERS;

CREATE OR REPLACE TRIGGER sys.DDL_AUDIT_TRG
AFTER DDL ON DATABASE
DECLARE
  l_eventId NUMBER;
  l_sqlText ORA_NAME_LIST_T;
BEGIN
  if ORA_SYSEVENT != 'TRUNCATE' then
    SELECT dsq_ddlevents_eiti.NEXTVAL INTO l_eventId FROM SYS.DUAL;
    INSERT INTO ddl_events (eventid,
      eventdate,
      oracle_user,
      object_name,
      object_type,
      action,
      machine,
      program,
      os_user)
    (SELECT l_eventId,
      sysdate,
      ORA_LOGIN_USER,
      ORA_DICT_OBJ_NAME,
      ORA_DICT_OBJ_TYPE,
      ORA_SYSEVENT,
      machine,
      program,
      osuser
     FROM SYS.DUAL
     RIGHT OUTER JOIN SYS.GV$SESSION s on (1=1)
     WHERE s.sid=SYS_CONTEXT('USERENV','SID')
     AND SYS_CONTEXT('USERENV','INSTANCE')=s.inst_id);

    FOR l in 1..ORA_SQL_TXT(l_sqlText) LOOP
    INSERT INTO DDL_EVENTS_SQL
      (eventId, sql_line, sql_text)
    VALUES
      (l_eventId, l, l_sqlText(l));
    END LOOP;
 end if;

 exception when others then
 null;
END;
/
