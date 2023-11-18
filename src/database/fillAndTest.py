import sqlite3

#Set connection
connection = sqlite3.connect('isoDB.db')
cursor = connection.cursor()
cursor.execute('''PRAGMA foreign_keys = ON;''')

#adding clients
cursor.execute(
	'''
	    INSERT INTO cliente (email, nombre, apellidos, pwd, admin) 
	    VALUES  ('hmongom@gmail.com', 'Hiram', 'Montejano', 'hmongom', 1),
		    	('drovmar@gmail.com', 'Daniel', 'Rovira', 'drovmar', 1),
                ('psegmar1@gmail.com', 'Pablo', 'Segovia', 'psegmar1', 1),
		    	('jsanver@gmail.com', 'Joan', 'Sanchez', 'jsanver', 1),
                ('test@gmail.com', 'test', 'testApellido', 'test', 0);
	'''
)

cursor.execute(
	'''
	    INSERT INTO cliente (email, pwd, admin) 
	    VALUES  ('hmongom5@gmail.com', 'hmongom', 1);
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
	    VALUES 	('tecnologia'),
			    ('ropa'),
                ('cocina'),
			    ('libros'),
                ('moto'),
			    ('cascos');
	'''
)

cursor.execute(
    '''
	    INSERT INTO clasificacion
	    VALUES	(1, 'tecnologia'),
		    	(2, 'ropa'),
                (3, 'cocina'),
			    (4, 'tecnologia'),
                (4, 'ropa');
	'''
)

cursor.execute(
    '''
	    INSERT INTO Direccion
	    VALUES	('jsanver@gmail.com', 'Alcoy'),
		        ('jsanver@gmail.com', 'Narnia del norte'),
		    	('hmongom@gmail.com', 'Xativa'),
                ('psegmar1@gmail.com', 'Ontenyent'),
			    ('drovmar@gmail.com', 'Narnia');
	'''
)
cursor.execute(
    '''
	    INSERT INTO Tarjeta
	    VALUES	('jsanver@gmail.com', '123213123123', 'Tarjeta 1'),
		        ('jsanver@gmail.com', 'diferente', 'Tarjeta 2'),
		    	('hmongom@gmail.com', '1234', 'Tarjeta 1'),
                ('psegmar1@gmail.com', '1234', 'Tarjeta 1'),
			    ('drovmar@gmail.com', '4444', 'Tarjeta 1');
	'''
)

cursor.execute(
    '''
	    INSERT INTO Carrito (id, email)
	    VALUES	(1, 'jsanver@gmail.com'),
		    	(2, 'hmongom@gmail.com'),
                (3, 'psegmar1@gmail.com'),
			    (4, 'drovmar@gmail.com');
	'''
)
cursor.execute(
    '''
	    INSERT INTO Contiene 
	    VALUES	(1, 1, 3),
		    	(2, 2, 1),
		    	(2, 1, 1),
				(1, 2, 1),
				(1, 4, 1),
				(3, 4, 1);
	'''
)
cursor.execute(
    '''
	    INSERT INTO Pedido 
	    VALUES	(1, 'jsanver@gmail.com', 'direccion1', 'Tarjeta 2', 23.0, 'Preparado');
	'''
)

cursor.execute(
    '''    
        SELECT *
        FROM Pedido;
    '''
)
data = cursor.fetchall()
print("Contenido de los Pedidos del sistema:")
for row in data:
	print(row)

print("\n")
cursor.execute(
    '''
	DELETE FROM Cliente WHERE email='jsanver@gmail.com';
	'''
)

connection.commit()



print("\n")
cursor.execute(
    '''    
        SELECT *
        FROM Pedido;
    '''
)
data = cursor.fetchall()
print("Contenido de los Pedidos del sistema:")
for row in data:
	print(row)

print("\n")
cursor.execute(
    '''    
        SELECT *
        FROM Contiene;
    '''
)
data = cursor.fetchall()
print("Contenido de los carritos del sistema:")
for row in data:
	print(row)



print("\n")
cursor.execute(
    '''    
        SELECT *
        FROM Carrito;
    '''
)
data = cursor.fetchall()
print("Contenido de los carritos del sistema:")
for row in data:
	print(row)


connection.close()