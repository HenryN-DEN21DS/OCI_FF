--------------------------------------------------------
--  DDL for View REF_OBIEE_AUTH_WLS_GROUPS
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "VWASAS"."REF_OBIEE_AUTH_WLS_GROUPS" ("ROLES") AS 
  (SELECT DISTINCT roles
      FROM REF_OBIEE_AUTORISATIE_WLS
     WHERE UPPER (roles) NOT IN
              ('BIADMINISTRATORS',
               'BIAUTHORS',
               'BICONSUMERS',
               'BIADMINISTRATOR',
               'BIAUTHOR',
               'BICONSUMER'))
 
;
  GRANT DELETE ON "VWASAS"."REF_OBIEE_AUTH_WLS_GROUPS" TO "METEOOR_WORK";
  GRANT INSERT ON "VWASAS"."REF_OBIEE_AUTH_WLS_GROUPS" TO "METEOOR_WORK";
  GRANT SELECT ON "VWASAS"."REF_OBIEE_AUTH_WLS_GROUPS" TO "METEOOR_WORK";
  GRANT UPDATE ON "VWASAS"."REF_OBIEE_AUTH_WLS_GROUPS" TO "METEOOR_WORK";
--------------------------------------------------------
--  DDL for View REF_OBIEE_AUTH_WLS_USR_GROUPS
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "VWASAS"."REF_OBIEE_AUTH_WLS_USR_GROUPS" ("WINDOWS_USERNAME", "ROLES") AS 
  (SELECT DISTINCT windows_username, roles
      FROM REF_OBIEE_AUTORISATIE_WLS
     WHERE UPPER (roles) NOT IN
              ('BIADMINISTRATORS',
               'BIAUTHORS',
               'BICONSUMERS',
               'BIADMINISTRATOR',
               'BIAUTHOR',
               'BICONSUMER'))
 
;
  GRANT DELETE ON "VWASAS"."REF_OBIEE_AUTH_WLS_USR_GROUPS" TO "METEOOR_WORK";
  GRANT INSERT ON "VWASAS"."REF_OBIEE_AUTH_WLS_USR_GROUPS" TO "METEOOR_WORK";
  GRANT SELECT ON "VWASAS"."REF_OBIEE_AUTH_WLS_USR_GROUPS" TO "METEOOR_WORK";
  GRANT UPDATE ON "VWASAS"."REF_OBIEE_AUTH_WLS_USR_GROUPS" TO "METEOOR_WORK";
--------------------------------------------------------
--  DDL for View WLS_GROUPMEMBERS_VW
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "VWASAS"."WLS_GROUPMEMBERS_VW" ("GROUP_NAME", "GROUPMEMBER_NAME") AS 
  select source group_name
     , windows_username groupmember_name
from REF_OBIEE_AUTORISATIE UNPIVOT
(val for (source)
     in ( BIBEHEER   as 'BIBEHEER' ,
          BIONTWIKKEL as 'BIONTWIKKEL' ,
          BICONSUMERS as 'BIConsumers' ,
          DB_CENTRAAL as 'DB_CENTRAAL' ,
          DB_CENTRAAL_DENY as 'DB_CENTRAAL_DENY' ,
          DB_PROCES as 'DB_PROCES' ,
          DB_EFFECT as 'DB_EFFECT' ,
          DB_EBS as 'DB_EBS',
          DB_INSPECTIEHISTORIE as 'DB_INSPECTIEHISTORIE' ,
          DB_VGC as 'DB_VGC' ,
          DB_VGCMAN as 'DB_VGCMAN' ,
          DB_CONTROL as 'DB_CONTROL' ,
          DIV_CV as 'DIV_CV' ,
          DIV_VI as 'DIV_VI' ,
          DIV_KCDV as 'DIV_KCDV' ,
          DIV_CV_ONTW as 'DIV_CV_ONTW' ,
          DIV_VI_ONTW as 'DIV_VI_ONTW' ,
          DIV_KCDV_ONTW as 'DIV_KCDV_ONTW' ,
          DB_PR_FINDB as 'DB_PR_FINDB'
         )
)
where ind_huidig_record = 1 and sysdate between trunc(sysdate) and NVL(einddatum, TO_DATE('31-12-4712', 'dd-mm-yyyy'))
;
  GRANT INSERT ON "VWASAS"."WLS_GROUPMEMBERS_VW" TO "METEOOR_WORK";
  GRANT DELETE ON "VWASAS"."WLS_GROUPMEMBERS_VW" TO "METEOOR_WORK";
  GRANT UPDATE ON "VWASAS"."WLS_GROUPMEMBERS_VW" TO "METEOOR_WORK";
  GRANT SELECT ON "VWASAS"."WLS_GROUPMEMBERS_VW" TO "METEOOR_WORK";
