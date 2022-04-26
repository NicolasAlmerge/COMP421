-- Include your create table DDL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the create table ddls for the tables with foreign key references
--    ONLY AFTER the parent tables has already been created.


------ HEALTHCARE INSTITUTION AND SUBTYPES ---------

CREATE TABLE HealthcareInstitution (
	email VARCHAR(50) NOT NULL,
	name VARCHAR(50) NOT NULL,
	phonenumber VARCHAR(50) NOT NULL,
	address VARCHAR(50) NOT NULL,
	website VARCHAR(50),
	PRIMARY KEY(email)
);

CREATE TABLE CommunityClinic (
	email VARCHAR(50) NOT NULL,
	PRIMARY KEY(email),
	FOREIGN KEY(email) REFERENCES HealthcareInstitution
);

CREATE TABLE BirthingCenter (
	email VARCHAR(50) NOT NULL,
        PRIMARY KEY(email),
        FOREIGN KEY(email) REFERENCES HealthcareInstitution
);


------- MIDWIFE --------

CREATE TABLE Midwife (
	pid INTEGER NOT NULL,
	name VARCHAR(50) NOT NULL,
	email VARCHAR(50) NOT NULL UNIQUE,
	phonenumber VARCHAR(50) NOT NULL,
	worksat VARCHAR(50) NOT NULL,
	PRIMARY KEY(pid),
	FOREIGN KEY(worksat) REFERENCES HealthcareInstitution
);


------- COUPLE / MOTHER / FATHER ----------

CREATE TABLE Mother (
	hcardid CHAR(12) NOT NULL,
	name VARCHAR(50) NOT NULL,
	email VARCHAR(50) NOT NULL UNIQUE,
	blood CHAR(3) NOT NULL,
	phonenumber VARCHAR(50) NOT NULL,
	profession VARCHAR(50) NOT NULL,
	address VARCHAR(50) NOT NULL,
	dateofbirth DATE NOT NULL,
	PRIMARY KEY(hcardid)
);

CREATE TABLE Father (
	fid INTEGER NOT NULL,
        name VARCHAR(50) NOT NULL,
        email VARCHAR(50),
	hcardid CHAR(12),
	dateofbirth DATE NOT NULL,
	blood CHAR(3),
	phonenumber VARCHAR(50) NOT NULL,
	profession VARCHAR(50) NOT NULL,
	address VARCHAR(50),
        PRIMARY KEY(fid)
);

CREATE TABLE Couple (
	cid INTEGER NOT NULL,
	mcardid CHAR(12) NOT NULL,
	fid INTEGER,
	PRIMARY KEY(cid),
	FOREIGN KEY(mcardid) REFERENCES Mother,
	FOREIGN KEY(fid) REFERENCES Father
);


----- INFO SESSION & INVITES -----

CREATE TABLE InfoSession (
	midwifeid INTEGER NOT NULL,
	sessiondate DATE NOT NULL,
	sessiontime TIME NOT NULL,
	language VARCHAR(50) NOT NULL,
	PRIMARY KEY(midwifeid, sessiondate, sessiontime),
	FOREIGN KEY(midwifeid) REFERENCES Midwife
);

CREATE TABLE SessionInvites (
	midwifeid INTEGER NOT NULL,
	sessiondate DATE NOT NULL,
	sessiontime TIME NOT NULL,
	coupleid INTEGER NOT NULL,
	registered SMALLINT CHECK(registered = 0 OR registered = 1) NOT NULL,
	attended SMALLINT CHECK(attended = 0 OR attended = 1) NOT NULL,
	CHECK(registered = 1 OR attended = 0),
	PRIMARY KEY(midwifeid, sessiondate, sessiontime, coupleid),
	FOREIGN KEY(midwifeid, sessiondate, sessiontime) REFERENCES InfoSession,
	FOREIGN KEY(coupleid) REFERENCES Couple
);



------ PREGNANCY & BABY ------

CREATE TABLE Pregnancy (
	id INTEGER NOT NULL,
	numbr INTEGER NOT NULL CHECK(numbr >= 1),
	finalduedate DATE,
	initialduedate DATE,
	birthplacedecided SMALLINT CHECK(birthplacedecided = 0 OR birthplacedecided = 1) NOT NULL DEFAULT 0,
	expectedbirthtimeframe DATE,
	lastperiod DATE,
	cid INTEGER NOT NULL,
	assistedby INTEGER,
	backupby INTEGER,
	birthat VARCHAR(50),
	PRIMARY KEY(id),
	FOREIGN KEY(cid) REFERENCES Couple,
	FOREIGN KEY(assistedby) REFERENCES Midwife,
	FOREIGN KEY(backupby) REFERENCES Midwife,
	FOREIGN KEY(birthat) REFERENCES BirthingCenter,
	CHECK(birthplacedecided = 1 OR birthat IS NULL),
	CHECK(backupby IS NULL OR backupby <> assistedby)
);

CREATE TABLE Baby (
	id INTEGER NOT NULL,
	name VARCHAR(50),
	gender CHAR(1) CHECK(gender = 'M' OR gender = 'F') NOT NULL,
	blood CHAR(3),
	birthdate DATE,
	birthtime TIME,
	pregn INTEGER NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(pregn) REFERENCES Pregnancy
);


------ APPOINTMENT, TESTS & NOTES ------

CREATE TABLE Appointment (
	id INTEGER NOT NULL,
	adate DATE NOT NULL,
	atime TIME NOT NULL,
	mainmidwife SMALLINT NOT NULL CHECK(mainmidwife = 0 OR mainmidwife = 1),
	pregn INTEGER NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(pregn) REFERENCES Pregnancy
);

CREATE TABLE Technician (
	id INTEGER NOT NULL,
	name VARCHAR(50) NOT NULL,
	phonenumber VARCHAR(50) NOT NULL,
	PRIMARY KEY(id)
);

CREATE TABLE MedicalTest (
	id INTEGER NOT NULL,
	testtype VARCHAR(50) NOT NULL,
	dateprescribed DATE NOT NULL,
	datesampletaken DATE,
	datelabworkdone DATE,
	result VARCHAR(500),
	appointmentid INTEGER NOT NULL,
	techid INTEGER,
	babyid INTEGER,
	PRIMARY KEY(id),
	FOREIGN KEY(appointmentid) REFERENCES Appointment,
	FOREIGN KEY(techid) REFERENCES Technician,
	FOREIGN KEY(babyid) REFERENCES Baby,
	CHECK(datelabworkdone IS NULL OR datelabworkdone >= dateprescribed)
);

CREATE TABLE MedicalNote (
	appointmentid INTEGER NOT NULL,
	notedate DATE NOT NULL,
	notetime TIME NOT NULL,
	content VARCHAR(500),
	PRIMARY KEY(appointmentid, notedate, notetime),
	FOREIGN KEY(appointmentid) REFERENCES Appointment
);

