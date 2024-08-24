/*******************************************************
 *                                                     *
 *               SISTEMA DE GESTIÓN CECINAS            *
 *                                                     *
 *   Tema: Transacciones en Bases de Datos             *
 *   Fecha: 21 de Agosto de 2024                       *
 *   Lenguaje: SQL                                     *
 *                                                     *
 *   Descripción:                                      *
 *   Este script demuestra cómo funcionan las          *
 *   transacciones en una base de datos relacional     *
 *   utilizando la estructura de la base de datos de   *
 *   Cecinas. Se explican las propiedades ACID de las  *
 *   transacciones y se incluyen ejemplos de COMMIT y  *
 *   ROLLBACK.                                         *
 *                                                     *
 *******************************************************/

/*******************************************************
 *                                                     *
 *   ¿QUÉ ES UNA TRANSACCIÓN Y POR QUÉ SON IMPORTANTES?*
 *                                                     *
 *******************************************************/
-- Una transacción es un conjunto de operaciones que se ejecutan como una unidad completa.
-- Todas las operaciones dentro de una transacción deben completarse correctamente; si alguna falla,
-- la transacción completa se deshace, garantizando la integridad de los datos.

-- Propiedades ACID:
-- 1. Atomicidad: La transacción es todo o nada.
-- 2. Consistencia: Los datos deben estar en un estado consistente antes y después de la transacción.
-- 3. Aislamiento: Las transacciones concurrentes no deben interferir entre sí.
-- 4. Durabilidad: Una vez que la transacción se confirma (COMMIT), sus cambios son permanentes.

/*******************************************************
 *                                                     *
 *   EJEMPLO 1: ATOMICIDAD Y CONSISTENCIA              *
 *                                                     *
 *******************************************************/
-- Realizaremos una inserción en la tabla cliente y otra en la tabla venta.
-- Si cualquiera de las operaciones falla, ambas se revertirán.

-- Inserción en la tabla cliente
INSERT INTO cliente (rut, nombre, giro, direccion, ciudad, fono)
VALUES ('112233445', 'Nuevo Cliente', 'Alimentos', 'Calle Real 123', 'Santiago', '99998888');

-- Inserción en la tabla venta (ERROR INTENCIONADO)
-- La clave foránea clienteRut en la tabla venta no coincide con ningún rut en la tabla cliente.
INSERT INTO venta (numeroFactura, fechaVenta, total, clienteRut)
VALUES (3, TO_DATE('2024-08-21', 'YYYY-MM-DD'), 500000, 'INVALIDO');

-- Si alguna operación falla, la transacción se deshace y los cambios no se aplican.
ROLLBACK;
/* Resultado: Ninguna de las operaciones anteriores se guardará, asegurando atomicidad y consistencia. */

/*******************************************************
 *                                                     *
 *   EJEMPLO 2: AISLAMIENTO                            *
 *                                                     *
 *******************************************************/
-- El aislamiento asegura que las transacciones concurrentes no interfieran entre sí.
-- En este ejemplo, abrimos una transacción y, antes de confirmar (COMMIT), otra transacción no verá los cambios.

-- Transacción 1: Inicia y hace cambios, pero no confirma
UPDATE inventario SET stock = stock - 100 WHERE id = 1;  -- Reducimos stock

-- Transacción 2: Intenta leer el valor actualizado (pero no verá el cambio)
SELECT * FROM inventario WHERE id = 1;
/* Resultado: La transacción 2 no verá los cambios realizados por la transacción 1
   hasta que la transacción 1 haga COMMIT. */

/*******************************************************
 *                                                     *
 *   EJEMPLO 3: DURABILIDAD                            *
 *                                                     *
 *******************************************************/
-- La durabilidad asegura que una vez que se confirma una transacción, sus efectos son permanentes.
-- Esto significa que los cambios se mantendrán incluso en caso de fallos del sistema.

-- Realizamos cambios y confirmamos la transacción.
INSERT INTO proveedor (rut, nombre) VALUES ('555555555', 'Nuevo Proveedor');
COMMIT;
/* Resultado: El nuevo proveedor se guardará permanentemente,
   y el sistema garantiza que el cambio persista incluso si falla. */

/*******************************************************
 *                                                     *
 *   CONFIRMACIÓN DE UNA TRANSACCIÓN (COMMIT)          *
 *                                                     *
 *******************************************************/
-- El comando COMMIT se utiliza para confirmar una transacción, guardando todos los cambios
-- realizados desde el último COMMIT o ROLLBACK.

INSERT INTO cliente (rut, nombre, giro, direccion, ciudad, fono)
VALUES ('667788990', 'Cliente Confirmado', 'Alimentos', 'Av. Confirmada 456', 'Concepción', '77776666');
COMMIT;
/* Resultado: Los cambios se guardan de forma permanente en la base de datos. */

/*******************************************************
 *                                                     *
 *   VUELTA ATRÁS DE UNA TRANSACCIÓN (ROLLBACK)        *
 *                                                     *
 *******************************************************/
-- El comando ROLLBACK se utiliza para deshacer una transacción, revirtiendo todos los cambios
-- realizados desde el último COMMIT o ROLLBACK.

INSERT INTO cliente (rut, nombre, giro, direccion, ciudad, fono)
VALUES ('223344556', 'Cliente Revertido', 'Alimentos', 'Pje. Revertido 789', 'Valparaíso', '88887777');
ROLLBACK;
/* Resultado: Los cambios no se aplican a la base de datos, y todo queda como estaba antes de la transacción. */
