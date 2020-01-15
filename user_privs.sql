col grantee for a30
col table_name for a50
col grantor for a30
col privilege for a30
col owner for a20
set verify off
select * from dba_role_privs where grantee = '&&1';
select * from dba_tab_privs where grantee = '&&1';
select * from dba_sys_privs where grantee = '&&1';
select * from dba_col_privs where grantee = '&&1';
set verify on

