/*******************************************************
 *                                                     *
 *               SISTEMA DE GESTIÓN CECINAS            *
 *                                                     *
 *   Tema: Restricciones (CONSTRAINTS) en SQL          *
 *   Fecha: 21 de Agosto de 2024                       *
 *   Lenguaje: SQL                                     *
 *                                                     *
 *   Descripción:                                      *
 *   Este script demuestra cómo funcionan las          *
 *   restricciones en una base de datos relacional     *
 *   utilizando la estructura de la base de datos de   *
 *   Cecinas. Se incluyen ejemplos de las restricciones*
 *   más comunes: NOT NULL, UNIQUE, PRIMARY KEY,       *
 *   FOREIGN KEY, CHECK, y DEFAULT. Ademas se muestra  *
 *   comofuncionan las opciones                        *
 *   de actualización y borrado en cascada en una base *
 *   de datos relacional                               *
 *                                                     *
 *******************************************************/

/*******************************************************
 *                                                     *
 *   RESTRICCIÓN 1: NOT NULL                           *
 *                                                     *
 *******************************************************/
-- La restricción NOT NULL asegura que una columna no pueda contener valores nulos.
-- Se aplica en la columna nombre de la tabla empresa.

CREATE TABLE empresa (
    rut VARCHAR2(10) PRIMARY KEY,
    nombre VARCHAR2(200) NOT NULL  -- Esta columna no puede ser nula
);

-- Ejemplo de inserción válida
INSERT INTO empresa (rut, nombre) VALUES ('123456789', 'Cecinas del Sur');

-- Ejemplo de inserción inválida (intentando insertar un valor nulo en nombre)
-- Esto producirá un error porque la columna nombre no puede ser nula
INSERT INTO empresa (rut, nombre) VALUES ('987654321', NULL);
/* Error esperado: ORA-01400: cannot insert NULL into ("NOMBRE") */


/*******************************************************
 *                                                     *
 *   RESTRICCIÓN 2: UNIQUE                             *
 *                                                     *
 *******************************************************/
-- La restricción UNIQUE asegura que todos los valores en una columna sean únicos.
-- Se aplica en la columna fono de la tabla cliente.

CREATE TABLE cliente (
    rut VARCHAR2(10) PRIMARY KEY,
    nombre VARCHAR2(120),
    fono VARCHAR2(20) UNIQUE  -- Esta columna debe contener valores únicos
);

-- Ejemplo de inserción válida
INSERT INTO cliente (rut, nombre, fono) VALUES ('987654321', 'Supermercado ABC', '22223333');

-- Ejemplo de inserción inválida (intentando insertar un valor duplicado en fono)
-- Esto producirá un error porque el valor ya existe en la tabla
INSERT INTO cliente (rut, nombre, fono) VALUES ('876543210', 'Carnicería Don Juan', '22223333');
/* Error esperado: ORA-00001: unique constraint violated */


/*******************************************************
 *                                                     *
 *   RESTRICCIÓN 3: PRIMARY KEY                        *
 *                                                     *
 *******************************************************/
-- La restricción PRIMARY KEY define una columna o combinación de columnas como
-- la clave primaria de la tabla. Esto asegura que los valores sean únicos y no nulos.

CREATE TABLE tipo_cecina (
    id NUMBER(12) PRIMARY KEY,  -- Clave primaria, valores únicos y no nulos
    nombre VARCHAR2(120)
);

-- Ejemplo de inserción válida
INSERT INTO tipo_cecina (id, nombre) VALUES (1, 'Chorizo');

-- Ejemplo de inserción inválida (intentando insertar un valor duplicado en la clave primaria)
-- Esto producirá un error porque el valor 1 ya existe en la tabla
INSERT INTO tipo_cecina (id, nombre) VALUES (1, 'Longaniza');
/* Error esperado: ORA-00001: unique constraint violated */


/*******************************************************
 *                                                     *
 *   RESTRICCIÓN 4: FOREIGN KEY                        *
 *                                                     *
 *******************************************************/
-- La restricción FOREIGN KEY establece una relación entre dos tablas.
-- Esta clave foránea apunta a la clave primaria de otra tabla.

CREATE TABLE planta_prod (
    id NUMBER(12) PRIMARY KEY,
    nombre VARCHAR2(120),
    maquinaria_id NUMBER(12),
    CONSTRAINT plantaProd_maquinaria_fk FOREIGN KEY (maquinaria_id)
    REFERENCES maquinaria(id)  -- Clave foránea que refiere a la tabla maquinaria
);

-- Ejemplo de inserción válida
INSERT INTO maquinaria (id, nombre) VALUES (1, 'Cortadora Automática');
INSERT INTO planta_prod (id, nombre, maquinaria_id) VALUES (1, 'Planta Principal', 1);

