/*******************************************************
 *                                                     *
 *               SISTEMA DE GESTIÓN CECINAS            *
 *                                                     *
 *   Naturaleza del Negocio: Producción de Cecinas     *
 *   Fecha: 21 de Agosto de 2024                       *
 *   Lenguaje: SQL                                     *
 *   Usuario: SYSTEM                                   *
 *                                                     *
 *   Descripción:                                      *
 *   Este script crea la estructura de base de datos   *
 *   para gestionar la producción, ventas, compras,    *
 *   y almacenes de una empresa de cecinas. Incluye    *
 *   la creación de tablas, usuarios y relaciones,     *
 *   así como la inserción de datos de ejemplo.        *
 *                                                     *
 *******************************************************/

/*******************************************************
 *                                                     *
 *   CREACIÓN DEL USUARIO Y ASIGNACIÓN DE PERMISOS     *
 *                                                     *
 *******************************************************/
-- AHORA ESTAMOS COMO SYSTEM, POR ESO PODEMOS CREAR USUARIOS.
-- CREAR UN USUARIO
--CREATE USER <tu_usuario> IDENTIFIED BY <tu_clave>;

-- ASIGNAMOS PERMISOS A MI NUEVO USUARIO
--GRANT CONNECT, RESOURCE TO <tu_usuario>;

/*******************************************************
 *                                                     *
 *    ELIMINACIÓN DE TABLAS HIJAS PARA EVITAR ERRORES  *
 *      DE INTEGRIDAD REFERENCIAL                      *
 *                                                     *
 *******************************************************/
-- Eliminar las tablas hijas primero para evitar problemas de integridad referencial

/*DROP TABLE detCompra CASCADE CONSTRAINTS;
DROP TABLE compra CASCADE CONSTRAINTS;
DROP TABLE detVenta CASCADE CONSTRAINTS;
DROP TABLE venta CASCADE CONSTRAINTS;
DROP TABLE cecina CASCADE CONSTRAINTS;
DROP TABLE tipo_cecina CASCADE CONSTRAINTS;
DROP TABLE cliente CASCADE CONSTRAINTS;
DROP TABLE proveedor CASCADE CONSTRAINTS;
DROP TABLE detReceta CASCADE CONSTRAINTS;
DROP TABLE det_produccion CASCADE CONSTRAINTS;
DROP TABLE produccion CASCADE CONSTRAINTS;
DROP TABLE planta_prod CASCADE CONSTRAINTS;
DROP TABLE maquinaria CASCADE CONSTRAINTS;
DROP TABLE receta CASCADE CONSTRAINTS;
DROP TABLE bodega CASCADE CONSTRAINTS;
DROP TABLE inventario CASCADE CONSTRAINTS;
DROP TABLE empresa CASCADE CONSTRAINTS;*/

/*******************************************************
 *                                                     *
 *            CREACIÓN DE TABLAS BASE                  *
 *                                                     *
 *******************************************************/

-- Tabla de Maquinarias
CREATE TABLE maquinaria (
    id NUMBER(12) PRIMARY KEY, 
    nombre VARCHAR2(200)
);

-- Tabla de Empresas
CREATE TABLE empresa(
    rut VARCHAR2(10) PRIMARY KEY NOT NULL,
    nombre VARCHAR2(200) NOT NULL
);

-- Tabla de Bodegas
CREATE TABLE bodega(
    id NUMBER(12) PRIMARY KEY,
    nombre VARCHAR2(200) NOT NULL
);

-- Tabla de Recetas
CREATE TABLE receta (
    id NUMBER(12) PRIMARY KEY,
    nombre VARCHAR2(200) NOT NULL
);

-- Tabla de Plantas de Producción
CREATE TABLE planta_prod (
    id NUMBER(12) PRIMARY KEY, 
    nombre VARCHAR2(20), 
    maquinaria_id NUMBER(12),
    CONSTRAINT plantaProd_maquinaria_fk
        FOREIGN KEY (maquinaria_id)
        REFERENCES maquinaria(id)
        ON DELETE CASCADE
);

-- Tabla de Producción
CREATE TABLE produccion(
    plantaprod_id NUMBER(12),
    id NUMBER(12) PRIMARY KEY,
    fechaInicio DATE,
    fechaTermino DATE,
    CONSTRAINT produccion_plantaprod_FK
    FOREIGN KEY (plantaprod_id)
    REFERENCES planta_prod(id)
    ON DELETE CASCADE
);

