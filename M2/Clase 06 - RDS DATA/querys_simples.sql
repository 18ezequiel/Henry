select nombre,apellido,fechaIngreso from alumno where idCohorte = 1243;

select distinct i.idInstructor, i.nombre, i.apellido
from instructor i 
inner join cohorte c	
on i.idInstructor = c.idInstructor
inner join carrera f
on c.idCarrera = f.idCarrera
where f.nombre = "Full Stack Developer";

select idAlumno, cedulaIdentidad,nombre,apellido from alumno where idCohorte = 1235;

select idAlumno, nombre, apellido from alumno where idCohorte = 1235 and fechaIngreso between '2019-01-01' and '2020-01-01';

select distinct a.nombre, a.apellido, f.nombre
from alumno a 
inner join cohorte c	
on a.idCohorte = c.idCohorte
inner join carrera f
on c.idCarrera = f.idCarrera;