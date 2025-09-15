BEGIN TRANSACTION;
BEGIN TRY
    -- 1. specialty
INSERT INTO specialty (name) VALUES
                                 ('Cardiología'),
                                 ('Neurología'),
                                 ('Pediatría'),
                                 ('Dermatología'),
                                 ('Oncología'),
                                 ('Ginecología'),
                                 ('Traumatología'),
                                 ('Endocrinología'),
                                 ('Oftalmología'),
                                 ('Psiquiatría');

-- 2. blood_type
INSERT INTO blood_type (type) VALUES
                                  ('A+'),('A-'),('B+'),('B-'),('AB+'),
                                  ('AB-'),('O+'),('O-'),('HH'),('AX');

-- 3. medical_appointment_status
INSERT INTO medical_appointment_status (status) VALUES
                                                    ('Pendiente'),
                                                    ('Confirmada'),
                                                    ('Cancelada'),
                                                    ('Completada'),
                                                    ('Reprogramada'),
                                                    ('No Asistió'),
                                                    ('En Curso'),
                                                    ('Derivada'),
                                                    ('Suspendida'),
                                                    ('Bloqueada');

-- 4. address
INSERT INTO address (street, city, country, postal_code) VALUES
                                                             ('Av. Siempre Viva 742','Springfield','USA','12345'),
                                                             ('Calle Falsa 123','Buenos Aires','Argentina','1000'),
                                                             ('Gran Vía 55','Madrid','España','28013'),
                                                             ('Rua das Flores 99','Lisboa','Portugal','1100'),
                                                             ('Oxford St 101','Londres','UK','W1D'),
                                                             ('Rue de Rivoli 77','París','Francia','75001'),
                                                             ('Alexanderplatz 8','Berlín','Alemania','10178'),
                                                             ('Via Roma 45','Roma','Italia','00184'),
                                                             ('Shinjuku 12','Tokio','Japón','160-0022'),
                                                             ('Av. Paulista 500','São Paulo','Brasil','01310');

-- 5. phone
INSERT INTO phone (code_area, n_phone) VALUES
                                           ('011','1234567'),
                                           ('011','9876543'),
                                           ('0341','5556677'),
                                           ('0221','4433221'),
                                           ('0351','7788990'),
                                           ('0381','2233445'),
                                           ('0291','6677889'),
                                           ('0261','5566778'),
                                           ('0232','3344556'),
                                           ('0345','1122334');

-- 6. medicament
INSERT INTO medicament (name, presentation, dose) VALUES
                                                      ('Paracetamol','Tabletas 500mg','500mg'),
                                                      ('Ibuprofeno','Cápsulas 400mg','400mg'),
                                                      ('Amoxicilina','Suspensión 250mg/5ml','250mg'),
                                                      ('Omeprazol','Cápsulas 20mg','20mg'),
                                                      ('Loratadina','Tabletas 10mg','10mg'),
                                                      ('Metformina','Tabletas 850mg','850mg'),
                                                      ('Atorvastatina','Tabletas 40mg','40mg'),
                                                      ('Losartán','Tabletas 50mg','50mg'),
                                                      ('Diazepam','Tabletas 5mg','5mg'),
                                                      ('Insulina','Frasco 100UI/ml','10UI');

-- 7. doctor
INSERT INTO doctor (school_number, name, last_name, years_experience, consulting_room, specialty_id) VALUES
                                                                                                         (1001,'Juan','Pérez',15,'Consultorio 101',1),
                                                                                                         (1002,'María','García',10,'Consultorio 102',2),
                                                                                                         (1003,'Luis','Fernández',8,'Consultorio 103',3),
                                                                                                         (1004,'Ana','Martínez',20,'Consultorio 104',4),
                                                                                                         (1005,'Pedro','López',12,'Consultorio 105',5),
                                                                                                         (1006,'Lucía','Torres',7,'Consultorio 106',6),
                                                                                                         (1007,'Diego','Hernández',18,'Consultorio 107',7),
                                                                                                         (1008,'Sofía','Ramírez',5,'Consultorio 108',8),
                                                                                                         (1009,'Jorge','Díaz',22,'Consultorio 109',9),
                                                                                                         (1010,'Elena','Suárez',9,'Consultorio 110',10);