-- Detalle de Producción
CREATE TABLE det_produccion(
    id NUMBER(12) PRIMARY KEY,
    cantidadEsperada NUMBER(12),
    cantidadObtenida NUMBER(12),
    fechaInicio DATE,
    fechaTermino DATE,
    recetaID NUMBER(12),
    bodegaID NUMBER(12),
    produccionID NUMBER(12),
    CONSTRAINT DetProduccion_receta_FK
    FOREIGN KEY (recetaID)
    REFERENCES receta(id),
    CONSTRAINT DetProduccion_produccion_FK
    FOREIGN KEY (produccionID)
    REFERENCES produccion(id),
    CONSTRAINT DetProduccion_bodega_FK
    FOREIGN KEY (bodegaID)
    REFERENCES bodega(id)  
);

-- Detalle de Recetas
CREATE TABLE detReceta(
    id NUMBER(12) PRIMARY KEY,
    recetaID NUMBER(12),
    cantidad NUMBER(8),
    CONSTRAINT detReceta_receta_FK
    FOREIGN KEY (recetaID)
    REFERENCES receta(id)
);

-- Tabla de Inventario
CREATE TABLE inventario(
    id NUMBER(12) PRIMARY KEY,
    nombre VARCHAR2(120) NOT NULL,
    stock NUMBER(12)
);

-- Tabla de Clientes
CREATE TABLE cliente(
    rut VARCHAR2(10) PRIMARY KEY,
    nombre VARCHAR2(120),
    giro VARCHAR2(120),
    direccion VARCHAR2(120),
    ciudad VARCHAR2(120),
    fono VARCHAR2(120)
);

-- Tabla de Tipos de Cecina
CREATE TABLE tipo_cecina(
    id NUMBER(12) PRIMARY KEY, 
    nombre VARCHAR2(120)
);

-- Tabla de Cecinas
CREATE TABLE cecina(
    id NUMBER(12) PRIMARY KEY,
    nombre VARCHAR2(120),
    stock NUMBER(8),
    precio NUMBER(12),
    tipoCecinaID NUMBER(12),
    CONSTRAINT cecina_tipoCecina_FK
    FOREIGN KEY(tipoCecinaID)
    REFERENCES tipo_cecina(id)
);

-- Tabla de Proveedores
CREATE TABLE proveedor(
    rut VARCHAR2(10) PRIMARY KEY,
    nombre VARCHAR2(120)
);

-- Tabla de Ventas
CREATE TABLE venta(
    numeroFactura NUMBER(12) PRIMARY KEY,
    fechaVenta DATE,
    total NUMBER(12),
    clienteRut VARCHAR2(10),
    CONSTRAINT ventaCliente_FK
    FOREIGN KEY(clienteRut)
    REFERENCES cliente(rut)
);

-- Detalle de Ventas
CREATE TABLE detVenta(
    id NUMBER(12) PRIMARY KEY,
    cantidad NUMBER(8),
    descripcion VARCHAR2(120),
    unitario NUMBER(12),
    cecina_ID NUMBER(12),
    venta_numFactura NUMBER(12),
    CONSTRAINT detVenta_venta_FK
    FOREIGN KEY(venta_numFactura)
    REFERENCES venta(numeroFactura),
    CONSTRAINT detVenta_cecina_FK
    FOREIGN KEY(cecina_ID)
    REFERENCES cecina(id)
);

-- Tabla de Compras
CREATE TABLE compra(
    numeroFactura NUMBER(12) PRIMARY KEY,
    fecha DATE,
    total NUMBER(12),
    proveedorRut VARCHAR2(10),
    CONSTRAINT compra_proveedor_FK
    FOREIGN KEY(proveedorRut)
    REFERENCES proveedor(rut)
);

-- Detalle de Compras
CREATE TABLE detCompra(
    compraNumeroFacturaID NUMBER(12),
    id NUMBER(12) PRIMARY KEY,
    cantidad NUMBER(8),
    descripcion VARCHAR2(120),
    unitario NUMBER(12),
    inventarioID NUMBER(12),
    CONSTRAINT detCompra_inventario_FK
    FOREIGN KEY(inventarioID)
    REFERENCES inventario(id),
    CONSTRAINT detCompra_compra_FK
    FOREIGN KEY(compraNumeroFacturaID)
    REFERENCES compra(numeroFactura)
);

/*******************************************************
 *                                                     *
 *               INSERCIÓN DE DATOS DE EJEMPLO         *
 *                                                     *
 *******************************************************/

-- Inserción de datos en la tabla empresa
INSERT INTO empresa (rut, nombre) VALUES ('123456789', 'Cecinas del Sur');
INSERT INTO empresa (rut, nombre) VALUES ('987654321', 'Embutidos del Norte');
INSERT INTO empresa (rut, nombre) VALUES ('111111111', 'Fábrica de Salchichas');
INSERT INTO empresa (rut, nombre) VALUES ('222222222', 'Productos del Campo');
INSERT INTO empresa (rut, nombre) VALUES ('333333333', 'Carnes Premium');

