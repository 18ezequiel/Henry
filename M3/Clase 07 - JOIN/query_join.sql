-- 1)

SELECT c.Nombre_y_Apellido, v.IdProducto, v.Precio
FROM venta v
JOIN cliente c
ON v.IdCliente = c.IdCliente;

-- 2)

SELECT c.IdCliente, SUM(v.Cantidad)
FROM cliente c
LEFT JOIN venta v
ON v.IdCliente = c.IdCliente
GROUP BY c.IdCliente
ORDER BY c.IdCliente asc;

-- 3)

SELECT c.IdCliente,c.Nombre_y_Apellido, SUM(v.Cantidad), YEAR(v.Fecha) as Año
FROM cliente c
LEFT JOIN venta v
ON v.IdCliente = c.IdCliente
GROUP BY c.IdCliente, YEAR(v.Fecha)
ORDER BY c.IdCliente asc;

-- 4)

SELECT c.Nombre_y_Apellido, v.IdProducto, SUM(v.Cantidad) as Cantidad_Productos, 
FROM cliente c
RIGHT JOIN venta v 
ON v.IdCliente = c.IdCliente 
GROUP BY c.IdCliente, v.IdProducto 
ORDER BY c.IdCliente asc;

-- 5)

SELECT l.IdLocalidad, l.Localidad, sum(v.Cantidad) as Cantidad_Productos, count(v.IdVenta) as Cantidad_Ventas, SUM(v.Precio * v.Cantidad) as Ventas
FROM sucursal s
JOIN venta v ON v.IdSucursal = s.IdSucursal 
JOIN localidad l ON l.IdLocalidad = s.IdLocalidad 
GROUP BY l.IdLocalidad
ORDER BY IdLocalidad asc;

-- select IdSucursal, count(*) from venta group by IdSucursal asc;

-- select IdLocalidad, count(*) from sucursal group by IdLocalidad asc;

-- select sum(Precio*Cantidad) as venta from venta order by venta asc;

-- 6)

SELECT p.IdProvincia, p.Provincia, sum(v.Cantidad) as Cantidad_Productos, count(v.IdVenta) as Cantidad_Ventas, SUM(v.Precio * v.Cantidad) as Ventas
FROM sucursal s
JOIN venta v ON v.IdSucursal = s.IdSucursal 
JOIN localidad l ON l.IdLocalidad = s.IdLocalidad
JOIN provincia p ON l.IdProvincia = p.IdProvincia
GROUP BY p.IdProvincia
HAVING Ventas > 100000
ORDER BY p.IdProvincia asc;

-- select IdSucursal, count(*) from venta group by IdSucursal; 

SELECT p.IdProvincia, p.Provincia, sum(v.Cantidad) as Cantidad_Productos, count(v.IdVenta) as Cantidad_Ventas, SUM(v.Precio * v.Cantidad) as Ventas
FROM venta v
JOIN cliente c ON c.IdCliente = v.IdCliente 
JOIN localidad l ON l.IdLocalidad = c.IdLocalidad
JOIN provincia p ON l.IdProvincia = p.IdProvincia
GROUP BY p.IdProvincia
HAVING Ventas > 100000
ORDER BY p.IdProvincia asc;

-- 7)

SELECT c.Rango_Etario, SUM(v.Precio*v.Cantidad) as venta
FROM cliente c
JOIN venta v ON v.IdCliente = c.IdCliente 
WHERE v.Outlier = 1
GROUP BY Rango_Etario
ORDER BY c.Rango_Etario asc;

-- 8) 

SELECT count(c.IdCliente) as Cantidad_Clientes, Provincia
FROM cliente c
JOIN localidad l ON c.IdLocalidad = l.IdLocalidad
JOIN provincia p ON l.IdProvincia = p.IdProvincia 
GROUP BY p.IdProvincia
ORDER BY p.Provincia;

-- SELECT count(*) from cliente;







