-- 2. CREATE DATABASE
CREATE DATABASE clinic_management_system;
USE clinic_management_system;

-- 3. CREATE TABLES (in correct order)
CREATE TABLE specializations (
    specialization_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization_id INT NOT NULL,
    license_number VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) NOT NULL,
    address TEXT,
    date_of_birth DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    hire_date DATE NOT NULL,
    salary DECIMAL(10, 2) CHECK (salary >= 0),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (specialization_id) REFERENCES specializations(specialization_id) ON DELETE RESTRICT,
    CONSTRAINT chk_doctor_email CHECK (email LIKE '%@%.%')
);

CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) NOT NULL,
    address TEXT NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    emergency_contact_name VARCHAR(100),
    emergency_contact_phone VARCHAR(15),
    blood_type ENUM('A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'),
    allergies TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT chk_patient_email CHECK (email LIKE '%@%.%')
);

CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled', 'No-Show') DEFAULT 'Scheduled',
    reason TEXT NOT NULL,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE CASCADE,
    UNIQUE KEY unique_doctor_timeslot (doctor_id, appointment_date, appointment_time),
    CONSTRAINT chk_appointment_time CHECK (
        (TIME(appointment_time) BETWEEN '08:00:00' AND '12:00:00') OR 
        (TIME(appointment_time) BETWEEN '13:00:00' AND '17:00:00')
    )
);

-- 4. INSERT DATA (in correct order)
-- First: Specializations
INSERT INTO specializations (name, description) VALUES
('Cardiology', 'Heart and cardiovascular system specialists'),
('Pediatrics', 'Medical care for infants, children, and adolescents'),
('Dermatology', 'Skin, hair, and nail condition specialists');

-- Second: Doctors (they reference specializations)
INSERT INTO doctors (first_name, last_name, specialization_id, license_number, email, phone, address, date_of_birth, gender, hire_date, salary) VALUES
('Sarah', 'Johnson', 1, 'MED123456', 's.johnson@clinic.com', '555-0101', '123 Medical Dr', '1980-03-15', 'Female', '2015-06-10', 95000.00),
('Michael', 'Chen', 2, 'MED654321', 'm.chen@clinic.com', '555-0102', '456 Health Ave', '1975-08-22', 'Male', '2012-02-15', 89000.00),
('Lisa', 'Rodriguez', 3, 'MED789012', 'l.rodriguez@clinic.com', '555-0103', '789 Care Rd', '1985-11-30', 'Female', '2018-09-05', 82000.00);

-- Third: Patients (independent)
INSERT INTO patients (first_name, last_name, email, phone, address, date_of_birth, gender, emergency_contact_name, emergency_contact_phone, blood_type, allergies) VALUES
('John', 'Doe', 'john.doe@email.com', '555-0201', '123 Main St', '1985-03-15', 'Male', 'Jane Doe', '555-0202', 'O+', 'Penicillin'),
('Jane', 'Smith', 'jane.smith@email.com', '555-0203', '456 Oak Ave', '1990-07-22', 'Female', 'John Smith', '555-0204', 'A-', 'Shellfish'),
('Robert', 'Brown', 'robert.brown@email.com', '555-0205', '789 Pine Rd', '1978-11-30', 'Male', 'Mary Brown', '555-0206', 'B+', 'Peanuts');

-- Fourth: Appointments (they reference both patients and doctors)
INSERT INTO appointments (patient_id, doctor_id, appointment_date, appointment_time, reason) VALUES
(1, 2, '2024-02-15', '10:00:00', 'Annual checkup'),
(2, 1, '2024-02-16', '14:30:00', 'Heart palpitations'),
(3, 3, '2024-02-17', '11:15:00', 'Skin rash examination');

-- 5. VERIFY EVERYTHING WORKED
SELECT '=== SPECIALIZATIONS ===' AS '';
SELECT * FROM specializations;

SELECT '=== DOCTORS ===' AS '';
SELECT * FROM doctors;

SELECT '=== PATIENTS ===' AS '';
SELECT * FROM patients;

SELECT '=== APPOINTMENTS ===' AS '';
SELECT * FROM appointments;

SELECT 'DATABASE CREATED SUCCESSFULLY!' AS STATUS;