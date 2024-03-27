-- Net iets uitgebreidere OASI tbv Migratie Ondersteuning: eerste veld extra en BSN ontbrak gek genoeg
CREATE OR REPLACE FORCE VIEW SIR.SIR_VSIR_TWERKZOEKENDEN_OASI
(wzd_werkzoekende_key, wzd_row_id, wzd_integration_id, wzd_bsn, wzd_datum_begin_werkzoekende, wzd_datum_einde_werkzoekende, wzd_werkzoekende_id, wzd_datum_verwijderd_uit_bron, wzd_voorletters, wzd_voorvoegsels, wzd_achternaam, wzd_code_geslacht, wzd_geboortedatum, wzd_extractiedatum_last, wzd_medewerker_invoer, wzd_huisnummer, wzd_huisnummer_toev, wzd_woonplaats, wzd_rijbewijs, wzd_vreemdelingendocument, wzd_email, wzd_straatnaam, wzd_werkmap, wzd_matchen_abs, wzd_cv_plus, wzd_ltste_datum_werkmap, wzd_woongemeente, wzd_schriftelijk_nl, wzd_mondeling_nl, wzd_act_code_einde_status, wzd_bu_code, wzd_held_postn_id, wzd_mdw_id, wzd_attendering_datum, wzd_banenafspraak, wzd_e_kanaal_mogelijk, wzd_bron_cv, wzd_cv_niet_verwijderen, wzd_act_reden_uitschrijving, wzd_act_uitschrijfdatum, wzd_act_inschrijfdatum, wzd_act_verlengdatum, wzd_act_dienstverband, wzd_act_beschikbare_uren, wzd_act_laatste_dvp_id, wzd_act_postcode, wzf_datum_begin_administratie, wzf_datum_einde_administratie, wzf_datum_begin_werkelijkheid, wzf_datum_einde_werkelijkheid, wzf_datum_eerste_mutatie, wzf_ind_actief, wzf_ind_actief_vrg_toestand, wzf_code_einde_status, wzf_code_einde_vrg_status, wzf_duur_status, wzf_duur_vrg_status, wzf_duur_onderbreking, wzf_duur_totaal, wzf_status_wz, wzf_reden_uitschrijving, wzf_uren_nog_werkzaam, wzf_uitschrijfdatum, wzf_inschrijfdatum, wzf_verlengdatum, wzf_niet_werkend_sinds, wzf_nationaliteit, wzf_dienstverband, wzf_beschikbare_uren, wzf_land, wzf_laatste_dvp_id, wzf_postcode, wzf_presentatie_op_werknl, wzf_dummy)
AS
SELECT wzd.werkzoekende_key
 , wzd.row_id
 , wzd.integration_id
 , wzd.bsn
 , wzd.datum_begin_werkzoekende
 , wzd.datum_einde_werkzoekende
 , wzd.werkzoekende_id
 , wzd.datum_verwijderd_uit_bron
 , wzd.voorletters
 , wzd.voorvoegsels
 , wzd.achternaam
 , wzd.code_geslacht
 , wzd.geboortedatum
 , wzd.extractiedatum_last
 , wzd.medewerker_invoer
 , wzd.huisnummer
 , wzd.huisnummer_toev
 , wzd.woonplaats
 , wzd.rijbewijs
 , wzd.vreemdelingendocument
 , wzd.email
 , wzd.straatnaam
 , wzd.werkmap
 , wzd.matchen_abs
 , wzd.cv_plus
 , wzd.ltste_datum_werkmap
 , wzd.woongemeente
 , wzd.schriftelijk_nl
 , wzd.mondeling_nl
 , wzd.act_code_einde_status
 , wzd.bu_code
 , wzd.held_postn_id
 , wzd.mdw_id
 , wzd.attendering_datum
 , wzd.banenafspraak
 , wzd.e_kanaal_mogelijk
 , wzd.bron_cv
 , wzd.cv_niet_verwijderen
 , wzd.act_reden_uitschrijving
 , wzd.act_uitschrijfdatum
 , wzd.act_inschrijfdatum
 , wzd.act_verlengdatum
 , wzd.act_dienstverband
 , wzd.act_beschikbare_uren
 , wzd.act_laatste_dvp_id
 , wzd.act_postcode
 , wzf.datum_begin_administratie
 , wzf.datum_einde_administratie
 , wzf.datum_begin_werkelijkheid
 , wzf.datum_einde_werkelijkheid
 , wzf.datum_eerste_mutatie
 , wzf.ind_actief
 , wzf.ind_actief_vrg_toestand
 , wzf.code_einde_status
 , wzf.code_einde_vrg_status
 , wzf.duur_status
 , wzf.duur_vrg_status
 , wzf.duur_onderbreking
 , wzf.duur_totaal
 , wzf.status_wz
 , wzf.reden_uitschrijving
 , wzf.uren_nog_werkzaam
 , wzf.uitschrijfdatum
 , wzf.inschrijfdatum
 , wzf.verlengdatum
 , wzf.niet_werkend_sinds
 , wzf.nationaliteit
 , wzf.dienstverband
 , wzf.beschikbare_uren
 , wzf.land
 , wzf.laatste_dvp_id
 , wzf.postcode
 , wzf.presentatie_op_werknl
 , wzf.dummy
 FROM sir.sir_twerkzoekenden_fct wzf
 , sir.sir_twerkzoekenden_dim wzd
 WHERE wzd.werkzoekende_key = wzf.werkzoekende;

