select 	/*+ ORDERED USE_NL(A, B) */
	sql_text from gv$session a,gv$sqltext b
where a.INST_ID=&inst
and a.sid=&sid
and b.INST_ID=a.INST_ID
and a.sql_address=b.address
and a.sql_hash_value=b.hash_value
order by piece;
-- TESTANDO GIT