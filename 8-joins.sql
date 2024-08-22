/*******************************************************
 *                                                     *
 *               SISTEMA DE GESTIÓN CECINAS            *
 *                                                     *
 *   Tema: Manejo de Relaciones usando JOINs en SQL    *
 *   Fecha: 21 de Agosto de 2024                       *
 *   Lenguaje: SQL                                     *
 *                                                     *
 *   Descripción:                                      *
 *   Este documento explica cómo utilizar los          *
 *   diferentes tipos de JOINs en SQL para manejar     *
 *   relaciones entre tablas. Incluye ejemplos de      *
 *   INNER JOIN, LEFT JOIN, RIGHT JOIN y FULL OUTER    *
 *   JOIN aplicados al sistema de gestión de Cecinas.  *
 *                                                     *
 *******************************************************/

/*******************************************************
 *                                                     *
 *   INNER JOIN: Obtener Datos Relacionados            *
 *                                                     *
 *******************************************************/
-- El INNER JOIN devuelve las filas cuando hay al menos una coincidencia en ambas tablas.

-- Ejemplo 1: Obtener todas las ventas con la información del cliente correspondiente.

-- Ejemplo 2: Obtener los productos y sus tipos (solo productos que tienen un tipo asociado).


/*******************************************************
 *                                                     *
 *   LEFT JOIN: Incluir Todos los Registros de la Tabla Izquierda
 *                                                     *
 *******************************************************/
-- El LEFT JOIN devuelve todas las filas de la tabla izquierda, y las filas coincidentes de la tabla derecha. 
-- Si no hay coincidencia, se devuelve NULL para las columnas de la tabla derecha.

-- Ejemplo 1: Obtener todos los clientes y las ventas correspondientes (incluso si no han hecho ninguna compra).

-- Ejemplo 2: Obtener todos los productos y sus tipos (incluso si no tienen un tipo asociado).


/*******************************************************
 *                                                     *
 *   RIGHT JOIN: Incluir Todos los Registros de la Tabla Derecha
 *                                                     *
 *******************************************************/
-- El RIGHT JOIN devuelve todas las filas de la tabla derecha, y las filas coincidentes de la tabla izquierda. 
-- Si no hay coincidencia, se devuelve NULL para las columnas de la tabla izquierda.

-- Ejemplo 1: Obtener todas las ventas y la información de los clientes correspondientes (incluso si no hay un cliente asociado).

-- Ejemplo 2: Obtener todos los tipos de cecina y los productos correspondientes (incluso si no hay productos de un tipo).


/*******************************************************
 *                                                     *
 *   FULL OUTER JOIN: Incluir Todos los Registros de Ambas Tablas
 *                                                     *
 *******************************************************/
-- El FULL OUTER JOIN devuelve todas las filas cuando hay una coincidencia en una u otra tabla.
-- Las filas que no tienen coincidencia en cualquiera de las tablas mostrarán NULL en las columnas de la otra tabla.

-- Ejemplo 1: Obtener todos los clientes y ventas, incluyendo aquellos que no tienen una relación directa.

-- Ejemplo 2: Obtener todos los productos y tipos, incluyendo productos sin tipo y tipos sin productos.


/*******************************************************
 *                                                     *
 *   CROSS JOIN: Producto Cartesiano de las Tablas     *
 *                                                     *
 *******************************************************/
-- El CROSS JOIN devuelve el producto cartesiano de ambas tablas. 
-- Es decir, combina todas las filas de la tabla izquierda con todas las filas de la tabla derecha.

-- Ejemplo: Obtener todas las combinaciones posibles de clientes y productos.

