create database university_healthcare_db;

use university_healthcare_db;

-- STUDENT TABLE

CREATE TABLE Student (
    StudentID NUMERIC(7) NOT NULL,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Gender ENUM('Male', 'Female', 'Other'),
    Address VARCHAR(255) NOT NULL,
    ZipCode NUMERIC(5) NOT NULL,
    ContactNumber NUMERIC(10) UNIQUE,
    PRIMARY KEY(StudentID),
    UniversityID NUMERIC(7),
    FOREIGN KEY(UniversityId) REFERENCES University(UniversityID)
);


CREATE TABLE University(
	UniversityID NUMERIC(7) NOT NULL,
    UniversityName VARCHAR(255) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    ZipCode NUMERIC(5) NOT NULL,
    ContactNumber NUMERIC(10) NOT NULL,
    PRIMARY KEY(UniversityID),
    ProviderID NUMERIC(7),
    FOREIGN KEY(UniversityId) REFERENCES HealthcareProvider(ProviderID)
    
);



-- MEDICAL PROFESSIONALS TABLE

CREATE TABLE MedicalProfessionals(
	MPID NUMERIC(7) NOT NULL,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Speciality VARCHAR(255),
    Gender ENUM('Male', 'Female', 'Other') NOT NULL,
    Address VARCHAR(255),
    ZipCode NUMERIC(5) NOT NULL,
    ContactNumber numeric(10),
    PRIMARY KEY (MPID),
    FileNumber NUMERIC(10) NOT NULL,
    ProviderID NUMERIC(5) NOT NULL,
    FOREIGN KEY(FileNumber) REFERENCES StudentMedicalRecords(FileNumber),
    FOREIGN KEY(ProviderID) REFERENCES HealthcareProvider(ProviderID)
);

-- INSURANCE TABLE

CREATE TABLE Insurance(
	InsuranceID NUMERIC(10) NOT NULL,
    InsuranceName VARCHAR(255) NOT NULL,
    CoverageAmount DECIMAL(13,2),
    PRIMARY KEY (InsuranceID)
);


-- STUDENT MEDICAL RECORDS

CREATE TABLE StudentMedicalRecords(
	FileNumber NUMERIC(10) NOT NULL,
    InsuranceNumber VARCHAR(255),
    CoverageAmount DECIMAL(13,2),
    PRIMARY KEY (FileNumber),
    ProviderID NUMERIC(7) NOT NULL,
    StudentID NUMERIC(7) NOT NULL,   
	FOREIGN KEY(ProviderID) REFERENCES HealthcareProvider(ProviderID),
    FOREIGN KEY(StudentID) REFERENCES Student(StudentID)
);


-- HEALTHCARE PROVIDER

CREATE TABLE HealthcareProvider(
	ProviderID NUMERIC(7) NOT NULL,
    Name VARCHAR(255) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    ZipCode NUMERIC(5) NOT NULL,
    ContactNumber NUMERIC(10) NOT NULL,
    PRIMARY KEY (ProviderID),
    InsuranceID NUMERIC(10) NOT NULL,
    FOREIGN KEY(InsuranceID) REFERENCES Insurance(InsuranceID)
);

-- BILLS

CREATE TABLE Bills(
	BillNumber NUMERIC(10) NOT NULL,
    BillAmount DECIMAL(13,2),
    BillFileNumber NUMERIC NOT NULL,
    PRIMARY KEY (BillNumber),
    FileNumber NUMERIC(10),
    FOREIGN KEY(FileNumber) REFERENCES StudentMedicalRecords(FileNumber)
);


-- PHARMACIES

CREATE TABLE Pharmacies(
	PharmacyID NUMERIC(10) NOT NULL,
    PharmacyName VARCHAR(255) NOT NULL,
    QuantityPrescribed NUMERIC,
    MedicineCode VARCHAR(255),
    PRIMARY KEY (PharmacyID),
    FileNumber NUMERIC(10) NOT NULL,
    FOREIGN KEY(FileNumber) REFERENCES StudentMedicalRecords(FileNumber)
);


-- altered table to add in medicines attribute




-- alter tables for address attribute wherever necessary to 
-- separate the columns into st, zipcode, state, county, country
-- change contact number attribute type to int(10)
-- add other tables from normalized tables to where they belong
-- check if anymore tables need to be added
