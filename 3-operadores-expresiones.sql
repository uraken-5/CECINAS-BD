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


-- Ejemplo 2: Aumentar el precio de todos los productos en un 10%


-- Ejemplo 3: Calcular el stock promedio de productos



/*******************************************************
 *                                                     *
 *   OPERADORES DE COMPARACIÓN                         *
 *                                                     *
 *******************************************************/
-- Los operadores de comparación se utilizan para comparar valores y devolver un resultado booleano.

-- Ejemplo 1: Seleccionar todos los productos cuyo precio es mayor a 1500


-- Ejemplo 2: Buscar clientes en la ciudad de 'Santiago'


-- Ejemplo 3: Comparar precios para ver si un producto es más caro que otro



/*******************************************************
 *                                                     *
 *   OPERADORES LÓGICOS                                *
 *                                                     *
 *******************************************************/
-- Los operadores lógicos se utilizan para combinar múltiples condiciones.

-- Ejemplo 1: Seleccionar productos cuyo stock sea mayor a 300 y cuyo precio sea menor a 2000


-- Ejemplo 2: Seleccionar clientes que estén en 'Santiago' o 'Concepción'


-- Ejemplo 3: Seleccionar productos que no tengan stock (stock igual a 0)



/*******************************************************
 *                                                     *
 *   OPERADORES DE CONCATENACIÓN                       *
 *                                                     *
 *******************************************************/
-- El operador de concatenación (|| en Oracle, + en otros motores) se utiliza para unir cadenas de texto.

-- Ejemplo 1: Concatenar el nombre y la ciudad de un cliente


-- Ejemplo 2: Crear una descripción completa del producto uniendo nombre y precio


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


-- Ejemplo 2: Buscar productos cuyo nombre contiene la palabra 'Tradicional'



/* 
   OPERADOR BETWEEN:
   Se utiliza para seleccionar valores dentro de un rango.
*/

-- Ejemplo 1: Buscar productos cuyo precio esté entre 1000 y 2000 CLP


-- Ejemplo 2: Buscar ventas realizadas en el mes de agosto de 2024



/* 
   OPERADOR IN:
   Se utiliza para comparar una columna con un conjunto de valores específicos.
*/

-- Ejemplo 1: Buscar clientes que estén en Santiago, Concepción o Valparaíso

-- Ejemplo 2: Buscar productos que sean de tipo 'Chorizo' o 'Longaniza'



/* 
   OPERADOR IS NULL e IS NOT NULL:
   Se utilizan para verificar si un valor es nulo o no.
*/

-- Ejemplo 1: Buscar clientes cuyo número de teléfono no esté registrado (es nulo)


-- Ejemplo 2: Buscar proveedores cuyo nombre está registrado (no es nulo)



/* 
   OPERADOR EXISTS:
   Se utiliza para comprobar si una subconsulta devuelve algún resultado.
*/

-- Ejemplo 1: Buscar productos que tienen ventas asociadas


-- Ejemplo 2: Buscar clientes que han realizado al menos una compra



/*******************************************************
 *                                                     *
 *   EXPRESIONES COMPLEJAS                             *
 *                                                     *
 *******************************************************/
-- Las expresiones complejas combinan múltiples operadores y funciones para crear cálculos avanzados.

-- Ejemplo 1: Calcular el valor total de inventario (precio * stock) y aplicar un 15% de descuento


-- Ejemplo 2: Seleccionar productos cuyo precio sea mayor al precio promedio de todos los productos