-- Ejemplo de inserción inválida (intentando insertar un valor en maquinaria_id que no existe en la tabla maquinaria)
-- Esto producirá un error porque no existe maquinaria con id 99
INSERT INTO planta_prod (id, nombre, maquinaria_id) VALUES (2, 'Planta Secundaria', 99);
/* Error esperado: ORA-02291: integrity constraint violated - parent key not found */


/*******************************************************
 *                                                     *
 *   RESTRICCIÓN 5: CHECK                              *
 *                                                     *
 *******************************************************/
-- La restricción CHECK asegura que los valores en una columna cumplan con una condición específica.

CREATE TABLE cecina (
    id NUMBER(12) PRIMARY KEY,
    nombre VARCHAR2(120),
    stock NUMBER(8),
    precio NUMBER(12) CHECK (precio > 0)  -- El precio debe ser mayor a 0
);

-- Ejemplo de inserción válida
INSERT INTO cecina (id, nombre, stock, precio) VALUES (1, 'Chorizo Tradicional', 500, 1500);

-- Ejemplo de inserción inválida (intentando insertar un valor negativo en precio)
-- Esto producirá un error porque el valor no cumple con la condición CHECK
INSERT INTO cecina (id, nombre, stock, precio) VALUES (2, 'Longaniza Ahumada', 300, -1000);
/* Error esperado: ORA-02290: check constraint violated */


/*******************************************************
 *                                                     *
 *   RESTRICCIÓN 6: DEFAULT                            *
 *                                                     *
 *******************************************************/
-- La restricción DEFAULT establece un valor predeterminado para una columna si no se proporciona uno.

CREATE TABLE inventario (
    id NUMBER(12) PRIMARY KEY,
    nombre VARCHAR2(120) NOT NULL,
    stock NUMBER(12) DEFAULT 0  -- El valor predeterminado de stock es 0
);

-- Ejemplo de inserción sin especificar el valor de stock (se usará el valor predeterminado)
INSERT INTO inventario (id, nombre) VALUES (1, 'Tripa Natural');

-- Ejemplo de inserción especificando un valor para stock (se usará el valor proporcionado)
INSERT INTO inventario (id, nombre, stock) VALUES (2, 'Carne de Cerdo', 1000);

-- Consulta para verificar los valores insertados
SELECT * FROM inventario;
/* El resultado mostrará que el primer registro tiene un stock de 0 (valor predeterminado)
   y el segundo registro tiene un stock de 1000 (valor especificado). */


/*******************************************************
 *                                                     *
 *   CONFIGURACIÓN DE ACTUALIZACIÓN EN CASCADA         *
 *                                                     *
 *******************************************************/
-- Eliminamos la restricción existente en la tabla produccion
ALTER TABLE produccion DROP CONSTRAINT produccion_plantaprod_FK;

-- Añadimos una nueva restricción con ON UPDATE CASCADE
ALTER TABLE produccion 
ADD CONSTRAINT produccion_plantaprod_FK 
FOREIGN KEY (plantaprod_id) 
REFERENCES planta_prod(id) 
ON UPDATE CASCADE;

-- Ejemplo de actualización en cascada:
-- Actualizamos el id de una planta de producción en la tabla planta_prod
UPDATE planta_prod SET id = 99 WHERE id = 1;

-- Las filas en la tabla produccion que tenían plantaprod_id = 1
-- ahora tendrán plantaprod_id = 99.

SELECT * FROM produccion WHERE plantaprod_id = 99;
/* El resultado mostrará que las filas han sido actualizadas
   automáticamente para reflejar el nuevo id de la planta de producción. */

  
/*******************************************************
 *                                                     *
 *   CONFIGURACIÓN DE BORRADO EN CASCADA               *
 *                                                     *
 *******************************************************/
-- Eliminamos la restricción existente en la tabla produccion
ALTER TABLE produccion DROP CONSTRAINT produccion_plantaprod_FK;

-- Añadimos una nueva restricción con ON DELETE CASCADE
ALTER TABLE produccion 
ADD CONSTRAINT produccion_plantaprod_FK 
FOREIGN KEY (plantaprod_id) 
REFERENCES planta_prod(id) 
ON DELETE CASCADE;

-- Ejemplo de borrado en cascada:
-- Eliminamos un registro de planta de producción en la tabla planta_prod
DELETE FROM planta_prod WHERE id = 2;

-- Todas las filas en la tabla produccion que tenían plantaprod_id = 2
-- serán eliminadas automáticamente.

SELECT * FROM produccion WHERE plantaprod_id = 2;
/* El resultado no mostrará ninguna fila, ya que todas fueron eliminadas
   automáticamente debido a la eliminación en cascada. */
