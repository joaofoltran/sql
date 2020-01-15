select s.owner, s.table_name, t.num_rows, s.column_name, s.histogram 
from dba_tab_col_statistics s
left join dba_tables t on s.table_name = t.table_name
--where lower(table_name) in ('hdrlcb','itelcb')
--and lower(column_name) in ('codemp','codufu','datref','orictz','stalcb','seqhdrlcb','codplacct','numcrz')
where s.owner = 'SAPIENS'
--and t.num_rows > 100000
and s.table_name in ('E075PRO','E210MVP')
and s.column_name in ('CODPRO','CODEMP')
order by t.num_rows, s.table_name, s.histogram;