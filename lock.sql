col "Maquina" format a21
col "User" format a20
col "Usuario do SO" format a19
col "Blocking SID" format a14
col "Objeto" format a30
col "Linha" format a75
col "Modulo" format a33
col "Classe de Espera" format a20
col "Evento" format a30
col "Lock Type" format a10
col "Request Mode" format a15
col "Lock Mode" format a15
col "Status" format a8
col "Bloqueando" format a10
col "Bloqueado" format a10
col "Kill Session" format a60
col "Texto SQL Parcial" format a300
--col "SID" format a10
--col "Serial#" format a10

set feed off;
alter session set nls_date_format='dd/mm/rrrr hh24:mi:ss';
set feed on;

set lines 2000;
set pages 1000;

SELECT
  sn.inst_id "Inst",
  m.sid "SID",
  sn.serial# "Serial#",
  sn.blocking_instance || ':' || sn.blocking_session "Blocking SID",
  sn.username "User",
  sn.logon_time "Login",
  to_char(to_date(tr.start_time,'mm/dd/rr hh24:mi:ss'),'dd/mm/rrrr hh24:mi:ss') "Inicio da Transacao",
  decode(m.lmode, 0, 'None' ,1, 'Null' ,2, 'Row Share' ,3, 'Row Excl.' ,4,
  'Share' ,5, 'S/Row Excl.' ,6, 'Exclusive' ,m.lmode, ltrim(to_char(m.lmode,
  '990'))) "Lock Mode",
  decode(m.request,0, 'None' ,1, 'Null' ,2, 'Row Share' ,3, 'Row Excl.' ,4,
  'Share' ,5, 'S/Row Excl.' ,6, 'Exclusive' ,m.request, ltrim(to_char(m.request
  ,'990'))) "Request Mode",
  m.id1,
  m.id2,
  sn.osuser "Usuario do SO",
  sn.machine "Maquina",
  sn.status "Status",
  sn.module "Modulo",
  sn.sql_exec_start "Inicio Execucao SQL",
  round(sn.last_call_et/60) "Minutos Ativo/Inativo",
  --round(sn.last_call_et) "Segundos Ativo/Inativo",
  ' ' "Objeto",
  ' ' "Linha",
  m.type "Lock Type",
  sn.event "Evento",
--  sn.wait_class "Classe de Espera",
  sn.sql_id "SQL Atual",
  sq.sql_text "Texto SQL Parcial"
from gv$session sn, gv$lock m, gv$transaction tr, gv$sqlarea sq
where sn.sid          = m.sid
and sn.inst_id        = m.inst_id
and sn.taddr          = tr.addr (+)
and sn.sql_id         = sq.sql_id (+)
and m.request         = 0
and lmode             != 4
and (id1, id2) in(
  select s.id1, s.id2
  from gv$lock s
  where request != 0
  and s.id1 = m.id1
  and s.id2 = m.id2)
union all
select
  sn.inst_id "Instancia",
  m.sid "SID",
  sn.serial# "Serial#",
  sn.blocking_instance || ':' || sn.blocking_session "Blocking SID",
  sn.username "User",
  sn.logon_time "Login",
  to_char(to_date(tr.start_time,'mm/dd/rr hh24:mi:ss'),'dd/mm/rrrr hh24:mi:ss') "Inicio da Transacao",
  decode(m.lmode, 0, 'None' ,1, 'Null' ,2, 'Row Share' ,3, 'Row Excl.' ,4,
  'Share' ,5, 'S/Row Excl.' ,6, 'Exclusive' ,m.lmode, ltrim(to_char(m.lmode,
  '990'))) "Lock Mode",
  decode(m.request,0, 'None' ,1, 'Null' ,2, 'Row Share' ,3, 'Row Excl.' ,4,
  'Share' ,5, 'S/Row Excl.' ,6, 'Exclusive' ,m.request, ltrim(to_char(m.request
  ,'990'))) "Request Mode",
  m.id1,
  m.id2,
  sn.osuser "Usuario do SO",
  sn.machine "Maquina",
  sn.status "Status",
  sn.module "Modulo",
  sn.sql_exec_start "Inicio Execucao SQL",
  round(sn.last_call_et/60) "Minutos Ativo/Inativo",
  --round(sn.last_call_et) "Segundos Ativo/Inativo",
  do.owner || '.' || do.object_name "Objeto",
  'select * from ' || do.owner || '.' || do.object_name || ' where rowid=' || '''' || dbms_rowid.rowid_create(1,sn.row_wait_obj#,sn.row_wait_file#, sn.row_wait_block#,sn.row_wait_row#) || ''';' "Linha",
  m.type "Lock Type",
  sn.event "Evento",
--  sn.wait_class "Classe de Espera",
  sn.sql_id "SQL Atual",
  sq.sql_text "Texto SQL Parcial"
from gv$session sn, gv$lock m, dba_objects do, gv$transaction tr, gv$sqlarea sq
where sn.sid          = m.sid
and sn.inst_id        = m.inst_id
and sn.row_wait_obj#  = do.object_id
and sn.taddr          = tr.addr (+)
and sn.sql_id         = sq.sql_id (+)
and m.request         != 0
and (id1, id2) in (
  select s.id1, s.id2
  from gv$lock s
  where request = 0
  and lmode != 4
  and s.id1 = m.id1
  and s.id2 = m.id2)
order by
  id1,
  id2,
  "Lock Mode"
/