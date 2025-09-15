
-- Vista de doctores con especialidad y horarios
CREATE VIEW vw_doctor_schedule AS
SELECT d.id AS doctor_id,
       d.name + ' ' + d.last_name AS doctor_name,
       s.name AS specialty,
       b.start_date,
       b.end_date
FROM doctor d
         JOIN specialty s ON d.specialty_id = s.id
         JOIN business_hours b ON d.id = b.doctor_id;

SELECT *FROM vw_doctor_schedule;




-- Vista de información del paciente
CREATE VIEW vw_patient_info AS
SELECT p.id AS patient_id,
       p.name + ' ' + p.last_name AS patient_name,
       p.birth_date,
       bt.type AS blood_type,
       a.city,
       a.country
FROM patient p
         JOIN blood_type bt ON p.blood_type_id = bt.id
         JOIN address a ON p.address_id = a.id;

SELECT * FROM vw_patient_info;




-- Vista de citas medicas
CREATE VIEW vw_medical_appointments AS
SELECT m.id AS appointment_id,
       m.date_time,
       m.reason,
       s.status,
       p.name + ' ' + p.last_name AS patient,
       d.name + ' ' + d.last_name AS doctor
FROM medical_appointment m
         JOIN medical_appointment_status s ON m.status_id = s.id
         JOIN patient p ON m.patient_id = p.id
         JOIN doctor d ON m.doctor_id = d.id;


SELECT * FROM vw_medical_appointments;



-- Modificamos la vista
ALTER VIEW vw_doctor_schedule AS
SELECT d.id AS doctor_id,
       d.name + ' ' + d.last_name AS doctor_name,
       d.consulting_room, -- Nuevo columna agregada
       d.school_number, -- Nuevo columna agregada
       s.name AS specialty,
       b.start_date,
       b.end_date
FROM doctor d
         JOIN specialty s ON d.specialty_id = s.id
         JOIN business_hours b ON d.id = b.doctor_id;


SELECT * FROM vw_doctor_schedule;



-- Creamos vista información de doctor
CREATE VIEW vw_doctor_info AS
SELECT d.id AS doctor_id,
       d.name,
       d.consulting_room,
       d.school_number
FROM doctor d


SELECT * FROM vw_doctor_info;


-- Actualizamos el nombre de medico con id = 1 através de la vista
UPDATE vw_doctor_info
SET name = 'Jean Pierre'
WHERE doctor_id = 1;

SELECT * FROM vw_doctor_info;


-- Eliminamoslas vista

DROP VIEW vw_doctor_schedule;
DROP VIEW vw_doctor_info;
DROP VIEW vw_medical_appointments;




-- Creamos la tabla temporal

CREATE TABLE #temp_patient_info (
                                    id INT,
                                    number_insurance VARCHAR(100),
                                    patient_name VARCHAR(100),
                                    blood_type VARCHAR(100)
);

-- Insertamos información en la tabla temporal
INSERT INTO #temp_patient_info (id, number_insurance, patient_name, blood_type)
SELECT
    p.id,
    p.number_insurance,
    p.name,
    bt.type
FROM patient p
         JOIN blood_type bt ON p.blood_type_id = bt.id;

-- Llamaos ala tabla temporal
SELECT * FROM #temp_patient_info;



