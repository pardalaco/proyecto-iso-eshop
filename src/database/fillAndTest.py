import sqlite3

###############################################################################

#Conection

###############################################################################
connection = sqlite3.connect('isoDB.db')
cursor = connection.cursor()
cursor.execute('''PRAGMA foreign_keys = ON;''')
###############################################################################

#INSERTIONS

###############################################################################
#Adding Clients
cursor.execute(
	'''
	    INSERT INTO Cliente (email, nombre, apellidos, tarjeta, direccion, pwd, admin) 
		VALUES 
			('usuario1@example.com', 'Juan', 'González', '1234567890123456', 'Calle 123', 'contrasena1', 0),
    		('usuario2@example.com', 'María', 'López', '9876543210987654', 'Avenida 456', 'contrasena2', 0),
    		('usuario3@example.com', 'Carlos', 'Martínez', '1111222233334444', 'Plaza Principal', 'contrasena3', 0),
    		('usuario4@example.com', 'Laura', 'Rodríguez', '5555666677778888', 'Carretera 789', 'contrasena4', 0),
   			('admin@example.com', 'Admin', 'Admin', '9999000011112222', 'Admin Address', 'admincontrasena', 1);
	'''
)
###############################################################################


###############################################################################
#Adding Products
cursor.execute(
	'''
		INSERT INTO Producto (nombre, descripcion, imagen, precio) 
			VALUES 	('Smartphone Samsung Galaxy S21', 'Teléfono inteligente con cámara de alta resolución y pantalla AMOLED.', 'samsung-galaxy-s21.jpg', 899.99),
    				('Portátil HP Pavilion', 'Ordenador portátil con procesador Intel Core i5 y pantalla Full HD de 15.6 pulgadas.', 'hp-pavilion-laptop.jpg', 799.00),
    				('Zapatillas Adidas Ultraboost', 'Zapatillas deportivas con tecnología de amortiguación Boost para mayor comodidad.', 'adidas-ultraboost.jpg', 149.99),
    				('Libro: "El Nombre del Viento" - Patrick Rothfuss', 'Famosa novela de fantasía sobre las aventuras de Kvothe.', 'el-nombre-del-viento.jpg', 17.50),
    				('Cámara Canon EOS Rebel T7', 'Cámara réflex digital con sensor CMOS de 24.1 megapíxeles y video Full HD.', 'canon-eos-rebel-t7.jpg', 549.00),
    				('Smart TV LG OLED C1', 'Televisor inteligente con tecnología OLED y resolución 4K.', 'lg-oled-c1-tv.jpg', 1499.99),
    				('Silla de Oficina Ergonómica', 'Silla ajustable con soporte lumbar para mayor comodidad durante largas horas de trabajo.', 'silla-ergonomica.jpg', 199.00),
    				('Frigorífico Samsung Side-by-Side', 'Refrigerador con dispensador de agua y capacidad de 600 litros.', 'samsung-side-by-side-fridge.jpg', 1899.00),
    				('Juego de Mesa: Catan', 'Juego estratégico de colonización y comercio para toda la familia.', 'catan-board-game.jpg', 49.99),
 	   				('Bicicleta de Montaña Trek', 'Bicicleta todo terreno con cuadro de aluminio y suspensiones delanteras.', 'trek-mountain-bike.jpg', 899.00),
    				('Altavoces Bluetooth JBL Flip 5', 'Altavoz portátil con batería de larga duración y resistente al agua.', 'jbl-flip-5-speakers.jpg', 129.99),
    				('Pelota de Fútbol Adidas', 'Pelota oficial de Adidas para partidos profesionales.', 'adidas-soccer-ball.jpg', 39.99),
    				('Cafetera Nespresso Vertuo', 'Máquina de café con tecnología de cápsulas para diferentes tamaños de taza.', 'nespresso-vertuo-coffee-maker.jpg', 249.00),
    				('Teclado mecánico Corsair K70', 'Teclado gaming con interruptores Cherry MX y retroiluminación RGB.', 'corsair-k70-keyboard.jpg', 149.00),
    				('Reloj de Pared Moderno', 'Reloj decorativo con diseño minimalista para el hogar.', 'modern-wall-clock.jpg', 29.99),
    				('Smartwatch Apple Watch Series 7', 'Reloj inteligente con pantalla retina y resistencia al agua.', 'apple-watch-series-7.jpg', 399.00);
	'''
)
###############################################################################


###############################################################################
#Adding Tags
cursor.execute(
	'''
		INSERT INTO Tag (nombre) 
			VALUES	('Tecnología'),
					('Electrónica'),
    				('Moda'),
    				('Hogar'),
    				('Deportes'),
    				('Libros'),
    				('Entretenimiento'),
    				('Cocina'),
    				('Juegos'),
    				('Belleza'),
    				('Herramientas'),
    				('Decoración');
	'''
)
###############################################################################


