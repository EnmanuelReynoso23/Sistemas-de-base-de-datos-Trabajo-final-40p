
INSERT INTO usuarios (id_usuario, nombre, email, password_hash, rol, activo, fecha_creacion, fecha_ultima_sesion) VALUES
(1, 'Admin ', 'admin@empresa.com', 'password_123', 'administrador', TRUE, NOW(), NOW()),
(2, 'Vendedor', 'vendedor@empresa.com', 'password_456', 'vendedor', TRUE, NOW(), NULL);

INSERT INTO categorias (id_categoria, codigo, nombre, descripcion, activo, fecha_creacion) VALUES
(1, 'ELEC', 'Electrónica', 'Dispositivos y accesorios electrónicos.', TRUE, NOW()),
(2, 'CONS', 'Consultoría', 'Servicios de asesoría.', TRUE, NOW());

INSERT INTO productos (id_producto, codigo_producto, codigo_barra, nombre, descripcion, id_categoria, tipo_producto, unidad_medida, precio_compra, precio_venta, stock_actual, stock_minimo, itbis, activo, fecha_creacion, id_usuario_creacion) VALUES
(101, 'LP-101', 'B001', 'Laptop Empresarial', 'Laptop de alto rendimiento.', 1, 'producto', 'Unidad', 800.00, 1200.00, 50.00, 5.00, TRUE, TRUE, NOW(), 1),
(201, 'SERV-01', NULL, 'Servicio de Asesoría HR', 'Hora de consultoría en recursos humanos.', 2, 'servicio', 'Hora', 0.00, 150.00, 0.00, 0.00, TRUE, TRUE, NOW(), 1);

INSERT INTO clientes (id_cliente, codigo_cliente, tipo_cliente, nombre, documento, telefono, email, direccion, limite_credito, activo, fecha_registro, id_usuario_registro) VALUES
(1, 'C-001', 'juridico', 'Tech Solutions SRL', 'RNC-123456789', '809-555-1000', 'contacto@techsolutions.com', 'Av. Principal #100', 5000.00, TRUE, NOW(), 2),
(2, 'C-002', 'natural', 'Juan Pérez', 'CED-00100010010', '809-555-2000', 'juan.perez@email.com', 'Calle Secundaria #25', 0.00, TRUE, NOW(), 2);

INSERT INTO formas_pago (id_forma_pago, codigo, nombre, descripcion, requiere_referencia, activo) VALUES
(1, 'EFE', 'Efectivo', 'Pago en físico.', FALSE, TRUE),
(2, 'TRANS', 'Transferencia Bancaria', 'Transferencia electrónica de fondos.', TRUE, TRUE),
(3, 'CRED', 'Tarjeta de Crédito', 'Pago con tarjeta de crédito/débito.', TRUE, TRUE);

INSERT INTO facturas (id_factura, numero_factura, serie, tipo_factura, id_cliente, id_usuario, fecha_factura, fecha_vencimiento, subtotal, descuentos, itbis, total, estado, observaciones, fecha_creacion, fecha_actualizacion) VALUES
(1, 'F-0001', 'A', 'contado', 1, 2, '2025-10-01', NULL, 1200.00, 0.00, 180.00, 1380.00, 'pagada', 'Venta al contado', NOW(), NOW()),
(2, 'F-0002', 'A', 'credito', 2, 2, '2025-10-02', '2025-11-01', 300.00, 0.00, 45.00, 345.00, 'emitida', '30 días de crédito', NOW(), NOW());

INSERT INTO detalle_factura (id_detalle, id_factura, id_producto, cantidad, precio_unitario, descuento_linea, subtotal_linea, itbis_linea, total_linea) VALUES
(1, 1, 101, 1.00, 1200.00, 0.00, 1200.00, 180.00, 1380.00),
(2, 2, 201, 2.00, 150.00, 0.00, 300.00, 45.00, 345.00);

INSERT INTO pagos (id_pago, numero_recibo, id_forma_pago, id_factura, monto, referencia, fecha_pago, id_usuario, observaciones, fecha_registro) VALUES
(1, 'R-0001', 1, 1, 1380.00, NULL, '2025-10-01', 2, 'Pago completo en efectivo', NOW());

INSERT INTO cuentas_por_cobrar (id_cuenta, id_factura, id_cliente, monto_original, monto_pendiente, fecha_vencimiento, dias_vencidos, estado, fecha_actualizacion) VALUES
(1, 2, 2, 345.00, 345.00, '2025-11-01', 0, 'pendiente', NOW());

INSERT INTO auditoria (id_auditoria, tabla, id_registro, operacion, valores_anteriores, valores_nuevos, id_usuario, fecha_operacion, ip_address) VALUES
(1, 'clientes', 2, 'INSERT', NULL, '{"nombre": "Juan Pérez", "documento": "CED-00100010010"}', 2, NOW(), '192.168.1.10');

INSERT INTO configuracion (id_config, clave, valor, descripcion, tipo_dato, fecha_actualizacion, id_usuario_actualizacion) VALUES
(1, 'TASA_ITBIS', '0.15', 'Tasa impositiva del ITBIS (Impuesto sobre Transferencia de Bienes Industrializados y Servicios).', 'number', NOW(), 1),
(2, 'NOMBRE_EMPRESA', 'Empresa Ejemplo S.R.L.', 'Nombre legal de la compañía para facturación.', 'string', NOW(), 1);
