-- https://oracle-base.com/articles/11g/data-guard-setup-11gr2#create_standby_dup --

-- MANUALLY STOP MRP PROCESS
ALTER DATABASE RECOVER MANAGED STANDBY DATABASE CANCEL;

-- MANUALLY START MRP
ALTER DATABASE RECOVER MANAGED STANDBY DATABASE DISCONNECT FROM SESSION;

-- QUERY STATUS OF LOG FILE DESTINATION
select dest_id,status,error from v$archive_dest where dest_id=2;

-- Enables log_archive_dest_n
ALTER SYSTEM SET LOG_ARCHIVE_DEST_STATE_2=enable;

-- Destination 2 configuration
select value from v$parameter where name = 'log_archive_dest_2';

-- dg config
select value from v$parameter where name = 'log_archive_config';

-- Messages from dest_id on v$dataguard_status
select message from v$dataguard_status where dest_id = 2;


---- ERROR MESSAGES ----

-- ORA-16795: the standby database needs to be re-created
    -- Check if flashback is on
        select flashback_on from v$database;
    -- Query when stdby became primary SCN *on new primary
        SELECT TO_CHAR(STANDBY_BECAME_PRIMARY_SCN) FROM V$DATABASE;
        SELECT SCN_TO_TIMESTAMP(SCN) from dual;
        -- On standby
            FLASHBACK DATABASE TO SCN XXXX;
        -- If flashback fails, we will need to recreate stdby with duplicate on rman
            rman target sys@prim auxiliary sys@stdby
            DUPLICATE TARGET DATABASE 
            FOR STANDBY 
            FROM ACTIVE DATABASE 
            DORECOVER
            SPFILE
                SET db_unique_name='db_unique_name' COMMENT 'is standby'
                SET LOG_ARCHIVE_DEST_2='service="primary_tns", LGWR SYNC AFFIRM delay=0 optional compression=disable max_failure=0 max_connections=1 reopen=300 db_unique_name="primary_unique_name" net_timeout=15, valid_for=(all_logfiles,primary_role)'
                SET FAL_SERVER='primary_unique_name' COMMENT 'is primary'
            NOFILENAMECHECK;
        -- if needed readd database to dataguard
            add database /*database*/ as connect identifier is &database maintained as physical;

-- ORA-16783: cannot resolve gap for database scsf2p_n2
    -- Use applied_stdby.sql to query last sequence applied and received
        @applied_stdby
    


    





