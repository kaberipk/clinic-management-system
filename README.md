# Clinic Management System Database

## 📋 Project Overview
A complete relational database system for managing a medical clinic, built with MySQL.

## 🗄️ Database Schema

### Tables
1. **specializations** - Medical specializations
2. **doctors** - Medical practitioners
3. **patients** - Patient information
4. **appointments** - Scheduling system

### 🔗 Relationships
- One-to-Many: Doctors → Appointments
- One-to-Many: Patients → Appointments
- One-to-Many: Specializations → Doctors

## 🚀 Installation
1. Execute the `clinic_database.sql` script in MySQL
2. The script will create the database and insert sample data

## 📊 Sample Queries
```sql
-- View all appointments
SELECT * FROM appointments;

-- Find appointments for a specific doctor
SELECT * FROM appointments WHERE doctor_id = 1;