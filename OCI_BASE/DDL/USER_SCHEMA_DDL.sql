create user VWASAS identified by '77A1Ce38AB!'
  default tablespace MI_DATA
  temporary tablespace TEMP
  profile NO_EXPIRE
  quota unlimited on mi_data;
-- Grant/Revoke role privileges 
grant resource to VWASAS;
-- Grant/Revoke system privileges 
grant create any index to VWASAS;
grant create database link to VWASAS;
grant create materialized view to VWASAS;
grant create procedure to VWASAS;
grant create session to VWASAS;
grant create synonym to VWASAS;
grant create table to VWASAS;
grant create view to VWASAS;
grant unlimited tablespace to VWASAS;


-- USER SQL
CREATE USER "VWASAS" IDENTIFIED BY "!CeL_2kj#2023!"  
DEFAULT TABLESPACE "MI_DATA"
TEMPORARY TABLESPACE "TEMP"
PASSWORD EXPIRE ;

-- QUOTAS
ALTER USER "VWASAS" QUOTA UNLIMITED ON "MI_DATA";

-- ROLES
GRANT "DBA" TO "VWASAS" ;
GRANT "SCHEDULER_ADMIN" TO "VWASAS" ;
GRANT "SELECT_CATALOG_ROLE" TO "VWASAS" ;
GRANT "CONNECT" TO "VWASAS" ;
GRANT "RESOURCE" TO "VWASAS" ;
GRANT "EXP_FULL_DATABASE" TO "VWASAS" ;

-- SYSTEM PRIVILEGES
GRANT CREATE ROLE TO "VWASAS" ;
GRANT CREATE MATERIALIZED VIEW TO "VWASAS" ;
GRANT CREATE ANY INDEX TO "VWASAS" ;
GRANT AUDIT ANY TO "VWASAS" ;
GRANT CREATE SESSION TO "VWASAS" ;
GRANT CREATE RULE TO "VWASAS" ;
GRANT BECOME USER TO "VWASAS" ;
GRANT CREATE SYNONYM TO "VWASAS" ;
GRANT CREATE ANY VIEW TO "VWASAS" ;
GRANT COMMENT ANY TABLE TO "VWASAS" ;
GRANT CREATE DATABASE LINK TO "VWASAS" ;
GRANT CREATE ANY TABLE TO "VWASAS" ;
GRANT CREATE PROCEDURE TO "VWASAS" ;
