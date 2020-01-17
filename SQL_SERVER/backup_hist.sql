SELECT
database_name, name, backup_start_date, backup_finish_date, datediff(mi, backup_start_date, backup_finish_date) [tempo (min)],
position, first_lsn, last_lsn, server_name, recovery_model, isnull(logical_device_name, ' ') logical_device_name, device_type,
type, cast(backup_size/1024/1024 as numeric(15,2)) [Tamanho (MB)], B.is_copy_only
FROM msdb.dbo.backupset B
INNER JOIN msdb.dbo.backupmediafamily BF ON B.media_set_id = BF.media_set_id
where backup_start_date >= dateadd(hh, -24 ,getdate())
and type in ('D','I','L')
-- and database_name = 'NomeDatabase'
order by backup_start_date desc