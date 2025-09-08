-- Crear base de datos
CREATE DATABASE hospital_lab1;
GO

USE hospital_lab1;
GO

-- Tablas de referencia/catálogo

-- Tabla: specialty
CREATE TABLE specialty (
                           id INT IDENTITY(1,1) PRIMARY KEY,
                           name VARCHAR(50) NOT NULL
);

-- Tabla: blood_type
CREATE TABLE blood_type (
                            id INT IDENTITY(1,1) PRIMARY KEY,
                            type VARCHAR(3) NOT NULL
);

-- Tabla: medical_appointment_status
CREATE TABLE medical_appointment_status (
                                            id INT IDENTITY(1,1) PRIMARY KEY,
                                            status VARCHAR(10) NOT NULL
);

-- Tabla: address
CREATE TABLE address (
                         id INT IDENTITY(1,1) PRIMARY KEY,
                         street VARCHAR(60) NOT NULL,
                         city VARCHAR(30) NOT NULL,
                         country VARCHAR(30) NOT NULL,
                         postal_code VARCHAR(8) NOT NULL
);

-- Tabla: phone
CREATE TABLE phone (
                       id INT IDENTITY(1,1) PRIMARY KEY,
                       code_area VARCHAR(4) NOT NULL,
                       n_phone VARCHAR(10) NOT NULL
);

-- Tabla: doctor (SIN business_hours_id para evitar referencia circular)
CREATE TABLE doctor (
                        id INT IDENTITY(1,1) PRIMARY KEY,
                        school_number BIGINT NOT NULL UNIQUE,
                        name VARCHAR(60) NOT NULL,
                        last_name VARCHAR(60) NOT NULL,
                        years_experience INT NOT NULL,
                        consulting_room VARCHAR(50) NOT NULL,
                        specialty_id INT NOT NULL,
                        CONSTRAINT FK_doctor_specialty FOREIGN KEY (specialty_id) REFERENCES specialty(id)
);

-- Tabla: business_hours (CON doctor_id - relación 1:N correcta)
CREATE TABLE business_hours (
                                id INT IDENTITY(1,1) PRIMARY KEY,
                                start_date TIME NOT NULL,
                                end_date TIME NOT NULL,
                                doctor_id INT NOT NULL,
                                CONSTRAINT FK_business_hours_doctor FOREIGN KEY (doctor_id) REFERENCES doctor(id)
);

-- Tabla: patient (SIN medical_appointment_id para evitar referencia circular)
CREATE TABLE patient (
                         id INT IDENTITY(1,1) PRIMARY KEY,
                         name VARCHAR(50) NOT NULL,
                         last_name VARCHAR(60) NOT NULL,
                         birth_date DATE NOT NULL,
                         number_insurance BIGINT NOT NULL UNIQUE ,
                         allergies VARCHAR(500) NOT NULL,
                         phone_id INT NOT NULL,
                         address_id INT NOT NULL,
                         blood_type_id INT NOT NULL,
                         CONSTRAINT FK_patient_phone FOREIGN KEY (phone_id) REFERENCES phone(id),
                         CONSTRAINT FK_patient_address FOREIGN KEY (address_id) REFERENCES address(id),
                         CONSTRAINT FK_patient_blood_type FOREIGN KEY (blood_type_id) REFERENCES blood_type(id)
);

-- Tabla: medical_appointment (CON patient_id y doctor_id - relación correcta)
CREATE TABLE medical_appointment (
                                     id INT IDENTITY(1,1) PRIMARY KEY,
                                     date_time DATETIME NOT NULL,
                                     reason VARCHAR(1000) NOT NULL,
                                     status_id INT NOT NULL,
                                     patient_id INT NOT NULL,
                                     doctor_id INT NOT NULL,
                                     CONSTRAINT FK_medical_appointment_status FOREIGN KEY (status_id) REFERENCES medical_appointment_status(id),
                                     CONSTRAINT FK_medical_appointment_patient FOREIGN KEY (patient_id) REFERENCES patient(id),
                                     CONSTRAINT FK_medical_appointment_doctor FOREIGN KEY (doctor_id) REFERENCES doctor(id)
);