-- WERKZOEKENDEN
create table sir.s_contact_his tablespace SIR_FCT_DATA NOLOGGING
as
select wzd_row_id  as row_id
, 'N'              as emp_flg
, 'N'              as priv_flg
, CAST(null as varchar2(30)) as X_CWI_PR_BEMID_BEROEP_ID
, case when wzf_datum_begin_werkelijkheid = to_date('01-01-1900','dd-mm-yyyy') 
       then null
       else wzf_datum_begin_werkelijkheid 
  end  LAST_UPD
, case when wzd_ltste_datum_werkmap = to_date('07-07-7777','dd-mm-yyyy') 
       then null
       else wzd_ltste_datum_werkmap 
  end  X_CWI_WERKMAP_DT
,      decode(wzf_laatste_dvp_id,'#', null,wzf_laatste_dvp_id)                as X_CWI_DVP_ID_LAST_OPENED
,      decode(wzf_reden_uitschrijving,'#', null,wzf_reden_uitschrijving)      as X_CWI_REDEN_EINDE_DVP
,      decode(wzd_medewerker_invoer,'#', null,wzd_medewerker_invoer)          as CREATOR_LOGIN
,      decode(wzd_mondeling_nl,'#', null,wzd_mondeling_nl)                    as X_CWI_MOND_NL_CD
,      decode(wzd_schriftelijk_nl,'#', null,wzd_schriftelijk_nl)              as X_CWI_SCHR_NL_CD
,      decode(wzd_voorvoegsels,'#', null,wzd_voorvoegsels)                    as MID_NAME
,      wzf_beschikbare_uren                                                   as X_CWI_BESCHIKBARE_UREN
,      decode(wzf_presentatie_op_werknl,'#', null,wzf_presentatie_op_werknl)  as X_CWI_ANNONIMITEITSNIVO_CD
,      decode(wzf_status_wz,'#', null,wzf_status_wz)                          as X_CWI_KLANT_STATUS
,      decode(wzd_achternaam,'#', null,wzd_achternaam)                        as LAST_NAME
,      decode(wzd_banenafspraak,'#', null,wzd_banenafspraak)                  as X_BANEN_AFSPRAAK_FLAG
,      decode(wzd_cv_niet_verwijderen,'#', null,wzd_cv_niet_verwijderen)      as X_CV_NIET_VERWIJDEREN_FLAG
,      decode(wzd_vreemdelingendocument,'#', null,wzd_vreemdelingendocument)  as X_CWI_TYPE_VREEMDELINGENDOC_CD
,      decode(wzd_woongemeente,'#', null,wzd_woongemeente)                    as X_WOONGEMEENTE
, case when wzf_verlengdatum = to_date('07-07-7777','dd-mm-yyyy') 
       then null
       else wzf_verlengdatum 
  end  X_CWI_VERLENGING_DT
