SELECT STAT.OWNER AS "Schema proprietário",
         STAT. TABLE_NAME AS "Nome do objeto",
         STAT.OBJECT_TYPE AS "Tipo do objeto",
         STAT.NUM_ROWS AS "Quant. de Linhas",
         STAT.LAST_ANALYZED
    FROM SYS.DBA_IND_STATISTICS STAT
   WHERE STAT.OWNER NOT IN ('SYS', 'SYSTEM', 'SYSMAN', 'DBSNMP')
ORDER BY LAST_ANALYZED;