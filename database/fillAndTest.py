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
	    INSERT INTO User (email, name, apellidos, payment, address, password, admin) 
			VALUES ('admin', 'Admin', 'Admin2', 'adminCard', 'AdminAddress', 'admin', 1);
	'''
)
###############################################################################


###############################################################################
#Adding Products
cursor.execute(
	'''
		INSERT INTO Product (name, description, image, price) 
			VALUES 	('Smartphone Samsung Galaxy S21', 'Teléfono inteligente con cámara de alta resolución y pantalla AMOLED.', 'samsung-galaxy-s21.jpg', 899.99),
    				('Portátil HP Pavilion', 'Ordenador portátil con procesador Intel Core i5 y pantalla Full HD de 15.6 pulgadas.', 'hp-pavilion-laptop.jpg', 799.00),
    				('Zapatillas Adidas Ultraboost', 'Zapatillas deportivas con tecnología de amortiguación Boost para mayor comodidad.', 'adidas-ultraboost.jpg', 149.99),
    				('Libro: "El name del Viento" - Patrick Rothfuss', 'Famosa novela de fantasía sobre las aventuras de Kvothe.', 'el-name-del-viento.jpg', 17.50),
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
		INSERT INTO Tag (name) 
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
		INSERT INTO Classification (product_id, tag) 
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
#Adding Default admin Marketing Tags
cursor.execute(
	'''
		INSERT INTO Marketing (email, tag, weight, counter)
			VALUES 	('admin', 'Libros', 0.5, 1),
							('admin', 'Hogar', 0.5, 1),
							('admin', 'Decoración', 0.5, 1);
	'''
)
###############################################################################


###############################################################################
#Adding Filler Users
cursor.execute(
	'''
	INSERT INTO User (email, name, payment, address, password, admin) 
VALUES 
    ('gatitolindosexy69@hotmail.es', 'Juan González', '1234567890123456', 'Calle 123', 'contrasena1', 0),
    ('pedro_el_bayas33@gmail.com', 'María López', '9876543210987654', 'Avenida 456', 'contrasena2', 0),
    ('atencionalclientegrupocorreos@correos.com', 'Carlos Martínez', '1111222233334444', 'Plaza Principal', 'contrasena3', 0),
    ('jesustocristo@cocacolazero.rg', 'Jesus Cristo', '5555666677778888', 'Belén 789', 'contrasena4', 0);
	'''
)
###############################################################################


###############################################################################
#Adding Filler Ratings
cursor.execute(
    '''
		INSERT INTO Feedback (email, product_id, rating, comment, date)
			VALUES	('gatitolindosexy69@hotmail.es', 13, 5, '¡Increíble, superó mis expectativas!', '10/09/2012'),
    				('gatitolindosexy69@hotmail.es', 12, 4, 'Buen Product, bastante satisfecho.', '12/01/2020'),
    				('gatitolindosexy69@hotmail.es', 3, 3, 'Cumple su función, podría mejorar.', '01/05/2021'),
    				('gatitolindosexy69@hotmail.es', 8, 2, 'No quedé satisfecho, esperaba más.', '10/03/2012'),
    				('gatitolindosexy69@hotmail.es', 2, 1, 'No lo recomendaría, mala calidad.', '23/12/2012'),
    				('pedro_el_bayas33@gmail.com', 2, 5, '¡Impresionante, funciona perfectamente!', '03/12/2012'),
    				('pedro_el_bayas33@gmail.com', 3, 4, 'Buen diseño, satisfecho con la compra.', '02/20/2011'),
    				('pedro_el_bayas33@gmail.com', 9, 3, 'Promedio, esperaba más por el precio.', '01/20/2019'),
    				('pedro_el_bayas33@gmail.com', 1, 2, 'No duró mucho, se rompió rápido.', '10/02/2000'),
    				('pedro_el_bayas33@gmail.com', 5, 1, 'Decepcionado, no cumplió mis expectativas.', '10/02/2003'),
    				('atencionalclientegrupocorreos@correos.com', 4, 5, '¡Sorprendente, mejor de lo esperado!', '10/01/2010'),
    				('atencionalclientegrupocorreos@correos.com', 8, 4, 'Buen rendimiento, lo recomendaría.', '17/02/1984'),
    				('atencionalclientegrupocorreos@correos.com', 12, 3, 'Aceptable, pero podría mejorar.', '20/20/2020'),
    				('atencionalclientegrupocorreos@correos.com', 9, 2, 'No quedé satisfecho, esperaba más.', '10/10/2013'),
    				('atencionalclientegrupocorreos@correos.com', 2, 1, 'Mala calidad, no lo recomendaría.', '01/09/2010'),
    				('jesustocristo@cocacolazero.rg', 16, 5, '¡Excelente, gran utilidad!', '10/13/777'),
    				('jesustocristo@cocacolazero.rg', 11, 4, 'Bastante satisfecho, cumple lo esperado.', '1/11/2'),
    				('jesustocristo@cocacolazero.rg', 4, 3, 'Normal, nada especial.', '29/04/-56'),
    				('jesustocristo@cocacolazero.rg', 2, 2, 'Se sobrecalenta demasiado, cada 2x3 tengo que meterlo en el frigorífico, y eso que aun no se ha inventado!', '01/01/117'),
    				('jesustocristo@cocacolazero.rg', 8, 1, 'Decepcionado, no cumplió con mis necesidades.', '10/02/1021');					
	'''
)
###############################################################################


###############################################################################
#Updating Product global rating
cursor.execute(
    '''
        UPDATE Product
        SET rating = (
                        SELECT AVG(rating)
                        FROM Feedback
                        WHERE Feedback.product_id = Product.ROWID
        )
        WHERE ROWID IN (SELECT DISTINCT product_id FROM Feedback);
    '''
)
###############################################################################


###############################################################################
#Updating Product global rating
cursor.execute(
    '''
        UPDATE Product
        SET rating = (
                        SELECT AVG(rating)
                        FROM Feedback
                        WHERE Feedback.product_id = Product.ROWID
        )
        WHERE ROWID IN (SELECT DISTINCT product_id FROM Feedback);
    '''
)
###############################################################################


###############################################################################
#Updating Product contRating
cursor.execute(
    '''
        UPDATE Product
        SET rating_count  = (
                            SELECT COUNT(rating)
                            FROM Feedback
                            WHERE Feedback.product_id = Product.ROWID
        )
        WHERE ROWID IN (SELECT DISTINCT product_id FROM Feedback);
    '''
)

###############################################################################

###############################################################################
connection.commit()
###############################################################################

#SELECTS

###############################################################################
#Select clients
cursor.execute(
    '''    
        SELECT *
        FROM User;
    '''
)
data = cursor.fetchall()
print("Contenido de los Users del sistema:")
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
        	p.name AS product_name,
        	p.description AS product_description,
        	p.image AS product_image,
        	p.price AS product_price,
			p.rating,
			p.rating_count,
        	GROUP_CONCAT(t.name) AS tags
		FROM Product p
			LEFT JOIN Classification c 
					ON p.ROWID = c.product_id
			LEFT JOIN Tag t 
					ON c.tag = t.name
		GROUP BY p.ROWID, p.name, p.description, p.image, p.price
		ORDER BY p.ROWID;
    '''
)
data = cursor.fetchall()
print("Contenido de los Products del sistema con sus tags:")
for row in data:
	print(row)
print("\n")
###############################################################################


###############################################################################
#Select Tags
cursor.execute(
    '''    
        SELECT name
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