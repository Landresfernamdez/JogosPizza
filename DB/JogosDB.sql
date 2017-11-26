
----tabla de los clientes
CREATE  TABLE clientes (
	nombre_usuario VARCHAR(50) NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	apellido1 VARCHAR(50) NOT NULL,
	apellido2 VARCHAR(50) NOT NULL,
	distrito VARCHAR(50) NOT NULL,
	canton VARCHAR(50) NOT NULL,
	provincia VARCHAR(50) NOT NULL,
	detalle VARCHAR(50) NOT NULL,
	contrasena VARCHAR(50) NOT NULL,
	PRIMARY KEY (nombre_usuario)
);

----tabla de los compradores
CREATE  TABLE comprador (
	nombre_usuario VARCHAR(50) NOT NULL,
	id_comprador SERIAL NOT NULL,
	PRIMARY KEY (nombre_usuario),
	CONSTRAINT FK_nombre_usuario_clientes_comprador FOREIGN KEY  (nombre_usuario) REFERENCES clientes (nombre_usuario)
);
----tabla del administrador 
CREATE  TABLE administrador (
	nombre_usuario VARCHAR(50) NOT NULL,
	id_administrador SERIAL NOT NULL,
	puesto VARCHAR(30) NOT NULL,
	PRIMARY KEY (nombre_usuario),
	CONSTRAINT FK_nombre_usuario_clientes_administrador FOREIGN KEY (nombre_usuario) REFERENCES clientes (nombre_usuario)
);
----tabla de las categorias
CREATE  TABLE categorias (
	nombre_categoria VARCHAR(50) NOT NULL,  
	PRIMARY KEY (nombre_categoria)
);
----tabla de los productos
CREATE  TABLE productos (
	nombre_producto VARCHAR(50) NOT NULL,
	precio MONEY NOT NULL,
	estado INT NOT NULL,
	nombre_categoria VARCHAR(50) NOT NULL,
	PRIMARY KEY (nombre_producto),
	CONSTRAINT FK_nombre_categoria_categorias_productos FOREIGN KEY  (nombre_categoria) REFERENCES categorias (nombre_categoria)
)
----tabla del administrador y comprador
CREATE TABLE AC(
	nombre_usuario VARCHAR(50) NOT NULL,
	nombre_categoria VARCHAR(50) NOT NULL,
	PRIMARY KEY (nombre_usuario,nombre_categoria),
	CONSTRAINT FK_nombre_usuario_administradores_categorias FOREIGN KEY  (nombre_usuario) REFERENCES administrador (nombre_usuario),
	CONSTRAINT FK_nombre_categoria_categoria_administradores FOREIGN KEY  (nombre_categoria) REFERENCES categorias (nombre_categoria)
);
----tabla de los pedidos
CREATE  TABLE pedido(
	id_pedido SERIAL NOT NULL,
	estado CHAR(1) NOT NULL,
	fecha DATE NOT NULL,
	nombre_usuario VARCHAR(50) NOT NULL,
	PRIMARY KEY (id_pedido),
	CONSTRAINT FK_nombre_usuario_comprador_pedido FOREIGN KEY  (nombre_usuario) REFERENCES comprador (nombre_usuario)
);
----tabla del administrador y del pedido
CREATE  TABLE AP (
	id_pedido SERIAL NOT NULL,
	nombre_usuario VARCHAR(50) NOT NULL,
	CONSTRAINT FK_id_pedido_pedido_administrador FOREIGN KEY  (id_pedido) REFERENCES pedido (id_pedido),
	CONSTRAINT FK_nombre_usuario_administrador_pedido FOREIGN KEY  (nombre_usuario) REFERENCES administrador (nombre_usuario)
);	
----tabla entre pedido y producto
CREATE  TABLE PP (
	nombre_producto VARCHAR(50) NOT NULL,
	id_pedido SERIAL NOT NULL,
	cantidad INT NOT NULL,
	CONSTRAINT FK_nombre_producto_producto_pedido FOREIGN KEY  (nombre_producto) REFERENCES productos (nombre_producto),
	CONSTRAINT FK_id_pedido_pedido_producto FOREIGN KEY  (id_pedido) REFERENCES pedido (id_pedido)
);
CREATE TABLE notificacion(
	id_pedido INT Primary Key NOT NULL,
	detalle VARCHAR(200),
	vista CHAR(1),
	CONSTRAINT FK_id_pedido_pedido_notificacion FOREIGN KEY  (id_pedido) REFERENCES pedido(id_pedido)
);
create or replace function consultarProducto(
	nombre_pedido varchar(50)
)
RETURNS VOID as
$BODY$
BEGIN
	SELECT * productos;

