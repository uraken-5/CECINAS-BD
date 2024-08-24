/*******************************************************
 *                                                     *
 *               SISTEMA DE GESTIÓN CECINAS            *
 *                                                     *
 *   Tema: Condicionales en SQL (Uso de CASE)          *
 *   Fecha: 21 de Agosto de 2024                       *
 *   Lenguaje: SQL                                     *
 *                                                     *
 *   Descripción:                                      *
 *   Este script demuestra cómo utilizar la estructura *
 *   CASE en SQL para realizar operaciones condicionales.
 *   La estructura CASE permite simular una estructura  *
 *   if-then-else en una consulta SQL, lo que añade    *
 *   flexibilidad y poder a las consultas.             *
 *                                                     *
 *******************************************************/

/*******************************************************
 *                                                     *
 *   USO BÁSICO DE CASE                                *
 *                                                     *
 *******************************************************/
-- La estructura CASE permite devolver un valor basado en una condición evaluada.

-- Ejemplo 1: Asignar un descuento según el precio del producto
SELECT nombre, precio,
       CASE
           WHEN precio > 2000 THEN 'Descuento 20%'
           WHEN precio BETWEEN 1500 AND 2000 THEN 'Descuento 10%'
           ELSE 'Sin Descuento'
       END AS descuento
FROM cecina;

-- Ejemplo 2: Clasificar los productos según su stock
SELECT nombre, stock,
       CASE
           WHEN stock > 500 THEN 'Alto'
           WHEN stock BETWEEN 100 AND 500 THEN 'Medio'
           ELSE 'Bajo'
       END AS nivel_stock
FROM cecina;


/*******************************************************
 *                                                     *
 *   USO DE CASE CON AGREGACIÓN                        *
 *                                                     *
 *******************************************************/
-- CASE también se puede usar en funciones agregadas para calcular valores condicionales.

-- Ejemplo 1: Calcular el total de productos con precio mayor y menor o igual a 2000
SELECT
    SUM(CASE WHEN precio > 2000 THEN 1 ELSE 0 END) AS productos_caros,
    SUM(CASE WHEN precio <= 2000 THEN 1 ELSE 0 END) AS productos_economicos
FROM cecina;


/*******************************************************
 *                                                     *
 *   USO DE CASE EN ORDER BY                           *
 *                                                     *
 *******************************************************/
-- La estructura CASE puede usarse en la cláusula ORDER BY para ordenar resultados de forma personalizada.

-- Ejemplo: Ordenar los productos primero por stock bajo, luego medio y finalmente alto
SELECT nombre, stock,
       CASE
           WHEN stock > 500 THEN 'Alto'
           WHEN stock BETWEEN 100 AND 500 THEN 'Medio'
           ELSE 'Bajo'
       END AS nivel_stock
FROM cecina
ORDER BY
       CASE
           WHEN stock > 500 THEN 3  -- Ordenar 'Alto' al final
           WHEN stock BETWEEN 100 AND 500 THEN 2  -- 'Medio' en medio
           ELSE 1  -- 'Bajo' primero
       END;

/*******************************************************
 *                                                     *
 *   USO AVANZADO DE CASE                              *
 *                                                     *
 *******************************************************/
-- CASE puede ser anidado o utilizar múltiples condiciones.

-- Ejemplo 1: Calcular el estado de las ventas basándose en el total
SELECT numeroFactura, total,
       CASE
           WHEN total > 1000000 THEN 'Venta Mayor'
           WHEN total BETWEEN 500000 AND 1000000 THEN 'Venta Media'
           WHEN total < 500000 THEN
               CASE
                   WHEN total > 250000 THEN 'Venta Menor - Nivel 2'
                   ELSE 'Venta Menor - Nivel 1'
               END
           ELSE 'Indefinido'
       END AS estado_venta
FROM venta;


/*******************************************************
 *                                                     *
 *   COMBINACIÓN DE CASE CON OTRAS FUNCIONES           *
 *                                                     *
 *******************************************************/
-- CASE se puede combinar con otras funciones para crear consultas más potentes.

-- Ejemplo 1: Asignar un rango de precios a los productos y convertirlo a mayúsculas
SELECT nombre, precio,
       UPPER(
           CASE
               WHEN precio > 2000 THEN 'Alto'
               WHEN precio BETWEEN 1500 AND 2000 THEN 'Medio'
               ELSE 'Bajo'
           END
       ) AS rango_precio
FROM cecina;

