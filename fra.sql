set serveroutput on
DECLARE
v_backup_hold NUMBER;
v_size_fra NUMBER;
v_growth_rate NUMBER;
v_size_db NUMBER;
v_size_archive NUMBER;
BEGIN
v_backup_hold := 2;
v_growth_rate := 1.2;
v_size_fra := 0;
-- Tamanho atual do DB em GB
SELECT ROUND(SUM(bytes)/1024/1024/1024,2) INTO v_size_db FROM v$datafile;
-- Tamanho de 24 horas de archivelog em GB
SELECT ROUND(SUM(blocks*block_size)/1024/1024/1024,2) INTO v_size_archive FROM V$ARCHIVED_LOG WHERE completion_time > sysdate-1;
-- Tamanho da FRA
SELECT ROUND(((v_size_db*v_backup_hold)+v_size_archive)*v_growth_rate,2) INTO v_size_fra FROM dual;
SYS.DBMS_OUTPUT.PUT_LINE('');
SYS.DBMS_OUTPUT.PUT_LINE('Size Database (GB): '||v_size_db);
SYS.DBMS_OUTPUT.PUT_LINE('Size Archives 24h (GB): '||v_size_archive);
SYS.DBMS_OUTPUT.PUT_LINE('Number backups level 0 hold: '||v_backup_hold||' Backups.');
SYS.DBMS_OUTPUT.PUT_LINE('Growth rate (%): '||v_growth_rate);
SYS.DBMS_OUTPUT.PUT_LINE('');
SYS.DBMS_OUTPUT.PUT_LINE('Size FRA = ((DB Size * Number backups level 0 hold) + Archivelog Size 24h) * Growth rate');
SYS.DBMS_OUTPUT.PUT_LINE('');
SYS.DBMS_OUTPUT.PUT_LINE('Size FRA (GB): '||v_size_fra);
END;
/