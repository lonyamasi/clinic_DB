-- Create Database
CREATE DATABASE ClinicDB;
USE ClinicDB;

-- Patients Table
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DOB DATE,
    Gender ENUM('Male', 'Female', 'Other'),
    Contact VARCHAR(15) UNIQUE,
    Address TEXT
);

-- Departments Table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100) NOT NULL
);

-- Rooms Table
CREATE TABLE Rooms (
    RoomNumber INT PRIMARY KEY,
    Type ENUM('Consultation', 'Surgery', 'Recovery', 'Waiting'),
    Capacity INT
);

-- Doctors Table
CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Specialization VARCHAR(100),
    Contact VARCHAR(15) UNIQUE,
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Appointments Table
CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    DoctorID INT,
    RoomNumber INT,
    AppointmentDate DATETIME,
    Status ENUM('Scheduled', 'Completed', 'Cancelled'),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    FOREIGN KEY (RoomNumber) REFERENCES Rooms(RoomNumber)
);

CREATE INDEX idx_appointments_patient_doctor 
ON Appointments (PatientID, DoctorID);


-- Billing Table
CREATE TABLE Billing (
    BillID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    Amount DECIMAL(10,2),
    PaymentStatus ENUM('Paid', 'Pending'),
    DateIssued DATE,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

-- Medical Records Table
CREATE TABLE MedicalRecords (
    RecordID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    DoctorID INT,
    Diagnosis TEXT,
    Treatment TEXT,
    DateRecorded DATE,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

CREATE INDEX idx_medicalrecords_patient_doctor 
ON MedicalRecords (PatientID, DoctorID);

-- Staff Table (Non-doctor employees)
CREATE TABLE Staff (
    StaffID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Role ENUM('Nurse', 'Receptionist', 'Lab Technician', 'Administrator'),
    Contact VARCHAR(15) UNIQUE,
    Salary DECIMAL(10,2)
);

-- Inventory Table (Medical supplies, drugs, equipment)
CREATE TABLE Inventory (
    ItemID INT PRIMARY KEY AUTO_INCREMENT,
    ItemName VARCHAR(100),
    Category ENUM('Drug', 'Equipment', 'Supply'),
    Quantity INT,
    ExpiryDate DATE
);

-- Prescriptions Table
CREATE TABLE Prescriptions (
    PrescriptionID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    DoctorID INT,
    ItemID INT,
    Dosage VARCHAR(50),
    Frequency VARCHAR(50),
    Duration VARCHAR(50),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    FOREIGN KEY (ItemID) REFERENCES Inventory(ItemID)
);

CREATE INDEX idx_prescriptions_patient_doctor 
ON Prescriptions (PatientID, DoctorID);


-- Insurance Table
CREATE TABLE Insurance (
    InsuranceID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    Provider VARCHAR(100),
    PolicyNumber VARCHAR(50),
    CoverageDetails TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

-- Lab Tests Table
CREATE TABLE LabTests (
    TestID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    DoctorID INT,
    StaffID INT,
    TestType VARCHAR(100),
    Result TEXT,
    DatePerformed DATE,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

CREATE INDEX idx_labtests_patient_doctor 
ON LabTests (PatientID, DoctorID);

CREATE INDEX idx_labtests_patient_staff 
ON LabTests (PatientID, StaffID);

-- Emergency Contacts Table
CREATE TABLE EmergencyContacts (
    ContactID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    ContactName VARCHAR(50),
    Relationship VARCHAR(50),
    Phone VARCHAR(15),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

-- Schedules Table
CREATE TABLE Schedules (
    ScheduleID INT PRIMARY KEY AUTO_INCREMENT,
    DoctorID INT,
    StaffID INT,
    Day ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'),
    StartTime TIME,
    EndTime TIME,
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);
CREATE INDEX idx_schedules_doctor_day 
ON Schedules (DoctorID, Day);

CREATE INDEX idx_schedules_staff_day 
ON Schedules (StaffID, Day);



