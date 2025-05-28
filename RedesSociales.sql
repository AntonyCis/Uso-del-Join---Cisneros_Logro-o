-- TABLAS --
CREATE DATABASE RedesSociales;
USE RedesSociales;

CREATE TABLE usuarios (
    UsuarioID INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Edad INT,
    Ciudad VARCHAR(50),
    Seguidores INT,
    FotosPublicadas INT
);

CREATE TABLE fotos (
    FotoID INT PRIMARY KEY,
    UsuarioID INT,
    Descripcion VARCHAR(255),
    Fecha DATE,
    MeGusta INT
);

CREATE TABLE comentarios (
    ComentarioID INT PRIMARY KEY,
    FotoID INT,
    UsuarioID INT,
    Comentario TEXT,
    Fecha DATE
);

-- INSERCION DE DATOS --

-- Usuarios
INSERT INTO usuarios VALUES
(1, 'Juan', 'Pérez', 30, 'Bogotá', 100, 2),
(2, 'Ana', 'Gómez', 25, 'Medellín', 150, 1),
(3, 'Luis', 'Rodríguez', 28, 'Cali', 50, 0); -- Usuario sin fotos

-- Fotos
INSERT INTO fotos VALUES
(101, 1, 'Atardecer en la playa', '2024-05-01', 200),
(102, 1, 'Mi gato dormido', '2024-05-03', 120),
(103, 2, 'Montañas', '2024-05-04', 180),
(104, NULL, 'Sin autor', '2024-05-05', 30); -- Foto sin usuario

-- Comentarios
INSERT INTO comentarios VALUES
(201, 101, 2, 'Hermosa foto!', '2024-05-06'),
(202, 103, 1, 'Buen encuadre.', '2024-05-07'),
(203, 104, NULL, 'Comentario anónimo.', '2024-05-08'), -- Comentario sin usuario
(204, NULL, 3, 'Sin foto comentada.', '2024-05-09');   -- Comentario sin foto

-- CONSULTAS SQL --
-- INNER JOIN --

-- Usuarios con sus fotos
SELECT u.Nombre, f.Descripcion
FROM usuarios u
INNER JOIN fotos f ON u.UsuarioID = f.UsuarioID;

-- Fotos con comentarios
SELECT f.Descripcion, c.Comentario
FROM fotos f
INNER JOIN comentarios c ON f.FotoID = c.FotoID;

-- Usuarios con comentarios realizados
SELECT u.Nombre, c.Comentario
FROM usuarios u
INNER JOIN comentarios c ON u.UsuarioID = c.UsuarioID;

-- LEFT JOIN --

-- Todos los usuarios y sus fotos (aunque no hayan subido ninguna)
SELECT u.Nombre, f.Descripcion
FROM usuarios u
LEFT JOIN fotos f ON u.UsuarioID = f.UsuarioID;

-- Todas las fotos y sus comentarios (aunque no tengan comentarios)
SELECT f.Descripcion, c.Comentario
FROM fotos f
LEFT JOIN comentarios c ON f.FotoID = c.FotoID;

-- Todos los usuarios y sus comentarios (aunque no hayan hecho comentarios)
SELECT u.Nombre, c.Comentario
FROM usuarios u
LEFT JOIN comentarios c ON u.UsuarioID = c.UsuarioID;

-- RIGHT JOIN --

-- Todas las fotos y sus autores (aunque no tengan usuario asociado)
SELECT u.Nombre, f.Descripcion
FROM usuarios u
RIGHT JOIN fotos f ON u.UsuarioID = f.UsuarioID;

-- Todos los comentarios y las fotos (aunque no estén asociadas)
SELECT f.Descripcion, c.Comentario
FROM fotos f
RIGHT JOIN comentarios c ON f.FotoID = c.FotoID;

-- Todos los comentarios y sus autores (aunque no tengan usuario asociado)
SELECT u.Nombre, c.Comentario
FROM usuarios u
RIGHT JOIN comentarios c ON u.UsuarioID = c.UsuarioID;

-- FULL OUTER JOIN

-- Usuarios y fotos, incluidas las no relacionadas entre sí
SELECT u.Nombre, f.Descripcion
FROM usuarios u
LEFT JOIN fotos f ON u.UsuarioID = f.UsuarioID
UNION
SELECT u.Nombre, f.Descripcion
FROM usuarios u
RIGHT JOIN fotos f ON u.UsuarioID = f.UsuarioID;

-- Fotos y comentarios, incluidos los no relacionados
SELECT f.Descripcion, c.Comentario
FROM fotos f
LEFT JOIN comentarios c ON f.FotoID = c.FotoID
UNION
SELECT f.Descripcion, c.Comentario
FROM fotos f
RIGHT JOIN comentarios c ON f.FotoID = c.FotoID;

-- Usuarios y comentarios, incluidos los no relacionados
SELECT u.Nombre, c.Comentario
FROM usuarios u
LEFT JOIN comentarios c ON u.UsuarioID = c.UsuarioID
UNION
SELECT u.Nombre, c.Comentario
FROM usuarios u
RIGHT JOIN comentarios c ON u.UsuarioID = c.UsuarioID;
