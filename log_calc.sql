SET LIN 200 PAGES 1000
COLUMN day format a15
COL "00" FORMAT a5
COL "01" FORMAT a5
COL "02" FORMAT a5
COL "03" FORMAT a5
COL "04" FORMAT a5
COL "05" FORMAT a5
COL "06" FORMAT a5
COL "07" FORMAT a5
COL "08" FORMAT a5
COL "09" FORMAT a5
COL "10" FORMAT a5
COL "11" FORMAT a5
COL "12" FORMAT a5
COL "13" FORMAT a5
COL "14" FORMAT a5
COL "15" FORMAT a5
COL "16" FORMAT a5
COL "17" FORMAT a5
COL "18" FORMAT a5
COL "19" FORMAT a5
COL "20" FORMAT a5
COL "21" FORMAT a5
COL "22" FORMAT a5
COL "23" FORMAT a5

select to_char(first_time,'YYYY-MON-DD') day,
 to_char(sum(decode(to_char(first_time,'HH24'),'00',1,0)),'9999') "00",
 to_char(sum(decode(to_char(first_time,'HH24'),'01',1,0)),'9999') "01",
 to_char(sum(decode(to_char(first_time,'HH24'),'02',1,0)),'9999') "02",
 to_char(sum(decode(to_char(first_time,'HH24'),'03',1,0)),'9999') "03",
 to_char(sum(decode(to_char(first_time,'HH24'),'04',1,0)),'9999') "04",
 to_char(sum(decode(to_char(first_time,'HH24'),'05',1,0)),'9999') "05",
 to_char(sum(decode(to_char(first_time,'HH24'),'06',1,0)),'9999') "06",
 to_char(sum(decode(to_char(first_time,'HH24'),'07',1,0)),'9999') "07",
 to_char(sum(decode(to_char(first_time,'HH24'),'08',1,0)),'9999') "08",
 to_char(sum(decode(to_char(first_time,'HH24'),'09',1,0)),'9999') "09",
 to_char(sum(decode(to_char(first_time,'HH24'),'10',1,0)),'9999') "10",
 to_char(sum(decode(to_char(first_time,'HH24'),'11',1,0)),'9999') "11",
 to_char(sum(decode(to_char(first_time,'HH24'),'12',1,0)),'9999') "12",
 to_char(sum(decode(to_char(first_time,'HH24'),'13',1,0)),'9999') "13",
 to_char(sum(decode(to_char(first_time,'HH24'),'14',1,0)),'9999') "14",
 to_char(sum(decode(to_char(first_time,'HH24'),'15',1,0)),'9999') "15",
 to_char(sum(decode(to_char(first_time,'HH24'),'16',1,0)),'9999') "16",
 to_char(sum(decode(to_char(first_time,'HH24'),'17',1,0)),'9999') "17",
 to_char(sum(decode(to_char(first_time,'HH24'),'18',1,0)),'9999') "18",
 to_char(sum(decode(to_char(first_time,'HH24'),'19',1,0)),'9999') "19",
 to_char(sum(decode(to_char(first_time,'HH24'),'20',1,0)),'9999') "20",
 to_char(sum(decode(to_char(first_time,'HH24'),'21',1,0)),'9999') "21",
 to_char(sum(decode(to_char(first_time,'HH24'),'22',1,0)),'9999') "22",
 to_char(sum(decode(to_char(first_time,'HH24'),'23',1,0)),'9999') "23"
 from v$log_history 
 where first_time > sysdate - 14
 group by to_char(first_time,'YYYY-MON-DD')
 order by day desc;