END
$BODY$
language plpgsql;
create or replace function insertarCliente(
	nombre_usuario varchar(50),
	nombre varchar(50),
	apellido1 varchar(50),
	apellido2 varchar(50),
	distrito varchar(50),
	canton varchar(50),
	provincia varchar(50),
	detalle varchar(50),
	contrasena varchar(50)
	)
RETURNS VOID as
$BODY$
BEGIN
	INSERT INTO clientes VALUES (nombre_usuario, nombre, apellido1,apellido2, distrito, canton, provincia, detalle, contrasena);
	INSERT INTO comprador(nombre_usuario) VALUES(nombre_usuario);

END
$BODY$
language plpgsql;
create or replace function insertarAdministrador(
	nombre_usuario varchar(50),
	nombre varchar(50),
	apellido1 varchar(50),
	apellido2 varchar(50),
	distrito varchar(50),
	canton varchar(50),
	provincia varchar(50),
	detalle varchar(50),
	contrasena varchar(50),
	puesto varchar(50)
	)
RETURNS VOID as
$BODY$
BEGIN
	INSERT INTO clientes VALUES (nombre_usuario,nombre,apellido1,apellido2, distrito, canton, provincia, detalle, contrasena);
	INSERT INTO administrador(nombre_usuario,puesto) VALUES(nombre_usuario,puesto);

END
$BODY$
language plpgsql;



CREATE OR REPLACE FUNCTION agregarProducto(
	nombre_producto VARCHAR(50),
	precio money,
	nombre_catego VARCHAR(50)
)
RETURNS VOID as
$BODY$
BEGIN
	IF (NOT EXISTS(SELECT * FROM categorias where nombre_categoria=nombre_catego))
	THEN
		INSERT INTO categorias VALUES(nombre_catego);
		INSERT INTO productos VALUES(nombre_producto,precio,1,nombre_catego);
	ELSE 
		INSERT INTO productos VALUES(nombre_producto,precio,1,nombre_catego);
		
	END IF;
END;
$BODY$
language plpgsql;

CREATE OR REPLACE FUNCTION modificarProducto(
	nombre_producto_p VARCHAR(50),
	estado_p CHAR(1)
	)
RETURNS VOID AS
$BODY$
BEGIN
	UPDATE productos SET estado=CAST(estado_p AS INT) where nombre_producto=nombre_producto_p;
END
$BODY$
language plpgsql;

CREATE OR REPLACE FUNCTION modificarProductoAll(
	nombre_producto_p VARCHAR(50),
	precio_p money,
	nombre_categoria_p VARCHAR(50)
	)
RETURNS VOID AS
$BODY$
BEGIN
	UPDATE productos SET precio=precio_p,nombre_categoria=nombre_categoria_p where nombre_producto=nombre_producto_p;
END
$BODY$
language plpgsql;


SELECT modificarProducto('')
SELECT * FROM productos

CREATE OR REPLACE FUNCTION eliminarProducto(
	nombre_producto_p VARCHAR(50)
	)
RETURNS VOID AS
$BODY$
BEGIN
	DELETE FROM productos where nombre_producto=nombre_producto_p;
END
$BODY$
language plpgsql;


CREATE OR REPLACE FUNCTION modificarPedidoR(
	id_p VARCHAR(10),
	estado_p CHAR(1),
	detalle_p VARCHAR(50)
	)
RETURNS VOID AS
$BODY$
BEGIN
	UPDATE pedido SET estado=estado_p where id_pedido=CAST(id_p AS INT);
	INSERT INTO notificacion VALUES(CAST(id_p AS INT),detalle_p,0);
END
$BODY$
language plpgsql;


CREATE OR REPLACE FUNCTION modificarPedido(
	id_p VARCHAR(10),
	estado_p CHAR(1)
	)
RETURNS VOID AS
$BODY$
BEGIN
	UPDATE pedido SET estado=estado_p where id_pedido=CAST(id_p AS INT);
END
$BODY$
language plpgsql;


SELECT * FROM Pedido
SELECT * FROM notificacion

