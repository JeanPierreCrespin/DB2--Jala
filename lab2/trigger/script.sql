
-- Tabla para guadar los cambios
CREATE TABLE audit_log (
                           audit_id INT IDENTITY(1,1) PRIMARY KEY,
                           table_name VARCHAR(50),
                           record_id INT,
                           column_name VARCHAR(50),
                           action VARCHAR(10),
                           action_date DATETIME DEFAULT GETDATE(),
                           old_value VARCHAR(255),
                           new_value VARCHAR(255)
);

-- Creamos trigger el cual va ir guardando los cambios en la tabla audit_log
CREATE TRIGGER trg_audit_patient
    ON patient
    AFTER INSERT, UPDATE, DELETE
    AS
BEGIN
    SET NOCOUNT ON;

    -- INSERT
INSERT INTO audit_log (table_name, record_id, column_name, action, new_value)
SELECT 'patient', i.id, 'name', 'INSERT', i.name
FROM inserted i;

INSERT INTO audit_log (table_name, record_id, column_name, action, new_value)
SELECT 'patient', i.id, 'number_insurance', 'INSERT', CAST(i.number_insurance AS VARCHAR(255))
FROM inserted i;

INSERT INTO audit_log (table_name, record_id, column_name, action, new_value)
SELECT 'patient', i.id, 'blood_type_id', 'INSERT', CAST(i.blood_type_id AS VARCHAR(255))
FROM inserted i;

-- UPDATE (solo cuando cambió el valor)
INSERT INTO audit_log (table_name, record_id, column_name, action, old_value, new_value)
SELECT 'patient', d.id, 'name', 'UPDATE', d.name, i.name
FROM deleted d
         JOIN inserted i ON d.id = i.id
WHERE d.name <> i.name;

INSERT INTO audit_log (table_name, record_id, column_name, action, old_value, new_value)
SELECT 'patient', d.id, 'number_insurance', 'UPDATE', CAST(d.number_insurance AS VARCHAR(255)), CAST(i.number_insurance AS VARCHAR(255))
FROM deleted d
         JOIN inserted i ON d.id = i.id
WHERE d.number_insurance <> i.number_insurance;

-- DELETE
INSERT INTO audit_log (table_name, record_id, column_name, action, old_value)
SELECT 'patient', d.id, 'name', 'DELETE', d.name
FROM deleted d;

INSERT INTO audit_log (table_name, record_id, column_name, action, old_value)
SELECT 'patient', d.id, 'number_insurance', 'DELETE', CAST(d.number_insurance AS VARCHAR(255))
FROM deleted d;

INSERT INTO audit_log (table_name, record_id, column_name, action, old_value)
SELECT 'patient', d.id, 'blood_type_id', 'DELETE', CAST(d.blood_type_id AS VARCHAR(255))
FROM deleted d;
END;




-- Tabla historial de estados
CREATE TABLE appointment_history (
                                     history_id INT IDENTITY(1,1) PRIMARY KEY,
                                     appointment_id INT,
                                     old_status_id INT,
                                     new_status_id INT,
                                     changed_at DATETIME DEFAULT GETDATE()
);

-- Trigger para registrar cambios de estado
CREATE TRIGGER trg_appointment_status_history
    ON medical_appointment
    AFTER UPDATE
              AS
BEGIN
    IF UPDATE(status_id)
BEGIN
INSERT INTO appointment_history (appointment_id, old_status_id, new_status_id)
SELECT d.id, d.status_id, i.status_id
FROM deleted d
         JOIN inserted i ON d.id = i.id;
END
END;


-- Tabla de historial de doctores
CREATE TABLE doctor_history (
                                history_id INT IDENTITY(1,1) PRIMARY KEY,
                                doctor_id INT,
                                old_room VARCHAR(50),
                                new_room VARCHAR(50),
                                changed_at DATETIME DEFAULT GETDATE()
);

-- Trigger para validar y registrar cambios
CREATE TRIGGER trg_doctor_validations
    ON doctor
    AFTER UPDATE
              AS
BEGIN
    -- Validación de experiencia
    IF EXISTS (SELECT 1 FROM inserted WHERE years_experience < 0)
BEGIN
        RAISERROR ('La experiencia no puede ser negativa.', 16, 1);
ROLLBACK TRANSACTION;
RETURN;
END



    -- Registro de cambios de consultorio
    IF UPDATE(consulting_room)
BEGIN
INSERT INTO doctor_history (doctor_id, old_room, new_room)
SELECT d.id, d.consulting_room, i.consulting_room
FROM deleted d
         JOIN inserted i ON d.id = i.id
WHERE d.consulting_room <> i.consulting_room;
END
END;
