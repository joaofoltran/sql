set lines 170
set pages 100
column "Tablespace" format A25
column "Usado" format '9999990'
column "Livre" format '9999990'
column "Expansivel" format A10
column "Total" format '9999990'
column "Usado %" format '990.00'
column "Livre %" format '990.00'
column "Tipo Ger." format A12
select t.tablespace_name "Tablespace",
       round(ar.usado) "Usado MB",
       round(decode(NVL2(cresc.tablespace, 0, sign(ar.Expansivel)),
                    1,
                    (ar.livre + ar.expansivel),
                    ar.livre),
             2) "Livre MB",
       round(ar.alocado) "Alocado Mb",
       NVL2(cresc.limite, 'ILIMITADO', round(ar.expansivel, 2)) "Expansivel",
       round(decode(NVL2(cresc.tablespace, 0, sign(ar.Expansivel)),
                    1,
                    ar.usado / (ar.total + ar.expansivel),
                    (ar.usado / ar.total)) * 100,
             2) "Usado %",
       round(decode(NVL2(cresc.tablespace, 0, sign(ar.Expansivel)),
                    1,
                    (ar.livre + ar.expansivel) / (ar.total + ar.expansivel),
                    (ar.livre / ar.total)) * 100,
             2) "Livre %",
       round(decode(NVL2(cresc.tablespace, 0, sign(ar.Expansivel)),
                    1,
                    (ar.total + ar.expansivel),
                    ar.total),
             2) "Total MB",
       FORCE_LOGGING
  from dba_tablespaces t,
       (select df.tablespace_name tablespace,
               sum(nvl(df.user_bytes,0))/1024/1024 Alocado,
               (sum(df.bytes) - sum(NVL(df_fs.bytes, 0))) / 1024 / 1024 Usado,
               sum(NVL(df_fs.bytes, 0)) / 1024 / 1024 Livre,
               sum(decode(df.autoextensible,
                          'YES',
                          decode(sign(df.maxbytes - df.bytes),
                                 1,
                                 df.maxbytes - df.bytes,
                                 0),
                          0)) / 1024 / 1024 Expansivel,
               sum(df.bytes) / 1024 / 1024 Total
          from dba_data_files df,
               (select tablespace_name, file_id, sum(bytes) bytes
                  from dba_free_space
                 group by tablespace_name, file_id) df_fs
         where df.tablespace_name = df_fs.tablespace_name(+)
           and df.file_id = df_fs.file_id(+)
         group by df.tablespace_name
        union
        select tf.tablespace_name tablespace,
               sum(nvl(tf.user_bytes,0))/1024/1024 Alocado,        
               sum(tf_fs.bytes_used) / 1024 / 1024 Usado,
               sum(tf_fs.bytes_free) / 1024 / 1024 Livre,
               sum(decode(tf.autoextensible,
                          'YES',
                          decode(sign(tf.maxbytes - tf.bytes),
                                 1,
                                 tf.maxbytes - tf.bytes,
                                 0),
                          0)) / 1024 / 1024 Expansivel,
               sum(tf.bytes) / 1024 / 1024 Total
          from dba_temp_files tf, V$TEMP_SPACE_HEADER tf_fs
         where tf.tablespace_name = tf_fs.tablespace_name
           and tf.file_id = tf_fs.file_id
         group by tf.tablespace_name) ar,
       (select df.tablespace_name tablespace, 'ILIMITADO' limite
          from dba_data_files df
         where df.maxbytes / 1024 / 1024 / 1024 > 32
           and df.autoextensible = 'YES'
         group by df.tablespace_name
        union
        select tf.tablespace_name tablespace, 'ILIMITADO' limite
          from dba_temp_files tf
         where tf.maxbytes / 1024 / 1024 / 1024 > 32
           and tf.autoextensible = 'YES'
         group by tf.tablespace_name) cresc
 where cresc.tablespace(+) = t.tablespace_name
   and ar.tablespace(+) = t.tablespace_name
 order by 6
 ;