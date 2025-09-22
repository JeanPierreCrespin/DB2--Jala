package org.mentoring;

import java.sql.*;

/**
 * Hello world!
 *
 */
public class App 
{
    private static final String URL = "jdbc:sqlserver://localhost:1434;databaseName=hospital_lab1;encrypt=false;trustServerCertificate=true;";
    private static final String USER = "sa";
    private static final String PASSWORD = "Jala2025";

    public static void main(String[] args) {
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD)) {
            System.out.println("Conexión establecida");

            // CRUD  medical_appointment
            insertarCita(conn);
            consultarCitas(conn, 1);
            actualizarCita(conn, 1, 2);
            eliminarCita(conn, 1);

            // Llamar a sp
            llamarSPRecetasMayores18(conn, 1);

        } catch (SQLException e) {
            System.out.println("Error de conexión: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // CREATE
    public static void insertarCita(Connection conn) {
        String sql = "INSERT INTO medical_appointment (date_time, reason, status_id, patient_id, doctor_id) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "2025-09-20 10:30:00");
            stmt.setString(2, "Consulta general");
            stmt.setInt(3, 1); // status pendiente
            stmt.setInt(4, 1); // paciente ID
            stmt.setInt(5, 2); // doctor ID
            stmt.executeUpdate();
            System.out.println("Cita insertada.");
        } catch (SQLException e) {
            System.out.println("Error al insertar cita: " + e.getMessage());
        }
    }

    // READ
    public static void consultarCitas(Connection conn, int patientId) {
        String sql = "SELECT * FROM medical_appointment WHERE patient_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, patientId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                System.out.println("Cita ID: " + rs.getInt("id") +
                        " | Motivo: " + rs.getString("reason") +
                        " | Fecha: " + rs.getTimestamp("date_time"));
            }
        } catch (SQLException e) {
            System.out.println("Error al consultar citas: " + e.getMessage());
        }
    }

    // UPDATE
    public static void actualizarCita(Connection conn, int citaId, int nuevoStatus) {
        String sql = "UPDATE medical_appointment SET status_id = ? WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, nuevoStatus);
            stmt.setInt(2, citaId);
            int filas = stmt.executeUpdate();
            if (filas > 0) {
                System.out.println("Cita actualizada con nuevo estado.");
            } else {
                System.out.println("No se encontró la cita con ID: " + citaId);
            }
        } catch (SQLException e) {
            System.out.println("Error al actualizar cita: " + e.getMessage());
        }
    }

    // DELETE
    public static void eliminarCita(Connection conn, int citaId) {
        String sql = "DELETE FROM medical_appointment WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, citaId);
            int filas = stmt.executeUpdate();
            if (filas > 0) {
                System.out.println("Cita eliminada.");
            } else {
                System.out.println("No se encontró la cita con ID: " + citaId);
            }
        } catch (SQLException e) {
            System.out.println("Error al eliminar cita: " + e.getMessage());
        }
    }

    // Procedimiento almacenado
    public static void llamarSPRecetasMayores18(Connection conn, int patientId) {
        String sql = "{call get_adult_patient_prescriptions(?)}";
        try (CallableStatement stmt = conn.prepareCall(sql)) {
            stmt.setInt(1, patientId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int total = rs.getInt("TotalPrescriptions");
                System.out.println("Total de recetas del paciente " + patientId + ": " + total);
            } else {
                System.out.println("No se encontraron recetas para el paciente o es menor de 18 años.");
            }
        } catch (SQLException e) {
            System.out.println("Error al llamar SP: " + e.getMessage());
        }
    }

    public void divide(){
        try {
            int resultado = 10 / 0;
        } catch (ArithmeticException e) {
            System.out.println("Error: división por cero");
        } finally {
            System.out.println("Finalizando operación");
        }

    }
}
