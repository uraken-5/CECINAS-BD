/*******************************************************
 *                                                     *
 *               SISTEMA DE GESTIÓN CECINAS            *
 *                                                     *
 *   Tema: Sentencias Clásicas en SQL                  *
 *   Fecha: 22 de Agosto de 2024                       *
 *   Lenguaje: SQL                                     *
 *                                                     *
 *   Descripción:                                      *
 *   Este script demuestra cómo utilizar las           *
 *   sentencias clásicas de SQL: SELECT, INSERT,       *
 *   DELETE, y UPDATE. Estas son fundamentales para    *
 *   realizar consultas, insertar datos, eliminar      *
 *   registros, y actualizar datos. Cada sentencia se  *
 *   presenta con ejemplos prácticos.                  *
 *                                                     *
 *******************************************************/

/*******************************************************
 *                                                     *
 *   SENTENCIA SELECT                                  *
 *                                                     *
 *******************************************************/
-- La sentencia SELECT se utiliza para consultar datos de una o más tablas.

-- Ejemplo 1: Seleccionar todas las columnas de la tabla cliente
SELECT * FROM cliente;

-- Ejemplo 2: Seleccionar el nombre y precio de los productos
SELECT nombre, precio FROM cecina;

-- Ejemplo 3: Seleccionar clientes en la ciudad de 'Santiago'
SELECT nombre, ciudad FROM cliente WHERE ciudad = 'Santiago';

-- Ejemplo 4: Seleccionar productos cuyo precio es mayor a 1500 y ordenar por precio
SELECT nombre, precio FROM cecina WHERE precio > 1500 ORDER BY precio DESC;


/*******************************************************
 *                                                     *
 *   SENTENCIA INSERT                                  *
 *                                                     *
 *******************************************************/
-- La sentencia INSERT se utiliza para añadir nuevos registros a una tabla.

-- Ejemplo 1: Insertar un nuevo cliente en la tabla cliente
INSERT INTO cliente (rut, nombre, giro, direccion, ciudad, fono) 
VALUES ('112233445', 'Cliente Nuevo', 'Alimentos', 'Calle Falsa 123', 'Santiago', '99887766');

-- Ejemplo 2: Insertar un nuevo producto en la tabla cecina
INSERT INTO cecina (id, nombre, stock, precio, tipoCecinaID) 
VALUES (6, 'Chorizo Picante', 150, 2500, 1);

-- Ejemplo 3: Insertar una nueva venta en la tabla venta
INSERT INTO venta (numeroFactura, fechaVenta, total, clienteRut) 
VALUES (3, TO_DATE('2024-08-21', 'YYYY-MM-DD'), 750000, '112233445');


/*******************************************************
 *                                                     *
 *   SENTENCIA DELETE                                  *
 *                                                     *
 *******************************************************/
-- La sentencia DELETE se utiliza para eliminar registros de una tabla.

-- Ejemplo 1: Eliminar un cliente por su RUT
DELETE FROM cliente WHERE rut = '987654321';

-- Ejemplo 2: Eliminar todos los productos con stock igual a 0
DELETE FROM cecina WHERE stock = 0;

-- Ejemplo 3: Eliminar ventas realizadas antes del 1 de enero de 2024
DELETE FROM venta WHERE fechaVenta < TO_DATE('2024-01-01', 'YYYY-MM-DD');


/*******************************************************
 *                                                     *
 *   SENTENCIA UPDATE                                  *
 *                                                     *
 *******************************************************/
-- La sentencia UPDATE se utiliza para modificar registros existentes en una tabla.

-- Ejemplo 1: Actualizar el precio de un producto específico
UPDATE cecina SET precio = 2000 WHERE id = 1;

-- Ejemplo 2: Incrementar el stock en 100 unidades para todos los productos
UPDATE cecina SET stock = stock + 100;

-- Ejemplo 3: Cambiar la ciudad de un cliente
UPDATE cliente SET ciudad = 'Valparaíso' WHERE rut = '876543210';


/*******************************************************
 *                                                     *
 *   EJEMPLOS AVANZADOS DE SELECT, INSERT, DELETE Y UPDATE
 *                                                     *
 *******************************************************/
-- SELECT avanzado: Contar el número de clientes en cada ciudad
SELECT ciudad, COUNT(*) AS cantidad_clientes FROM cliente GROUP BY ciudad;

-- INSERT avanzado: Insertar múltiples registros en la tabla inventario
INSERT INTO inventario (id, nombre, stock)
VALUES (3, 'Sal', 500), (4, 'Ajo', 300);

-- DELETE avanzado: Eliminar productos que no tienen ventas asociadas
DELETE FROM cecina WHERE id NOT IN (SELECT DISTINCT cecina_ID FROM detVenta);

-- UPDATE avanzado: Aplicar un descuento del 10% a todos los productos con precio mayor a 2000
UPDATE cecina SET precio = precio * 0.90 WHERE precio > 2000;