SELECT modificarPedidoR('2','n','Disculpe pero no tenemos ingredientes');
SELECT modificarPedido('1','n');
CREATE OR REPLACE FUNCTION agregarProducto(
	nombre_pedido VARCHAR(50),
	precio money,
	estado CHAR(1),
	nombre_catego VARCHAR(50)
)
RETURNS VOID as
$BODY$
BEGIN
	IF (NOT EXISTS(SELECT * FROM categorias where nombre_categoria=nombre_catego))
	THEN
		INSERT INTO categorias VALUES(nombre_catego);
		INSERT INTO productos VALUES(nombre_pedido,precio,CAST(estado AS INT),nombre_catego);
	ELSE 
		INSERT INTO productos VALUES(nombre_pedido,precio,CAST(estado AS INT),nombre_catego);
		
	END IF;
END;
$BODY$
language plpgsql;


CREATE OR REPLACE FUNCTION insertarPedido(
	nombre_usuario VARCHAR(50)
	)
RETURNS INT AS
$BODY$
	DECLARE id INT;
BEGIN
	INSERT INTO pedido(nombre_usuario,estado,fecha)VALUES(nombre_usuario,'n',CURRENT_TIMESTAMP);
	id=(select max(id_pedido) from pedido);
	RETURN id;
END
$BODY$
language plpgsql;

CREATE OR REPLACE FUNCTION insertarProductoapedido(
	nombre_producto_p VARCHAR(50),
	id_pedido_p VARCHAR(50),
	cantidad_p VARCHAR(50)
	)
RETURNS VOID AS
$BODY$
BEGIN
	INSERT INTO pp(nombre_producto,id_pedido,cantidad)VALUES(nombre_producto_p,CAST(id_pedido_p AS INT),CAST(cantidad_p AS INT));
END
$BODY$
language plpgsql;

SELECT * FROM productos
SELECT insertarProductoapedido('Pizza suprema grande','1','3')
SELECT * FROM PP
SELECT * FROM pedido
SELECT insertarPedido('landresf12')
---Pruebas

SELECT agregarProducto('Pizza Hawaiana mediana','5000',1,'Pizzas medianas');
SELECT agregarProducto('Pizza peperoni mediana','5000','1','Pizzas medianas');
SELECT agregarProducto('Pizza suprema mediana','5000','1','Pizzas medianas');

SELECT agregarProducto('Pizza Hawaiana pequeña','3500','1','Pizzas pequeñas');
SELECT agregarProducto('Pizza peperoni pequeña','3500','1','Pizzas pequeñas');
SELECT agregarProducto('Pizza suprema pequeña','3500','1','Pizzas pequeñas');

SELECT agregarProducto('Pizza Hawaiana grande','7500','1','Pizzas grandes');
SELECT agregarProducto('Pizza peperoni grande','7500','1','Pizzas grandes');
SELECT agregarProducto('Pizza suprema grande','7500','1','Pizzas grandes');

SELECT * FROM categorias
SELECT * FROM productos

--Simulacion de un pedido

SELECT insertarPedido('landresf12','n','23-11-2017 00:00:00')
INSERT INTO PP VALUES('Pizza suprema grande','1','3');
INSERT INTO PP VALUES('Pizza suprema mediana','1','3');

INSERT INTO PP VALUES('Pizza peperoni grande','2','3');
INSERT INTO PP VALUES('Pizza suprema mediana','2','3');

SELECT pp.nombre_producto,pp.cantidad,pp.cantidad*p.precio  AS total,p.nombre_categoria FROM PP as pp inner join productos as p on pp.id_pedido='1' and p.nombre_producto=pp.nombre_producto  


SELECT * FROM PP
SELECT * FROM pedido

SELECT * FROM productos WHERE nombre_categoria='Pizzas pequeñas' and estado='1'

SELECT * FROM productos

SELECT * FROM categorias
SELECT insertarPedido('landresf12','n','22-11-2017 00:00:00')
SELECT * FROM pedido where estado='n'
select insertarCliente('landresf12','Andres','Fernandez','Calderon','Piedades Sur','San Ramon','Alajuela','Residencias TEC San Carlos','12345');
SELECT * FROM Comprador
SELECT insertarAdministrador('yerlin96','Yerlin','Ramirez','Chavarria','Santiago','San Ramon','Alajuela','Balboa','12345','Gerente');
SELECT * FROM Administrador
SELECT count(*) as counta FROM administrador as a inner join clientes as c on a.nombre_usuario='yerlin9' and c.contrasena='12345'
SELECT count(*) as counta FROM comprador as a inner join clientes as c on a.nombre_usuario='landresf1' and c.contrasena='12345'


