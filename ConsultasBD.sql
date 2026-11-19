use evento_uc3m;

-- 1)
SELECT 
    te.CodT,
    te.NombreT,
    COUNT(*) AS TotalEventos
FROM Evento e JOIN Tipo_Evento te ON e.TipoE = te.CodT
WHERE YEAR(e.FechaH_I) = 2024
GROUP BY te.CodT, te.NombreT;

-- ----------------------------------------------------------------------------------------------------------------------- --

-- 2)
SELECT Título, Presupuesto
FROM Evento
WHERE YEAR(FechaH_I) = 2024
ORDER BY Presupuesto DESC
LIMIT 1;

-- ----------------------------------------------------------------------------------------------------------------------- --


-- 3) 

SELECT 
    p.CodP,
    p.Nombre,
    p.Apellidos,
    COUNT(e.Cod_E) AS TotalEventos
FROM Evento e
JOIN Interno i ON e.Organizado_por = i.CodP
JOIN Persona p ON p.CodP = i.CodP
GROUP BY p.CodP, p.Nombre, p.Apellidos
ORDER BY TotalEventos DESC
LIMIT 1;

-- ----------------------------------------------------------------------------------------------------------------------- --


-- 4)
SELECT 
    Título,
    FechaH_I,
    FechaH_F
FROM Evento
WHERE YEAR(FechaH_I) = 2024
  AND Ayuda IS NULL;

-- ----------------------------------------------------------------------------------------------------------------------- --


-- 5)

SELECT DISTINCT e.Título
FROM Evento e
JOIN Descrita_Por d ON e.Cod_E = d.Evento
JOIN Categoria c ON d.Categoria = c.IdC
WHERE YEAR(e.FechaH_I) = 2023
  AND c.NombreC LIKE '%Inteligencia Artificial%';


-- ----------------------------------------------------------------------------------------------------------------------- --



-- 6)

SELECT 
    c.CodC,
    c.NombreCentro,
    COUNT(e.Cod_E) AS TotalEventos
FROM Centro c
LEFT JOIN Evento e ON e.Celebrado_en = c.CodC
GROUP BY c.CodC, c.NombreCentro
ORDER BY TotalEventos DESC;


-- 7)

SELECT 
    d.Cod_Dpto,
    d.NombreD,
    SUM(p.Num_horas) AS TotalHoras
FROM Participa p
JOIN Interno i ON p.Participante = i.CodP
JOIN Adscrito a ON a.Investigador = i.CodP
JOIN Departamento d ON d.Cod_Dpto = a.Departamento
JOIN Evento e ON e.Cod_E = p.Evento
WHERE YEAR(e.FechaH_I) IN (2023, 2024)
GROUP BY d.Cod_Dpto, d.NombreD;

-- ----------------------------------------------------------------------------------------------------------------------- --



-- 8)

SELECT e.*
FROM Evento e
JOIN Centro c ON e.Celebrado_en = c.CodC
WHERE c.NombreCentro = 'Escuela Politécnica Superior'
  AND e.Título LIKE '%política%'
  AND e.Título LIKE '%internacional%';


-- ----------------------------------------------------------------------------------------------------------------------- --

-- 9)

SELECT 
    p.Nombre,
    p.Apellidos,
    ex.NombreE AS Institucion
FROM Evento e
JOIN Participa pa ON pa.Evento = e.Cod_E
JOIN Persona p ON p.CodP = pa.Participante
JOIN Externo ex ON ex.CodP = p.CodP
WHERE e.Título = 'Las rutas turísticas: El patrimonio monumental en la gestión de itinerarios culturales';


-- ----------------------------------------------------------------------------------------------------------------------- --

-- 10)

SELECT 
    p.Genero,
    COUNT(e.Cod_E) AS TotalEventos
FROM Evento e
JOIN Persona p ON p.CodP = e.Organizado_por
GROUP BY p.Genero;




