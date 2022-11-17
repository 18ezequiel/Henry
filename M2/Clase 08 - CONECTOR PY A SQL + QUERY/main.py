import pandas as pd
from conect import coneccion
import mysql

df = pd.read_csv("oferta_gastronomica.csv")
df['categoria'].dropna()

conect_db = coneccion()

db = 'oferta_gastronomica'

query = ("""CREATE TABLE ofertaGastronomica
            
        (id_local INT ,
        nombre VARCHAR(255),
        categoria VARCHAR(255),
        direccion VARCHAR(255),
        barrio VARCHAR(255),
        comuna VARCHAR(255))
        """)


conect_db.execute(db, query)

df = df.fillna("---")

for index, row in df.iterrows():

        query2 = """INSERT INTO ofertaGastronomica (id_local,nombre,categoria,direccion,barrio,comuna) values (%s,%s,%s,%s,%s,%s)"""

        conect_db.execute_agregar(db, query2,(row.id, row.nombre, row.categoria, row.direccion_completa, row.barrio, row.comuna))

#conect_db.commit_d()

        










