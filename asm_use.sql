select 
 name,type Redundancy,
 (total_mb/decode(type,'NORMAL',2,'HIGH',3,'EXTERN',1)) Total_MB,
 (free_mb/decode(type,'NORMAL',2,'HIGH',3,'EXTERN',1)) Free_MB,
 ((free_mb/decode(type,'NORMAL',2,'HIGH',3,'EXTERN',1))/(total_mb/decode(type,'NORMAL',2,'HIGH',3,'EXTERN',1)))*100 "% Free"
 from v$asm_diskgroup;