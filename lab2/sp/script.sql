
-- Mostrar citas de un doctor por su doctor_id

CREATE PROCEDURE sp_get_appointments_by_doctor
    @doctor_id INT
AS
BEGIN
SELECT ma.id, ma.date_time, ma.reason, mas.status,
       p.name + ' ' + p.last_name AS patient_name
FROM medical_appointment ma
         JOIN medical_appointment_status mas ON ma.status_id = mas.id
         JOIN patient p ON ma.patient_id = p.id
WHERE ma.doctor_id = @doctor_id;
END;


-- LLamamos al procedimiento
EXEC sp_get_appointments_by_doctor @doctor_id = 1;



-- SP para insertar un nuevo paciente
CREATE PROCEDURE sp_insert_patient
    @name VARCHAR(50),
    @last_name VARCHAR(60),
    @birth_date DATE,
    @number_insurance BIGINT,
    @allergies VARCHAR(500),
    @phone_id INT,
    @address_id INT,
    @blood_type_id INT
AS
BEGIN
INSERT INTO patient (name, last_name, birth_date, number_insurance, allergies, phone_id, address_id, blood_type_id)
VALUES (@name, @last_name, @birth_date, @number_insurance, @allergies, @phone_id, @address_id, @blood_type_id);
END;


-- Ejecutamos el procedimiento
EXEC sp_insert_patient
    @name = 'María',
    @last_name = 'González',
    @birth_date = '1990-05-15',
    @number_insurance = 123456789012345,
    @allergies = 'Penicilina, Mariscos',
    @phone_id = 1,
    @address_id = 3,
    @blood_type_id = 2;


SELECT * FROM patient;






-- Actualizar estado de una cita
CREATE PROCEDURE sp_update_appointment_status
    @appointment_id INT,
    @new_status_id INT
AS
BEGIN
UPDATE medical_appointment
SET status_id = @new_status_id
WHERE id = @appointment_id;
END;

select * from medical_appointment;


-- LLamos al SP  sp_update_appointment_status
EXEC sp_update_appointment_status @appointment_id = 1, @new_status_id = 4;



select * from medical_appointment;





-- Validmos que no se inserte el mismo paciente con en numero de seguro más de una vez
CREATE PROCEDURE sp_valid_insert_patient
    @name VARCHAR(50),        @last_name VARCHAR(60),
    @birth_date DATE,         @number_insurance BIGINT,
    @allergies VARCHAR(500),  @phone_id INT,
    @address_id INT,          @blood_type_id INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM patient WHERE number_insurance = @number_insurance)
BEGIN
        PRINT 'El número de seguro ya existe, no se puede insertar.';
END
ELSE
BEGIN
INSERT INTO patient (name, last_name, birth_date, number_insurance, allergies, phone_id, address_id, blood_type_id)
VALUES (@name, @last_name, @birth_date, @number_insurance, @allergies, @phone_id, @address_id, @blood_type_id);
END
END;


-- Segundo llamado con el mismo número de seguro (debería fallar)
EXEC sp_valid_insert_patient
    @name = 'Luis',              @last_name = 'García',
    @birth_date = '1988-07-22',  @number_insurance = 123456789012345,  -- Mismo número que  ya se ingre anterior
    @allergies = 'Ninguna',      @phone_id = 4,
    @address_id = 5,             @blood_type_id = 1;




-- SP par insertar citas médicas
CREATE PROCEDURE sp_insert_appointment
    @date_time DATETIME,
    @reason VARCHAR(1000),
    @status_id INT,
    @patient_id INT,
    @doctor_id INT
AS
BEGIN
    SET NOCOUNT ON;
BEGIN TRY
BEGIN TRANSACTION;

INSERT INTO medical_appointment (date_time, reason, status_id, patient_id, doctor_id)
VALUES (@date_time, @reason, @status_id, @patient_id, @doctor_id);

COMMIT TRANSACTION;
END TRY
BEGIN CATCH
IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        THROW 50000, @ErrorMessage, 1;
END CATCH
END;

-- Ejemplo 1: Llamado exitoso
EXEC sp_insert_appointment
    @date_time = '2024-03-15 10:30:00',    @reason = 'Consulta general de rutina',
    @status_id = 1,                        @patient_id = 5,
    @doctor_id = 3;