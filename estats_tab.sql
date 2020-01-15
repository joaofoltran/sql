SELECT STAT.OWNER AS "Schema proprietário",
         STAT.TABLE_NAME AS "Nome do objeto",
         STAT.OBJECT_TYPE AS "Tipo do objeto",
         STAT.NUM_ROWS AS "Quant. de Linhas",
         STAT.LAST_ANALYZED AS "Última coleta"
    FROM SYS.DBA_TAB_STATISTICS STAT
   WHERE STAT.OWNER NOT IN ('SYS', 'SYSTEM', 'SYSMAN', 'DBSNMP')
   --and stat.num_rows > 2000
ORDER BY last_analyzed;