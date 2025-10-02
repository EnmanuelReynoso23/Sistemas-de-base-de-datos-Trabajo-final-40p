-- ====== ENUMS ======
CREATE TYPE rol_usuario AS ENUM('administrador','vendedor','contador');
CREATE TYPE tipo_producto AS ENUM('producto','servicio');
CREATE TYPE tipo_cliente AS ENUM('natural','juridico');
CREATE TYPE tipo_factura AS ENUM('contado','credito');
CREATE TYPE estado_factura AS ENUM('borrador','emitida','pagada','anulada');
CREATE TYPE estado_cxc AS ENUM('pendiente','vencida','pagada','incobrable');
CREATE TYPE oper_audit AS ENUM('INSERT','UPDATE','DELETE');
CREATE TYPE tipo_cfg AS ENUM('string','number','boolean','json');

-- TABLAS
CREATE TABLE usuarios(
  id_usuario INT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  rol rol_usuario NOT NULL,
  activo BOOLEAN NOT NULL,
  fecha_creacion TIMESTAMP,
  fecha_ultima_sesion TIMESTAMP
);

CREATE TABLE categorias(
  id_categoria INT PRIMARY KEY,
  codigo VARCHAR(20) NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  descripcion TEXT,
  activo BOOLEAN,
  fecha_creacion TIMESTAMP
);

CREATE TABLE productos(
  id_producto INT PRIMARY KEY,
  codigo_producto VARCHAR(50) NOT NULL,
  codigo_barra VARCHAR(50),
  nombre VARCHAR(200) NOT NULL,
  descripcion TEXT,
  id_categoria INT,
  tipo_producto tipo_producto NOT NULL,
  unidad_medida VARCHAR(20) NOT NULL,
  precio_compra DECIMAL(10,2),
  precio_venta DECIMAL(10,2) NOT NULL,
  stock_actual DECIMAL(10,2),
  stock_minimo DECIMAL(10,2),
  itbis BOOLEAN,
  activo BOOLEAN,
  fecha_creacion TIMESTAMP,
  id_usuario_creacion INT
);

CREATE TABLE clientes(
  id_cliente INT PRIMARY KEY,
  codigo_cliente VARCHAR(20) NOT NULL,
  tipo_cliente tipo_cliente NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  documento VARCHAR(20) NOT NULL,
  telefono VARCHAR(20),
  email VARCHAR(150),
  direccion TEXT,
  ciudad VARCHAR(80),
  provincia VARCHAR(80),
  pais VARCHAR(80),
  limite_credito DECIMAL(12,2),
  activo BOOLEAN,
  fecha_registro TIMESTAMP,
  id_usuario_registro INT
);

CREATE TABLE formas_pago(
  id_forma_pago INT PRIMARY KEY,
  codigo VARCHAR(10) NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  descripcion TEXT,
  requiere_referencia BOOLEAN,
  activo BOOLEAN
);

CREATE TABLE facturas(
  id_factura INT PRIMARY KEY,
  numero_factura VARCHAR(20) NOT NULL,
  serie VARCHAR(10),
  tipo_factura tipo_factura NOT NULL,
  id_cliente INT NOT NULL,
  id_usuario INT NOT NULL,
  fecha_factura DATE NOT NULL,
  fecha_vencimiento DATE,
  subtotal DECIMAL(12,2) NOT NULL,
  descuentos DECIMAL(12,2),
  itbis DECIMAL(12,2) NOT NULL,
  total DECIMAL(12,2) NOT NULL,
  estado estado_factura NOT NULL,
  observaciones TEXT,
  fecha_creacion TIMESTAMP,
  fecha_actualizacion TIMESTAMP
);

CREATE TABLE detalle_factura(
  id_detalle INT PRIMARY KEY,
  id_factura INT NOT NULL,
  id_producto INT NOT NULL,
  cantidad DECIMAL(10,2) NOT NULL,
  precio_unitario DECIMAL(10,2) NOT NULL,
  descuento_linea DECIMAL(10,2),
  subtotal_linea DECIMAL(12,2) NOT NULL,
  itbis_linea DECIMAL(12,2) NOT NULL,
  total_linea DECIMAL(12,2) NOT NULL
);

CREATE TABLE pagos(
  id_pago INT PRIMARY KEY,
  numero_recibo VARCHAR(20) NOT NULL,
  id_forma_pago INT NOT NULL,
  id_factura INT NOT NULL,
  monto DECIMAL(12,2) NOT NULL,
  referencia VARCHAR(100),
  fecha_pago DATE NOT NULL,
  id_usuario INT NOT NULL,
  observaciones TEXT,
  fecha_registro TIMESTAMP
);

CREATE TABLE cuentas_por_cobrar(
  id_cuenta INT PRIMARY KEY,
  id_factura INT NOT NULL,
  id_cliente INT NOT NULL,
  monto_original DECIMAL(12,2) NOT NULL,
  monto_pendiente DECIMAL(12,2) NOT NULL,
  fecha_vencimiento DATE NOT NULL,
  dias_vencidos INT,
  estado estado_cxc NOT NULL,
  fecha_actualizacion TIMESTAMP
);

CREATE TABLE auditoria(
  id_auditoria INT PRIMARY KEY,
  tabla VARCHAR(50) NOT NULL,
  id_registro INT NOT NULL,
  operacion oper_audit NOT NULL,
  valores_anteriores JSONB,
  valores_nuevos JSONB,
  id_usuario INT NOT NULL,
  fecha_operacion TIMESTAMP,
  ip_address VARCHAR(45)
);

CREATE TABLE configuracion(
  id_config INT PRIMARY KEY,
  clave VARCHAR(100) NOT NULL,
  valor TEXT,
  descripcion TEXT,
  tipo_dato tipo_cfg,
  fecha_actualizacion TIMESTAMP,
  id_usuario_actualizacion INT
);