,      decode(wzd_bu_code,'#', null,wzd_bu_code)                              as BU_ID
,      decode(wzd_code_geslacht,'#', null,wzd_code_geslacht)                  as SEX_MF
,      decode(wzd_rijbewijs,'#', null,wzd_rijbewijs)                          as X_CWI_RIJBEWIJS_TOTAL
, case when wzf_inschrijfdatum = to_date('07-07-7777','dd-mm-yyyy') 
       then null
       else wzf_inschrijfdatum 
  end  X_CWI_INSCHRIJVING_DT
,case when wzd_attendering_datum = to_date('07-07-7777','dd-mm-yyyy') 
       then null
       else wzd_attendering_datum 
  end  X_ATTENDERING_DT
,      decode(wzd_e_kanaal_mogelijk,'#', null,wzd_e_kanaal_mogelijk)          as X_EKANAAL_MOGELIJK_FLG
,      decode(wzd_matchen_abs,'#', null,wzd_matchen_abs)                      as X_ABS_FLAG
,      decode(wzf_dienstverband,'#', null,wzf_dienstverband)                  as X_CWI_DIENSTVERBAND_CD
,      decode(wzd_bron_cv,'#', null,wzd_bron_cv)                              as X_BRON_CV
,      decode(wzd_bsn,'#', null,wzd_bsn)                                      as SOC_SECURITY_NUM
, case when wzd_geboortedatum = to_date('07-07-7777','dd-mm-yyyy') 
       then null
       else wzd_geboortedatum 
  end  BIRTH_DT
,      decode(wzd_voorletters,'#', null,wzd_voorletters)                      as FST_NAME
, case when wzf_uitschrijfdatum = to_date('07-07-7777','dd-mm-yyyy') 
       then null
       else wzf_uitschrijfdatum 
  end  X_CWI_EINDE_INSCHRIJVING_DT
,      decode(wzd_cv_plus,'#', null,wzd_cv_plus)                              as X_HGM_INDICATIE_FLG
,      decode(wzd_email,'#', null,wzd_email)                                  as EMAIL_ADDR
,      decode(wzd_held_postn_id,'#', null,wzd_held_postn_id)                  as PR_HELD_POSTN_ID
,      decode(wzd_mdw_id,'#', null,wzd_mdw_id)                                as PAR_ROW_ID
,      decode(wzd_werkmap,'#', null,wzd_werkmap)                              as MEMBER_FLG
,      decode(wzf_nationaliteit,'#', null,wzf_nationaliteit)                  as X_CWI_NATIONALITEIT_CD
,      wzf_uren_nog_werkzaam                                                  as X_CWI_UREN_NOG_WERKZAAM
,      wzf_datum_begin_werkelijkheid                                          as geldig_van
,      wzf_datum_einde_werkelijkheid                                          as geldig_tot
,      case when wzd_datum_verwijderd_uit_bron = to_date('07-07-7777','dd-mm-yyyy') 
            then null
            else wzd_datum_verwijderd_uit_bron 
       end dtd_verwijderd_uit_bron
from sir.sir_vsir_twerkzoekenden_oasi o
WHERE WZF_DATUM_BEGIN_WERKELIJKHEID <> to_date('01-01-1900','dd-mm-yyyy') -- hier weten we sowieso nog niks 
;

-- ADRESSEN 
create table sir.S_ADDR_PER_HIS tablespace SIR_FCT_DATA NOLOGGING
as
select NVL(k.wza_row_id, 'G-'||to_char(ROWNUM))                 	as ROW_ID -- hebben we niet dus genereren ?
, decode(WZA.WZD_ROW_ID,'#',null,WZA.WZD_ROW_ID)                    as PER_ID -- koppeling met S_CONTACT 
, decode(WZA.WZD_HUISNUMMER,'#',null,WZA.WZD_HUISNUMMER)            as ADDR_LINE_3
, decode(WZA.WZD_WOONPLAATS,'#',null,WZA.WZD_WOONPLAATS)            as CITY
, decode(WZA.WZF_POSTCODE,'#',null,WZA.WZF_POSTCODE)                as ZIPCODE
, decode(WZA.WZD_HUISNUMMER_TOEV,'#',null,WZA.WZD_HUISNUMMER_TOEV)  as X_CWI_HUISNUMMER_TOEVOEGING
, decode(WZA.WZD_STRAATNAAM,'#',null,WZA.WZD_STRAATNAAM)            as ADDR
, decode(WZA.WZF_LAND,'#',null,WZA.WZF_LAND)                        as COUNTRY
, case when WZA.WZF_DATUM_BEGIN_WERKELIJKHEID = to_date('01-01-1900','dd-mm-yyyy') 
       then null
       else WZA.WZF_DATUM_BEGIN_WERKELIJKHEID 
  end last_upd
