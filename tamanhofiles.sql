select (select round(sum(bytes/1024/1024/1024)) from dba_data_files) + (select round(sum(bytes/1024/1024/1024)) from dba_temp_files) as GB from dual;