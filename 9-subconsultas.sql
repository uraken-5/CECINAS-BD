/*******************************************************
 *                                                     *
 *               SISTEMA DE GESTIÓN CECINAS            *
 *                                                     *
 *   Tema: Uso de Subconsultas en SQL                  *
 *   Fecha: 21 de Agosto de 2024                       *
 *   Lenguaje: SQL                                     *
 *                                                     *
 *   Descripción:                                      *
 *   Este script explica cómo utilizar subconsultas en *
 *   SQL para realizar consultas más avanzadas y       *
 *   flexibles. Las subconsultas permiten anidar una   *
 *   consulta dentro de otra, permitiendo trabajar con *
 *   resultados dinámicos.                             *
 *                                                     *
 *******************************************************/

/*******************************************************
 *                                                     *
 *   TIPOS DE SUBCONSULTAS                             *
 *                                                     *
 *******************************************************/
-- Las subconsultas en SQL se pueden utilizar de diferentes maneras según la necesidad.
-- A continuación, se describen los tipos más comunes.

-- 1. Subconsulta Escalar: Devuelve un único valor.
-- 2. Subconsulta de Fila Única: Devuelve una sola fila (con una o más columnas).
-- 3. Subconsulta de Múltiples Filas: Devuelve múltiples filas.
-- 4. Subconsulta Correlacionada: Se refiere a la tabla externa en su propio WHERE.


/*******************************************************
 *                                                     *
 *   SUBCONSULTA ESCALAR                               *
 *                                                     *
 *******************************************************/
-- Una subconsulta escalar devuelve un único valor. Es común utilizarla en la cláusula SELECT o WHERE.

-- Ejemplo 1: Obtener el nombre del cliente con la venta de mayor valor.
SELECT nombre
FROM cliente
WHERE rut = (SELECT clienteRut FROM venta ORDER BY total DESC FETCH FIRST 1 ROW ONLY);

-- Explicación:
-- La subconsulta obtiene el `clienteRut` de la venta con el total más alto.
-- La consulta externa utiliza ese `clienteRut` para devolver el nombre del cliente.


/*******************************************************
 *                                                     *
 *   SUBCONSULTA DE FILA ÚNICA                         *
 *                                                     *
 *******************************************************/
-- Una subconsulta de fila única devuelve una sola fila, generalmente utilizada en la cláusula WHERE.

-- Ejemplo 2: Obtener la información de la venta más reciente.
SELECT *
FROM venta
WHERE fechaVenta = (SELECT MAX(fechaVenta) FROM venta);

-- Explicación:
-- La subconsulta encuentra la fecha de venta más reciente.
-- La consulta externa devuelve todos los detalles de esa venta.


/*******************************************************
 *                                                     *
 *   SUBCONSULTA DE MÚLTIPLES FILAS                    *
 *                                                     *
 *******************************************************/
-- Una subconsulta de múltiples filas devuelve varias filas. Se utiliza con operadores como IN, ANY, o EXISTS.

-- Ejemplo 3: Obtener los nombres de los clientes que han realizado compras mayores a 500,000.
SELECT nombre
FROM cliente
WHERE rut IN (SELECT clienteRut FROM venta WHERE total > 500000);

-- Explicación:
-- La subconsulta devuelve los `clienteRut` de todas las ventas superiores a 500,000.
-- La consulta externa devuelve los nombres de los clientes correspondientes.


/*******************************************************
 *                                                     *
 *   SUBCONSULTA CORRELACIONADA                        *
 *                                                     *
 *******************************************************/
-- Una subconsulta correlacionada se refiere a la tabla de la consulta externa y se ejecuta para cada fila.

-- Ejemplo 4: Obtener todos los productos cuyo precio sea superior al precio promedio de su tipo.
SELECT nombre, precio
FROM cecina ce
WHERE precio > (SELECT AVG(precio)
                FROM cecina
                WHERE tipoCecinaID = ce.tipoCecinaID);

-- Explicación:
-- La subconsulta se ejecuta para cada producto en `cecina`, calculando el precio promedio de los productos del mismo tipo.
-- La consulta externa devuelve los productos cuyo precio es mayor al promedio de su tipo.


/*******************************************************
 *                                                     *
 *   SUBCONSULTA EN LA CLÁUSULA FROM                   *
 *                                                     *
 *******************************************************/
-- Las subconsultas también se pueden utilizar en la cláusula FROM, creando tablas temporales.

-- Ejemplo 5: Obtener el total de ventas por cliente para aquellos que han comprado más de 3 veces.
SELECT c.nombre, SUM(v.total) AS total_ventas
FROM cliente c
JOIN (SELECT clienteRut, COUNT(*) AS cantidad_ventas
      FROM venta
      GROUP BY clienteRut
      HAVING COUNT(*) > 3) v ON c.rut = v.clienteRut
GROUP BY c.nombre;

-- Explicación:
-- La subconsulta en la cláusula FROM agrupa las ventas por cliente y filtra aquellos que han realizado más de 3 compras.
-- La consulta externa luego suma el total de ventas para esos clientes.


/*******************************************************
 *                                                     *
 *   PRACTICA ADICIONAL CON SUBCONSULTAS               *
 *                                                     *
 *******************************************************/
-- Ejemplo 6: Encuentra el nombre de los clientes que han comprado todos los productos de tipo 'Longaniza'.
SELECT nombre
FROM cliente
WHERE rut IN (SELECT clienteRut
              FROM venta v
              WHERE NOT EXISTS (SELECT *
                                FROM cecina ce
                                WHERE ce.tipoCecinaID = 2
                                AND NOT EXISTS (SELECT *
                                                FROM detVenta dv
                                                WHERE dv.cecina_ID = ce.id
                                                AND dv.venta_numFactura = v.numeroFactura)));

-- Explicación:
-- Esta subconsulta compleja asegura que el cliente haya comprado todos los productos de tipo 'Longaniza'.


