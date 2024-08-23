/*******************************************************
 *                                                     *
 *               SISTEMA DE GESTIÓN CECINAS            *
 *                                                     *
 *   Tema: Expresiones y Operadores en SQL             *
 *   Fecha: 22 de Agosto de 2024                       *
 *   Lenguaje: SQL                                     *
 *                                                     *
 *   Descripción:                                      *
 *   Este script demuestra cómo utilizar expresiones y *
 *   operadores en SQL para realizar cálculos,         *
 *   comparaciones y combinaciones de datos. Se        *
 *   incluyen ejemplos con operadores aritméticos,     *
 *   de comparación, lógicos, de concatenación, y      *
 *   otros operadores avanzados como LIKE, BETWEEN,    *
 *   IN, IS NULL y EXISTS.                             *
 *                                                     *
 *******************************************************/

/*******************************************************
 *                                                     *
 *   OPERADORES ARITMÉTICOS                            *
 *                                                     *
 *******************************************************/
-- Los operadores aritméticos se utilizan para realizar cálculos matemáticos.

-- Ejemplo 1: Calcular el precio total multiplicando el precio por la cantidad en stock
SELECT nombre, stock, precio, (stock*precio) AS precio_total FROM cecina;

-- USO DE DUAL : 
SELECT ((4+5)*6 / 78 +4 * (4-4)) AS RESULTADO FROM DUAL;

-- Ejemplo 2: Aumentar el precio de todos los productos en un 10% (usar un update) en la tabla cecina :30
SELECT 100 * 1.10 FROM DUAL;
update cecina set precio=precio*1.1;
UPDATE CECINA set PRECIO = (PRECIO*1.1);
select * from cecina;

-- Ejemplo 3: Calcular el stock promedio de productos
SELECT AVG(stock) AS PROMEDIO FROM cecina;


/*******************************************************
 *                                                     *
 *   OPERADORES DE COMPARACIÓN                         *
 *                                                     *
 *******************************************************/
-- Los operadores de comparación se utilizan para comparar valores y devolver un resultado booleano.

-- Ejemplo 1: Seleccionar todos los productos cuyo precio es mayor a 1500 de cecinas
SELECT * FROM cecina WHERE precio < 1500;

-- Ejemplo 2: Buscar clientes en la ciudad de 'Santiago'
SELECT * FROM CLIENTE WHERE CIUDAD='Santiago';

-- Ejemplo 3: Comparar precios para ver si un producto es más caro que otro (lo guardamos para los joins)

/*******************************************************
 *                                                     *
 *   OPERADORES LÓGICOS                                *
 *                                                     *
 *******************************************************/
-- Los operadores lógicos se utilizan para combinar múltiples condiciones.

-- Ejemplo 1: Seleccionar productos cuyo stock sea mayor a 300 y cuyo precio sea menor a 2000
SELECT * FROM cecina WHERE stock > 300 AND precio < 2000;

-- Ejemplo 2: Seleccionar clientes que estén en 'Santiago' o 'Concepción'
SELECT * FROM cliente WHERE ciudad = 'Santiago' OR ciudad = 'Concepción';

-- Ejemplo 3: Seleccionar productos que no tengan stock (stock igual a 0)
SELECT * FROM cecina WHERE NOT stock > 0; 

/*******************************************************
 *                                                     *
 *   OPERADORES DE CONCATENACIÓN                       *
 *                                                     *
 *******************************************************/
-- El operador de concatenación (|| en Oracle, + en otros motores) se utiliza para unir cadenas de texto.

-- Ejemplo 1: Concatenar el nombre y la ciudad de un cliente
SELECT nombre || ' - ' || ciudad AS cliente_ciudad FROM cliente;

-- Ejemplo 2: Crear una descripción completa del producto uniendo nombre y precio
SELECT nombre || ' - ' || precio || 'CLP' AS descripcion FROM cecina;

-- Version 2:
SELECT nombre || ' - ' || TO_CHAR(precio) || 'CLP' AS descripcion FROM cecina;

/*******************************************************
 *                                                     *
 *   OPERADORES AVANZADOS                              *
 *                                                     *
 *******************************************************/

/* 
   OPERADOR LIKE:
   Se utiliza para buscar un patrón específico en una columna de texto.
*/

-- Ejemplo 1: Buscar clientes cuyo nombre empieza con 'Super'
SELECT * FROM cliente;
SELECT * FROM cliente WHERE nombre LIKE 'Super%';

-- Ejemplo 2: Buscar productos cuyo nombre contiene la palabra 'Tradicional'
SELECT * FROM cecina;
SELECT * FROM cecina WHERE nombre LIKE '%Tradicional%';


/* 
   OPERADOR BETWEEN:
   Se utiliza para seleccionar valores dentro de un rango.
*/

-- Ejemplo 1: Buscar productos cuyo precio esté entre 1000 y 2000 CLP
SELECT * FROM cecina WHERE precio BETWEEN 1000 AND 2000;

-- Ejemplo 2: Buscar ventas realizadas en el mes de agosto de 2024
SELECT * FROM venta WHERE fechaventa BETWEEN TO_DATE('2024-08-05', 'YYYY-MM-DD') AND TO_DATE('2024-08-07', 'YYYY-MM-DD');

/* 
   OPERADOR IN:
   Se utiliza para comparar una columna con un conjunto de valores específicos.
*/

-- Ejemplo 1: Buscar clientes que estén en Santiago, Concepción o Valparaíso
SELECT * FROM cliente WHERE ciudad IN ('Santiago','Concepción','Valparaíso');

-- Ejemplo 2: Buscar productos que sean de tipo 'Chorizo' o 'Longaniza'
SELECT * FROM cecina;
SELECT * FROM cecina WHERE ID IN (SELECT id FROM tipo_cecina WHERE nombre IN ('Jamón','Chorizo'));


/* 
   OPERADOR IS NULL e IS NOT NULL:
   Se utilizan para verificar si un valor es nulo o no.
*/

-- Ejemplo 1: Buscar clientes cuyo número de teléfono no esté registrado (es nulo)
select * from cliente WHERE fono IS NOT NULL;


-- Ejemplo 2: Buscar proveedores cuyo nombre está registrado (no es nulo)
SELECT * FROM proveedor WHERE nombre IS NOT NULL;


/* 
   OPERADOR EXISTS:
   Se utiliza para comprobar si una subconsulta devuelve algún resultado.
*/

-- Ejemplo 1: Buscar productos que tienen ventas asociadas
SELECT * FROM cecina WHERE EXISTS (SELECT 1 FROM detventa WHERE cecina_id = cecina.id);

-- SELECT 1 FROM detventa WHERE cecina_id = 2; --- se asejema a una salida booleana (1 - 0)

-- Ejemplo 2: Buscar clientes que han realizado al menos una compra
SELECT * FROM cliente WHERE EXISTS (SELECT 1 FROM venta WHERE clienterut = cliente.rut);

/*******************************************************
 *                                                     *
 *   EXPRESIONES COMPLEJAS                             *
 *                                                     *
 *******************************************************/
-- Las expresiones complejas combinan múltiples operadores y funciones para crear cálculos avanzados.

-- Ejemplo 1: Calcular el valor total de cecina (precio * stock) y aplicar un 15% de descuento
select * from cecina;
SELECT nombre,
       (stock*precio) AS total,
       (stock*precio) * 0.85 AS valor_con_descuento
FROM cecina;

-- Ejemplo 2: Seleccionar productos cuyo precio sea mayor al precio promedio de todos los productos

