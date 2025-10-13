-- Índices para PRODUCTOS
CREATE INDEX idx_codigo_producto ON productos(codigo_producto);
CREATE INDEX idx_codigo_barra ON productos(codigo_barra);
CREATE INDEX idx_categoria ON productos(id_categoria);
CREATE INDEX idx_activo_productos ON productos(activo);

-- Índices para CLIENTES
CREATE INDEX idx_codigo_cliente ON clientes(codigo_cliente);
CREATE INDEX idx_documento ON clientes(documento);
CREATE INDEX idx_activo_clientes ON clientes(activo);

-- Índices para FACTURAS
CREATE INDEX idx_numero_factura ON facturas(numero_factura);
CREATE INDEX idx_cliente_facturas ON facturas(id_cliente);
CREATE INDEX idx_fecha_facturas ON facturas(fecha_factura);
CREATE INDEX idx_estado_facturas ON facturas(estado);

-- Índices para DETALLE_FACTURA
CREATE INDEX idx_factura_detalle ON detalle_factura(id_factura);
CREATE INDEX idx_producto_detalle ON detalle_factura(id_producto);

-- Índices para PAGOS
CREATE INDEX idx_factura_pagos ON pagos(id_factura);
CREATE INDEX idx_fecha_pagos ON pagos(fecha_pago);

-- Índices para CUENTAS_POR_COBRAR
CREATE INDEX idx_cliente_cxc ON cuentas_por_cobrar(id_cliente);
CREATE INDEX idx_estado_cxc ON cuentas_por_cobrar(estado);
CREATE INDEX idx_vencimiento_cxc ON cuentas_por_cobrar(fecha_vencimiento);

-- Índices para AUDITORIA
CREATE INDEX idx_tabla_registro ON auditoria(tabla, id_registro);
CREATE INDEX idx_usuario_auditoria ON auditoria(id_usuario);
CREATE INDEX idx_fecha_auditoria ON auditoria(fecha_operacion);
