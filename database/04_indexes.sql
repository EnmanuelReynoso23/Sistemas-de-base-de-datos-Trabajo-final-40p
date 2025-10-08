
CREATE INDEX idx_productos_id_categoria ON productos (id_categoria);
CREATE INDEX idx_productos_id_usuario_creacion ON productos (id_usuario_creacion);

CREATE INDEX idx_clientes_id_usuario_registro ON clientes (id_usuario_registro);

CREATE INDEX idx_facturas_id_cliente ON facturas (id_cliente);
CREATE INDEX idx_facturas_id_usuario ON facturas (id_usuario);

CREATE INDEX idx_detalle_factura_id_factura ON detalle_factura (id_factura);
CREATE INDEX idx_detalle_factura_id_producto ON detalle_factura (id_producto);

CREATE INDEX idx_pagos_id_forma_pago ON pagos (id_forma_pago);
CREATE INDEX idx_pagos_id_factura ON pagos (id_factura);
CREATE INDEX idx_pagos_id_usuario ON pagos (id_usuario);

CREATE INDEX idx_cxc_id_factura ON cuentas_por_cobrar (id_factura);
CREATE INDEX idx_cxc_id_cliente ON cuentas_por_cobrar (id_cliente);

CREATE INDEX idx_auditoria_id_usuario ON auditoria (id_usuario);

CREATE INDEX idx_configuracion_id_usuario_actualizacion ON configuracion (id_usuario_actualizacion);

-- INDICES PARA OPTIMIZAR BUSQUEDA Y FILTRADO (WHERE Clauses)

CREATE INDEX idx_usuarios_rol ON usuarios (rol);
CREATE UNIQUE INDEX uix_usuarios_email ON usuarios (email); 
CREATE INDEX idx_usuarios_activo ON usuarios (activo);

CREATE UNIQUE INDEX uix_categorias_codigo ON categorias (codigo);
CREATE INDEX idx_categorias_nombre ON categorias (nombre);

CREATE UNIQUE INDEX uix_productos_codigo_producto ON productos (codigo_producto);
CREATE UNIQUE INDEX uix_productos_codigo_barra ON productos (codigo_barra) WHERE codigo_barra IS NOT NULL; nde
CREATE INDEX idx_productos_tipo ON productos (tipo_producto);
CREATE INDEX idx_productos_activo ON productos (activo);

CREATE UNIQUE INDEX uix_clientes_documento ON clientes (documento);
CREATE UNIQUE INDEX uix_clientes_codigo ON clientes (codigo_cliente);
CREATE INDEX idx_clientes_tipo ON clientes (tipo_cliente);

CREATE UNIQUE INDEX uix_facturas_numero_serie ON facturas (numero_factura, serie);
CREATE INDEX idx_facturas_fecha ON facturas (fecha_factura);
CREATE INDEX idx_facturas_estado ON facturas (estado);
CREATE INDEX idx_facturas_tipo ON facturas (tipo_factura);

CREATE INDEX idx_cxc_estado ON cuentas_por_cobrar (estado);
CREATE INDEX idx_cxc_fecha_vencimiento ON cuentas_por_cobrar (fecha_vencimiento);

CREATE INDEX idx_auditoria_tabla_operacion ON auditoria (tabla, operacion);

CREATE UNIQUE INDEX uix_configuracion_clave ON configuracion (clave);
