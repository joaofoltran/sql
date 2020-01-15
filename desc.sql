set verify off
set linesize 300
set pagesize 9999
set feedback off



alter session set cursor_sharing=force;

prompt
Prompt Datatypes for Table &1

column data_type format a20
column column_name heading "Column Name" format a30
column data_type heading "Data|Type" format a30
column data_length heading "Data|Length" format a10
column nullable heading "Nullable" format a8

select column_name,
data_type,
substr(
decode( data_type, 'NUMBER',
decode( data_precision, NULL, NULL,
'('||data_precision||','||data_scale||')' ),
data_length),
1,11) data_length,
decode( nullable, 'Y', 'null', 'not null' ) nullable
from dba_tab_columns
--where owner = upper('2')
where upper(table_name) = upper('&1')
order by column_id
/


prompt
prompt
Prompt Indexes on &1
column index_name heading "Index Name"
column Uniqueness heading "Is|Unique" format a6
column columns format a70 word_wrapped

select substr(a.index_name,1,30) index_name,
decode(a.uniqueness,'UNIQUE','Yes','No') uniqueness,
max(decode( b.column_position, 1, substr(b.column_name,1,30),
NULL )) ||
max(decode( b.column_position, 2, ', '||
substr(b.column_name,1,30), NULL )) ||
max(decode( b.column_position, 3, ', '||
substr(b.column_name,1,30), NULL )) ||
max(decode( b.column_position, 4, ', '||
substr(b.column_name,1,30), NULL )) ||
max(decode( b.column_position, 5, ', '||
substr(b.column_name,1,30), NULL )) ||
max(decode( b.column_position, 6, ', '||
substr(b.column_name,1,30), NULL )) ||
max(decode( b.column_position, 7, ', '||
substr(b.column_name,1,30), NULL )) ||
max(decode( b.column_position, 8, ', '||
substr(b.column_name,1,30), NULL )) ||
max(decode( b.column_position, 9, ', '||
substr(b.column_name,1,30), NULL )) ||
max(decode( b.column_position, 10, ', '||
substr(b.column_name,1,30), NULL )) ||
max(decode( b.column_position, 11, ', '||
substr(b.column_name,1,30), NULL )) ||
max(decode( b.column_position, 12, ', '||
substr(b.column_name,1,30), NULL )) ||
max(decode( b.column_position, 13, ', '||
substr(b.column_name,1,30), NULL )) ||
max(decode( b.column_position, 14, ', '||
substr(b.column_name,1,30), NULL )) ||
max(decode( b.column_position, 15, ', '||
substr(b.column_name,1,30), NULL )) ||
max(decode( b.column_position, 16, ', '||
substr(b.column_name,1,30), NULL )) columns
from dba_indexes a, dba_ind_columns b
--where a.owner = upper('')
where a.table_name = upper('&1')
and b.table_name = a.table_name
and b.table_owner = a.owner
and a.index_name = b.index_name
group by substr(a.index_name,1,30), a.uniqueness
/

prompt

alter session set cursor_sharing=exact;
set verify on
set linesize 400
set feedback on