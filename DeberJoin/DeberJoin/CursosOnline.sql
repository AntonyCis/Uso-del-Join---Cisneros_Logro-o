Create database CursosOnline;
Use CursosOnline;

-- Tabla instructores
CREATE TABLE instructores (
    InstructorID INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Especialidad VARCHAR(100)
);

-- Tabla estudiantes
CREATE TABLE estudiantes (
    EstudianteID INT PRIMARY KEY,
    NombreEstudiante VARCHAR(100),
    FechaInscripcion DATE
);

-- Tabla cursos
CREATE TABLE cursos (
    CursoID INT PRIMARY KEY,
    NombreCurso VARCHAR(100),
    FechaInscripcion DATE,
    InstructorID INT,
    FOREIGN KEY (InstructorID) REFERENCES instructores(InstructorID)
);

-- Tabla inscripciones
CREATE TABLE inscripciones (
    InscripcionID INT PRIMARY KEY,
    EstudianteID INT,
    CursoID INT,
    FOREIGN KEY (EstudianteID) REFERENCES estudiantes(EstudianteID),
    FOREIGN KEY (CursoID) REFERENCES cursos(CursoID)
);

-- Tabla leccionescompletadas
CREATE TABLE leccionescompletadas (
    LeccionID INT PRIMARY KEY,
    EstudianteID INT,
    CursoID INT,
    LeccionesCompletadas INT,
    FOREIGN KEY (EstudianteID) REFERENCES estudiantes(EstudianteID),
    FOREIGN KEY (CursoID) REFERENCES cursos(CursoID)
);

-- DATOS DE PRUEBA

-- Instructores
INSERT INTO instructores VALUES 
(1, 'Carlos Ramírez', 'SQL'),
(2, 'Ana Torres', 'Python'),
(3, 'Pedro Mejía', 'Machine Learning');

-- Estudiantes
INSERT INTO estudiantes VALUES 
(1, 'Luis Pérez', '2024-01-10'),
(2, 'María Gómez', '2024-01-12'),
(3, 'José Martínez', '2024-02-01'),
(4, 'Lucía Herrera', '2024-02-15');

-- Cursos
INSERT INTO cursos VALUES 
(1, 'Introducción a SQL', '2024-01-05', 1),
(2, 'Python Intermedio', '2024-01-10', 2),
(3, 'Modelos de ML', '2024-02-20', NULL); -- Curso sin instructor

-- Inscripciones
INSERT INTO inscripciones VALUES 
(1, 1, 1), -- Luis en SQL
(2, 2, 1), -- María en SQL
(3, 2, 2), -- María en Python
(4, 3, 2); -- José en Python

-- Lecciones completadas
INSERT INTO leccionescompletadas VALUES 
(1, 1, 1, 3), -- Luis completó 3 lecciones de SQL
(2, 2, 1, 2), -- María completó 2 lecciones de SQL
(3, 2, 2, 1), -- María completó 1 lección de Python
(4, 3, 2, 4); -- José completó 4 lecciones de Python

-- JOINS

-- 1. ESTUDIANTES Y CURSOS

-- INNER JOIN: estudiantes inscritos
SELECT e.NombreEstudiante, c.NombreCurso
FROM estudiantes e
INNER JOIN inscripciones i ON e.EstudianteID = i.EstudianteID
INNER JOIN cursos c ON i.CursoID = c.CursoID;

-- LEFT JOIN: todos los estudiantes, inscritos o no
SELECT e.NombreEstudiante, c.NombreCurso
FROM estudiantes e
LEFT JOIN inscripciones i ON e.EstudianteID = i.EstudianteID
LEFT JOIN cursos c ON i.CursoID = c.CursoID;

-- RIGHT JOIN: todos los cursos, con o sin estudiantes
SELECT e.NombreEstudiante, c.NombreCurso
FROM estudiantes e
RIGHT JOIN inscripciones i ON e.EstudianteID = i.EstudianteID
RIGHT JOIN cursos c ON i.CursoID = c.CursoID;

-- FULL OUTER JOIN: todos los estudiantes y cursos (con UNION)
SELECT e.NombreEstudiante, c.NombreCurso
FROM estudiantes e
LEFT JOIN inscripciones i ON e.EstudianteID = i.EstudianteID
LEFT JOIN cursos c ON i.CursoID = c.CursoID

UNION

SELECT e.NombreEstudiante, c.NombreCurso
FROM estudiantes e
RIGHT JOIN inscripciones i ON e.EstudianteID = i.EstudianteID
RIGHT JOIN cursos c ON i.CursoID = c.CursoID;

-- 2. CURSOS E INSTRUCTORES

-- INNER JOIN: cursos con instructor
SELECT c.NombreCurso, i.Nombre AS NombreInstructor
FROM cursos c
INNER JOIN instructores i ON c.InstructorID = i.InstructorID;

-- LEFT JOIN: todos los cursos, incluso sin instructor
SELECT c.NombreCurso, i.Nombre AS NombreInstructor
FROM cursos c
LEFT JOIN instructores i ON c.InstructorID = i.InstructorID;

-- RIGHT JOIN: todos los instructores, incluso sin cursos
SELECT c.NombreCurso, i.Nombre AS NombreInstructor
FROM cursos c
RIGHT JOIN instructores i ON c.InstructorID = i.InstructorID;

-- FULL OUTER JOIN: todos los cursos e instructores
SELECT c.NombreCurso, i.Nombre AS NombreInstructor
FROM cursos c
LEFT JOIN instructores i ON c.InstructorID = i.InstructorID

UNION

SELECT c.NombreCurso, i.Nombre AS NombreInstructor
FROM cursos c
RIGHT JOIN instructores i ON c.InstructorID = i.InstructorID;

-- 3. ESTUDIANTES Y LECCIONES COMPLETADAS

-- INNER JOIN: estudiantes que completaron lecciones
SELECT e.NombreEstudiante, lc.LeccionesCompletadas, c.NombreCurso
FROM estudiantes e
INNER JOIN leccionescompletadas lc ON e.EstudianteID = lc.EstudianteID
INNER JOIN cursos c ON lc.CursoID = c.CursoID;

-- LEFT JOIN: todos los estudiantes
SELECT e.NombreEstudiante, lc.LeccionesCompletadas, c.NombreCurso
FROM estudiantes e
LEFT JOIN leccionescompletadas lc ON e.EstudianteID = lc.EstudianteID
LEFT JOIN cursos c ON lc.CursoID = c.CursoID;

-- RIGHT JOIN: todas las lecciones (por curso)
SELECT e.NombreEstudiante, lc.LeccionesCompletadas, c.NombreCurso
FROM estudiantes e
RIGHT JOIN leccionescompletadas lc ON e.EstudianteID = lc.EstudianteID
RIGHT JOIN cursos c ON lc.CursoID = c.CursoID;

-- FULL OUTER JOIN: todos los estudiantes y lecciones
SELECT e.NombreEstudiante, lc.LeccionesCompletadas, c.NombreCurso
FROM estudiantes e
LEFT JOIN leccionescompletadas lc ON e.EstudianteID = lc.EstudianteID
LEFT JOIN cursos c ON lc.CursoID = c.CursoID

UNION

SELECT e.NombreEstudiante, lc.LeccionesCompletadas, c.NombreCurso
FROM estudiantes e
RIGHT JOIN leccionescompletadas lc ON e.EstudianteID = lc.EstudianteID
RIGHT JOIN cursos c ON lc.CursoID = c.CursoID;