-- Inserción de datos en la tabla maquinaria
INSERT INTO maquinaria (id, nombre) VALUES (1, 'Cortadora Automática');
INSERT INTO maquinaria (id, nombre) VALUES (2, 'Embutidora Industrial');
INSERT INTO maquinaria (id, nombre) VALUES (3, 'Selladora al Vacío');
INSERT INTO maquinaria (id, nombre) VALUES (4, 'Molinillo de Carne');
INSERT INTO maquinaria (id, nombre) VALUES (5, 'Enfriador Industrial');

-- Inserción de datos en la tabla bodega
INSERT INTO bodega (id, nombre) VALUES (1, 'Bodega Central');
INSERT INTO bodega (id, nombre) VALUES (2, 'Bodega de Insumos');
INSERT INTO bodega (id, nombre) VALUES (3, 'Bodega de Productos Terminados');
INSERT INTO bodega (id, nombre) VALUES (4, 'Bodega de Secado');
INSERT INTO bodega (id, nombre) VALUES (5, 'Bodega de Materias Primas');

-- Inserción de datos en la tabla receta
INSERT INTO receta (id, nombre) VALUES (1, 'Receta Chorizo');
INSERT INTO receta (id, nombre) VALUES (2, 'Receta Longaniza');
INSERT INTO receta (id, nombre) VALUES (3, 'Receta Salchicha');
INSERT INTO receta (id, nombre) VALUES (4, 'Receta Morcilla');
INSERT INTO receta (id, nombre) VALUES (5, 'Receta Jamón Serrano');

-- Inserción de datos en la tabla planta_prod
INSERT INTO planta_prod (id, nombre, maquinaria_id) VALUES (1, 'Planta Principal', 1);
INSERT INTO planta_prod (id, nombre, maquinaria_id) VALUES (2, 'Planta Secundaria', 2);
INSERT INTO planta_prod (id, nombre, maquinaria_id) VALUES (3, 'Planta de Cortado', 3);
INSERT INTO planta_prod (id, nombre, maquinaria_id) VALUES (4, 'Planta de Envasado', 4);
INSERT INTO planta_prod (id, nombre, maquinaria_id) VALUES (5, 'Planta de Enfriamiento', 5);

-- Inserción de datos en la tabla produccion
INSERT INTO produccion (plantaprod_id, id, fechaInicio, fechaTermino) VALUES (1, 1, TO_DATE('2024-08-01', 'YYYY-MM-DD'), TO_DATE('2024-08-15', 'YYYY-MM-DD'));
INSERT INTO produccion (plantaprod_id, id, fechaInicio, fechaTermino) VALUES (2, 2, TO_DATE('2024-08-10', 'YYYY-MM-DD'), TO_DATE('2024-08-20', 'YYYY-MM-DD'));
INSERT INTO produccion (plantaprod_id, id, fechaInicio, fechaTermino) VALUES (3, 3, TO_DATE('2024-08-12', 'YYYY-MM-DD'), TO_DATE('2024-08-22', 'YYYY-MM-DD'));
INSERT INTO produccion (plantaprod_id, id, fechaInicio, fechaTermino) VALUES (4, 4, TO_DATE('2024-08-14', 'YYYY-MM-DD'), TO_DATE('2024-08-24', 'YYYY-MM-DD'));
INSERT INTO produccion (plantaprod_id, id, fechaInicio, fechaTermino) VALUES (5, 5, TO_DATE('2024-08-16', 'YYYY-MM-DD'), TO_DATE('2024-08-26', 'YYYY-MM-DD'));

