-- FOREIGN KEYS

-- PRODUCTOS → CATEGORIAS, USUARIOS
ALTER TABLE productos
  ADD CONSTRAINT fk_productos_categorias FOREIGN KEY(id_categoria) REFERENCES categorias(id_categoria),
  ADD CONSTRAINT fk_productos_usuarios FOREIGN KEY(id_usuario_creacion) REFERENCES usuarios(id_usuario);

-- CLIENTES → USUARIOS
ALTER TABLE clientes
  ADD CONSTRAINT fk_clientes_usuarios FOREIGN KEY(id_usuario_registro) REFERENCES usuarios(id_usuario);

-- FACTURAS → CLIENTES, USUARIOS
ALTER TABLE facturas
  ADD CONSTRAINT fk_facturas_clientes FOREIGN KEY(id_cliente) REFERENCES clientes(id_cliente),
  ADD CONSTRAINT fk_facturas_usuarios FOREIGN KEY(id_usuario) REFERENCES usuarios(id_usuario);

-- DETALLE_FACTURA → FACTURAS, PRODUCTOS
ALTER TABLE detalle_factura
  ADD CONSTRAINT fk_detalle_factura_facturas FOREIGN KEY(id_factura) REFERENCES facturas(id_factura),
  ADD CONSTRAINT fk_detalle_factura_productos FOREIGN KEY(id_producto) REFERENCES productos(id_producto);

-- PAGOS → FORMAS_PAGO, FACTURAS, USUARIOS
ALTER TABLE pagos
  ADD CONSTRAINT fk_pagos_formas FOREIGN KEY(id_forma_pago) REFERENCES formas_pago(id_forma_pago),
  ADD CONSTRAINT fk_pagos_facturas FOREIGN KEY(id_factura) REFERENCES facturas(id_factura),
  ADD CONSTRAINT fk_pagos_usuarios FOREIGN KEY(id_usuario) REFERENCES usuarios(id_usuario);

-- CUENTAS_POR_COBRAR → FACTURAS, CLIENTES
ALTER TABLE cuentas_por_cobrar
  ADD CONSTRAINT fk_cxc_facturas FOREIGN KEY(id_factura) REFERENCES facturas(id_factura),
  ADD CONSTRAINT fk_cxc_clientes FOREIGN KEY(id_cliente) REFERENCES clientes(id_cliente);

-- AUDITORIA → USUARIOS
ALTER TABLE auditoria
  ADD CONSTRAINT fk_auditoria_usuarios FOREIGN KEY(id_usuario) REFERENCES usuarios(id_usuario);

-- CONFIGURACION → USUARIOS
ALTER TABLE configuracion
  ADD CONSTRAINT fk_configuracion_usuarios FOREIGN KEY(id_usuario_actualizacion) REFERENCES usuarios(id_usuario);