-- 8. patient
INSERT INTO patient (name, last_name, birth_date, number_insurance, allergies, phone_id, address_id, blood_type_id) VALUES
                                                                                                                        ('Carlos','Mendoza','1990-05-10',20001,'Ninguna',1,1,1),
                                                                                                                        ('Laura','Sánchez','1985-03-15',20002,'Polen',2,2,2),
                                                                                                                        ('Martín','Gómez','2000-07-20',20003,'Penicilina',3,3,3),
                                                                                                                        ('Valeria','Ruiz','1995-11-30',20004,'Ninguna',4,4,4),
                                                                                                                        ('Andrés','Cruz','1978-02-25',20005,'Mariscos',5,5,5),
                                                                                                                        ('Camila','Herrera','1988-09-12',20006,'Aspirina',6,6,6),
                                                                                                                        ('Ricardo','Morales','1992-01-08',20007,'Ninguna',7,7,7),
                                                                                                                        ('Natalia','Ortiz','2001-06-22',20008,'Gluten',8,8,8),
                                                                                                                        ('Fernando','Silva','1983-04-18',20009,'Lácteos',9,9,9),
                                                                                                                        ('Paula','Vega','1999-12-05',20010,'Ninguna',10,10,10);

-- 9. business_hours
INSERT INTO business_hours (start_date, end_date, doctor_id) VALUES
                                                                 ('08:00','12:00',1),
                                                                 ('09:00','13:00',2),
                                                                 ('10:00','14:00',3),
                                                                 ('14:00','18:00',4),
                                                                 ('15:00','19:00',5),
                                                                 ('08:00','12:00',6),
                                                                 ('09:00','13:00',7),
                                                                 ('10:00','14:00',8),
                                                                 ('14:00','18:00',9),
                                                                 ('15:00','19:00',10);

-- 10. medical_appointment
INSERT INTO medical_appointment (date_time, reason, status_id, patient_id, doctor_id) VALUES
                                                                                          ('2025-09-01 09:00','Chequeo general',1,1,1),
                                                                                          ('2025-09-02 10:00','Dolor de cabeza',2,2,2),
                                                                                          ('2025-09-03 11:00','Fiebre alta',3,3,3),
                                                                                          ('2025-09-04 14:00','Control dermatológico',4,4,4),
                                                                                          ('2025-09-05 15:00','Consulta oncología',5,5,5),
                                                                                          ('2025-09-06 09:30','Revisión ginecológica',6,6,6),
                                                                                          ('2025-09-07 10:30','Chequeo traumatología',7,7,7),
                                                                                          ('2025-09-08 11:30','Control endocrinología',8,8,8),
                                                                                          ('2025-09-09 16:00','Revisión oftalmológica',9,9,9),
                                                                                          ('2025-09-10 17:00','Consulta psiquiatría',10,10,10);

-- 11. health_status
INSERT INTO health_status (type_test, description, date_made, patient_id) VALUES
                                                                              ('Análisis de sangre','Hemograma completo','2025-09-01',1),
                                                                              ('Radiografía','Rayos X de tórax','2025-09-02',2),
                                                                              ('Electrocardiograma','ECG en reposo','2025-09-03',3),
                                                                              ('Resonancia','RMN cerebral','2025-09-04',4),
                                                                              ('Ecografía','Abdominal','2025-09-05',5),
                                                                              ('Colonoscopia','Revisión preventiva','2025-09-06',6),
                                                                              ('Endoscopia','Revisión gástrica','2025-09-07',7),
                                                                              ('Prueba de alergia','Test cutáneo','2025-09-08',8),
                                                                              ('Audiometría','Evaluación auditiva','2025-09-09',9),
                                                                              ('Oftalmología','Examen de la vista','2025-09-10',10);

