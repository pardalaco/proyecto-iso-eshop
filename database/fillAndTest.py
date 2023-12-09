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
			VALUES ('admin', 'Admin', 'Admin2', 'adminCard', 'AdminAddress', 'admin', 1);
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