-- Crescimento total do Banco
select SUM(SIZE_MB) from
  (select tab1.owner, tab1.segment_name, tab1.partition_name, tab1.segment_type, tab1.tablespace_name, round((tab2.bytes-tab1.bytes)/1024/1024) size_mb  from
    (select owner, segment_name, partition_name, segment_type, tablespace_name, bytes from nagios_segment_hist where trunc(run_date) = '01/02/2019') tab1,
    (select owner, segment_name, partition_name, segment_type, tablespace_name, bytes from nagios_segment_hist where trunc(run_date) = '28/02/2019') tab2
  where tab1.owner = tab2.owner
  and tab1.segment_name = tab2.segment_name
  and ((tab1.partition_name = tab2.partition_name) or (tab1.partition_name is null and tab2.partition_name is null))
  and (tab2.bytes-tab1.bytes) > 0
  and tab1.segment_type not in('TYPE2 UNDO','ROLLBACK')
  order by size_mb desc
  );

-- Crescimento total por owner
select owner, SUM(SIZE_MB) from
  (select tab1.owner, tab1.segment_name, tab1.partition_name, tab1.segment_type, tab1.tablespace_name, round((tab2.bytes-tab1.bytes)/1024/1024) size_mb  from
    (select owner, segment_name, partition_name, segment_type, tablespace_name, bytes from nagios_segment_hist where trunc(run_date) = '01/11/2019') tab1,
    (select owner, segment_name, partition_name, segment_type, tablespace_name, bytes from nagios_segment_hist where trunc(run_date) = '30/11/2019') tab2
  where tab1.owner = tab2.owner
  and tab1.segment_name = tab2.segment_name
  and ((tab1.partition_name = tab2.partition_name) or (tab1.partition_name is null and tab2.partition_name is null))
  and (tab2.bytes-tab1.bytes) > 0
  and tab1.segment_type not in('TYPE2 UNDO','ROLLBACK')
  order by size_mb desc
  ) group by owner order by 2 desc;

-- Crescimento por segmentos
SELECT tab1.owner,
  tab1.segment_name,
  tab1.segment_type,
  tab1.mb_tab1 "01/01/2017 (MB)",
  --tab2.owner,
  --tab2.segment_name,
  --tab2.segment_type,
  tab2.mb_tab2 "31/05/2017 (MB)",
  (tab2.mb_tab2-tab1.mb_tab1) "CRESCIMENTO (MB)"
FROM
  (SELECT tab1.owner,tab1.partition_name,tab1.segment_name,tab1.segment_type,ROUND(tab1.bytes/1024/1024) MB_TAB1 FROM suptcadm.NAGIOS_SEGMENT_HIST tab1  WHERE tab1.owner = 'MONITORING'
  AND TRUNC(tab1.run_date) = '01/01/2017') tab1,
  (SELECT tab2.owner,tab2.partition_name,tab2.segment_name,tab2.segment_type,ROUND(tab2.bytes/1024/1024) MB_TAB2 FROM suptcadm.NAGIOS_SEGMENT_HIST tab2 WHERE tab2.owner = 'MONITORING' 
  AND TRUNC(tab2.run_date) = '31/05/2017') tab2
WHERE tab1.owner          = tab2.owner
AND tab1.segment_name     = tab2.segment_name
AND ((tab1.partition_name = tab2.partition_name)
OR (tab1.partition_name  IS NULL
AND tab2.partition_name  IS NULL))
AND (tab2.mb_tab2-tab1.mb_tab1) > 0
order by (tab2.mb_tab2-tab1.mb_tab1) desc;

-- Verificar versão do banco
select * from v$version;

-- Verificar PSU aplicados
select * from SYS.REGISTRY$HISTORY order by 1 desc;

-- Verificar parametros PGA e SGA
show parameter sga;
show parameter pga;

-- Verificar tamanho de segmentos
select round(sum(bytes/1024/1024/1024)) GB from dba_segments;

-- Verificar tamanho de arquivos
select (select round(sum(bytes/1024/1024/1024)) GB from dba_data_files) + (select round(sum(bytes/1024/1024/1024)) GB from dba_temp_files) as FILES_GB from dual;
select round(sum(bytes/1024/1024/1024)) GB from dba_data_files;
select round(sum(bytes/1024/1024/1024)) GB from dba_temp_files;

-- Objetos alterados durante o mês -- OWBA001P, OWBA017P
select * from NAGIOS_DBA_OBJECTS
where
last_ddl_time between to_date('01/01/2017', 'dd/mm/yyyy') and to_date('31/01/2017', 'dd/mm/yyyy')
and owner not in ('SYS','SYSTEM','ORACLE_OCM','SUPTCADM')
order by 1;
