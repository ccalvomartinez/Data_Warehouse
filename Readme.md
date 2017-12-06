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
Análisis de la tabla de productos: [Script de análisis de productos](https://github.com/ccalvomartinez/Data_Warehouse/blob/master/ANALISIS_TABLA_PRODUCTOS(SERVICIOS).sql)

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

De aquí podemos concluir que esto no es una tabla de productos si no, mas bien una tabla de servicios y así llamaremos a nuestra tabla de `ODS`.
Además, podemos sacar a una dimensión el producto relacionado con el servicio (`PRODUCT_NAME`), el canal (`CHANNEL`) y también sacaremos la dirección a otra tabla tal y como se hizo con los clientes.
Será importante comprobar que todos los `CUSTOMER_ID` estén en la tabla de clientes y en caso de que no estén, insertarlos con ID significativos para, posteriormente, realizar un informe con estos "errores".

#### Modelo
[Modelo ODS de servicios](https://github.com/ccalvomartinez/Data_Warehouse/blob/master/ModeloServicios.pdf)

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
