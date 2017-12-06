USE ODS;

-- POBLAR TABLA DEPARTAMENTOS
-- ++++++++++++++++++++++++++

INSERT INTO ODS_DM_DEPARTAMENTOS (DE_DEPARTAMENTO, FC_INSERT, FC_MODIFICACION)
SELECT DISTINCT UPPER(TRIM(SERVICE)), NOW(), NOW() 
FROM STAGE.STG_CONTACTOS_IVR
WHERE LENGTH(TRIM(SERVICE)) > 0;

INSERT INTO ODS_DM_DEPARTAMENTOS VALUES (99, 'DESCONOCIDO', NOW(), NOW());
INSERT INTO ODS_DM_DEPARTAMENTOS VALUES (98, 'NO APLICA', NOW(), NOW());

ANALYZE TABLE ODS_DM_DEPARTAMENTOS;

-- POBLAR TABLA AGENTES
-- ++++++++++++++++++++

INSERT INTO ODS_DM_AGENTES (DE_AGENTE, FC_INSERT, FC_MODIFICACION)
SELECT DISTINCT UPPER(TRIM(AGENT)), NOW(), NOW() 
FROM STAGE.STG_CONTACTOS_IVR
WHERE LENGTH(TRIM(AGENT)) > 0;

INSERT INTO ODS_DM_AGENTES VALUES (9999, 'DESCONOCIDO', NOW(), NOW());
INSERT INTO ODS_DM_AGENTES VALUES (9998, 'NO APLICA', NOW(), NOW());

ANALYZE TABLE ODS_DM_AGENTES;

-- POBLAR TABLA LLAMADAS
-- ++++++++++++++++++++

INSERT INTO ODS_HC_LLAMADAS 
(ID_IVR,
TELEFONO_LLAMADA,
FC_INICIO_LLAMADA,
FC_FIN_LLAMADA,
ID_DEPARTAMENTO,
FLG_TRANSFERIDO,
ID_AGENTE,
FC_INSERT,
FC_MODIFICACION)
SELECT ID,
	CASE WHEN LENGTH(TRIM(PHONE_NUMBER)) > 0 THEN PHONE_NUMBER ELSE 9999999999 END TELEFONO_LLAMADA,
    CASE WHEN LENGTH(TRIM(START_DATETIME)) > 0 THEN IFNULL(str_to_date(START_DATETIME, "%Y-%m-%d %H:%i:%s.%f"), str_to_date("31/12/9999", "%d/%m/%Y"))
		ELSE str_to_date("31/12/9999", "%d/%m/%Y") END FC_INICIO,
  	CASE WHEN LENGTH(TRIM(END_DATETIME)) > 0 THEN IFNULL(str_to_date(END_DATETIME, "%Y-%m-%d %H:%i:%s.%f"), str_to_date("31/12/9999", "%d/%m/%Y")) 
		ELSE str_to_date("31/12/9999", "%d/%m/%Y") END FC_FIN,
	IFNULL(ID_DEPARTAMENTO, 99) DEPARTAMENTO,
	CASE WHEN FLG_TRANSFER = "True" THEN 1 ELSE 0 END TRANSFER,
	IFNULL(ID_AGENTE, 98) AGENTE,
    NOW(),
    NOW()
FROM STAGE.STG_CONTACTOS_IVR LLAMADAS
LEFT JOIN ODS_DM_DEPARTAMENTOS ON UPPER(TRIM(LLAMADAS.SERVICE)) = ODS_DM_DEPARTAMENTOS.DE_DEPARTAMENTO
LEFT JOIN ODS_DM_AGENTES on UPPER(TRIM(LLAMADAS.AGENT)) = ODS_DM_AGENTES.DE_AGENTE;

ANALYZE TABLE ODS_HC_LLAMADAS;