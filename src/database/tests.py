import sqlite3

connection = sqlite3.connect('isoDB.db')
cursor = connection.cursor()


#Testing
cursor.execute(
    '''    
        SELECT producto.id, producto.nombre, producto.descripcion, producto.imagen, producto.precio, tag.nombre
        FROM producto, clasificacion, tag
        WHERE producto.id = clasificacion.idProducto AND clasificacion.idTag = tag.id
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
('drovmar@gmail.com', 'Daniel', 'Rovira', 'drovmar', 'direccionDani', 'tarjetaDaniel', 1)
('hmongom@gmail.com', 'Hiram', 'Montejano', 'hmongom', 'direccionHiram', 'tarjetaHiram', 1)
('jsanver@gmail.com', 'Joan', 'Sanchez', 'jsanver', 'direccionJoan', 'tarjetaJoan', 1)
('psegmar1@gmail.com', 'Pablo', 'Segovia', 'psegmar1', 'direccionPablo', 'tarjetaPablo', 1)
('test@gmail.com', 'test', 'testApellido', 'test', 'direccionTest', 'tarjetaTest', 0)
'''
