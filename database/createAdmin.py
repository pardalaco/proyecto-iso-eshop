import sqlite3

connection = sqlite3.connect('isoDB.db')
cursor = connection.cursor()
cursor.execute('''PRAGMA foreign_keys = ON;''')

cursor.execute("""
INSERT INTO cliente (email, nombre, apellidos, pwd, admin) 
VALUES  ('admin', 'Admin', 'Admin', 'admin', 1);
""")

connection.commit()