, WZA.WZF_DATUM_BEGIN_WERKELIJKHEID as geldig_van
, WZA.WZF_DATUM_EINDE_WERKELIJKHEID as geldig_tot
from sir.sir_vsir_twerkzoekenden_oasi wza
LEFT OUTER JOIN sir.sir_twz_adressen_kin k
ON WZA.WZD_ROW_ID                 = k.wza_wze_id
AND WZA.WZD_HUISNUMMER            = k.wza_HUISNUMMER
AND WZA.WZD_WOONPLAATS            = k.wza_PLAATS
AND WZA.WZF_POSTCODE              = k.wza_POSTCODE
AND WZA.WZD_HUISNUMMER_TOEV       = k.wza_HUISNUMMER_TOEVOEGING
AND WZA.WZD_STRAATNAAM            = k.wza_STRAATNAAM
AND WZA.WZF_LAND                  = k.wza_LAND
WHERE WZF_DATUM_BEGIN_WERKELIJKHEID <> to_date('01-01-1900','dd-mm-yyyy') -- hier weten we sowieso nog niks 
;

-- DV 
create table sir.S_CASE_HIS tablespace SIR_FCT_DATA NOLOGGING
as
select decode(dnd_dv_id,'#',null,dnd_dv_id)                                         as ROW_ID
,      CAST('DV' as varchar2(50))                                                   as TYPE
,      case when dnf_datum_begin_werkelijkheid = to_date('01-01-1900','dd-mm-yyyy') 
            then null
            else dnf_datum_begin_werkelijkheid 
       end last_upd
,      case when dnd_datum_begin_dv = to_date('07-07-7777','dd-mm-yyyy') 
            then null
            else dnd_datum_begin_dv 
       end  CASE_DT
,      case when dnd_datum_einde_dv = to_date('07-07-7777','dd-mm-yyyy') 
            then null
            else dnd_datum_einde_dv 
       end  CLOSED_DT       
,      case when dnd_datum_melding = to_date('07-07-7777','dd-mm-yyyy') 
            then null
            else dnd_datum_melding 
       end  X_NOTIFICATION_DATE
,      decode(dnd_vestiging_id,'#',null,dnd_vestiging_id)                           as BU_ID
,      decode(dnf_reden_einde,'#',null,dnf_reden_einde)                             as X_REASON_SERVICE_ENDING
,      case when dnd_overdrachtsdatum_wwb = to_date('07-07-7777','dd-mm-yyyy') 
            then null
            else dnd_overdrachtsdatum_wwb 
       end  X_OVERDRACHT_WWB_DATE
,      case when dnf_max_uitkeringsdatum = to_date('07-07-7777','dd-mm-yyyy') 
            then null
            else dnf_max_uitkeringsdatum 
       end  X_MAX_PAYMENT_DATE
,      case when dnf_niet_werkend_sinds = to_date('07-07-7777','dd-mm-yyyy') 
            then null
            else dnf_niet_werkend_sinds 
       end  X_NON_WORKING_DATE
,      decode(dnf_uitstroom_status,'#',null,dnf_uitstroom_status)                   as X_TUSSENRESULTAAT_STATUS
,      decode(dnd_samenloop,'#',null,dnd_samenloop)                                 as X_SAMENLOOP_FLG
,      case when dnd_vermoed_eerste_uitk_dag = to_date('07-07-7777','dd-mm-yyyy') 
            then null
            else dnd_vermoed_eerste_uitk_dag 
       end  X_UNEMPLOYMENT_DATE
,      decode(dnf_participatieladder,'#',null,dnf_participatieladder)               as X_PARTICIPATIELADDER
,      decode(dnd_dv_naam,'#',null,dnd_dv_naam)                                     as NAME
,      case when dnd_eerste_ww_dag = to_date('07-07-7777','dd-mm-yyyy') 
            then null
            else dnd_eerste_ww_dag 
       end  X_UNEMPLOYMENT_DATE_WW 
