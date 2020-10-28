-- Mostra informações sobre a tabela informada
--accept lwrorupp prompt 'Lower or Upper...: '
--accept tablename prompt 'Table Name...: '

set verify off

col partitioned for a11
col temporary for a9

select owner
,table_name
,num_rows
,sample_size
,last_analyzed
,partitioned
,temporary
from dba_tables
where lower(table_name) like '%indi_atendimento_prot%'
;

set verify on