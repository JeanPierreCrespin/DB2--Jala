
// Insert Data
db.medicament.insertMany([
    { name: "Ibuprofen", presentation: "Tablet 200mg", dose: "1 tablet every 8h" },
    { name: "Amoxicillin", presentation: "Capsule 500mg", dose: "1 capsule every 12h" },
    { name: "Paracetamol", presentation: "Tablet 500mg", dose: "1 tablet every 6h" },
    { name: "Lisinopril", presentation: "Tablet 10mg", dose: "1 tablet daily" },
    { name: "Metformin", presentation: "Tablet 850mg", dose: "1 tablet every 12h" },
    { name: "Atorvastatin", presentation: "Tablet 20mg", dose: "1 tablet nightly" },
    { name: "Omeprazole", presentation: "Capsule 20mg", dose: "1 capsule before breakfast" },
    { name: "Ciprofloxacin", presentation: "Tablet 500mg", dose: "1 tablet every 12h" },
    { name: "Prednisone", presentation: "Tablet 10mg", dose: "1 tablet daily for 5 days" },
    { name: "Levothyroxine", presentation: "Tablet 50mcg", dose: "1 tablet daily before breakfast" }
])

db.doctor.insertMany([
    { school_number: 1001, name: "Laura", last_name: "Gomez", years_experience: 12, consulting_room: "101", specialty: "Cardiology" },
    { school_number: 1002, name: "Carlos", last_name: "Martínez", years_experience: 8, consulting_room: "102", specialty: "Neurology" },
    { school_number: 1003, name: "Ana", last_name: "Rodriguez", years_experience: 15, consulting_room: "103", specialty: "Pediatrics" },
    { school_number: 1004, name: "Miguel", last_name: "Fernandez", years_experience: 10, consulting_room: "104", specialty: "Dermatology" },
    { school_number: 1005, name: "Sofía", last_name: "Lopez", years_experience: 9, consulting_room: "105", specialty: "Gastroenterology" },
    { school_number: 1006, name: "Diego", last_name: "Hernandez", years_experience: 7, consulting_room: "106", specialty: "Endocrinology" },
    { school_number: 1007, name: "Carla", last_name: "Vega", years_experience: 11, consulting_room: "107", specialty: "Orthopedics" },
    { school_number: 1008, name: "Ricardo", last_name: "Silva", years_experience: 14, consulting_room: "108", specialty: "Cardiology" },
    { school_number: 1009, name: "Valentina", last_name: "Ramos", years_experience: 6, consulting_room: "109", specialty: "Neurology" },
    { school_number: 1010, name: "Javier", last_name: "Castro", years_experience: 13, consulting_room: "110", specialty: "Pediatrics" }
])


db.patient.insertMany([
    { name: "María", last_name: "González", birth_date: ISODate("1985-04-12"), number_insurance: 987654321, allergies: ["Penicilina", "Mariscos"], phone: { code_area: "123", number: "555-1234" }, address: { street: "Calle Principal 123", city: "Ciudad", country: "País", postal_code: "12345" }, blood_type: "A+" },
    { name: "Juan", last_name: "Pérez", birth_date: ISODate("1990-06-20"), number_insurance: 123456789, allergies: [], phone: { code_area: "011", number: "444-5678" }, address: { street: "Av. Secundaria 456", city: "Ciudad", country: "País", postal_code: "54321" }, blood_type: "O-" },
    { name: "Lucía", last_name: "Martínez", birth_date: ISODate("1978-12-05"), number_insurance: 234567890, allergies: ["Aspirina"], phone: { code_area: "022", number: "555-9876" }, address: { street: "Calle 9 de Julio 789", city: "Ciudad", country: "País", postal_code: "23456" }, blood_type: "B+" },
    { name: "Diego", last_name: "Ramírez", birth_date: ISODate("2000-03-15"), number_insurance: 345678901, allergies: [], phone: { code_area: "033", number: "555-6789" }, address: { street: "Av. Libertador 321", city: "Ciudad", country: "País", postal_code: "34567" }, blood_type: "AB-" },
    { name: "Valentina", last_name: "Sosa", birth_date: ISODate("1995-08-22"), number_insurance: 456789012, allergies: ["Polen"], phone: { code_area: "044", number: "555-4321" }, address: { street: "Calle Falsa 456", city: "Ciudad", country: "País", postal_code: "45678" }, blood_type: "A-" },
    { name: "Santiago", last_name: "Torres", birth_date: ISODate("1982-11-30"), number_insurance: 567890123, allergies: ["Mariscos"], phone: { code_area: "055", number: "555-8765" }, address: { street: "Av. Córdoba 987", city: "Ciudad", country: "País", postal_code: "56789" }, blood_type: "O+" },
    { name: "Isabella", last_name: "Vargas", birth_date: ISODate("1975-07-18"), number_insurance: 678901234, allergies: ["Penicilina"], phone: { code_area: "066", number: "555-3456" }, address: { street: "Calle Rivadavia 654", city: "Ciudad", country: "País", postal_code: "67890" }, blood_type: "B-" },
    { name: "Matías", last_name: "García", birth_date: ISODate("1998-02-10"), number_insurance: 789012345, allergies: [], phone: { code_area: "077", number: "555-2345" }, address: { street: "Av. San Martín 321", city: "Ciudad", country: "País", postal_code: "78901" }, blood_type: "AB+" },
    { name: "Camila", last_name: "Fernández", birth_date: ISODate("2002-09-05"), number_insurance: 890123456, allergies: ["Aspirina"], phone: { code_area: "088", number: "555-5432" }, address: { street: "Calle Belgrano 123", city: "Ciudad", country: "País", postal_code: "89012" }, blood_type: "A+" },
    { name: "Tomás", last_name: "Rojas", birth_date: ISODate("1988-05-25"), number_insurance: 901234567, allergies: [], phone: { code_area: "099", number: "555-6543" }, address: { street: "Av. Libertad 456", city: "Ciudad", country: "País", postal_code: "90123" }, blood_type: "O-" }
])


// Consult

// Creamos la collection medicament
db.createCollection("medicament")

// Listamos todos los doctores de la colección
db.doctor.find().pretty()

// Listamos todos los pacientes de una colección
db.patient.find().pretty()

// Actualizar un documento específico
db.doctor.updateOne(
    { name: "Laura", last_name: "Gomez" },
    { $set: { consulting_room: "AA05", years_experience: 8 } }
)

// Actualizar múltiples documentos
db.doctor.updateMany(
    { years_experience: { $lt: 8 } },
    { $set: { consulting_room: "Consultorio General" } }
)

// Eliminar un documento específico
db.doctor.deleteOne({ name: "María" })

// Eliminar todos los doctores de una especialidad específica
db.doctor.deleteMany({ specialty: "Cardiology" })