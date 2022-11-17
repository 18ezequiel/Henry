import mysql.connector as mariadb

class coneccion:

    def conectar(self, base):

    # Connect to the database
        credencial =    {
                        "host":'database-2.ccufuhsi7yem.us-east-1.rds.amazonaws.com',
                        "user":'usuarioaws',
                        "password":'18Ezequiel,',
                        "database": base,
                        "port":'3306'
                        }
        
        conect1 = None
        conect1 = mariadb.connect(**credencial)
        return conect1
    
    def execute(self, base, query):

        cone = self.conectar(base)

        cursor1 = cone.cursor()

        cursor1.execute(query)

  

    def execute_agregar(self, base, query, argumento):

        cone = self.conectar(base)

        cursor1 = cone.cursor()

        cursor1.execute(query, argumento)

        cone.commit()

        cone.close()


    