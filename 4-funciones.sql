/*******************************************************
 *                                                     *
 *               SISTEMA DE GESTIÓN CECINAS            *
 *                                                     *
 *   Tema: Uso de Funciones en SQL (Oracle)            *
 *   Fecha: 21 de Agosto de 2024                       *
 *   Lenguaje: SQL                                     *
 *                                                     *
 *   Descripción:                                      *
 *   Este script demuestra cómo utilizar diversas      *
 *   funciones en Oracle, incluyendo funciones         *
 *   matemáticas, de fecha y hora, y funciones de      *
 *   agregación. Se utiliza la tabla DUAL para pruebas *
 *   y se muestran ejemplos prácticos aplicados a la   *
 *   base de datos de Cecinas.                         *
 *                                                     *
 *******************************************************/

/*******************************************************
 *                                                     *
 *   FUNCIONES MATEMÁTICAS                             *
 *                                                     *
 *******************************************************/
-- Las funciones matemáticas realizan operaciones numéricas.

-- Ejemplo 1: Mostrar la raíz cuadrada de 4 usando la tabla DUAL
SELECT SQRT(4) AS raiz FROM DUAL;

-- Ejemplo 2: Calcular el valor absoluto de -15
SELECT ABS(-15) AS VALO_ABSOLUTO FROM DUAL;

-- Ejemplo 3: Redondear el valor de PI a 2 decimales
SELECT ROUND(3.14536353,2) AS pi_redondeado FROM DUAL;


/*******************************************************
 *                                                     *
 *   FUNCIONES DE FECHA Y HORA                         *
 *                                                     *
 *******************************************************/
-- Las funciones de fecha y hora permiten trabajar con fechas y horas en las consultas.

-- Ejemplo 1: Mostrar la fecha actual del sistema
SELECT SYSDATE AS fecha_actual from dual;

-- Ejemplo 2: Agregar 7 días a la fecha actual
SELECT SYSDATE + 7 AS fecha_mas_7_dias FROM DUAL;

-- Ejemplo 3: Mostrar el nombre del día de la semana de la fecha actual
SELECT TO_CHAR(SYSDATE, 'Day') AS dia_semana FROM DUAL;


/*******************************************************
 *                                                     *
 *   FUNCIONES DE CADENA DE TEXTO                      *
 *                                                     *
 *******************************************************/
-- Las funciones de cadena permiten manipular y transformar texto.

-- Ejemplo 1: Convertir a mayúsculas el nombre de un cliente
SELECT UPPER('Cecinas del Sur') AS noombre FROM DUAL;
SELECT * FROM cliente WHERE UPPER(ciudad) = 'SANTIAGO';
SELECT * FROM cliente WHERE LOWER(ciudad) = 'SANTIAGO';

-- Ejemplo 2: Extraer los primeros 3 caracteres del nombre de un cliente
SELECT SUBSTR('Cecinas del Sur',1,9) AS primeros_3_caracteres FROM DUAL;

-- Ejemplo 3: Reemplazar 'Sur' por 'Norte' en el nombre de un cliente
SELECT REPLACE('Cecinas del Sur', 'Sur', 'Norte') AS nombre FROM DUAL;

/*******************************************************
 *                                                     *
 *   FUNCIONES DE AGREGACIÓN                           *
 *                                                     *
 *******************************************************/
-- Las funciones de agregación permiten calcular valores agregados en conjuntos de datos.

-- Ejemplo 1: Contar la cantidad de productos en la tabla cecina
SELECT COUNT(*) AS cantidad_productos FROM cecina;

-- Ejemplo 2: Obtener el precio mínimo y máximo de los productos
SELECT MIN(precio), MAX(precio) FROM cecina;

-- Ejemplo 3: Calcular el total del stock de productos
SELECT SUM(stock) FROM cecina;

-- Ejemplo 4: Calcular el precio promedio de los productos
SELECT AVG(precio) FROM cecina;

/*******************************************************
 *                                                     *
 *   FUNCIONES ANIDADAS                                *
 *                                                     *
 *******************************************************/
-- Las funciones pueden ser anidadas para realizar operaciones más complejas.

-- Ejemplo 1: Redondear el precio promedio de los productos a 2 decimales
SELECT round(AVG(precio),2) FROM cecina;

-- Ejemplo 2: Convertir a mayúsculas el nombre del día de la semana de la fecha actual
SELECT SUBSTR(LOWER(UPPER(TO_CHAR(SYSDATE, 'Day'))),1,3) AS dia_semana FROM DUAL;