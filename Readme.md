# Data Warehouse
## Creación de un sistema Data Warehouse desde datos ficticios de una empresa de comunicaciones.
Tenemos tres sitemas diferetes, a saber, `CRM`, `IVR` y `Facturador`.
Ya tenemos los datos cargados en `STAGE` y el modelo de clientes ya está cargado en `ODS`.
Por tanto, tenemos que analizar el resto de tablas y generar los modelos para el `ODS`.

### CRM
El sistema `CRM` tiene tres tablas
1. Productos
2. Clientes
3. Orders

### IVR
El sistema `IVR` tiene una tabla
1. Contactos

### Facturador
El sistema `Facturador` tiene una tabla
1. Facturas

## Creación de modelos ODS para las tablas de CRM

### Productos
#### Análisis
Análisis de la tabla de `Productos`: [Script de análisis de Productos](https://github.com/ccalvomartinez/Data_Warehouse/blob/master/ANALISIS_TABLA_PRODUCTOS(SERVICIOS).sql)

Totales | Valores
------------ | -------------
 TOTAL_REGISTROS | 78495
 TOTAL_CUSTOMER_ID | 78495
 TOTAL_DIS_CUSTOMER_ID | 8001
 TOTAL_PRODUCT_ID | 78495
 TOTAL_DIS_PRODUCT_ID | 78495
 TOTAL_PRODUCT_NAME | 78495
 TOTAL_DIS_PRODUCT_NAME | 6
 TOTAL_ACCESS_POINT | 78274
 TOTAL_DIS_ACCESS_POINT | 78274
 TOTAL_DIS_ACCESS_POINT_LEN | 8
 TOTAL_AGENT_CODE | 42630
 TOTAL_DIS_AGENT_CODE | 700
 TOTAL_CHANNEL | 78274
 TOTAL_DIS_CHANNEL | 4
 TOTAL_START_DATE | 78495
 TOTAL_DIS_START_DATE | 8035
 TOTAL_INSTALL_DATE | 75363
 TOTAL_DIS_INSTALL_DATE | 75359
 TOTAL_PRODUCT_CITY | 78274
 TOTAL_DIS_PRODUCT_CITY | 81
 TOTAL_PRODUCT_ADDRESS | 78274
 TOTAL_DIS_PRODUCT_ADDRESS | 77036
 TOTAL_PRODUCT_POSTAL_CODE | 78274
 TOTAL_DIS_PRODUCT_POSTAL_CODE | 273
 TOTAL_PRODUCT_STATE | 78090
 TOTAL_DIS_PRODUCT_STATE | 3
 TOTAL_PRODUCT_COUNTRY | 78274
 TOTAL_DIS_PRODUCT_COUNTRY | 1

De aquí podemos concluir que esto no es una tabla de productos si no, más bien, una tabla de servicios y así llamaremos a nuestra tabla de `ODS`.

Además, podemos sacar a una dimensión el producto relacionado con el servicio (`PRODUCT_NAME`), el canal (`CHANNEL`) y también sacaremos la dirección a otra tabla tal y como se hizo con los clientes.

Será importante comprobar que todos los `CUSTOMER_ID` estén en la tabla de clientes y en caso de que no estén, insertarlos con IDs significativos para, posteriormente, realizar un informe con estos "errores".

#### Modelo
[Modelo ODS de Servicios](https://github.com/ccalvomartinez/Data_Warehouse/blob/master/ModeloServicios.pdf)

#### Creación de tablas
[Script de creación de tablas de Servicios](https://github.com/ccalvomartinez/Data_Warehouse/blob/master/CREAR_TABLAS_ODS_SERVICIOS.sql)

#### Población de tablas
[Script de población de tablas de Servicios](https://github.com/ccalvomartinez/Data_Warehouse/blob/master/POBLAR_TABLA_SERVICIOS.sql)

#### Conteo de filas del modelo

Tabla | Número de filas
------------ | -------------
 ODS_HC_SERVICIOS | 78495
 ODS_HC_CLIENTES | 20002
 ODS_HC_DIRECCIONES | 95769
 ODS_DM_PRODUCTOS | 8
 ODS_DM_CANALES | 6
 ODS_DM_CIUDADES_ESTADO | 158
 ODS_DM_PAISES | 3
 
### Orders
#### Análisis
Análisis de la tabla de `Orders`: [Script de análisis de Orders](https://github.com/ccalvomartinez/Data_Warehouse/blob/master/ANALISIS_TABLA_ORDERS.sql)

Totales | Valores
------------ | -------------
 TOTAL_REGISTROS | 360067
 TOTAL_ID | 360067
 TOTAL_DIS_ID | 324081
 TOTAL_ORDER | 360067
 TOTAL_DIS_ORDER | 78000
 TOTAL_PHASE | 360067
 TOTAL_DIS_PHASE | 7
 TOTAL_AGENT | 360032
 TOTAL_DIS_AGENT | 100
 TOTAL_START_DT | 360067
 TOTAL_DIS_START_DT | 342069
 TOTAL_END_DT | 282067
 TOTAL_END_DT | 270382

Lo primero que llama la atención es que el `ID` no es único, por tanto no lo podremos usar como PRIMARY KEY de nuestra tabla de `ODS`.

Podemos sacar a una dimensión el la fase (`PHASE`), el canal (`CHANNEL`) y el agente (`AGENT`).

Además, relacionaremos `ORDER` con la tabla `ODS_HC_SERVICOS`. Será importante comprobar que todos los `ORDER` estén en la tabla de Servicios y en caso de que no estén, insertarlos con IDs significativos para, posteriormente, realizar un informe con estos "errores".

#### Modelo
[Modelo ODS de Órdenes](https://github.com/ccalvomartinez/Data_Warehouse/blob/master/OrdenesModel.pdf)

#### Creación de tablas
[Script de creación de tablas de Órdenes](https://github.com/ccalvomartinez/Data_Warehouse/blob/master/CREAR_TABLAS_ODS_ORDENES.sql)

#### Población de tablas
[Script de población de tablas de Órdenes](https://github.com/ccalvomartinez/Data_Warehouse/blob/master/POBLAR_TABLAS_ORDENES.sql)

#### Conteo de filas del modelo

Tabla | Número de filas
------------ | -------------
 ODS_HC_ORDENES | 360067
 ODS_HC_SERVICIOS | 78495
 ODS_DM_FASES | 9
 ODS_DM_AGENTES | 694
 
## Creación de modelos ODS para las tablas de IVR
### Contactos
#### Análisis
Análisis de la tabla de `Contactos`: [Script de análisis de Contactos](https://github.com/ccalvomartinez/Data_Warehouse/blob/master/ANALISIS_TABLA_CONTACTOS.sql)

Totales | Valores
------------ | -------------
 TOTAL_REGISTROS | 202717
 TOTAL_ID | 202717
 TOTAL_DIS_ID | 150000
 TOTAL_PHONE_NUMBER | 185018
 TOTAL_DIS_PHONE_NUMBER | 18225
 TOTAL_START_DATETIME | 202717
 TOTAL_DIS_START_DATETIME | 201098
 TOTAL_END_DATETIME | 186535
 TOTAL_DIS_END_DATETIME | 183677
 TOTAL_SERVICE | 202502
 TOTAL_DIS_SERVICE | 6
 TOTAL_FLG_TRANSFER | 202717
 TOTAL_DIS_FLG_TRANFER | 2
 TOTAL_AGENT | 194739
 TOTAL_DIS_AGENT | 593


Lo primero que llama la atención es que el `ID` no es único, por tanto no lo podremos usar como PRIMARY KEY de nuestra tabla de `ODS`.
También vemos que, en realidad es una tabla de llamadas recibidas, por tanto llamaremos a nuestra tabla `ODS_HC_LLAMADAS`
Podemos sacar a una dimensión el servicio (`SERVICE`), al que nosotros llamaremos departamento para no confundirlo con la tabla de servicios y el agente (`AGENT`), el mismo de la tabla anterior.

#### Modelo
[Modelo ODS de Llamadas](https://github.com/ccalvomartinez/Data_Warehouse/blob/master/ModeloLlamadas.pdf)

#### Creación de tablas
[Script de creación de tablas de Llamadas](https://github.com/ccalvomartinez/Data_Warehouse/blob/master/CREAR_TABLAS_ODS_LLAMADAS.sql)

#### Población de tablas
[Script de población de tablas de Llamadas](https://github.com/ccalvomartinez/Data_Warehouse/blob/master/POBLAR_TABLA_LLAMADAS.sql)

#### Conteo de filas del modelo

Tabla | Número de filas
------------ | -------------
 ODS_HC_LLAMADAS | 202717
 ODS_DM_AGENTES | 694
 ODS_DM_DEPARTAMENTOS | 8
 
 ## Creación de modelos ODS para las tablas de Facturador

### Facturas
#### Análisis
Análisis de la tabla de `Facturas`: [Script de análisis de Facturas](https://github.com/ccalvomartinez/Data_Warehouse/blob/master/ANALISIS_TABLA_FACTURAS.sql)

Totales | Valores
------------ | -------------
 TOTAL_REGISTROS | 420000
 TOTAL_BILL_REF_NO | 420000
 TOTAL_DIS_BILL_REF_NO | 420000
 TOTAL_CUSTOMER_ID | 420000
 TOTAL_DIS_CUSTOMER_ID | 20000
 TOTAL_START_DATE | 420000
 TOTAL_DIS_START_DATE | 40
 TOTAL_END_DATE | 420000
 TOTAL_DIS_END_DATE | 20
 TOTAL_STATEMENT_DATE | 420000
 TOTAL_DIS_STATEMENT_DATE | 40
 TOTAL_PAYMENT_DATE | 420000
 TOTAL_DIS_PAYMENT_DATE | 400
 TOTAL_BILL_CYCLE | 420000
 TOTAL_DIS_BILL_CYCLE | 2
 TOTAL_AMOUNT | 420000
 TOTAL_DIS_AMOUNT | 5604
 TOTAL_BILL_METHOD | 420000
 TOTAL_DIS_BILL_METHOD | 3


Podemos sacar a una dimensión el método de pago (`BILL_METHOD`) y el cilco de facturación (`BILL_CYCLE`).

Será importante comprobar que todos los `CUSTOMER_ID` estén en la tabla de clientes y en caso de que no estén, insertarlos con IDs significativos para, posteriormente, realizar un informe con estos "errores".

#### Modelo
[Modelo ODS de Facturas](https://github.com/ccalvomartinez/Data_Warehouse/blob/master/ModeloFacturas.pdf)

#### Creación de tablas
[Script de creación de tablas de Facturas](https://github.com/ccalvomartinez/Data_Warehouse/blob/master/CREAR_TABLAS_ODS_FACTURAS.sql)

#### Población de tablas
[Script de población de tablas de Facturas](https://github.com/ccalvomartinez/Data_Warehouse/blob/master/POBLAR_TABLA_FACTURAS.sql)

#### Conteo de filas del modelo

Tabla | Número de filas
------------ | -------------
 ODS_HC_FACTURAS | 420000
 ODS_HC_CLIENTES | 20002
 ODS_DM_METODOS_PAGO | 5
 ODS_DM_CICLOS_FACTURACION | 4
 
## Resumen

[Modelo completo ODS](https://github.com/ccalvomartinez/Data_Warehouse/blob/master/ModeloODS.pdf)

### Conteo de filas del modelo
Tabla | Número de filas
------------ | -------------
 ODS_HC_CLIENTES | 20002
 ODS_HC_SERVICIOS | 78495
 ODS_HC_ORDENES | 360067
 ODS_HC_LLAMADAS | 202717
 ODS_HC_FACTURAS | 420000
 ODS_HC_DIRECCIONES | 95769
 ODS_DM_CIUDADES_ESTADO | 158
 ODS_DM_PAISES | 3
 ODS_DM_PRODUCTOS | 8
 ODS_DM_CANALES | 6
 ODS_DM_FASES | 9
 ODS_DM_AGENTES | 694
 ODS_DM_DEPARTAMENTOS | 8
 ODS_DM_METODOS_PAGO | 5
 ODS_DM_CICLOS_FACTURACION | 4
 