,      dnf_aantal_uren_ww                                                           as X_TOTAL_WW_HOURS_1
,      decode(dnd_eigenaar_id,'#',null,dnd_eigenaar_id)                             as PR_POSTN_ID
,      decode(dnf_status,'#',null,dnf_status)                                       as STATUS_CD
,      dnd_dagloon                                                                  as X_DAILY_PAY
,      decode(dnd_medische_indicering,'#',null,dnd_medische_indicering)             as X_MEDISCHE_INDICERING
,      decode(dnf_reden_uitstroom,'#',null,dnf_reden_uitstroom)                     as X_PR_TUSSENRESULTAAT_ID
,      decode(wzd_row_id,'#',null,wzd_row_id)                                       as PR_SUBJECT_ID
,      case when dnf_eerste_uitk_dag = to_date('07-07-7777','dd-mm-yyyy') 
            then null
            else dnf_eerste_uitk_dag 
       end  X_ACTUAL_1ST_WW_DATE
,      dnf_datum_begin_werkelijkheid                                                as geldig_van
,      dnf_datum_einde_werkelijkheid                                                as geldig_tot
,      case when dnd_datum_verwijderd_uit_bron = to_date('07-07-7777','dd-mm-yyyy') 
            then null
            else dnd_datum_verwijderd_uit_bron 
       end dtd_verwijderd_uit_bron      
from   sir.sir_vsir_tdvs_oasi o
where  dnf_datum_begin_werkelijkheid <> to_date('01-01-1900','dd-mm-yyyy') -- hier weten we sowieso nog niks 
;

-- DV TUSSENRESULTAAT UITSTROOM
create table sir.CX_ADV_XM_his tablespace SIR_FCT_DATA NOLOGGING
as
select  o.dnf_reden_uitstroom                                                  as ROW_ID 
,       o.dnd_dv_id                                                            as PAR_ROW_ID -- link met DV 
,       case when o.dnf_datum_begin_werkelijkheid = to_date('01-01-1900','dd-mm-yyyy') 
             then null
             else o.dnf_datum_begin_werkelijkheid
        end last_upd
,       CAST('DV Uitstroom' as varchar2(50))                                   as TYPE
,       case when o.dnf_datum_uitstroom = to_date('07-07-7777','dd-mm-yyyy') 
             then null
             else o.dnf_datum_uitstroom 
        end X_DATUM_UITSTROOM
,       o.dnf_datum_begin_werkelijkheid                                        as geldig_van
,       o.dnf_datum_einde_werkelijkheid                                        as geldig_tot
FROM    SIR.SIR_VSIR_TDVS_OASI o
where   o.dnd_dv_id <> '#' 
AND     o.dnf_datum_begin_werkelijkheid <> to_date('01-01-1900','dd-mm-yyyy') -- hier weten we sowieso nog niks 
AND     SUBSTR(o.dnf_reden_uitstroom,2,1) = '-' -- ooit foute mapping dus alleen de betekenisvolle
;

-- INDICERINGEN 
create table sir.S_CASE_XM_his tablespace SIR_FCT_DATA NOLOGGING
as
select  CAST('G-'||to_char(ROWNUM) as varchar2(50))                           as ROW_ID -- hebben we niet dus genereren ?
,       o.dnd_dv_id                                                           as PAR_ROW_ID -- link met DV 
,       case when o.dnf_datum_begin_werkelijkheid = to_date('01-01-1900','dd-mm-yyyy') 
             then null
             else o.dnf_datum_begin_werkelijkheid
        end last_upd
,       o.dnf_indicering                                                       as ATTRIB_05
,       o.dnf_datum_begin_werkelijkheid                                        as geldig_van
,       o.dnf_datum_einde_werkelijkheid                                        as geldig_tot
FROM    SIR.SIR_VSIR_TDVS_OASI o
where   o.dnd_dv_id <> '#' 
AND     o.dnf_datum_begin_werkelijkheid <> to_date('01-01-1900','dd-mm-yyyy') -- hier weten we sowieso nog niks 
AND     o.dnf_indicering <> '#' -- alleen de betekenisvolle
;

