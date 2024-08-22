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


-- Ejemplo 2: Clasificar los productos según su stock



/*******************************************************
 *                                                     *
 *   USO DE CASE CON AGREGACIÓN                        *
 *                                                     *
 *******************************************************/
-- CASE también se puede usar en funciones agregadas para calcular valores condicionales.

-- Ejemplo 1: Calcular el total de productos con precio mayor y menor o igual a 2000



/*******************************************************
 *                                                     *
 *   USO DE CASE EN ORDER BY                           *
 *                                                     *
 *******************************************************/
-- La estructura CASE puede usarse en la cláusula ORDER BY para ordenar resultados de forma personalizada.

-- Ejemplo: Ordenar los productos primero por stock bajo, luego medio y finalmente alto


/*******************************************************
 *                                                     *
 *   USO AVANZADO DE CASE                              *
 *                                                     *
 *******************************************************/
-- CASE puede ser anidado o utilizar múltiples condiciones.

-- Ejemplo 1: Calcular el estado de las ventas basándose en el total



/*******************************************************
 *                                                     *
 *   COMBINACIÓN DE CASE CON OTRAS FUNCIONES           *
 *                                                     *
 *******************************************************/
-- CASE se puede combinar con otras funciones para crear consultas más potentes.

-- Ejemplo 1: Asignar un rango de precios a los productos y convertirlo a mayúsculas