-- 12. health_result
INSERT INTO health_result (description, health_status_id) VALUES
                                                              ('Normal',1),('Anomalía detectada',2),('Normal',3),('Pequeña lesión',4),('Normal',5),
                                                              ('Polipos detectados',6),('Gastritis leve',7),('Alergia confirmada',8),('Normal',9),('Miopía leve',10);

-- 13. clinical_history
INSERT INTO clinical_history (doctor_notes, diagnosis, prescription, patient_id) VALUES
                                                                                     ('Paciente estable','Gripe común','Paracetamol 500mg cada 8h',1),
                                                                                     ('Dolor persistente','Migraña','Ibuprofeno 400mg cada 12h',2),
                                                                                     ('Fiebre alta','Infección viral','Reposo e hidratación',3),
                                                                                     ('Dermatitis leve','Alergia cutánea','Loratadina 10mg cada 24h',4),
                                                                                     ('Control oncológico','Bajo observación','Seguimiento médico',5),
                                                                                     ('Chequeo rutinario','Sin hallazgos','Continuar hábitos saludables',6),
                                                                                     ('Lesión deportiva','Esguince','Reposo y fisioterapia',7),
                                                                                     ('Diabetes controlada','Hiperglucemia leve','Metformina 850mg cada 12h',8),
                                                                                     ('Problemas de visión','Miopía','Lentes recetados',9),
                                                                                     ('Ansiedad','Trastorno de ansiedad','Terapia psicológica',10);

-- 14. clinical_result
INSERT INTO clinical_result (description, clinical_history_id) VALUES
                                                                   ('Mejoría notable',1),('Dolor recurrente',2),('Fiebre controlada',3),('Sin brotes',4),('En estudio',5),
                                                                   ('Normal',6),('Recuperación parcial',7),('Glucosa en rango',8),('Visión corregida',9),('Ansiedad moderada',10);

-- 15. indication
INSERT INTO indication (description, medicament_id) VALUES
                                                        ('Dolor leve',1),('Inflamación',2),('Infección bacteriana',3),('Reflujo gástrico',4),('Alergia',5),
                                                        ('Diabetes tipo 2',6),('Colesterol alto',7),('Hipertensión',8),('Ansiedad',9),('Diabetes tipo 1',10);

-- 16. contra_indication
INSERT INTO contra_indication (description, medicament_id) VALUES
                                                               ('Problemas hepáticos',1),('Úlcera gástrica',2),('Alergia a penicilina',3),('Embarazo',4),('Insuficiencia renal',5),
                                                               ('Acidosis láctica',6),('Enfermedad hepática',7),('Hiperpotasemia',8),('Depresión severa',9),('Hipoglucemia',10);

-- 17. prescription
INSERT INTO prescription (dose, frequency, duration_treatment, medicament_id, patient_id, doctor_id) VALUES
                                                                                                         ('500mg','Cada 8h','5 días',1,1,1),
                                                                                                         ('400mg','Cada 12h','7 días',2,2,2),
                                                                                                         ('250mg','Cada 8h','10 días',3,3,3),
                                                                                                         ('20mg','Cada 24h','14 días',4,4,4),
                                                                                                         ('10mg','Cada 24h','30 días',5,5,5),
                                                                                                         ('850mg','Cada 12h','90 días',6,6,6),
                                                                                                         ('40mg','Cada 24h','60 días',7,7,7),
                                                                                                         ('50mg','Cada 12h','180 días',8,8,8),
                                                                                                         ('5mg','Cada 24h','15 días',9,9,9),
                                                                                                         ('10UI','Antes de las comidas','Indefinido',10,10,10);

COMMIT;
END TRY
BEGIN CATCH
   ROLLBACK;
END CATCH;
GO