-- OPLEIDINGEN DEEL 1
create table sir.s_contact_xm_his tablespace SIR_FCT_DATA NOLOGGING
as
select CAST('G-'||to_char(ROWNUM) as varchar2(50))                           as ROW_ID -- hebben we niet dus genereren ?
,      case when o.opf_datum_begin_werkelijkheid = to_date('01-01-1900','dd-mm-yyyy') 
            then null
            else o.opf_datum_begin_werkelijkheid 
            end last_upd
,      decode(o.opf_nvs_opleidingscode,'#',null,o.opf_nvs_opleidingscode)        as ATTRIB_34
,      CAST('CWI Opleiding' as varchar2(30))                                     as TYPE
,      decode(o.opd_wz_row_id,'#',null,o.opd_wz_row_id)                          as PAR_ROW_ID
,      decode(o.opd_instantie_id,'#',null, o.opd_instantie_id)                   as X_CWI_EMPLOYER_OU_ID
,      case when o.opd_datum_begin_opleiding = to_date('07-07-7777','dd-mm-yyyy') 
            then null
            else o.opd_datum_begin_opleiding 
       end  ATTRIB_26
,      case when o.opd_datum_einde_opleiding = to_date('07-07-7777','dd-mm-yyyy') 
            then null
            else o.opd_datum_einde_opleiding 
       end   ATTRIB_13
,      decode(o.opf_diploma,'#',null,o.opf_diploma)                              as ATTRIB_36
,      o.opf_datum_begin_werkelijkheid                                           as geldig_van
,      o.opf_datum_einde_werkelijkheid                                           as geldig_tot
,      case when o.opd_datum_verwijderd_uit_bron = to_date('07-07-7777','dd-mm-yyyy') 
            then null
            else o.opd_datum_verwijderd_uit_bron 
       end dtd_verwijderd_uit_bron
from   SIR.SIR_VSIR_TOPLEIDINGEN_OASI o
where  o.opf_datum_begin_werkelijkheid <> to_date('01-01-1900','dd-mm-yyyy') -- hier weten we sowieso nog niks 
;

-- OPLEIDINGEN DEEL 2
-- Referentietabel voor Opleidingen + het nivo ervan
create table sir.CX_OPLEIDINGEN_his tablespace SIR_FCT_DATA NOLOGGING
as
select CAST('G-'||to_char(ROWNUM) as varchar2(50))                           as ROW_ID -- hebben we niet dus genereren ?
,      case when geldig_van = to_date('01-01-1900','dd-mm-yyyy') 
            then null
            else geldig_van 
       end last_upd
,      decode(opf_nvs_opleidingscode,'#',null,opf_nvs_opleidingscode)        as X_OPLEIDING_CD
,      decode(opf_niveau,'#',null,opf_niveau)                              as X_CODE_OPLEIDINGSNIVEAU
,      geldig_van
,      geldig_tot
FROM
(select o.opf_nvs_opleidingscode
,       o.opf_niveau
,       MIN(o.opf_datum_begin_werkelijkheid)                                      as geldig_van
,       MAX(o.opf_datum_einde_werkelijkheid)                                      as geldig_tot
from    SIR.SIR_VSIR_TOPLEIDINGEN_OASI o
where   o.opf_datum_begin_werkelijkheid <> to_date('01-01-1900','dd-mm-yyyy') -- hier weten we sowieso nog niks 
group by o.opf_nvs_opleidingscode
,        o.opf_niveau
)
;

-- BEROEPEN DEEL 1
insert into sir.s_contact_xm_his 
( row_id
, last_upd
, attrib_34
, type
, par_row_id
, geldig_van
, geldig_tot
, dtd_verwijderd_uit_bron
)
select o.bed_row_id  row_id
,      case when o.bef_datum_begin_werkelijkheid = to_date('01-01-1900','dd-mm-yyyy') 
            then null
            else o.bef_datum_begin_werkelijkheid 
            end last_upd
,      case when o.bef_beroepscode = '#'
            then null 
            else o.bef_beroepscode
       end  attrib_34
,      o.bed_type_beroep type 
,      case when o.wzd_row_id = '#'
            then null 
            else o.wzd_row_id
       end par_row_id
,      o.bef_datum_begin_werkelijkheid geldig_van
,      o.bef_datum_einde_werkelijkheid geldig_tot
,      case when o.bed_datum_verwijderd_uit_bron = to_date('07-07-7777','dd-mm-yyyy') 
            then null
            else o.bed_datum_verwijderd_uit_bron 
       end dtd_verwijderd_uit_bron
