
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
	FOREIGN KEY  (nombre_usuario) REFERENCES clientes (nombre_usuario)
);

----tabla del administrador 

CREATE  TABLE administrador (

	nombre_usuario VARCHAR(50) NOT NULL,
	id_administrador SERIAL NOT NULL,
	puesto VARCHAR(30) NOT NULL,

	PRIMARY KEY (nombre_usuario),
	FOREIGN KEY  (nombre_usuario) REFERENCES clientes (nombre_usuario)
);

----tabla de los productos
CREATE  TABLE productos (

	nombre_producto VARCHAR(50) NOT NULL,
	precio MONEY NOT NULL,
	estado INT NOT NULL,

	PRIMARY KEY (nombre_producto)
);


----tabla de las categorias
CREATE  TABLE categorias (
	
	nombre_categoria VARCHAR(50) NOT NULL,  
	PRIMARY KEY (nombre_categoria)
);


----tabla de los pedidos
CREATE  TABLE pedido(

	id_pedido SERIAL NOT NULL,
	estado CHAR(1) NOT NULL,
	fecha DATE NOT NULL,
	nombre_usuario VARCHAR(50) NOT NULL,
    
	PRIMARY KEY (id_pedido),
	FOREIGN KEY  (nombre_usuario) REFERENCES comprador (nombre_usuario)
);


----tabla del administrador y comprador
CREATE TABLE AC (

    nombre_usuario VARCHAR(50) NOT NULL,
    nombre_categoria VARCHAR(50) NOT NULL,
	
	PRIMARY KEY (nombre_usuario),
	FOREIGN KEY  (nombre_usuario) REFERENCES administrador (nombre_usuario),
	FOREIGN KEY  (nombre_categoria) REFERENCES categorias (nombre_categoria)
);

----tabla del administrador y del pedido
CREATE  TABLE AP (

	id_pedido SERIAL NOT NULL,
	nombre_usuario VARCHAR(50) NOT NULL,

	FOREIGN KEY  (id_pedido) REFERENCES pedido (id_pedido),
	FOREIGN KEY  (nombre_usuario) REFERENCES administrador (nombre_usuario)
);	

----tabla entre pedidp y producto
CREATE  TABLE PP (

	nombre_producto VARCHAR(50) NOT NULL,
	id_pedido SERIAL NOT NULL,
	cantidad INT NOT NULL,

	FOREIGN KEY  (nombre_producto) REFERENCES productos (nombre_producto),
	FOREIGN KEY  (id_pedido) REFERENCES pedido (id_pedido)
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
	
	insert into clientes values (nombre_usuario, nombre, apellido1,apellido2, distrito, canton, provincia, detalle, contrasena);

END
$BODY$
language plpgsql;
