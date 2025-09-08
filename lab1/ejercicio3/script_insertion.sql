-- A
BEGIN TRANSACTION;
BEGIN TRY
    -- Insertar especialidad
INSERT INTO specialty (name) VALUES ('Cardiología');

    -- Insertar médico
INSERT INTO doctor (school_number, name, last_name, years_experience, consulting_room, specialty_id)
VALUES (123456789, 'Juan', 'Pérez', 15, 'Consultorio 201', 1);

-- Datos auxiliares del paciente
INSERT INTO phone (code_area, n_phone) VALUES ('011', '4567890');
INSERT INTO address (street, city, country, postal_code)
VALUES ('Av. Libertador 321', 'Buenos Aires', 'Argentina', '1001');
INSERT INTO blood_type (type) VALUES ('A+');

-- Insertar paciente
INSERT INTO patient (name, last_name, birth_date, number_insurance, allergies, phone_id, address_id, blood_type_id)
VALUES ('María', 'Gómez', '1990-05-15', 987654321, 'Ninguna', 1, 1, 1);

-- Insertar estado de cita
INSERT INTO medical_appointment_status (status) VALUES ('Pendiente');

-- Insertar cita médica
INSERT INTO medical_appointment (date_time, reason, status_id, patient_id, doctor_id)
VALUES ('2025-09-15 09:30:00', 'Chequeo general', 1, 1, 1);

COMMIT;
END TRY
BEGIN CATCH
ROLLBACK;
END CATCH;
GO


-- B

BEGIN TRANSACTION;
BEGIN TRY
UPDATE medical_appointment
SET date_time = '2025-09-15 11:00:00',
    reason = 'Chequeo anual de rutina'
WHERE id = 1;

COMMIT;
END TRY
BEGIN CATCH
ROLLBACK;
END CATCH;
GO


-- C

BEGIN TRANSACTION;
BEGIN TRY
    -- Insertar medicamento
INSERT INTO medicament (name, presentation, dose)
    VALUES ('Ibuprofeno', 'Tabletas de 400mg', '400mg');

    -- Insertar receta
INSERT INTO prescription (dose, frequency, duration_treatment, medicament_id, patient_id, doctor_id)
VALUES ('400mg', 'Cada 8 horas', '7 días', 1, 1, 1);

COMMIT;
END TRY
BEGIN CATCH
ROLLBACK;
END CATCH;
GO


-- D

BEGIN TRANSACTION;
BEGIN TRY
UPDATE prescription
SET frequency = 'Cada 12 horas',
    duration_treatment = '10 días'
WHERE id = 1;

COMMIT;
END TRY
BEGIN CATCH
ROLLBACK;
END CATCH;
GO


-- E

BEGIN TRANSACTION;
BEGIN TRY

    -- Insertar estado de cita
INSERT INTO medical_appointment_status (status) VALUES ('Cancelada');

    -- Opción A: Cancelar cambiando estado
UPDATE medical_appointment
SET status_id = 2   --  2 = "Cancelada"
WHERE id = 1;

COMMIT;
END TRY
BEGIN CATCH
ROLLBACK;
END CATCH;
GO