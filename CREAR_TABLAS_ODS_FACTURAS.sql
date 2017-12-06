USE ODS;

-- CREAR TABLAS ODS
-- +++++++++++++++

DROP TABLE IF EXISTS ODS_DM_METODOS_PAGO;
CREATE TABLE ODS_DM_METODOS_PAGO
(ID_METODO_PAGO INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
DE_METODO_PAGO VARCHAR(512),
FC_INSERT DATETIME,
FC_MODIFICACION DATETIME);

DROP TABLE IF EXISTS ODS_DM_CICLOS_FACTURACION;
CREATE TABLE ODS_DM_CICLOS_FACTURACION
(ID_CICLO_FACTURACION INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
DE_CICLO_FACTURACION VARCHAR(512),
FC_INSERT DATETIME,
FC_MODIFICACION DATETIME);

DROP TABLE IF EXISTS ODS_HC_FACTURAS;
CREATE TABLE ODS_HC_FACTURAS
(ID_FACTURA INT UNSIGNED NOT NULL PRIMARY KEY,
ID_CLIENTE INT NOT NULL,
FC_INICIO DATETIME,
FC_FIN DATETIME,
FC_ESTADO DATETIME,
FC_PAGO DATETIME,
ID_CICLO_FACTURACION INT UNSIGNED,
ID_METODO_PAGO INT UNSIGNED,
CANTIDAD DECIMAL(10,2),
FC_INSERT DATETIME,
FC_MODIFICACION DATETIME);

-- CREAR FOREING KEYS
-- ++++++++++++++++++

ALTER TABLE ODS_HC_FACTURAS ADD INDEX fk_fact_ciclo_idx (ID_CICLO_FACTURACION ASC);
ALTER TABLE ODS_HC_FACTURAS ADD CONSTRAINT fk_fact_ciclo FOREIGN KEY (ID_CICLO_FACTURACION) 
	REFERENCES ODS_DM_CICLOS_FACTURACION (ID_CICLO_FACTURACION);
    
ALTER TABLE ODS_HC_FACTURAS ADD INDEX fk_fact_mpago_idx (ID_METODO_PAGO ASC);
ALTER TABLE ODS_HC_FACTURAS ADD CONSTRAINT fk_fact_mpago FOREIGN KEY (ID_METODO_PAGO) 
	REFERENCES ODS_DM_METODOS_PAGO (ID_METODO_PAGO);
    
ALTER TABLE ODS_HC_FACTURAS ADD INDEX fk_fact_cli_idx (ID_CLIENTE ASC);
ALTER TABLE ODS_HC_FACTURAS ADD CONSTRAINT fk_fact_cli FOREIGN KEY (ID_CLIENTE) 
	REFERENCES ODS_HC_CLIENTES (ID_CLIENTE);
