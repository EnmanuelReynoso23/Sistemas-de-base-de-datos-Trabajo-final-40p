# Diccionario de Datos - Sistema de Facturación

## Descripción General

Este documento describe las entidades, atributos y relaciones del sistema de base de datos para el manejo de facturación, clientes, productos y pagos.

## Entidades Principales

### 1. CLIENTES

Tabla que almacena la información de los clientes del sistema.

| Atributo       | Tipo de Dato | Longitud | Restricciones                         | Descripción                       |
| -------------- | ------------ | -------- | ------------------------------------- | ---------------------------------- |
| id_cliente     | SERIAL       | -        | PRIMARY KEY, NOT NULL, AUTO_INCREMENT | Identificador único del cliente   |
| nombre         | VARCHAR      | 100      | NOT NULL                              | Nombre del cliente                 |
| apellido       | VARCHAR      | 100      | NOT NULL                              | Apellido del cliente               |
| email          | VARCHAR      | 150      | UNIQUE, NOT NULL                      | Correo electrónico del cliente    |
| telefono       | VARCHAR      | 20       | -                                     | Número de teléfono del cliente   |
| direccion      | TEXT         | -        | -                                     | Dirección completa del cliente    |
| fecha_registro | DATE         | -        | DEFAULT CURRENT_DATE                  | Fecha de registro del cliente      |
| estado         | BOOLEAN      | -        | DEFAULT TRUE                          | Estado activo/inactivo del cliente |

### 2. PRODUCTOS

Tabla que contiene la información de los productos disponibles para venta.

| Atributo       | Tipo de Dato | Longitud | Restricciones                         | Descripción                        |
| -------------- | ------------ | -------- | ------------------------------------- | ----------------------------------- |
| id_producto    | SERIAL       | -        | PRIMARY KEY, NOT NULL, AUTO_INCREMENT | Identificador único del producto   |
| nombre         | VARCHAR      | 200      | NOT NULL                              | Nombre del producto                 |
| descripcion    | TEXT         | -        | -                                     | Descripción detallada del producto |
| precio         | DECIMAL      | 10,2     | NOT NULL                              | Precio unitario del producto        |
| stock          | INTEGER      | -        | DEFAULT 0                             | Cantidad disponible en inventario   |
| categoria      | VARCHAR      | 50       | -                                     | Categoría del producto             |
| fecha_creacion | DATE         | -        | DEFAULT CURRENT_DATE                  | Fecha de creación del producto     |
| estado         | BOOLEAN      | -        | DEFAULT TRUE                          | Estado activo/inactivo del producto |

### 3. USUARIOS

Tabla para gestionar los usuarios del sistema (administradores, vendedores, etc.).

| Atributo       | Tipo de Dato | Longitud | Restricciones                         | Descripción                            |
| -------------- | ------------ | -------- | ------------------------------------- | --------------------------------------- |
| id_usuario     | SERIAL       | -        | PRIMARY KEY, NOT NULL, AUTO_INCREMENT | Identificador único del usuario        |
| nombre_usuario | VARCHAR      | 50       | UNIQUE, NOT NULL                      | Nombre de usuario para login            |
| contrasena     | VARCHAR      | 255      | NOT NULL                              | Contraseña encriptada                  |
| nombre         | VARCHAR      | 100      | NOT NULL                              | Nombre completo del usuario             |
| email          | VARCHAR      | 150      | UNIQUE, NOT NULL                      | Correo electrónico del usuario         |
| rol            | VARCHAR      | 20       | NOT NULL                              | Rol del usuario (admin, vendedor, etc.) |
| fecha_creacion | DATE         | -        | DEFAULT CURRENT_DATE                  | Fecha de creación del usuario          |
| estado         | BOOLEAN      | -        | DEFAULT TRUE                          | Estado activo/inactivo del usuario      |

### 4. FACTURAS

Tabla principal para las facturas de venta.