-- Inserción de datos en la tabla det_produccion
INSERT INTO det_produccion (id, cantidadEsperada, cantidadObtenida, fechaInicio, fechaTermino, recetaID, bodegaID, produccionID) 
VALUES (1, 1000, 950, TO_DATE('2024-08-01', 'YYYY-MM-DD'), TO_DATE('2024-08-15', 'YYYY-MM-DD'), 1, 1, 1);
INSERT INTO det_produccion (id, cantidadEsperada, cantidadObtenida, fechaInicio, fechaTermino, recetaID, bodegaID, produccionID) 
VALUES (2, 2000, 1980, TO_DATE('2024-08-10', 'YYYY-MM-DD'), TO_DATE('2024-08-20', 'YYYY-MM-DD'), 2, 2, 2);
INSERT INTO det_produccion (id, cantidadEsperada, cantidadObtenida, fechaInicio, fechaTermino, recetaID, bodegaID, produccionID) 
VALUES (3, 1500, 1450, TO_DATE('2024-08-12', 'YYYY-MM-DD'), TO_DATE('2024-08-22', 'YYYY-MM-DD'), 3, 3, 3);
INSERT INTO det_produccion (id, cantidadEsperada, cantidadObtenida, fechaInicio, fechaTermino, recetaID, bodegaID, produccionID) 
VALUES (4, 1800, 1750, TO_DATE('2024-08-14', 'YYYY-MM-DD'), TO_DATE('2024-08-24', 'YYYY-MM-DD'), 4, 4, 4);
INSERT INTO det_produccion (id, cantidadEsperada, cantidadObtenida, fechaInicio, fechaTermino, recetaID, bodegaID, produccionID) 
VALUES (5, 2200, 2150, TO_DATE('2024-08-16', 'YYYY-MM-DD'), TO_DATE('2024-08-26', 'YYYY-MM-DD'), 5, 5, 5);

-- Inserción de datos en la tabla detReceta
INSERT INTO detReceta (id, recetaID, cantidad) VALUES (1, 1, 500);
INSERT INTO detReceta (id, recetaID, cantidad) VALUES (2, 2, 1000);
INSERT INTO detReceta (id, recetaID, cantidad) VALUES (3, 3, 700);
INSERT INTO detReceta (id, recetaID, cantidad) VALUES (4, 4, 900);
INSERT INTO detReceta (id, recetaID, cantidad) VALUES (5, 5, 1200);

-- Inserción de datos en la tabla inventario
INSERT INTO inventario (id, nombre, stock) VALUES (1, 'Tripa Natural', 500);
INSERT INTO inventario (id, nombre, stock) VALUES (2, 'Carne de Cerdo', 1000);
INSERT INTO inventario (id, nombre, stock) VALUES (3, 'Sal', 300);
INSERT INTO inventario (id, nombre, stock) VALUES (4, 'Especias', 200);
INSERT INTO inventario (id, nombre, stock) VALUES (5, 'Ajo', 150);

-- Inserción de datos en la tabla cliente
INSERT INTO cliente (rut, nombre, giro, direccion, ciudad, fono) VALUES ('987654321', 'Supermercado ABC', 'Alimentos', 'Calle Falsa 123', 'Santiago', '22223333');
INSERT INTO cliente (rut, nombre, giro, direccion, ciudad, fono) VALUES ('876543210', 'Carnicería Don Juan', 'Carnes', 'Av. Real 456', 'Concepción', '11114444');
INSERT INTO cliente (rut, nombre, giro, direccion, ciudad, fono) VALUES ('765432109', 'Minimarket El Buen Gusto', 'Alimentos', 'Pje. Los Olivos 789', 'Valparaíso', '33335555');
INSERT INTO cliente (rut, nombre, giro, direccion, ciudad, fono) VALUES ('654321098', 'Distribuidora Sur', 'Distribución', 'Camino Norte 101', 'Antofagasta', '44446666');
INSERT INTO cliente (rut, nombre, giro, direccion, ciudad, fono) VALUES ('543210987', 'Tienda Gourmet', 'Alimentos', 'Av. Central 202', 'Viña del Mar', '55557777');

-- Inserción de datos en la tabla tipo_cecina
INSERT INTO tipo_cecina (id, nombre) VALUES (1, 'Chorizo');
INSERT INTO tipo_cecina (id, nombre) VALUES (2, 'Longaniza');
INSERT INTO tipo_cecina (id, nombre) VALUES (3, 'Salchicha');
INSERT INTO tipo_cecina (id, nombre) VALUES (4, 'Morcilla');
INSERT INTO tipo_cecina (id, nombre) VALUES (5, 'Jamón');

-- Inserción de datos en la tabla cecina
INSERT INTO cecina (id, nombre, stock, precio, tipoCecinaID) VALUES (1, 'Chorizo Tradicional', 500, 1500, 1);
INSERT INTO cecina (id, nombre, stock, precio, tipoCecinaID) VALUES (2, 'Longaniza Ahumada', 300, 1800, 2);
INSERT INTO cecina (id, nombre, stock, precio, tipoCecinaID) VALUES (3, 'Salchicha Vienesa', 700, 1000, 3);
INSERT INTO cecina (id, nombre, stock, precio, tipoCecinaID) VALUES (4, 'Morcilla Casera', 250, 1600, 4);
INSERT INTO cecina (id, nombre, stock, precio, tipoCecinaID) VALUES (5, 'Jamón Serrano', 400, 2500, 5);

