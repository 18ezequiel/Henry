USE henry;
############################################### 1,2 #######################################################
###########################################################################################################
# METODO PARA CONTAR    
###########################################################################################################
SELECT COUNT(nombre) FROM carrera; select count(nombre) from alumno;


############################################### 3 #########################################################
###########################################################################################################
# AGRUPO EN COHORTES LA CANTIDAD DE ALUMNOS QUE TIENE C/U   3
###########################################################################################################
select idCohorte, count(nombre) from alumno group by idCohorte; 


############################################### PRUEBA ####################################################
###########################################################################################################
# CORROBORO QUE ESTE BIEN LA QUERY
###########################################################################################################
INSERT INTO alumno (idAlumno,cedulaIdentidad,nombre,apellido,fechaNacimiento,fechaIngreso,idCohorte)
VALUES (181,'274352477','Candicse','Rosjas','2000-12-10','2020-01-21',1243);

delete from alumno where idAlumno = 181;
###########################################################################################################


############################################### 4 #########################################################
###########################################################################################################
# ORDENO DESDE LOS ULTIMOS EN INGRESAR HASTA LOS PRIMEROS EN INGRESAR Y COLOCO EL N Y A EN UNA COLUMNA COMO Nombre Completo    
###########################################################################################################
select concat(nombre, " ", apellido) as "Nombre Completo", fechaIngreso from alumno order by fechaIngreso desc;


############################################### 5, 6, 7 ###################################################
###########################################################################################################
# PRIMER ALUMNO QUE INGRESO, FILTRO POR FECHA
###########################################################################################################

select CONCAT(nombre, " ",apellido)  as 'Nombre Completo', fechaIngreso from alumno order by fechaIngreso asc limit 1;  # primer alumnos, orden creciente en fecha, limito a una row

select CONCAT(nombre, " ",apellido)  as 'Nombre Completo', fechaIngreso from alumno order by fechaIngreso desc limit 1; # segundo alumno, orde decreciente en fecha, limito a una row


############################################### 8 #########################################################
###########################################################################################################
# UTILIZO METODO YEAR PARA EXTRAER AÑO DE LA FECHA, FILTRO POR ESE VALOR, AGRUPO PARA NO REPETIR Y METODO COUNT PARA CONTAR 
###########################################################################################################

select  year(fechaIngreso) as Año, count(year(fechaIngreso)) as Ingresantes from alumno group by Año order by Año asc;


############################################### 9 #########################################################
###########################################################################################################
# IDENTICO AL ANTERIOR, SOLO QUE EL METODO WEEKOFYEAR SEPARA AL AÑO POR SEMANAS
###########################################################################################################

select weekofyear(fechaIngreso) as 'Ingresantes por Semana', year(fechaIngreso) as Año from alumno order by Año asc;


############################################### 10 ########################################################
###########################################################################################################
# SELECCIONO POR AÑO, CUENTO CANT DE ALUMNOS, AGRUPO POR AÑO PARA NO REPETIR Y LO LIMITO CON HAVING > 20
###########################################################################################################

select year(fechaIngreso) as Año, count(*) from alumno group by year(fechaIngreso) having count(*) > 20;

select year(fechaIngreso) as Año, count(*) from alumno group by year(fechaIngreso);   # corroboración 10


############################################### 11 ########################################################
###########################################################################################################
# UTILIZO METODO TIMESTAMPDIFF PARA RESTAR FECHAS Y EXPRESARLA EN AÑOS, PRIMERA FECHA EL NACIMIENTO, SEGUNDA CURDATE (FECHA ACTUAL)
###########################################################################################################

select curdate();

select nombre, apellido, timestampdiff(year,fechaNacimiento,curdate()) as 'Edad Instructor' from instructor;

select nombre,apellido,fechaNacimiento from instructor;

###########################################################################################################
# CON EL DATEADD COMPRUEBO QUE MIDE AÑOS COMPLETOS YA QUE A SU FECHA DE NACIMIENTO LE RESTO 3 AÑOS, Y AL CALCULAR DE NUEVO LA EDAD ME DICE QUE TIENE 3 AÑOS +
###########################################################################################################
 
select nombre,apellido, timestampdiff(year,date_add(fechaNacimiento, interval -3 year),curdate()) as 'Edad Instructor' from instructor;   ### adelanta o vuelve el tiempo que le pidas


############################################### 12 ########################################################
###########################################################################################################
#  SELECCIONO NOMBRE, APELLIDO Y LE CALCULO LA EDAD A C/U
###########################################################################################################

select nombre, apellido, timestampdiff(year, fechaNacimiento, curdate()) as 'Edad del Alumno' from alumno;  #12A

###########################################################################################################
# SUMO LAS EDADES Y LAS DIVIDO POR LA CANTIDAD DE ALUMNOS
###########################################################################################################

select (SUM(timestampdiff(year, fechaNacimiento, curdate()))/ count(idAlumno)) as 'Edad Promedio Henry'  from alumno;  #12B

###########################################################################################################
# MISMO QUE EL ANTERIOR, SOLO QUE AHORA GRUPO POR idCohorte
###########################################################################################################

select idCohorte, (SUM(timestampdiff(year, fechaNacimiento, curdate()))/ count(idAlumno)) as 'Edad Promedio'  from alumno group by idCohorte;  #13C

############################################### 13 ##########################################################
#############################################################################################################
# CALCULO EDADES DE LOS ALUMNOS Y CON UN WHERE LIMITO A QUE ME MUESTRE LOS QUE SUPERAN LA EDAD PROMEDIO, A LO ULTIMO ORDENO ASCENDENTEMENTE
#############################################################################################################

select nombre, apellido, timestampdiff(year, fechaNacimiento, curdate()) as Edad from alumno where timestampdiff(year, fechaNacimiento, curdate()) > 31.7333 order by Edad asc;

