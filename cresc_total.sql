-- Crescimento total do Banco
select SUM(SIZE_MB) from
  (select tab1.owner, tab1.segment_name, tab1.partition_name, tab1.segment_type, tab1.tablespace_name, round((tab2.bytes-tab1.bytes)/1024/1024) size_mb  from
    (select owner, segment_name, partition_name, segment_type, tablespace_name, bytes from suptcadm.nagios_segment_hist where trunc(run_date) = '&DATA_INICIO') tab1,
    (select owner, segment_name, partition_name, segment_type, tablespace_name, bytes from suptcadm.nagios_segment_hist where trunc(run_date) = '&DATA_FIM') tab2
  where tab1.owner = tab2.owner
  and tab1.segment_name = tab2.segment_name
  and ((tab1.partition_name = tab2.partition_name) or (tab1.partition_name is null and tab2.partition_name is null))
  and (tab2.bytes-tab1.bytes) > 0
  and tab1.segment_type not in('TYPE2 UNDO','ROLLBACK')
  order by size_mb desc
  );