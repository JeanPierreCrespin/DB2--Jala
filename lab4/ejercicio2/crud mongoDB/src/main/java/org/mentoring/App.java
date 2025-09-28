package org.mentoring;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoDatabase;
import com.mongodb.MongoException;
import com.mongodb.client.*;
import org.bson.Document;
/**
 * Hello world!
 *
 */
public class App 
{
    public static void main(String[] args) {
        String uri = "mongodb://localhost:27017";
        String dbName = "hospital_db";
        String collectionName = "doctor";

        // Crear cliente de conexión
        try (MongoClient mongoClient = MongoClients.create(uri)) {

            // Selecionamos Base de Datos
            MongoDatabase database = mongoClient.getDatabase(dbName);
            // Selecionamos la collection
            MongoCollection<Document> collection = database.getCollection(collectionName);

            System.out.println("Conectado a MongoDB ...");

            // ------------------ CREATE ------------------
            try {
                Document doctor = new Document("school_number", 10009)
                        .append("name", "Ana")
                        .append("last_name", "Rodriguez")
                        .append("years_experience", 15)
                        .append("consulting_room", "103")
                        .append("specialty", "Pediatrics");

                collection.insertOne(doctor);
                System.out.println("Doctor agregado corectamente: " + doctor.toJson());

            } catch (MongoException e) {
                System.err.println("Error al agregar un  doctor: " + e.getMessage());
            }

            // ------------------ READ ------------------
            try {
                Document filtro = new Document("years_experience", 10);
                FindIterable<Document> doctors = collection.find(filtro).limit(3);

                System.out.println("Listamos los doctores:");
                for (Document d : doctors) {
                    System.out.println(d.toJson());
                }
            } catch (MongoException e) {
                System.err.println("Error al leer los doctores: " + e.getMessage());
            }

            // ------------------ UPDATE ------------------
            try {
                Document filtro = new Document("name", "Ana");
                Document actualizacion = new Document("$set", new Document("years_experience", 20));

                collection.updateOne(filtro, actualizacion);
                System.out.println("Doctor actualizado correctamente");

            } catch (MongoException e) {
                System.err.println("Error al actualizar doctor: " + e.getMessage());
            }

            // ------------------ DELETE ------------------
            try {
                Document filtroDelete = new Document("name", "Ana");
                collection.deleteOne(filtroDelete);
                System.out.println("Doctor eliminado correctamente");
            } catch (MongoException e) {
                System.err.println("Error al eliminar doctor: " + e.getMessage());
            }

        } catch (MongoException e) {
            System.err.println("Error, no podemos conectarnos a mongoDB: " + e.getMessage());
        }
    }
}