###############################################################################
#Adding Product-Tag Clasifications
cursor.execute(
	'''
		INSERT INTO Clasificacion (idProducto, tag) 
			VALUES	(1, 'Tecnología'), (1, 'Electrónica'),
    				(2, 'Tecnología'), (2, 'Electrónica'),
    				(3, 'Deportes'), (3, 'Moda'),
    				(4, 'Libros'), (4, 'Entretenimiento'),
    				(5, 'Tecnología'), (5, 'Electrónica'),
    				(6, 'Tecnología'), (6, 'Electrónica'), (6, 'Hogar'),
    				(7, 'Hogar'), (7, 'Herramientas'), (7, 'Decoración'),
    				(8, 'Hogar'), (8, 'Electrónica'), (8, 'Cocina'),
    				(9, 'Juegos'), (9, 'Entretenimiento'),
    				(10, 'Deportes'),
    				(11, 'Tecnología'), (11, 'Electrónica'), (11, 'Entretenimiento'),
    				(12, 'Deportes'),
    				(13, 'Cocina'), (13, 'Electrónica'),
    				(14, 'Tecnología'), (14, 'Electrónica'), (14, 'Herramientas'),
    				(15, 'Hogar'), (15, 'Decoración'),
    				(16, 'Tecnología'), (16, 'Electrónica'), (16, 'Entretenimiento');
	'''
)
###############################################################################


###############################################################################
#Adding Carts
cursor.execute(
    '''
	    INSERT INTO Carrito (email, nombre) 
			VALUES	('usuario1@example.com', 'Carrito de Compras Principal'),
       				('usuario1@example.com', 'Carrito de Ofertas Especiales'),
       				('usuario1@example.com', 'Lista de Deseos'),
	   				('usuario2@example.com', 'Compras Semanales'),
       				('usuario2@example.com', 'Carrito para Regalos'),
       				('usuario2@example.com', 'Favoritos de Tecnología'),
	   				('usuario3@example.com', 'Carrito de Moda'),
       				('usuario3@example.com', 'Lista de Regalos de Cumpleaños'),
       				('usuario3@example.com', 'Compras para el Hogar'),
       				('usuario4@example.com', 'Lista de Compras Mensuales'),
       				('usuario4@example.com', 'Carrito de Artículos para el Hogar'),
       				('usuario4@example.com', 'Carrito de Vacaciones');
	'''
)
###############################################################################


###############################################################################
#Adding Content to Carts
cursor.execute(
    '''
		INSERT INTO Contiene (idCarrito, idProducto, cantidad) 
			VALUES	(1, 4, 2), (1, 5, 3), 
    				(2, 7, 3), (2, 8, 2), (2, 9, 1),
    				(3, 10, 2), (3, 11, 1), 
    				(4, 13, 2), 
    				(5, 16, 1), (5, 1, 2), (5, 2, 1),
    				(6, 3, 3), 
    				(7, 6, 2), (7, 7, 1), (7, 8, 3),
    				(8, 9, 3), (8, 10, 2), 
    				(9, 12, 1), (9, 13, 2), (9, 14, 3),
    				(10, 15, 2), (10, 16, 1), 
    				(11, 2, 1), 
    				(12, 5, 1), (12, 6, 2), (12, 7, 3);
	'''
)
###############################################################################


###############################################################################
#Updating total cart value
cursor.execute(
    '''
		UPDATE Carrito
		SET total = (	
						SELECT SUM(precio * Contiene.cantidad)
    					FROM Contiene
    					JOIN Producto ON Contiene.idProducto = Producto.ROWID
    					WHERE Contiene.idCarrito = Carrito.ROWID
    					GROUP BY Contiene.idCarrito
		);		
	'''
)
###############################################################################


###############################################################################
#Adding Random Marketing status
cursor.execute(
    '''
		INSERT INTO Marketing (email, tag, peso, contador)
			VALUES	('usuario1@example.com', 'Cocina', 0.6, 4),
    				('usuario1@example.com', 'Decoración', 0.2, 9),
    				('usuario1@example.com', 'Deportes', 0.8, 2),
    				('usuario1@example.com', 'Electrónica', 0.4, 7),
    				('usuario1@example.com', 'Entretenimiento', 0.5, 6),
    				('usuario1@example.com', 'Herramientas', 0.7, 3),
    				('usuario2@example.com', 'Moda', 0.3, 8),
    				('usuario2@example.com', 'Libros', 0.9, 5),
    				('usuario2@example.com', 'Tecnología', 0.6, 1),
    				('usuario2@example.com', 'Hogar', 0.7, 10),
    				('usuario2@example.com', 'Juegos', 0.4, 6),
    				('usuario2@example.com', 'Entretenimiento', 0.2, 7),
    				('usuario3@example.com', 'Herramientas', 0.7, 5),
    				('usuario3@example.com', 'Cocina', 0.3, 8),
    				('usuario3@example.com', 'Deportes', 0.5, 3),
    				('usuario3@example.com', 'Decoración', 0.9, 10),
    				('usuario3@example.com', 'Entretenimiento', 0.2, 7),
    				('usuario3@example.com', 'Hogar', 0.6, 1),
    				('usuario4@example.com', 'Tecnología', 0.8, 6),
    				('usuario4@example.com', 'Juegos', 0.4, 9),
    				('usuario4@example.com', 'Libros', 0.6, 2),
    				('usuario4@example.com', 'Moda', 0.1, 4),
    				('usuario4@example.com', 'Electrónica', 0.9, 10),
    				('usuario4@example.com', 'Entretenimiento', 0.3, 5);	
	'''
)
###############################################################################


