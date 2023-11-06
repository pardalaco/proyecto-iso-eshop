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
	    VALUES	('jsanver@gmail.com', '123213123123'),
		        ('jsanver@gmail.com', 'diferente'),
		    	('hmongom@gmail.com', '1234'),
                ('psegmar1@gmail.com', '1234'),
			    ('drovmar@gmail.com', '4444');
	'''
)

cursor.execute(
    '''
	    INSERT INTO Carrito (email)
	    VALUES	('jsanver@gmail.com'),
		    	('hmongom@gmail.com'),
                ('psegmar1@gmail.com'),
			    ('drovmar@gmail.com');
	'''
)
cursor.execute(
    '''
	    INSERT INTO Contiene 
	    VALUES	('jsanver@gmail.com', 1, 3),
		    	('hmongom@gmail.com', 2, 1),
		    	('hmongom@gmail.com', 1, 1),
				('jsanver@gmail.com', 2, 1),
				('jsanver@gmail.com', 4, 1),
				('psegmar1@gmail.com', 4, 1);
	'''
)
connection.commit()



#Testing
cursor.execute(
    '''    
        SELECT producto.id, producto.nombre, producto.descripcion, producto.imagen, producto.precio, tag.nombre
        FROM producto, clasificacion, tag
        WHERE producto.id = clasificacion.idProducto AND clasificacion.tag = tag.nombre
	        AND tag.nombre = 'tecnologia';
    '''
)
data = cursor.fetchall()
print("Productos con tag tecnologia:")
for row in data:
	print(row)
'''
Debe devolver:
Productos con tag tecnologia:
(1, 'iPhone 12', 'Movil que funciona de maravilla pero radioactivo', '/imagenes/iPhone12', 799.99, 'tecnologia')
(4, 'Apple Watch 7', 'Reloj que hace muchas cosas', '/imagenes/appleWatch7', 439.95, 'tecnologia')
'''
	
print("\n")
cursor.execute(
    '''    
        SELECT *
        FROM cliente;
    '''
)
data = cursor.fetchall()
print("Clientes del sistema:")
for row in data:
	print(row)
'''
Debe devolver: 
Clientes del sistema:
('drovmar@gmail.com', 'Daniel', 'Rovira', 'drovmar', 1)
('hmongom5@gmail.com', 'Mr', 'Robberino', 'hmongom', 1)
('hmongom@gmail.com', 'Hiram', 'Montejano', 'hmongom', 1)
('jsanver@gmail.com', 'Joan', 'Sanchez', 'jsanver', 1)
('psegmar1@gmail.com', 'Pablo', 'Segovia', 'psegmar1', 1)
('test@gmail.com', 'test', 'testApellido', 'test', 0)
'''

print("\n")
cursor.execute(
    '''    
        SELECT *
        FROM Direccion;
    '''
)
data = cursor.fetchall()
print("Direcciones del sistema:")
for row in data:
	print(row)
'''
Debe devolver: 
Direcciones del sistema:
('drovmar@gmail.com', 'Narnia')
('hmongom@gmail.com', 'Xativa')
('jsanver@gmail.com', 'Alcoy')
('jsanver@gmail.com', 'Narnia del norte')
('psegmar1@gmail.com', 'Ontenyent')
'''
print("\n")
cursor.execute(
    '''    
        SELECT *
        FROM Tarjeta;
    '''
)
data = cursor.fetchall()
print("Tarjetas del sistema:")
for row in data:
	print(row)
'''
Debe devolver: 
Tarjetas del sistema:
('drovmar@gmail.com', '4444')
('hmongom@gmail.com', '1234')
('jsanver@gmail.com', '123213123123')
('jsanver@gmail.com', 'diferente')
('psegmar1@gmail.com', '1234')
'''

print("\n")
cursor.execute(
    '''    
        SELECT *
        FROM Carrito;
    '''
)
data = cursor.fetchall()
print("Carritos del sistema:")
for row in data:
	print(row)
'''
Debe devolver: 
Carritos del sistema:
('drovmar@gmail.com', 0)
('hmongom@gmail.com', 0)
('jsanver@gmail.com', 0)
('psegmar1@gmail.com', 0)
'''

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
'''
Debe devolver: 
Contenido de los carritos del sistema:
('hmongom@gmail.com', 2, 1)
('jsanver@gmail.com', 1, 1)
('jsanver@gmail.com', 2, 3)
('psegmar1@gmail.com', 4, 1)
'''

print("\n")
cursor.execute(
    '''    
        SELECT *
        FROM Tag;
    '''
)
data = cursor.fetchall()
print("Tags del sistema:")
for row in data:
	print(row)
'''
Debe devolver: 
Tags del sistema:
('cascos',)
('cocina',)
('libros',)
('moto',)
('ropa',)
('tecnologia',)
'''

connection.close()