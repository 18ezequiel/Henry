
-- Instrucción SQL N° 1

INSERT INTO fact_venta (IdFecha, Fecha, IdSucursal, IdProducto, IdProductoFecha, IdSucursalFecha, IdProductoSucursalFecha)
SELECT	c.IdFecha, 
		g.Fecha,
		g.IdSucursal, 
        NULL AS IdProducto, 
        NULL AS IdProductoFecha, 
        g.IdSucursal * 100000000 + c.IdFecha IdSucursalFecha,
        NULL AS IdProductoSucursalFecha
FROM 	gasto g JOIN calendario c
	ON (g.Fecha = c.fecha)
WHERE g.IdSucursal * 100000000 + c.IdFecha NOT IN (	SELECT	v.IdSucursal * 100000000 + c.IdFecha 
													FROM venta v JOIN calendario c ON (v.Fecha = c.fecha)
													WHERE v.Outlier = 1);
												
												

-- Instrucción SQL N° 2

INSERT INTO fact_venta (IdFecha, Fecha, IdSucursal, IdProducto, IdProductoFecha, IdSucursalFecha, IdProductoSucursalFecha)
SELECT	c.IdFecha, 
		co.Fecha,
		NULL AS IdSucursal, 
        co.IdProducto, 
        co.IdProducto * 100000000 + c.IdFecha AS  IdProductoFecha, 
        NULL IdSucursalFecha,
        NULL AS IdProductoSucursalFecha
FROM 	compra co JOIN calendario c
	ON (co.Fecha = c.fecha)
WHERE co.IdProducto * 100000000 + c.IdFecha NOT IN (SELECT	v.IdProducto * 100000000 + c.IdFecha 
													FROM venta v JOIN calendario c ON (v.Fecha = c.fecha)
													WHERE v.Outlier = 1);

-- Instrucción SQL N° 3

SELECT 	co.TipoProducto,
		co.PromedioVentaConOutliers,
        so.PromedioVentaSinOutliers
FROM
	(	SELECT 	tp.TipoProducto, AVG(v.Precio * v.Cantidad) as PromedioVentaConOutliers
		FROM 	venta v 
		JOIN producto p
		ON (v.IdProducto = p.IdProducto)
		JOIN tipo_producto tp
		ON (p.IdTipoProducto = tp.IdTipoProducto)
		GROUP BY tp.TipoProducto
	) co
JOIN
	(	SELECT 	tp.TipoProducto, AVG(v.Precio * v.Cantidad) as PromedioVentaSinOutliers
		FROM 	venta v 
		JOIN producto p
		ON (v.IdProducto = p.IdProducto and v.Outlier = 1)
		JOIN tipo_producto tp
		ON (p.IdTipoProducto = tp.IdTipoProducto)
		GROUP BY tp.TipoProducto
	) so
ON co.TipoProducto = so.TipoProducto;



-- 1) Devuelven un numero que indica la id_sucursal / id_producto + el año + el mes + el dia.
-- La finalidad es darle un valor a un hecho, agiliza la forma de buscarlo
-- El NOT IN sirve para excluir los parámetros que se le da.

-- 2) Las sub consultas detallan el promedio de venta con y sin outliers en cada tipo de producto.
-- Generar una nueva tabla a la cual hacerle consultas por medio de una query.
-- IdProducto y TipoProducto.


-- 3)

CREATE VIEW punto_3 AS
SELECT 	co.TipoProducto,
		co.PromedioVentaConOutliers,
        so.PromedioVentaSinOutliers
FROM
	(	SELECT 	tp.TipoProducto, AVG(v.Precio * v.Cantidad) as PromedioVentaConOutliers
		FROM 	venta v 
		JOIN producto p
		ON (v.IdProducto = p.IdProducto)
		JOIN tipo_producto tp
		ON (p.IdTipoProducto = tp.IdTipoProducto)
		GROUP BY tp.TipoProducto
	) co
JOIN
	(	SELECT 	tp.TipoProducto, AVG(v.Precio * v.Cantidad) as PromedioVentaSinOutliers
		FROM 	venta v 
		JOIN producto p
		ON (v.IdProducto = p.IdProducto and v.Outlier = 1)
		JOIN tipo_producto tp
		ON (p.IdTipoProducto = tp.IdTipoProducto)
		GROUP BY tp.TipoProducto
	) so
ON co.TipoProducto = so.TipoProducto;


-- 4)

-- Total de ventas el primer dia y el ultimo dia

SELECT	v.Fecha, SUM(v.Precio * v.Cantidad) AS Ventas
FROM venta v
WHERE v.Fecha =	(SELECT min(v.Fecha) 
				 FROM venta v)
OR v.Fecha = (SELECT max(v.Fecha) 
			  FROM venta v)
GROUP BY v.Fecha
ORDER BY v.Fecha asc;


-- 5)

SELECT	v.IdProducto , p.Producto, v.Fecha, SUM(v.Precio * v.Cantidad) AS Ventas
FROM venta v
LEFT JOIN producto p
ON v.IdProducto = p.IdProducto
WHERE v.Fecha =	(SELECT min(v.Fecha) 
				 FROM venta v)
OR v.Fecha = (SELECT max(v.Fecha) 
			  FROM venta v)
GROUP BY v.IdProducto
ORDER BY v.Fecha asc;


-- 6)

DROP VIEW punto_6;
CREATE VIEW punto_6 AS
SELECT	v.IdProducto , p.Producto, v.Fecha, SUM(v.Precio * v.Cantidad) AS Ventas
FROM venta v
LEFT JOIN producto p
ON v.IdProducto = p.IdProducto
GROUP BY v.IdProducto, v.Fecha
ORDER BY v.IdProducto asc;


SELECT Fecha, SUM(Ventas) as Ventas
FROM punto_6 
GROUP BY Fecha
ORDER BY Ventas DESC 
limit 1;







	