| Atributo          | Tipo de Dato | Longitud | Restricciones                                         | Descripción                                        |
| ----------------- | ------------ | -------- | ----------------------------------------------------- | --------------------------------------------------- |
| id_factura        | SERIAL       | -        | PRIMARY KEY, NOT NULL, AUTO_INCREMENT                 | Identificador único de la factura                  |
| id_cliente        | INTEGER      | -        | FOREIGN KEY REFERENCES CLIENTES(id_cliente), NOT NULL | Cliente que realiza la compra                       |
| id_usuario        | INTEGER      | -        | FOREIGN KEY REFERENCES USUARIOS(id_usuario), NOT NULL | Usuario que genera la factura                       |
| fecha_emision     | DATE         | -        | DEFAULT CURRENT_DATE, NOT NULL                        | Fecha de emisión de la factura                     |
| fecha_vencimiento | DATE         | -        | -                                                     | Fecha de vencimiento de la factura                  |
| subtotal          | DECIMAL      | 10,2     | NOT NULL                                              | Subtotal antes de impuestos                         |
| iva               | DECIMAL      | 10,2     | DEFAULT 0                                             | Monto del IVA                                       |
| total             | DECIMAL      | 10,2     | NOT NULL                                              | Total de la factura                                 |
| estado            | VARCHAR      | 20       | DEFAULT 'PENDIENTE'                                   | Estado de la factura (PENDIENTE, PAGADA, CANCELADA) |
| notas             | TEXT         | -        | -                                                     | Notas adicionales de la factura                     |

### 5. DETALLE_FACTURA

Tabla que detalla los productos incluidos en cada factura.

| Atributo        | Tipo de Dato | Longitud | Restricciones                                           | Descripción                                      |
| --------------- | ------------ | -------- | ------------------------------------------------------- | ------------------------------------------------- |
| id_detalle      | SERIAL       | -        | PRIMARY KEY, NOT NULL, AUTO_INCREMENT                   | Identificador único del detalle                  |
| id_factura      | INTEGER      | -        | FOREIGN KEY REFERENCES FACTURAS(id_factura), NOT NULL   | Factura a la que pertenece el detalle             |
| id_producto     | INTEGER      | -        | FOREIGN KEY REFERENCES PRODUCTOS(id_producto), NOT NULL | Producto vendido                                  |
| cantidad        | INTEGER      | -        | NOT NULL                                                | Cantidad del producto vendido                     |
| precio_unitario | DECIMAL      | 10,2     | NOT NULL                                                | Precio unitario al momento de la venta            |
| subtotal        | DECIMAL      | 10,2     | NOT NULL                                                | Subtotal del detalle (cantidad * precio_unitario) |
| descuento       | DECIMAL      | 10,2     | DEFAULT 0                                               | Descuento aplicado al detalle                     |

### 6. PAGOS

Tabla que registra los pagos realizados por las facturas.

| Atributo    | Tipo de Dato | Longitud | Restricciones                                         | Descripción                                             |
| ----------- | ------------ | -------- | ----------------------------------------------------- | -------------------------------------------------------- |
| id_pago     | SERIAL       | -        | PRIMARY KEY, NOT NULL, AUTO_INCREMENT                 | Identificador único del pago                            |
| id_factura  | INTEGER      | -        | FOREIGN KEY REFERENCES FACTURAS(id_factura), NOT NULL | Factura pagada                                           |
| fecha_pago  | DATE         | -        | DEFAULT CURRENT_DATE, NOT NULL                        | Fecha en que se realizó el pago                         |
| monto       | DECIMAL      | 10,2     | NOT NULL                                              | Monto del pago                                           |
| metodo_pago | VARCHAR      | 30       | NOT NULL                                              | Método de pago (efectivo, tarjeta, transferencia, etc.) |
| referencia  | VARCHAR      | 100      | -                                                     | Referencia o número de transacción                     |
| notas       | TEXT         | -        | -                                                     | Notas adicionales del pago                               |

### 7. CUENTAS_POR_COBRAR

Tabla para el seguimiento de las cuentas por cobrar.