from   sir.sir_vsir_tberoepen_oasi o
where  o.bef_datum_begin_werkelijkheid <> to_date('01-01-1900','dd-mm-yyyy') -- hier weten we sowieso nog niks 
and    o.bed_type_beroep <> '#'
;
commit;

-- BEROEPEN DEEL 2 
create unique index S_CONTACT_HIS_UK on sir.S_CONTACT_HIS (ROW_ID, GELDIG_VAN);
analyze index SIR.S_CONTACT_HIS_UK compute statistics;
declare
cursor c_pr_bem_id
is
select d.row_id    bem_id
,      wzd.row_id  wzd_row_id
,      f.datum_begin_werkelijkheid
,      f.datum_einde_werkelijkheid
      from   sir.sir_tberoepen_fct f -- count(*) 5.935.735 ACCEPTATIE 
      ,      sir.sir_tberoepen_dim d
      ,      sir.sir_twerkzoekenden_dim wzd        
      where  wzd.werkzoekende_key         = f.werkzoekende
      and    f.beroep                     = d.beroep_key
      and    f.datum_begin_administratie  = to_date('01-01-1900', 'dd-mm-yyyy')
      and    f.datum_begin_werkelijkheid <> to_date('01-01-1900', 'dd-mm-yyyy') -- hier weten we sowieso nog niks 
      and    f.bvi_flag                   = 'Y'
order by 2, 3 -- bij update zelfde rij wint de meest recente
;
TYPE t_pr_bem_tab is TABLE of c_pr_bem_id%ROWTYPE;
l_pr_bem_tab t_pr_bem_tab;

begin
   open c_pr_bem_id; 
   fetch c_pr_bem_id bulk collect into l_pr_bem_tab limit 100000;
   while l_pr_bem_tab.first is not null
   loop
      forall i IN l_pr_bem_tab.first .. l_pr_bem_tab.last 
      update sir.s_contact_his h
      set    h.x_cwi_pr_bemid_beroep_id = l_pr_bem_tab(i).bem_id
      where  h.row_id = l_pr_bem_tab(i).wzd_row_id
      -- overlap met tijdslijn Werkzoekende
      and (  (l_pr_bem_tab(i).datum_begin_werkelijkheid between h.geldig_van and h.geldig_tot)
             OR (l_pr_bem_tab(i).datum_einde_werkelijkheid between h.geldig_van and h.geldig_tot)
             OR (l_pr_bem_tab(i).datum_begin_werkelijkheid <= h.geldig_van and l_pr_bem_tab(i).datum_einde_werkelijkheid >= h.geldig_tot)
          )
      ;
      commit;   
      fetch c_pr_bem_id bulk collect into l_pr_bem_tab limit 100000;
   end loop;
   close c_pr_bem_id;   
end;   
/
drop index SIR.S_CONTACT_HIS_UK;

/* MEET QUERIES VOORTGANG BEROEPEN DEEL 2 
select max(t.row_id) from SIR.S_CONTACT_HIS t
where t.x_cwi_pr_bemid_beroep_id is not null
;
select * -- count(*) 5.935.735 ACCEPTATIE 
from
(
select d.row_id    bem_id
,      wzd.row_id  wzd_row_id
,      f.datum_begin_werkelijkheid
,      f.datum_einde_werkelijkheid
,      row_number() over (order by wzd.row_id, f.datum_begin_werkelijkheid) rij_nr
      from   sir.sir_tberoepen_fct f 
      ,      sir.sir_tberoepen_dim d
      ,      sir.sir_twerkzoekenden_dim wzd        
      where  wzd.werkzoekende_key         = f.werkzoekende
      and    f.beroep                     = d.beroep_key
      and    f.datum_begin_administratie  = to_date('01-01-1900', 'dd-mm-yyyy')
	  and    f.datum_begin_werkelijkheid <> to_date('01-01-1900', 'dd-mm-yyyy') -- hier weten we sowieso nog niks 
      and    f.bvi_flag                   = 'Y'
order by 2, 3
)
where wzd_row_id = '1-ZZZY7T' -- max uit vorige query
;
*/