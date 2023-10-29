import sqlite3

connection = sqlite3.connect('isoDB.db')
cursor = connection.cursor()

#Reset state of tables
cursor.execute(
	'''
        DROP TABLE IF EXISTS Cliente;
    '''
)
cursor.execute(
	'''
        DROP TABLE IF EXISTS Producto;
    '''
)
cursor.execute(
	'''
        DROP TABLE IF EXISTS Clasificacion;
    '''
)

cursor.execute(
	'''
        DROP TABLE IF EXISTS Tag;
    '''
)

#DB table structure definition
cursor.execute(
    '''
	    CREATE TABLE Cliente (
            email VARCHAR(40) NOT NULL,
            nombre VARCHAR(45) NULL,
            apellidos VARCHAR(70) NULL,
            pwd VARCHAR(45) NOT NULL,
            direccion VARCHAR(45) NULL,
            tarjeta VARCHAR(45) NULL,
            admin TINYINT NULL DEFAULT 0,
            PRIMARY KEY (email)
	    ) WITHOUT ROWID;
    '''
)
cursor.execute(
    '''
	    CREATE TABLE Producto (
            id INT NOT NULL,
            nombre VARCHAR(45) NULL,
            descripcion VARCHAR(100) NULL,
            imagen VARCHAR(80) NULL,
            precio DECIMAL(7,2) NULL,
            PRIMARY KEY (id)
	    );
    '''
)
cursor.execute(
    '''
	    CREATE TABLE Tag (
            id INT NOT NULL,
            nombre VARCHAR(45) NOT NULL UNIQUE,
            PRIMARY KEY (id)
        );
    '''
)
cursor.execute(
    '''
	    CREATE TABLE Clasificacion (
            idProducto INT NOT NULL,
            idTag INT NOT NULL,
            PRIMARY KEY (idProducto, idTag ),
            FOREIGN KEY (idProducto)
                REFERENCES Producto (id)
                    ON DELETE CASCADE
                    ON UPDATE CASCADE,
            FOREIGN KEY (idTag)
                REFERENCES Tag (id)
                    ON DELETE CASCADE
                    ON UPDATE CASCADE
	    ) WITHOUT ROWID;
    '''
)


#adding clients
cursor.execute(
	'''
	    INSERT INTO cliente (email, nombre, apellidos, pwd, direccion, tarjeta, admin) 
	    VALUES  ('hmongom@gmail.com', 'Hiram', 'Montejano', 'hmongom', 'direccionHiram', 'tarjetaHiram', 1),
		    	('drovmar@gmail.com', 'Daniel', 'Rovira', 'drovmar', 'direccionDani', 'tarjetaDaniel', 1),
                ('psegmar1@gmail.com', 'Pablo', 'Segovia', 'psegmar1', 'direccionPablo', 'tarjetaPablo', 1),
		    	('jsanver@gmail.com', 'Joan', 'Sanchez', 'jsanver', 'direccionJoan', 'tarjetaJoan', 1),
                ('test@gmail.com', 'test', 'testApellido', 'test', 'direccionTest', 'tarjetaTest', 0);
	'''
)

#adding products
cursor.execute(
	'''
	    INSERT INTO Producto 
	    VALUES 	(1, 'iPhone 12', 'Movil que funciona de maravilla pero radioactivo', '/imagenes/iPhone12', 799.99),
			    (2, 'Air Jordan Zoom', 'Zapatillas para saltar mucho', '/imagenes/Jordan', 180.00),
			    (3, 'Cuchillo de carne', 'Cuchillo muy afilado', '/imagenes/cuchillo', 80.00),
                (4, 'Apple Watch 7', 'Reloj que hace muchas cosas', '/imagenes/appleWatch7', 439.95);     
    '''
)

#adding tags
cursor.execute(
	'''
	    INSERT INTO tag
	    VALUES 	(1, 'tecnologia'),
			    (2, 'ropa'),
                (3, 'cocina'),
			    (4, 'libros'),
                (5, 'moto'),
			    (6, 'cascos');
	'''
)

cursor.execute(
    '''
	    INSERT INTO clasificacion
	    VALUES	(1, 1),
		    	(2, 2),
                (3, 3),
			    (4, 1),
                (4, 2);
	'''
)
connection.commit()
print("Ejecución con éxito.")