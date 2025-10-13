-- ====== ENUMS ======
CREATE TYPE rol_usuario AS ENUM('administrador','vendedor','contador');
CREATE TYPE tipo_producto AS ENUM('producto','servicio');
CREATE TYPE tipo_cliente AS ENUM('natural','jurídico');
CREATE TYPE tipo_factura AS ENUM('contado','crédito');
CREATE TYPE estado_factura AS ENUM('borrador','emitida','pagada','anulada');
CREATE TYPE estado_cxc AS ENUM('pendiente','vencida','pagada','incobrable');
CREATE TYPE oper_audit AS ENUM('INSERT','UPDATE','DELETE');
CREATE TYPE tipo_cfg AS ENUM('string','number','boolean','json');

-- TABLAS
CREATE TABLE usuarios(
  id_usuario SERIAL PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  rol rol_usuario NOT NULL,
  activo BOOLEAN DEFAULT true,
  fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  fecha_ultima_sesion TIMESTAMP
);

CREATE TABLE categorias(
  id_categoria SERIAL PRIMARY KEY,
  codigo VARCHAR(20) NOT NULL UNIQUE,
  nombre VARCHAR(100) NOT NULL,
  descripcion TEXT,
  activo BOOLEAN DEFAULT true,
  fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE productos(
  id_producto SERIAL PRIMARY KEY,
  codigo_producto VARCHAR(50) NOT NULL UNIQUE,
  codigo_barra VARCHAR(50) UNIQUE,
  nombre VARCHAR(200) NOT NULL,
  descripcion TEXT,
  id_categoria INT REFERENCES categorias(id_categoria),
  tipo_producto tipo_producto NOT NULL,
  unidad_medida VARCHAR(20) NOT NULL,
  precio_compra DECIMAL(10,2) NOT NULL,
  precio_venta DECIMAL(10,2) NOT NULL,
  stock_actual DECIMAL(10,2) DEFAULT 0,
  stock_minimo DECIMAL(10,2) DEFAULT 0,
  itbis BOOLEAN DEFAULT true,
  activo BOOLEAN DEFAULT true,
  fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  id_usuario_creacion INT REFERENCES usuarios(id_usuario)
);

CREATE TABLE clientes(
  id_cliente SERIAL PRIMARY KEY,
  codigo_cliente VARCHAR(20) NOT NULL UNIQUE,
  tipo_cliente tipo_cliente NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  documento VARCHAR(20) NOT NULL UNIQUE,
  telefono VARCHAR(20),
  email VARCHAR(150),
  direccion TEXT,
  ciudad VARCHAR(80),
  provincia VARCHAR(80),
  pais VARCHAR(80) DEFAULT 'República Dominicana',
  limite_credito DECIMAL(12,2) DEFAULT 0,
  activo BOOLEAN DEFAULT true,
  fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  id_usuario_registro INT REFERENCES usuarios(id_usuario)
);

CREATE TABLE formas_pago(
  id_forma_pago SERIAL PRIMARY KEY,
  codigo VARCHAR(10) NOT NULL UNIQUE,
  nombre VARCHAR(50) NOT NULL,
  descripcion TEXT,
  require_referencia BOOLEAN DEFAULT false,
  activo BOOLEAN DEFAULT true
);

CREATE TABLE facturas(
  id_factura SERIAL PRIMARY KEY,
  numero_factura VARCHAR(20) NOT NULL UNIQUE,
  serie VARCHAR(10),
  tipo_factura tipo_factura NOT NULL,
  id_cliente INT NOT NULL REFERENCES clientes(id_cliente),
  id_usuario INT NOT NULL REFERENCES usuarios(id_usuario),
  fecha_factura DATE NOT NULL,
  fecha_vencimiento DATE,
  subtotal DECIMAL(12,2) NOT NULL,
  descuento DECIMAL(12,2) DEFAULT 0,
  itbis DECIMAL(12,2) DEFAULT 0,
  total DECIMAL(12,2) NOT NULL,
  estado estado_factura NOT NULL,
  observaciones TEXT,
  fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE detalle_factura(
  id_detalle SERIAL PRIMARY KEY,
  id_factura INT NOT NULL REFERENCES facturas(id_factura),
  id_producto INT NOT NULL REFERENCES productos(id_producto),
  cantidad DECIMAL(10,2) NOT NULL,
  precio_unitario DECIMAL(10,2) NOT NULL,
  descuento_linea DECIMAL(10,2) DEFAULT 0,
  itbis_linea DECIMAL(12,2) DEFAULT 0,
  subtotal_linea DECIMAL(12,2) NOT NULL,
  total_linea DECIMAL(12,2) NOT NULL
);

CREATE TABLE pagos(
  id_pago SERIAL PRIMARY KEY,
  numero_recibo VARCHAR(20) NOT NULL UNIQUE,
  id_factura INT NOT NULL REFERENCES facturas(id_factura),
  id_forma_pago INT NOT NULL REFERENCES formas_pago(id_forma_pago),
  monto DECIMAL(12,2) NOT NULL,
  referencia VARCHAR(50),
  fecha_pago DATE NOT NULL,
  id_usuario INT NOT NULL REFERENCES usuarios(id_usuario),
  observaciones TEXT,
  fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE cuentas_por_cobrar(
  id_cuenta SERIAL PRIMARY KEY,
  id_factura INT NOT NULL REFERENCES facturas(id_factura),
  id_cliente INT NOT NULL REFERENCES clientes(id_cliente),
  monto_original DECIMAL(12,2) NOT NULL,
  monto_pendiente DECIMAL(12,2) NOT NULL,
  fecha_vencimiento DATE NOT NULL,
  dias_vencido INT DEFAULT 0,
  estado estado_cxc NOT NULL,
  fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE configuracion(
  id_config SERIAL PRIMARY KEY,
  clave VARCHAR(100) NOT NULL UNIQUE,
  valor TEXT,
  descripcion TEXT,
  tipo_dato tipo_cfg NOT NULL,
  fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  id_usuario_actualizacion INT REFERENCES usuarios(id_usuario)
);

CREATE TABLE auditoria(
  id_auditoria SERIAL PRIMARY KEY,
  tabla VARCHAR(50) NOT NULL,
  id_registro INT NOT NULL,
  operacion oper_audit NOT NULL,
  valores_anteriores JSONB,
  valores_nuevos JSONB,
  id_usuario INT NOT NULL REFERENCES usuarios(id_usuario),
  fecha_operacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  ip_address VARCHAR(45)
);