-- Inserción de datos en la tabla proveedor
INSERT INTO proveedor (rut, nombre) VALUES ('123123123', 'Proveedor de Insumos');
INSERT INTO proveedor (rut, nombre) VALUES ('321321321', 'Distribuidora de Carnes');
INSERT INTO proveedor (rut, nombre) VALUES ('456456456', 'Especias del Mundo');
INSERT INTO proveedor (rut, nombre) VALUES ('654654654', 'Envolturas Naturales');
INSERT INTO proveedor (rut, nombre) VALUES ('789789789', 'Fábrica de Sal');

-- Inserción de datos en la tabla venta
INSERT INTO venta (numeroFactura, fechaVenta, total, clienteRut) VALUES (1, TO_DATE('2024-08-05', 'YYYY-MM-DD'), 750000, '987654321');
INSERT INTO venta (numeroFactura, fechaVenta, total, clienteRut) VALUES (2, TO_DATE('2024-08-06', 'YYYY-MM-DD'), 540000, '876543210');
INSERT INTO venta (numeroFactura, fechaVenta, total, clienteRut) VALUES (3, TO_DATE('2024-08-07', 'YYYY-MM-DD'), 420000, '765432109');
INSERT INTO venta (numeroFactura, fechaVenta, total, clienteRut) VALUES (4, TO_DATE('2024-08-08', 'YYYY-MM-DD'), 680000, '654321098');
INSERT INTO venta (numeroFactura, fechaVenta, total, clienteRut) VALUES (5, TO_DATE('2024-08-09', 'YYYY-MM-DD'), 530000, '543210987');

-- Inserción de datos en la tabla detVenta
INSERT INTO detVenta (id, cantidad, descripcion, unitario, cecina_ID, venta_numFactura) 
VALUES (1, 100, 'Chorizo Tradicional', 1500, 1, 1);
INSERT INTO detVenta (id, cantidad, descripcion, unitario, cecina_ID, venta_numFactura) 
VALUES (2, 150, 'Longaniza Ahumada', 1800, 2, 2);
INSERT INTO detVenta (id, cantidad, descripcion, unitario, cecina_ID, venta_numFactura) 
VALUES (3, 200, 'Salchicha Vienesa', 1000, 3, 3);
INSERT INTO detVenta (id, cantidad, descripcion, unitario, cecina_ID, venta_numFactura) 
VALUES (4, 120, 'Morcilla Casera', 1600, 4, 4);
INSERT INTO detVenta (id, cantidad, descripcion, unitario, cecina_ID, venta_numFactura) 
VALUES (5, 80, 'Jamón Serrano', 2500, 5, 5);

-- Inserción de datos en la tabla compra
INSERT INTO compra (numeroFactura, fecha, total, proveedorRut) VALUES (1, TO_DATE('2024-08-02', 'YYYY-MM-DD'), 300000, '123123123');
INSERT INTO compra (numeroFactura, fecha, total, proveedorRut) VALUES (2, TO_DATE('2024-08-04', 'YYYY-MM-DD'), 200000, '321321321');
INSERT INTO compra (numeroFactura, fecha, total, proveedorRut) VALUES (3, TO_DATE('2024-08-06', 'YYYY-MM-DD'), 150000, '456456456');
INSERT INTO compra (numeroFactura, fecha, total, proveedorRut) VALUES (4, TO_DATE('2024-08-08', 'YYYY-MM-DD'), 250000, '654654654');
INSERT INTO compra (numeroFactura, fecha, total, proveedorRut) VALUES (5, TO_DATE('2024-08-10', 'YYYY-MM-DD'), 180000, '789789789');

-- Inserción de datos en la tabla detCompra
INSERT INTO detCompra (compraNumeroFacturaID, id, cantidad, descripcion, unitario, inventarioID) 
VALUES (1, 1, 200, 'Tripa Natural', 1500, 1);
INSERT INTO detCompra (compraNumeroFacturaID, id, cantidad, descripcion, unitario, inventarioID) 
VALUES (2, 2, 100, 'Carne de Cerdo', 2000, 2);
INSERT INTO detCompra (compraNumeroFacturaID, id, cantidad, descripcion, unitario, inventarioID) 
VALUES (3, 3, 50, 'Sal', 800, 3);
INSERT INTO detCompra (compraNumeroFacturaID, id, cantidad, descripcion, unitario, inventarioID) 
VALUES (4, 4, 30, 'Especias', 1200, 4);
INSERT INTO detCompra (compraNumeroFacturaID, id, cantidad, descripcion, unitario, inventarioID) 
VALUES (5, 5, 60, 'Ajo', 1000, 5);
