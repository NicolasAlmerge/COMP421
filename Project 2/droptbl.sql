-- Include your drop table DDL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the drop table ddls for the tables with foreign key references
--    ONLY AFTER the parent tables has already been dropped (reverse of the creation order).

DROP TABLE MedicalNote;
DROP TABLE MedicalTest;
DROP TABLE Technician;
DROP TABLE Appointment;
DROP TABLE Baby;
DROP TABLE Pregnancy;
DROP TABLE SessionInvites;
DROP TABLE InfoSession;
DROP TABLE Couple;
DROP TABLE Father;
DROP TABLE Mother;
DROP TABLE Midwife;
DROP TABLE BirthingCenter;
DROP TABLE CommunityClinic;
DROP TABLE HealthcareInstitution;