| Atributo          | Tipo de Dato | Longitud | Restricciones                                         | Descripción                                     |
| ----------------- | ------------ | -------- | ----------------------------------------------------- | ------------------------------------------------ |
| id_cuenta         | SERIAL       | -        | PRIMARY KEY, NOT NULL, AUTO_INCREMENT                 | Identificador único de la cuenta por cobrar     |
| id_factura        | INTEGER      | -        | FOREIGN KEY REFERENCES FACTURAS(id_factura), NOT NULL | Factura pendiente de pago                        |
| id_cliente        | INTEGER      | -        | FOREIGN KEY REFERENCES CLIENTES(id_cliente), NOT NULL | Cliente deudor                                   |
| monto_total       | DECIMAL      | 10,2     | NOT NULL                                              | Monto total de la deuda                          |
| monto_pagado      | DECIMAL      | 10,2     | DEFAULT 0                                             | Monto ya pagado                                  |
| saldo_pendiente   | DECIMAL      | 10,2     | NOT NULL                                              | Saldo pendiente de pago                          |
| fecha_vencimiento | DATE         | -        | NOT NULL                                              | Fecha límite de pago                            |
| estado            | VARCHAR      | 20       | DEFAULT 'PENDIENTE'                                   | Estado de la cuenta (PENDIENTE, VENCIDA, PAGADA) |
| dias_mora         | INTEGER      | -        | DEFAULT 0                                             | Días de retraso en el pago                      |

## Relaciones entre Entidades

### Relaciones Definidas

- **CLIENTES** 1:N **FACTURAS** (Un cliente puede tener múltiples facturas)
- **USUARIOS** 1:N **FACTURAS** (Un usuario puede generar múltiples facturas)
- **FACTURAS** 1:N **DETALLE_FACTURA** (Una factura puede tener múltiples detalles)
- **PRODUCTOS** 1:N **DETALLE_FACTURA** (Un producto puede aparecer en múltiples detalles)
- **FACTURAS** 1:N **PAGOS** (Una factura puede tener múltiples pagos)
- **FACTURAS** 1:1 **CUENTAS_POR_COBRAR** (Una factura genera una cuenta por cobrar)
- **CLIENTES** 1:N **CUENTAS_POR_COBRAR** (Un cliente puede tener múltiples cuentas por cobrar)

## Reglas de Negocio Implementadas

### Integridad Referencial

- **CASCADE**: Eliminación en cascada para detalles de factura y pagos cuando se elimina una factura
- **RESTRICT**: Prevención de eliminación de clientes, productos y usuarios si tienen registros relacionados
- **SET NULL**: Establecer valores nulos en referencias cuando sea apropiado

### Validaciones

- Los precios y montos deben ser valores positivos
- Las fechas de vencimiento no pueden ser anteriores a la fecha de emisión
- El stock de productos no puede ser negativo
- Los estados tienen valores predefinidos

### Índices Recomendados

- Índice en `email` de CLIENTES para búsquedas rápidas
- Índice en `nombre_usuario` de USUARIOS para autenticación
- Índice en `fecha_emision` de FACTURAS para reportes por fecha
- Índice compuesto en `id_factura, id_producto` de DETALLE_FACTURA

## Normalización Aplicada

### Primera Forma Normal (1NF)

- Todos los atributos contienen valores atómicos
- No hay grupos repetitivos
- Cada fila es única

### Segunda Forma Normal (2NF)

- Cumple 1NF
- Todos los atributos no clave dependen completamente de la clave primaria
- Eliminación de dependencias parciales

### Tercera Forma Normal (3NF)

- Cumple 2NF
- No existen dependencias transitivas
- Cada atributo no clave depende directamente de la clave primaria

Este diccionario de datos proporciona la estructura completa para implementar el sistema de facturación en PostgreSQL.`</content>`
`<parameter name="filePath">`c:\Users\reyno\OneDrive\Sistemas-de-base-de-datos-Trabajo-final-40p\Diagrama y Diccionario\diccionario_datos.md
