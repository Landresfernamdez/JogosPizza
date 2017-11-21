
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

----tabla entre pedidp y producto
CREATE  TABLE PP (
	nombre_producto VARCHAR(50) NOT NULL,
	id_pedido SERIAL NOT NULL,
	cantidad INT NOT NULL,
	CONSTRAINT FK_nombre_producto_producto_pedido FOREIGN KEY  (nombre_producto) REFERENCES productos (nombre_producto),
	CONSTRAINT FK_id_pedido_pedido_producto FOREIGN KEY  (id_pedido) REFERENCES pedido (id_pedido)
);

	
create or replace function agregarProducto(
	nombre_pedido varchar(50),
	precio money,
	estado int
)

RETURNS VOID as
$BODY$
BEGIN
	
	insert into producto values(nombre_pedido,precio,estado);	

END
$BODY$
language plpgsql;

		
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
---Pruebas

select insertarCliente('landresf12','Andres','Fernandez','Calderon','Piedades Sur','San Ramon','Alajuela','Residencias TEC San Carlos','12345');
SELECT * FROM Comprador

SELECT insertarAdministrador('yerlin96','Yerlin','Ramirez','Chavarria','Santiago','San Ramon','Alajuela','Balboa','12345','Gerente');


SELECT * FROM Administrador

SELECT count(*) as counta FROM administrador as a inner join clientes as c on a.nombre_usuario='yerlin96' and c.contrasena='12345'
SELECT count(*) as counta FROM comprador as a inner join clientes as c on a.nombre_usuario='landresf12' and c.contrasena='12345'



