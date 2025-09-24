# 🧾 Sistema de Facturación - Base de Datos Relacional

[![Database](https://img.shields.io/badge/Database-MySQL-blue)](https://mysql.com)
[![SQL](https://img.shields.io/badge/Language-SQL-orange)](https://www.w3schools.com/sql/)
[![Normalización](https://img.shields.io/badge/Normalización-3NF-green)](https://es.wikipedia.org/wiki/Tercera_forma_normal)

## 👥 Equipo de Desarrollo

| Desarrollador | Rol |
|---------------|-----|
| **Ryan** |  |
| **Noelia** |  |
| **Enmanuel** |  |
| **Anael** |  |

## 📋 Descripción del Proyecto

Sistema integral de facturación que permite gestionar de manera eficiente toda la información relacionada con clientes, productos, ventas, facturación, pagos y cuentas por cobrar. La base de datos está diseñada siguiendo las mejores prácticas de normalización y garantiza la integridad referencial.

## 🎯 Objetivos

- ✅ Diseñar una base de datos relacional normalizada
- ✅ Implementar integridad referencial
- ✅ Crear procedimientos almacenados eficientes
- ✅ Garantizar la consistencia de los datos
- ✅ Facilitar consultas complejas entre múltiples tablas

## 🗄️ Diseño del Modelo Relacional

### Entidades Principales

#### 🏢 **CLIENTES**
- **ID_Cliente** (PK) - INT AUTO_INCREMENT
- Nombre - VARCHAR(100)
- Apellido - VARCHAR(100)
- Email - VARCHAR(150)
- Teléfono - VARCHAR(20)
- Dirección - TEXT
- Fecha_Registro - DATETIME
- Estado - ENUM('Activo', 'Inactivo')

#### 📦 **PRODUCTOS**
- **ID_Producto** (PK) - INT AUTO_INCREMENT
- Código_Producto - VARCHAR(50) UNIQUE
- Nombre - VARCHAR(150)
- Descripción - TEXT
- Precio_Unitario - DECIMAL(10,2)
- Stock_Disponible - INT
- Categoría - VARCHAR(100)
- Estado - ENUM('Disponible', 'Agotado', 'Descontinuado')

#### 👤 **USUARIOS**
- **ID_Usuario** (PK) - INT AUTO_INCREMENT
- Nombre_Usuario - VARCHAR(50) UNIQUE
- Contraseña - VARCHAR(255)
- Nombre_Completo - VARCHAR(150)
- Email - VARCHAR(150)
- Rol - ENUM('Administrador', 'Vendedor', 'Contador')
- Fecha_Creación - DATETIME
- Estado - ENUM('Activo', 'Inactivo')

#### 🧾 **FACTURAS**
- **ID_Factura** (PK) - INT AUTO_INCREMENT
- Número_Factura - VARCHAR(50) UNIQUE
- ID_Cliente (FK) - INT
- ID_Usuario (FK) - INT
- Fecha_Factura - DATETIME
- Subtotal - DECIMAL(12,2)
- Impuesto - DECIMAL(12,2)
- Total - DECIMAL(12,2)
- Estado - ENUM('Pendiente', 'Pagada', 'Anulada')

#### 📝 **DETALLE_FACTURA**
- **ID_Detalle** (PK) - INT AUTO_INCREMENT
- ID_Factura (FK) - INT
- ID_Producto (FK) - INT
- Cantidad - INT
- Precio_Unitario - DECIMAL(10,2)
- Descuento - DECIMAL(5,2)
- Subtotal - DECIMAL(12,2)

#### 💰 **PAGOS**
- **ID_Pago** (PK) - INT AUTO_INCREMENT
- ID_Factura (FK) - INT
- Fecha_Pago - DATETIME
- Monto - DECIMAL(12,2)
- Método_Pago - ENUM('Efectivo', 'Tarjeta', 'Transferencia', 'Cheque')
- Referencia - VARCHAR(100)
- Estado - ENUM('Procesado', 'Pendiente', 'Rechazado')

#### 📊 **CUENTAS_POR_COBRAR**
- **ID_Cuenta** (PK) - INT AUTO_INCREMENT
- ID_Factura (FK) - INT
- ID_Cliente (FK) - INT
- Monto_Original - DECIMAL(12,2)
- Monto_Pendiente - DECIMAL(12,2)
- Fecha_Vencimiento - DATE
- Estado - ENUM('Vigente', 'Vencida', 'Pagada')

### 🔗 Relaciones entre Entidades

```sql
-- Relaciones Principales
CLIENTES (1) ──────── (N) FACTURAS
USUARIOS (1) ──────── (N) FACTURAS
FACTURAS (1) ──────── (N) DETALLE_FACTURA
PRODUCTOS (1) ──────── (N) DETALLE_FACTURA
FACTURAS (1) ──────── (N) PAGOS
FACTURAS (1) ──────── (1) CUENTAS_POR_COBRAR
CLIENTES (1) ──────── (N) CUENTAS_POR_COBRAR
```

## 🛠️ Tecnologías Utilizadas

- **SGBD**: MySQL 8.0+
- **Lenguaje**: SQL
- **Herramientas**: MySQL Workbench, phpMyAdmin
- **Normalización**: Tercera Forma Normal (3NF)

## 📁 Estructura del Proyecto

```
sistema-facturacion/
├── 📁 database/
│   ├── 01_create_database.sql
│   ├── 02_create_tables.sql
│   ├── 03_foreign_keys.sql
│   ├── 04_indexes.sql
│   └── 05_sample_data.sql
├── 📁 stored_procedures/
│   ├── clientes/
│   │   ├── sp_insertar_cliente.sql
│   │   ├── sp_actualizar_cliente.sql
│   │   └── sp_consultar_clientes.sql
│   ├── productos/
│   │   ├── sp_insertar_producto.sql
│   │   ├── sp_actualizar_producto.sql
│   │   └── sp_consultar_productos.sql
│   └── facturas/
│       ├── sp_crear_factura.sql
│       ├── sp_consultar_facturas.sql
│       └── sp_reporte_ventas.sql
├── 📁 queries/
│   ├── consultas_basicas.sql
│   ├── consultas_complejas.sql
│   └── reportes.sql
├── 📁 docs/
│   ├── diagrama_er.png
│   ├── diccionario_datos.md
│   └── manual_usuario.md
└── README.md
```

## 🚀 Instalación y Configuración

El proyecto requiere la instalación de un Sistema de Gestión de Base de Datos MySQL y la ejecución secuencial de los scripts de creación de base de datos, tablas, relaciones e índices. Los procedimientos almacenados deben ser implementados siguiendo la estructura modular propuesta.

## ✅ Criterios de Normalización Aplicados

### Primera Forma Normal (1NF)
- ✅ Todos los atributos contienen valores atómicos
- ✅ No hay grupos repetitivos
- ✅ Cada fila es única

### Segunda Forma Normal (2NF)
- ✅ Cumple 1NF
- ✅ Todos los atributos no clave dependen completamente de la clave primaria
- ✅ Eliminación de dependencias parciales

### Tercera Forma Normal (3NF)
- ✅ Cumple 2NF
- ✅ No existen dependencias transitivas
- ✅ Cada atributo no clave depende directamente de la clave primaria

## 🔐 Integridad Referencial

### Restricciones Implementadas
- **CASCADE**: Eliminación en cascada para registros dependientes
- **RESTRICT**: Prevención de eliminación si existen referencias
- **SET NULL**: Establecer valor nulo en caso de eliminación del padre

Las restricciones de integridad referencial garantizan la consistencia de los datos y previenen operaciones que puedan comprometer la integridad del sistema.

## 📊 Testing y Verificación

El sistema incluye scripts de verificación para garantizar:
- Integridad referencial entre todas las tablas
- Consistencia de datos en stocks y transacciones
- Validación de reglas de negocio implementadas
- Pruebas de rendimiento de consultas complejas

## 📈 Métricas de Rendimiento

- **Índices Optimizados**: Creados en campos de búsqueda frecuente
- **Consultas Eficientes**: Tiempo promedio < 100ms
- **Normalización 3NF**: Minimización de redundancia de datos
- **Integridad**: 100% de consistencia referencial



### 🎓 Proyecto Académico - Diseño de Base de Datos Relacionales
**Universidad**: Universidad Abierta Para Adultos (UAPA)  
**Curso**: Bases de Datos Relacionales  
**Período**: 2025

---

