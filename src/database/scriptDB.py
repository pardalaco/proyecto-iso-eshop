import sqlite3

#Set connection
connection = sqlite3.connect('isoDB.db')
cursor = connection.cursor()
cursor.execute('''PRAGMA foreign_keys = ON;''')

#Reset state of tables
cursor.execute(
	'''
        DROP TABLE IF EXISTS Cliente;
    '''
)
cursor.execute(
	'''
        DROP TABLE IF EXISTS Direccion;
    '''
)
cursor.execute(
	'''
        DROP TABLE IF EXISTS Tarjeta;
    '''
)
cursor.execute(
	'''
        DROP TABLE IF EXISTS Carrito;
    '''
)
cursor.execute(
	'''
        DROP TABLE IF EXISTS Contiene;
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
            nombre VARCHAR(45) NULL DEFAULT 'Mr',
            apellidos VARCHAR(70) NULL DEFAULT 'Robberino',
            pwd VARCHAR(45) NOT NULL,
            admin TINYINT NULL DEFAULT 0,
            PRIMARY KEY (email)
	    ) WITHOUT ROWID;
    '''
)
cursor.execute(
    '''
	    CREATE TABLE Direccion (
            email VARCHAR(40) NOT NULL,
            direccion VARCHAR(45) NOT NULL,
            PRIMARY KEY (email, direccion),
            FOREIGN KEY (email)
                REFERENCES Cliente (email)
                    ON DELETE CASCADE
                    ON UPDATE CASCADE
	    ) WITHOUT ROWID;
    '''
)
cursor.execute(
    '''
	    CREATE TABLE Tarjeta (
            email VARCHAR(40) NOT NULL,
            tarjeta VARCHAR(45) NOT NULL,
            PRIMARY KEY (email, tarjeta),
            FOREIGN KEY (email)
                REFERENCES Cliente (email)
                    ON DELETE CASCADE
                    ON UPDATE CASCADE
	    ) WITHOUT ROWID;
    '''
)
cursor.execute(
    '''
	    CREATE TABLE Carrito (
            email VARCHAR(40) NOT NULL,
            total DECIMAL(7,2) NOT NULL DEFAULT 0.0,
            PRIMARY KEY (email),
            FOREIGN KEY (email)
                REFERENCES Cliente (email)
                    ON DELETE CASCADE
                    ON UPDATE CASCADE
	    ) WITHOUT ROWID;
    '''
)
cursor.execute(
    '''
	    CREATE TABLE Contiene (
            email VARCHAR(40) NOT NULL,
            idProducto INT NOT NULL,
            cantidad INT DEFAULT 1,
            PRIMARY KEY (email, idProducto),
            FOREIGN KEY (email)
                REFERENCES Carrito (email)
                    ON DELETE CASCADE
                    ON UPDATE CASCADE,
            FOREIGN KEY (idProducto)
                REFERENCES Producto (id)
                    ON DELETE CASCADE
                    ON UPDATE CASCADE
	    ) WITHOUT ROWID;
    '''
)
cursor.execute(
    '''
	    CREATE TABLE Producto (
            id INT NOT NULL,
            nombre VARCHAR(45) NOT NULL,
            descripcion VARCHAR(100) NOT NULL,
            imagen VARCHAR(80) NOT NULL,
            precio DECIMAL(7,2) NOT NULL,
            PRIMARY KEY (id)
	    ) WITHOUT ROWID;
    '''
)
cursor.execute(
    '''
	    CREATE TABLE Tag (
            nombre VARCHAR(45) NOT NULL,
            PRIMARY KEY (nombre)
        ) WITHOUT ROWID;
    '''
)
cursor.execute(
    '''
	    CREATE TABLE Clasificacion (
            idProducto INT NOT NULL,
            tag INT NOT NULL,
            PRIMARY KEY (idProducto, tag),
            FOREIGN KEY (idProducto)
                REFERENCES Producto (id)
                    ON DELETE CASCADE
                    ON UPDATE CASCADE,
            FOREIGN KEY (tag)
                REFERENCES Tag (nombre)
                    ON DELETE CASCADE
                    ON UPDATE CASCADE
	    ) WITHOUT ROWID;
    '''
)

cursor.execute(
    '''
	    DROP TRIGGER IF EXISTS TOTAL_CARRITO;
    '''
)
connection.close()
print("Ejecución con éxito.")