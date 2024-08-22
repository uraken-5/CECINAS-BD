/*******************************************************
 *                                                     *
 *               SISTEMA DE GESTIÓN CECINAS            *
 *                                                     *
 *   Tema: Integridad Referencial y Errores Comunes    *
 *   Fecha: 21 de Agosto de 2024                       *
 *   Lenguaje: SQL                                     *
 *                                                     *
 *   Descripción:                                      *
 *   Este script demuestra cómo funciona la integridad *
 *   referencial en una base de datos relacional.      *
 *   Se incluyen ejemplos de los errores más comunes  *
 *   que pueden ocurrir al no respetar las reglas de   *
 *   integridad referencial. Cada ejemplo está basado  *
 *   en la estructura de la base de datos de Cecinas.  *
 *                                                     *
 *******************************************************/

/*******************************************************
 *                                                     *
 *   EJEMPLO 1: INSERCIÓN CON CLAVE FORÁNEA INEXISTENTE*
 *                                                     *
 *******************************************************/
-- Intento de inserción de un registro en la tabla produccion
-- usando un plantaprod_id que no existe en la tabla planta_prod.
-- Esto producirá un error de integridad referencial.

/* Error esperado: ORA-02291: integrity constraint violated - parent key not found */


/*******************************************************
 *                                                     *
 *   EJEMPLO 2: MODIFICACIÓN DE UNA CLAVE PRIMARIA     *
 *              CON REGISTROS 'HIJOS'                  *
 *                                                     *
 *******************************************************/
-- Intento de actualización de la clave primaria en la tabla planta_prod
-- que tiene registros 'hijos' en la tabla produccion.
-- Esto producirá un error de integridad referencial.

/* Error esperado: ORA-02292: integrity constraint violated - child record found */


/*******************************************************
 *                                                     *
 *   EJEMPLO 3: MODIFICACIÓN DE UNA CLAVE FORÁNEA      *
 *              A UN VALOR INEXISTENTE                 *
 *                                                     *
 *******************************************************/
-- Intento de actualización de un plantaprod_id en la tabla produccion
-- a un valor que no existe en la tabla planta_prod.
-- Esto producirá un error de integridad referencial.

/* Error esperado: ORA-02291: integrity constraint violated - parent key not found */


/*******************************************************
 *                                                     *
 *   EJEMPLO 4: ELIMINACIÓN DE UNA FILA CON 'HIJOS'    *
 *                                                     *
 *******************************************************/
-- Intento de eliminación de un registro en la tabla planta_prod
-- que tiene registros 'hijos' en la tabla produccion.
-- Esto producirá un error de integridad referencial.

/* Error esperado: ORA-02292: integrity constraint violated - child record found */

