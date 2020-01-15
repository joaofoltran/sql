set pages 200
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';

select trunc(FIRST_TIME,'hh') data_hora,count(*) qtd, round(sum(blocks*block_size/1024/1024)) mb
from v$archived_log
where to_char(trunc(FIRST_TIME,'hh'),'YYYYMM') = to_char(sysdate-1,'YYYYMM')
group by trunc(FIRST_TIME,'hh')
order by trunc(FIRST_TIME,'hh')
;