use hospital_db



//Creamos colección
db.createCollection("nurse")

//Insetamos información en la colección nuse.
db.nurse.insertMany([
    { nombre: "Pedro Salinas", turno: "noche", especialidad: "vacunación", edad: 25},
    { nombre: "Anabelle Torres", turno: "tarde", especialidad: "cirugía", edad: 40 }
])



//Actualizamos al un enfermero
db.nurse.updateOne(
    { nombre: "Pedro Salinas" },
    { $set: { turno: "mañana" } }
)


//Actualizamos la coleccion medicamento
db.medicament.updateMany(
    {},
    { $set: { stock: 10 } }
)




//Delete 
db.doctor.deleteOne({ school_number: 1002 })

//Eliminamos los todos los medicamentos con stock = 10
db.medicament.deleteMany({ stock: 10 })




//Indices --> insertamos a  registros para ver la diferencia de usar una consulta con indices y sin ellos.
for (let i = 1; i <= 12000; i++) {
    db.doctor.insertOne({
        school_number: 1000 + i * 2,
        name: "Doctor" + i,
        last_name: "Apellido" + i,
        years_experience: Math.floor(Math.random() * 30) + 1,
        consulting_room: (100 + (i % 200)).toString(),
        specialty: ["Cardiology", "Neurology", "Pediatrics", "Dermatology", "Oncology"][i % 5],
        age: Math.floor(Math.random() * 30) + 25
    });
}

//Consultamos Los dcotores con edad 30
db.getCollection("doctor").find({
    age: 30
}).explain("executionStats").executionStats;

//Consultamos Los dcotores con edad 30
db.doctor.find({ age:30 }).explain("executionStats").executionStats;

//Creamos un  indice acendente sobre el campo age.
db.doctor.createIndex({ age: 1 });



//Insertamos las enfermeras

for (let i = 1; i <= 100; i++) {
    db.nurse.insertOne({
        name: "name" + i + " age" + i,
        turn:  ["mañana", "tarde", "noche"][i % 3],
        especiality: [
            "vacunación", "pediatría", "cardiología", "ginecología", "traumatología",
            "dermatología", "neurología", "odontología", "emergencias", "clínica general"
        ][i % 10],
        age: Math.floor(Math.random() * 30) + 25 // entre 25 y 55

    });
}



// Calculamos el pomedio usando $avg
db.doctor.aggregate([{
    $group: {
        _id: null,
        avgAge: { $avg:  "$age"  }
    }
}]);


//Ordenamos acendente usando $sort (1)
db.nurse.aggregate([
    {
        $sort: {age: 1}
    }
]);


//Usamos $sum
db.doctor.aggregate([
    { $group: { _id: "$specialty", totalAniosExperiencia: { $sum: "$years_experience" } } }
]);


//Usamos $first
db.doctor.aggregate([
    { $group: { _id: "$specialty", primerDoctor: { $first: "$name" } } }
]);



// filtramos usando $gt (>=)
db.doctor.aggregate([
    { $match: { years_experience: { $gt: 10 } } }
]);