-- Tabla: health_status
CREATE TABLE health_status (
                               id INT IDENTITY(1,1) PRIMARY KEY,
                               type_test VARCHAR(50) NOT NULL,
                               description VARCHAR(500) NOT NULL,
                               date_made DATE NOT NULL,
                               patient_id INT NOT NULL,
                               CONSTRAINT FK_health_status_patient FOREIGN KEY (patient_id) REFERENCES patient(id)
);

-- Tabla: health_result
CREATE TABLE health_result (
                               id INT IDENTITY(1,1) PRIMARY KEY,
                               description VARCHAR(250) NOT NULL,
                               health_status_id INT NOT NULL,
                               CONSTRAINT FK_health_result_health_status FOREIGN KEY (health_status_id) REFERENCES health_status(id)
);

-- Tabla: clinical_history
CREATE TABLE clinical_history (
                                  id INT IDENTITY(1,1) PRIMARY KEY,
                                  create_at DATETIME NOT NULL DEFAULT GETDATE(),
                                  doctor_notes VARCHAR(1000) NOT NULL,
                                  diagnosis VARCHAR(500) NOT NULL,
                                  prescription VARCHAR(500) NOT NULL,
                                  patient_id INT NOT NULL,
                                  CONSTRAINT FK_clinical_history_patient FOREIGN KEY (patient_id) REFERENCES patient(id)
);

-- Tabla: clinical_result
CREATE TABLE clinical_result (
                                 id INT IDENTITY(1,1) PRIMARY KEY,
                                 description VARCHAR(250) NOT NULL,
                                 clinical_history_id INT NOT NULL,
                                 CONSTRAINT FK_clinical_result_clinical_history FOREIGN KEY (clinical_history_id) REFERENCES clinical_history(id)
);

-- Tabla: medicament
CREATE TABLE medicament (
                            id INT IDENTITY(1,1) PRIMARY KEY,
                            name VARCHAR(50) NOT NULL,
                            presentation VARCHAR(500) NOT NULL,
                            dose VARCHAR(50) NOT NULL
);

-- Tabla: indication
CREATE TABLE indication (
                            id INT IDENTITY(1,1) PRIMARY KEY,
                            description VARCHAR(250) NOT NULL,
                            medicament_id INT NOT NULL,
                            CONSTRAINT FK_indication_medicament FOREIGN KEY (medicament_id) REFERENCES medicament(id)
);

-- Tabla: contra_indication
CREATE TABLE contra_indication (
                                   id INT IDENTITY(1,1) PRIMARY KEY,
                                   description VARCHAR(250) NOT NULL,
                                   medicament_id INT NOT NULL,
                                   CONSTRAINT FK_contra_indication_medicament FOREIGN KEY (medicament_id) REFERENCES medicament(id)
);

-- Tabla: prescription
CREATE TABLE prescription (
                              id INT IDENTITY(1,1) PRIMARY KEY,
                              create_at DATETIME NOT NULL DEFAULT GETDATE(),
                              dose VARCHAR(1000) NOT NULL,
                              frequency VARCHAR(50) NOT NULL,
                              duration_treatment VARCHAR(50) NOT NULL,
                              medicament_id INT NOT NULL,
                              patient_id INT NOT NULL,
                              doctor_id INT NOT NULL,
                              CONSTRAINT FK_prescription_medicament FOREIGN KEY (medicament_id) REFERENCES medicament(id),
                              CONSTRAINT FK_prescription_patient FOREIGN KEY (patient_id) REFERENCES patient(id),
                              CONSTRAINT FK_prescription_doctor FOREIGN KEY (doctor_id) REFERENCES doctor(id)
);