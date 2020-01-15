--|#########################################################################
--|# Program: obj_ddl.sql
--|# Author : Gilson Martins (gilson.pmartins@gmail.com | skype: gilson.pmartins)
--|# Version: 1.0
--|#
--|# Description: Retornar a DDL de um objeto
--|# 
--|# History:
--|#   12/12/2011 - Released version 1.0 as GPL.
--|#  
--|# Usage: obj_ddl <OBJECT_TYPE> <OBJECT_NAME> <OWNER>
--|# 
--|#########################################################################

begin
   DBMS_METADATA.SET_TRANSFORM_PARAM
      ( DBMS_METADATA.SESSION_TRANSFORM, 'SEGMENT_ATTRIBUTES', true );
   DBMS_METADATA.SET_TRANSFORM_PARAM
      ( DBMS_METADATA.SESSION_TRANSFORM, 'STORAGE', false );
   DBMS_METADATA.SET_TRANSFORM_PARAM
      ( DBMS_METADATA.SESSION_TRANSFORM, 'TABLESPACE', true );
   DBMS_METADATA.SET_TRANSFORM_PARAM
      ( DBMS_METADATA.SESSION_TRANSFORM, 'SQLTERMINATOR', true );
   DBMS_METADATA.SET_TRANSFORM_PARAM
      ( DBMS_METADATA.SESSION_TRANSFORM, 'PRETTY', true );
   DBMS_METADATA.SET_TRANSFORM_PARAM
      ( DBMS_METADATA.SESSION_TRANSFORM, 'CONSTRAINTS_AS_ALTER', true );

end;
/

SET LINES 200
SET LONG 200000000
SET PAGES 5000 LIN 4000 TRIMSPOO ON
col output format a9999

select dbms_metadata.get_ddl('&OBJECT_TYPE','&OBJECT_NAME','&OWNER') output from dual;

--|## THE END ##|--
