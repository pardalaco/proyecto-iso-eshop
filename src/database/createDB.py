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
        DROP TABLE IF EXISTS LineaPedido;
    '''
)
cursor.execute(
	'''
        DROP TABLE IF EXISTS Pedido;
    '''
)
cursor.execute(
	'''
        DROP TABLE IF EXISTS Tag;
    '''
)
cursor.execute(
	'''
        DROP TABLE IF EXISTS Feedback;
    '''
)
cursor.execute(
	'''
        DROP TABLE IF EXISTS Marketing;
    '''
)

#DB table structure definition
cursor.execute(
    '''
	    CREATE TABLE Cliente (
            email VARCHAR(40) NOT NULL,
            nombre VARCHAR(45) NULL DEFAULT 'Mr',
            apellidos VARCHAR(70) NULL DEFAULT 'Robberino',
            tarjeta VARCHAR(45) NULL,
            direccion VARCHAR(45) NULL,
            pwd VARCHAR(45) NOT NULL,
            admin TINYINT NOT NULL DEFAULT 0,
            PRIMARY KEY (email)
	    ) WITHOUT ROWID;
    '''
)
cursor.execute(
    '''
	    CREATE TABLE Carrito (
            ROWID INTEGER NOT NULL,
            email VARCHAR(40) NOT NULL,
            nombre VARCHAR(40) NOT NULL Default 'Carrito',
            total DECIMAL(7,2) NOT NULL DEFAULT 0.0,
            PRIMARY KEY (ROWID),
            FOREIGN KEY (email)
                REFERENCES Cliente (email)
                    ON DELETE CASCADE
                    ON UPDATE CASCADE
	    );
    '''
)
cursor.execute(
    '''
	    CREATE TABLE Contiene (
            idCarrito INT NOT NULL,
            idProducto INT NOT NULL,
            cantidad INT NOT NULL DEFAULT 1,
            PRIMARY KEY (idCarrito, idProducto),
            FOREIGN KEY (idCarrito)
                REFERENCES Carrito (ROWID)
                    ON DELETE CASCADE
                    ON UPDATE CASCADE,
            FOREIGN KEY (idProducto)
                REFERENCES Producto (ROWID)
                    ON DELETE CASCADE
                    ON UPDATE CASCADE
	    ) WITHOUT ROWID;
    '''
)
cursor.execute(
    '''
	    CREATE TABLE Producto (
            ROWID INTEGER NOT NULL,
            nombre VARCHAR(45) NOT NULL,
            descripcion VARCHAR(100) NOT NULL,
            imagen VARCHAR(80) NOT NULL,
            precio DECIMAL(7,2) NOT NULL,
            rating DECIMAL NOT NULL DEFAULT 0,
            contRating INT NOT NULL DEFAULT 0,
            PRIMARY KEY (ROWID)
	    );
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
            tag VARHCAR(45) NOT NULL,
            PRIMARY KEY (idProducto, tag),
            FOREIGN KEY (idProducto)
                REFERENCES Producto (ROWID)
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
	    CREATE TABLE Pedido (
            ROWID INTEGER NOT NULL,
            email VARCHAR(40),
            direccion VARCHAR(45) NOT NULL,
            tarjeta VARCHAR(45) NOT NULL,
            fecha VARCHAR(20) NOT NULL,
            total DECIMAL(7,2) NOT NULL,
            estado VARCHAR(20) NOT NULL DEFAULT 'Invoiced',
            PRIMARY KEY (ROWID),
            FOREIGN KEY (email)
                REFERENCES Cliente (email)
                    ON DELETE SET NULL
                    ON UPDATE CASCADE
	    );
    '''
)
cursor.execute(
    '''
	    CREATE TABLE LineaPedido (
            idPedido INT NOT NULL,
            nombre VARCHAR(45) NOT NULL,
            idProducto INT,
            cantidad INT NOT NULL,
            PRIMARY KEY (idPedido, nombre),
            FOREIGN KEY (idPedido)
                REFERENCES Pedido (ROWID)
                    ON DELETE CASCADE
                    ON UPDATE CASCADE
            FOREIGN KEY (idProducto)
                REFERENCES Producto (ROWID)
                    ON DELETE SET NULL
                    ON UPDATE CASCADE
	    ) WITHOUT ROWID;
    '''
)
cursor.execute(
    '''
	    CREATE TABLE Feedback (
            email VARCHAR(40) NOT NULL,
            idProducto INT NOT NULL,
            rating INT NOT NULL,
            comentario VARCHAR(100) NULL,
            PRIMARY KEY (email, idProducto),
            FOREIGN KEY (email)
                REFERENCES Cliente (email)
                    ON DELETE CASCADE
                    ON UPDATE CASCADE,
            FOREIGN KEY (idProducto)
                REFERENCES Producto (ROWID)
                    ON DELETE CASCADE
                    ON UPDATE CASCADE
	    ) WITHOUT ROWID;
    '''
)
cursor.execute(
    '''
	    CREATE TABLE Marketing (
            email VARCHAR(40) NOT NULL,
            tag VARCHAR(45) NOT NULL,
            peso DECIMAL(7,2) NOT NULL DEFAULT 0.5,
            contador INT NOT NULL,
            PRIMARY KEY (email, tag),
            FOREIGN KEY (email)
                REFERENCES Cliente (email)
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