###############################################################################
#Adding Feedback to products
cursor.execute(
    '''
		INSERT INTO Feedback (email, idProducto, rating, comentario)
			VALUES	('usuario1@example.com', 3, 5, '¡Increíble, superó mis expectativas!'),
    				('usuario1@example.com', 7, 4, 'Buen producto, bastante satisfecho.'),
    				('usuario1@example.com', 11, 3, 'Cumple su función, podría mejorar.'),
    				('usuario1@example.com', 14, 2, 'No quedé satisfecho, esperaba más.'),
    				('usuario1@example.com', 16, 1, 'No lo recomendaría, mala calidad.'),
    				('usuario2@example.com', 2, 5, '¡Impresionante, funciona perfectamente!'),
    				('usuario2@example.com', 6, 4, 'Buen diseño, satisfecho con la compra.'),
    				('usuario2@example.com', 9, 3, 'Promedio, esperaba más por el precio.'),
    				('usuario2@example.com', 10, 2, 'No duró mucho, se rompió rápido.'),
    				('usuario2@example.com', 13, 1, 'Decepcionado, no cumplió mis expectativas.'),
    				('usuario3@example.com', 4, 5, '¡Sorprendente, mejor de lo esperado!'),
    				('usuario3@example.com', 8, 4, 'Buen rendimiento, lo recomendaría.'),
    				('usuario3@example.com', 12, 3, 'Aceptable, pero podría mejorar.'),
    				('usuario3@example.com', 15, 2, 'No quedé satisfecho, esperaba más.'),
    				('usuario3@example.com', 1, 1, 'Mala calidad, no lo recomendaría.'),
    				('usuario4@example.com', 5, 5, '¡Excelente, gran utilidad!'),
    				('usuario4@example.com', 16, 4, 'Bastante satisfecho, cumple lo esperado.'),
    				('usuario4@example.com', 10, 3, 'Normal, nada especial.'),
    				('usuario4@example.com', 9, 2, 'No duró mucho, se rompió rápidamente.'),
    				('usuario4@example.com', 7, 1, 'Decepcionado, no cumplió con mis necesidades.');
	'''
)
###############################################################################


###############################################################################
#Updating Product global rating
cursor.execute(
    '''
		UPDATE Producto
		SET rating = (
    					SELECT AVG(rating)
    					FROM Feedback
    					WHERE Feedback.idProducto = Producto.ROWID
		)
		WHERE ROWID IN (SELECT DISTINCT idProducto FROM Feedback);		
	'''
)
###############################################################################


###############################################################################
#Updating Product contRating
cursor.execute(
    '''
		UPDATE Producto
		SET contRating  = (
    						SELECT COUNT(rating)
    						FROM Feedback
    						WHERE Feedback.idProducto = Producto.ROWID
		)
		WHERE ROWID IN (SELECT DISTINCT idProducto FROM Feedback);	
	'''
)
connection.commit()
###############################################################################

#SELECTS

###############################################################################
#Select clients
cursor.execute(
    '''    
        SELECT *
        FROM Cliente;
    '''
)
data = cursor.fetchall()
print("Contenido de los Clientes del sistema:")
for row in data:
	print(row)
print("\n")
###############################################################################


###############################################################################
#Select Products
cursor.execute(
    '''    
        SELECT 
			p.ROWID AS product_id,
        	p.nombre AS product_name,
        	p.descripcion AS product_description,
        	p.imagen AS product_image,
        	p.precio AS product_price,
			p.rating,
			p.contRating,
        	GROUP_CONCAT(t.nombre) AS tags
		FROM Producto p
			LEFT JOIN Clasificacion c 
					ON p.ROWID = c.idProducto
			LEFT JOIN Tag t 
					ON c.tag = t.nombre
		GROUP BY p.ROWID, p.nombre, p.descripcion, p.imagen, p.precio
		ORDER BY p.ROWID;
    '''
)
data = cursor.fetchall()
print("Contenido de los Productos del sistema con sus tags:")
for row in data:
	print(row)
print("\n")
###############################################################################


###############################################################################
#Select Tags
cursor.execute(
    '''    
        SELECT nombre
        FROM Tag;
    '''
)
data = cursor.fetchall()
print("Tags del sistema:")
for row in data:
	print(row)


###############################################################################

#END

###############################################################################
connection.close()