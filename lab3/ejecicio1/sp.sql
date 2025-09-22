USE hospital_lab1;
GO
-- Creamos el SP
CREATE PROCEDURE get_adult_patient_prescriptions
    @patient_id INT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM patient
        WHERE id = @patient_id AND DATEDIFF(YEAR, birth_date, GETDATE()) >= 18
    )
BEGIN
SELECT COUNT(*) AS TotalPrescriptions
FROM prescription
WHERE patient_id = @patient_id;
END
END;

-- LLamamos al SP
EXEC get_adult_patient_prescriptions @patient_id = 1;
