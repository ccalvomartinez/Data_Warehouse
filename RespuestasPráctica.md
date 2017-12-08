## ¿Por qué en el modelo de DIRECCIONES dejo en la misma tabla las CIUDADES y los ESTADOS y no los separo en dos tablas distintas para ser más estricta con la jerarquía?
Porque hay ciudades con el mismo nombre en diferentes estados y si queremos hacer un análisis por ciudad siempre vamos a tener que cruzar con la tabla de estados para obtener la tupla CIUDAD-ESTADO.

Otra razón puede ser que no nos interese el análisis por estados. Aunque nos interesara en un futuro, no sería difícil dividir las tablas, porque es una cuestion "interna".

## ¿Serías capaz de separar el campo DE_DIRECCION  de la tabla direcciones en dos campos NOMBRE_VIA y NUM_VIA?
```SQL
SELECT 
SUBSTRING_INDEX(DE_DIRECCION, ' ' , 1) NUM_VIA,
SUBSTRING(DE_DIRECCION, LOCATE(' ', DE_DIRECCION) + 1) NOMBRE_VIA
FROM ODS.ODS_HC_DIRECCIONES
WHERE ID_DIRECCION < 999998
```

## Cambios en los sistemas de origen teniendo en cuenta:
### Data quality
1. Cada campo debe tener su tipo adecuado. Las fechas deben serde tipo fecha, los enteros de tipo entero, etc. No se debe permitir que todos los campos sean de tipo VARCHAR.
2. Los campos nulos se deben controlar en origen y sólo permitirlos si tienen sentido en el modelo. Un campo nulo en un lugar que no corresponde debería ser algo a eliminar porque es un error.
3. En el caso de campos como NUM_DOCUMENTO, DIRECCION o TELEFONO sería interesante definir los formatos para que sean iguales entre todos los sistemas.
4. Para datos como NUM_DOCUMENTO, EMAIL, TELEFONO, DIRECCION se podría comprobar, en la medida de lo posible, su veracidad, antes de ingresarlos en el sistema.

### Master data
Hay datos que son comunes a varios sitemas y deberían estar almacenados en tablas generales. El caso más claro sería CIUDADES_ESTADO y PAISES.

Además tablas tales como PRODUCTOS, aunque en nuestro sistema no aparece, debería estar relacionana con las facturas (para hacer un desglose de los cargos).

El ID_CLIENTE también es algo que debería ser compartido por todos los sistemas.

### Data Modeling & Design
En primer lugar, como he dicho antes, los tipos de los campos deben ser los corresndientes a la realidad que están modelando.

Además, todas las tablas deberían tener PRIMARY KEY.

En las tablas y campos que corresponda debería haber FOREING KEYS (por ejemplo, la tabla de clientes debería estar relacionada con la de servicios y la de servicios con la de órdenes).

Los datos que se repitan en las tablas deben ser sacados a otras tablas de dimensiones. Esto ahorra espacio e incoherencias (por ejemplo, el género en clientes).

En resumen, habría que normalizar las correspondientes tablas, al menos hasta cierto punto.

## ¿Aconsejarías algun cambio en los sistemas origen extra, teniendo en cuenta el resto de disciplinas del Data Governance?
1. Metadatos: en una empresa con varios sistemas trabajando a la vez es muy importante que cada tabla contenga sus propios metadatos de manera que las personas que usen los datos de esa tabla puedan saber de qué están hablando.
2. Integración de sistemas. En el modelo que se nos ha planteado veo un problema claro de integración. Creo que el sistema iVR debería de estar conectado con el CMR, de tal manera que si llama un cliente
    a. Quede constancia de la llamada
    b. El operador tenga acceso a los datos relevantes del cliente.

## Diseño Data Warehouse

[Modelo DataWarehouse](https://github.com/ccalvomartinez/Data_Warehouse/blob/master/ModeloDatawarehouse.pdf)

He añadido al modelo original una base de datos de informes porque dado el negocio que se maneja es muy probable que se necesiten informes de detalle de instalaciones, altas, bajas, etc.

Además también habrá que generar informes de errores teniendo en cuenta las incoherencias que se han descubierto respecto a los servicios cuyos clientes no están en la tabla de clientes.

Por otra parte he añadido las relaciones de integración entre los sistemas del negocio.

## Escribe tus propias reglas de un DataWarehouse.

1. La tablas que generemos en ODS tienen que tener sentido para el negocio.
2. Debemos establecer relaciones entre los sistemas que, conceptualmente, estén relacionados, aunque no lo estén en origen.
3. Es importante guardar todos los datos de cada día, ya que, por ejemplo, en los CRMs pueden desaparecer registros.
4. Debemos sacar a tablas de dimensiones los elementos que se repitan, siempre que tenga sentido para el negocio.
5. Los datos de las tablas tienen que estar normalizados (tipos de datos correcto, no nulos, todos en mayúsculas - o minúsculas - en los varchar,...).
6. No se permiten nulos. Cuando un campo es nulo hay que decidir si no debería serlo (en ese caso lo calificamos como desconocido) o si lo es porque no aplica.
7. Las tablas deben estar relativamente normalizadas (PK, Fks, etc.) aunque eso no nos impedirá crear tablas de conveniencia para consultas costosas que se realicen repetidas veces el en trabajo diario.
8. La teoría es muy bonita, pero hay que trabajar con lo que se tiene, lo que a veces significa transgredir las "normas" o ser inventivo.

## Nivel de SQL antes y después.
* Antes: Dejad que las queries se acerquen a mí.
* Después: Todo lo que quiso saber sobre SQL y no se atrevió a preguntar.

## ¿Algún comentario extra?
Necesito más Gigas de RAM en mi ordenador.
