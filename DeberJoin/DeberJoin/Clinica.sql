-- CREACIÓN DE TABLAS
Create database Clinicas;
Use Clinicas;
CREATE TABLE pacientes (
    PacienteID INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Edad INT,
    Ciudad VARCHAR(50),
    Direccion VARCHAR(100)
);

-- Tabla DOCTORES
CREATE TABLE doctores (
    DoctorID INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Especialidad VARCHAR(50)
);

-- Tabla MEDICAMENTOS
CREATE TABLE medicamentos (
    MedicamentoID INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Descripcion VARCHAR(100)
);

-- Tabla CONSULTAS
CREATE TABLE consultas (
    ConsultaID INT PRIMARY KEY,
    PacienteID INT,
    DoctorID INT,
    Fecha DATE,
    FOREIGN KEY (PacienteID) REFERENCES pacientes(PacienteID),
    FOREIGN KEY (DoctorID) REFERENCES doctores(DoctorID)
);

-- Tabla RECETAS
CREATE TABLE recetas (
    RecetaID INT PRIMARY KEY,
    PacienteID INT,
    MedicamentoID INT,
    DoctorID INT,
    Fecha DATE,
    FOREIGN KEY (PacienteID) REFERENCES pacientes(PacienteID),
    FOREIGN KEY (MedicamentoID) REFERENCES medicamentos(MedicamentoID),
    FOREIGN KEY (DoctorID) REFERENCES doctores(DoctorID)
);

-- Insertar PACIENTES
INSERT INTO pacientes VALUES
(1, 'Ana', 'Mora', 28, 'Quito', 'Av. Amazonas'),
(2, 'Luis', 'Pérez', 35, 'Guayaquil', 'Av. 9 de Octubre'),
(3, 'Sofía', 'López', 22, 'Cuenca', 'Calle Larga');

-- Insertar DOCTORES
INSERT INTO doctores VALUES
(1, 'Carlos', 'Ramírez', 'Pediatría'),
(2, 'Elena', 'Torres', 'Medicina General'),
(3, 'Andrés', 'Gómez', 'Cardiología');

-- Insertar MEDICAMENTOS
INSERT INTO medicamentos VALUES
(1, 'Paracetamol', 'Analgésico y antipirético'),
(2, 'Ibuprofeno', 'Antiinflamatorio no esteroideo'),
(3, 'Amoxicilina', 'Antibiótico');

-- Insertar CONSULTAS (una sin paciente y una sin doctor)
INSERT INTO consultas VALUES
(1, 1, 1, '2025-05-01'), -- Ana con Dr. Carlos
(2, 2, NULL, '2025-05-02'), -- Luis sin doctor
(3, NULL, 2, '2025-05-03'); -- sin paciente, con Dra. Elena

-- Insertar RECETAS (algunas sin relación completa)
INSERT INTO recetas VALUES
(1, 1, 1, 1, '2025-05-01'), -- Ana recibió Paracetamol de Dr. Carlos
(2, 2, 2, 2, '2025-05-02'), -- Luis recibió Ibuprofeno de Dra. Elena
(3, 3, NULL, 3, '2025-05-03'); -- Sofía sin medicamento

-- INNER JOIN: Solo pacientes con consultas
SELECT p.Nombre, c.Fecha
FROM pacientes p
INNER JOIN consultas c ON p.PacienteID = c.PacienteID;

-- LEFT JOIN: Todos los pacientes, incluso sin consultas
SELECT p.Nombre, c.Fecha
FROM pacientes p
LEFT JOIN consultas c ON p.PacienteID = c.PacienteID;

-- RIGHT JOIN: Todas las consultas, incluso sin paciente
SELECT p.Nombre, c.Fecha
FROM pacientes p
RIGHT JOIN consultas c ON p.PacienteID = c.PacienteID;

-- FULL OUTER JOIN: Todos los pacientes y consultas (relacionados o no)
SELECT p.Nombre, c.Fecha
FROM pacientes p
LEFT JOIN consultas c ON p.PacienteID = c.PacienteID

UNION

SELECT p.Nombre, c.Fecha
FROM pacientes p
RIGHT JOIN consultas c ON p.PacienteID = c.PacienteID;

-- 2. CONSULTAS - DOCTORES

-- INNER JOIN: Solo consultas con doctor asignado
SELECT c.ConsultaID, d.Nombre AS Doctor
FROM consultas c
INNER JOIN doctores d ON c.DoctorID = d.DoctorID;

-- LEFT JOIN: Todas las consultas, incluso sin doctor
SELECT c.ConsultaID, d.Nombre AS Doctor
FROM consultas c
LEFT JOIN doctores d ON c.DoctorID = d.DoctorID;

-- RIGHT JOIN: Todos los doctores, incluso sin consultas asignadas
SELECT c.ConsultaID, d.Nombre AS Doctor
FROM consultas c
RIGHT JOIN doctores d ON c.DoctorID = d.DoctorID;

-- Simulación de FULL OUTER JOIN entre consultas y doctores
SELECT c.ConsultaID, d.Nombre AS Doctor
FROM consultas c
LEFT JOIN doctores d ON c.DoctorID = d.DoctorID

UNION

SELECT c.ConsultaID, d.Nombre AS Doctor
FROM consultas c
RIGHT JOIN doctores d ON c.DoctorID = d.DoctorID;

-- 3. PACIENTES - MEDICAMENTOS (por recetas)
-- INNER JOIN: Pacientes con medicamentos recetados
SELECT p.Nombre AS Paciente, m.Nombre AS Medicamento
FROM pacientes p
INNER JOIN recetas r ON p.PacienteID = r.PacienteID
INNER JOIN medicamentos m ON r.MedicamentoID = m.MedicamentoID;

-- LEFT JOIN: Todos los pacientes, incluso sin medicamentos
SELECT p.Nombre AS Paciente, m.Nombre AS Medicamento
FROM pacientes p
LEFT JOIN recetas r ON p.PacienteID = r.PacienteID
LEFT JOIN medicamentos m ON r.MedicamentoID = m.MedicamentoID;

-- RIGHT JOIN: Todos los medicamentos, incluso si no han sido recetados
SELECT p.Nombre AS Paciente, m.Nombre AS Medicamento
FROM pacientes p
RIGHT JOIN recetas r ON p.PacienteID = r.PacienteID
RIGHT JOIN medicamentos m ON r.MedicamentoID = m.MedicamentoID;

-- FULL OUTER JOIN: Todos los pacientes y medicamentos, estén relacionados o no
-- Parte 1: LEFT JOIN desde pacientes hacia recetas y medicamentos
SELECT p.Nombre AS Paciente, m.Nombre AS Medicamento
FROM pacientes p
LEFT JOIN recetas r ON p.PacienteID = r.PacienteID
LEFT JOIN medicamentos m ON r.MedicamentoID = m.MedicamentoID

UNION

SELECT p.Nombre AS Paciente, m.Nombre AS Medicamento
FROM medicamentos m
RIGHT JOIN recetas r ON m.MedicamentoID = r.MedicamentoID
RIGHT JOIN pacientes p ON p.PacienteID = r.PacienteID
WHERE p.PacienteID IS NULL;



