import sqlite3

#Set connection
connection = sqlite3.connect('isoDB.db')
cursor = connection.cursor()
cursor.execute('''PRAGMA foreign_keys = ON;''')

#Reset state of tables
cursor.execute(
	'''
        DROP TABLE IF EXISTS User;
    '''
)
cursor.execute(
	'''
        DROP TABLE IF EXISTS Carrito;
    '''
)
cursor.execute(
	'''
        DROP TABLE IF EXISTS Contains;
    '''
)
cursor.execute(
	'''
        DROP TABLE IF EXISTS Product;
    '''
)
cursor.execute(
	'''
        DROP TABLE IF EXISTS Classification;
    '''
)
cursor.execute(
	'''
        DROP TABLE IF EXISTS ShopOrderLine;
    '''
)
cursor.execute(
	'''
        DROP TABLE IF EXISTS ShopOrder;
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
	    CREATE TABLE User (
            email VARCHAR(40) NOT NULL,
            name VARCHAR(45) NULL DEFAULT 'Mr',
            apellidos VARCHAR(70) NULL DEFAULT 'Robberino',
            payment VARCHAR(45) NULL,
            address VARCHAR(45) NULL,
            password VARCHAR(45) NOT NULL,
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
            name VARCHAR(40) NOT NULL Default 'Carrito',
            total DECIMAL(7,2) NOT NULL DEFAULT 0.0,
            PRIMARY KEY (ROWID),
            FOREIGN KEY (email)
                REFERENCES User (email)
                    ON DELETE CASCADE
                    ON UPDATE CASCADE
	    );
    '''
)
cursor.execute(
    '''
	    CREATE TABLE Contains (
            cart_id INT NOT NULL,
            product_id INT NOT NULL,
            quantity INT NOT NULL DEFAULT 1,
            PRIMARY KEY (cart_id, product_id),
            FOREIGN KEY (cart_id)
                REFERENCES Carrito (ROWID)
                    ON DELETE CASCADE
                    ON UPDATE CASCADE,
            FOREIGN KEY (product_id)
                REFERENCES Product (ROWID)
                    ON DELETE CASCADE
                    ON UPDATE CASCADE
	    ) WITHOUT ROWID;
    '''
)
cursor.execute(
    '''
	    CREATE TABLE Product (
            ROWID INTEGER NOT NULL,
            name VARCHAR(45) NOT NULL,
            description VARCHAR(100) NOT NULL,
            image VARCHAR(80) NOT NULL,
            price DECIMAL(7,2) NOT NULL,
            rating DECIMAL NOT NULL DEFAULT 0,
            rating_count INT NOT NULL DEFAULT 0,
            PRIMARY KEY (ROWID)
	    );
    '''
)
cursor.execute(
    '''
	    CREATE TABLE Tag (
            name VARCHAR(45) NOT NULL,
            PRIMARY KEY (name)
        ) WITHOUT ROWID;
    '''
)
cursor.execute(
    '''
	    CREATE TABLE Classification (
            product_id INT NOT NULL,
            tag VARHCAR(45) NOT NULL,
            PRIMARY KEY (product_id, tag),
            FOREIGN KEY (product_id)
                REFERENCES Product (ROWID)
                    ON DELETE CASCADE
                    ON UPDATE CASCADE,
            FOREIGN KEY (tag)
                REFERENCES Tag (name)
                    ON DELETE CASCADE
                    ON UPDATE CASCADE
	    ) WITHOUT ROWID;
    '''
)
cursor.execute(
    '''
	    CREATE TABLE ShopOrder (
            ROWID INTEGER NOT NULL,
            email VARCHAR(40),
            address VARCHAR(45) NOT NULL,
            payment VARCHAR(45) NOT NULL,
            date VARCHAR(20) NOT NULL,
            total DECIMAL(7,2) NOT NULL,
            status VARCHAR(20) NOT NULL DEFAULT 'Invoiced',
            PRIMARY KEY (ROWID),
            FOREIGN KEY (email)
                REFERENCES User (email)
                    ON DELETE SET NULL
                    ON UPDATE CASCADE
	    );
    '''
)
cursor.execute(
    '''
	    CREATE TABLE ShopOrderLine (
            order_id INT NOT NULL,
            name VARCHAR(45) NOT NULL,
            product_id INT,
            quantity INT NOT NULL,
            PRIMARY KEY (order_id, name),
            FOREIGN KEY (order_id)
                REFERENCES ShopOrder (ROWID)
                    ON DELETE CASCADE
                    ON UPDATE CASCADE
            FOREIGN KEY (product_id)
                REFERENCES Product (ROWID)
                    ON DELETE SET NULL
                    ON UPDATE CASCADE
	    ) WITHOUT ROWID;
    '''
)
cursor.execute(
    '''
	    CREATE TABLE Feedback (
            email VARCHAR(40) NOT NULL,
            product_id INT NOT NULL,
            rating INT NOT NULL,
            comment VARCHAR(100) NULL,
            date VARCHAR(20) NOT NULL,
            PRIMARY KEY (email, product_id),
            FOREIGN KEY (email)
                REFERENCES User (email)
                    ON DELETE CASCADE
                    ON UPDATE CASCADE,
            FOREIGN KEY (product_id)
                REFERENCES Product (ROWID)
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
            weight DECIMAL(7,2) NOT NULL DEFAULT 0.5 CHECK(weight >= 0 AND weight <= 1),
            counter INT NOT NULL,
            PRIMARY KEY (email, tag),
            FOREIGN KEY (email)
                REFERENCES User (email)
                    ON DELETE CASCADE
                    ON UPDATE CASCADE,
            FOREIGN KEY (tag)
                REFERENCES Tag (name)
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