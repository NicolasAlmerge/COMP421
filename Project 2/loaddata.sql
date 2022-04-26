-- Include your INSERT SQL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO cs421;

-- Remember to put the INSERT statements for the tables with foreign key references
--    ONLY AFTER the parent tables!


INSERT INTO HealthcareInstitution(email, name, phonenumber, address) VALUES
	('contact@goodbirthingcenter.com', 'Lac-Saint-Louis', '+1 555 666 1234', '111 Good Street, Montreal'),
	('hello@verygoodclinic.com', 'Very Good Clinic', '+1 973 278 1000', '123 Somewhere Street, Quebec'),
	('nicholasclinic@dingmail.com', 'Nicholas Clinic', '+1 756 756 7566', '9 Canada Street, Quebec'),
	('badcenter@hellomail.ca', 'Bad Center', '+1 867 867 3122', '139 Bad Street, Laval')
;

INSERT INTO HealthcareInstitution(email, name, phonenumber, address, website) VALUES
	('theamazingbirthingcenter@email.com', 'Amazing Birthing Center', '+1 234 567 8900', '999 Amazing Street, Montreal', 'www.amazingcenter.com'),
	('center421@email.com', 'Center 421', '+1 421 421 9000', '421 Computer Science Street, Montreal', 'www.center421.com'),
	('contact@clinic500.com', 'Clinic 500', '+1 500 005 1876', '500 Medical Street, Toronto', 'www.clinic500.com'),
	('contact@awesomeclinic.com', 'Awesome Clinic', '+1 999 999 1111', '888 Awesome Street, Montreal', 'www.awesomeclinic.com'),
	('contact@newlifecenter.com', 'New Life Center', '+1 345 567 1789', '777 University Street, Montreal', 'www.newlifecenter.com'),
	('hi@quebeccenter.ca', 'Quebec Center', '+1 777 111 7711', '825 Somewhere Street, Quebec', 'quebecscenter.ca')
;


INSERT INTO CommunityClinic(email) VALUES
	('contact@goodbirthingcenter.com'),
	('hello@verygoodclinic.com'),
	('contact@clinic500.com'),
	('contact@awesomeclinic.com'),
	('nicholasclinic@dingmail.com')
;


INSERT INTO BirthingCenter(email) VALUES
	('theamazingbirthingcenter@email.com'),
	('center421@email.com'),
	('badcenter@hellomail.ca'),
	('contact@newlifecenter.com'),
	('hi@quebeccenter.ca')
;


INSERT INTO Midwife(pid, name, email, phonenumber, worksat) VALUES
	(1001, 'Marion Girard', 'marion.girard@helloworld.com', '+1 892 892 7777', 'theamazingbirthingcenter@email.com'),
	(1002, 'Aurelia Beta', 'aureliabeta@gmail.com', '+1 123 123 4567', 'contact@goodbirthingcenter.com'),
	(1003, 'Charlotte Charly', 'charlycharlotte@coldmail.com', '+1 889 675 5512', 'badcenter@hellomail.ca'),
	(1004, 'Raphaelle Laval', 'lavalra@hmail.com', '+1 690 850 5378', 'contact@goodbirthingcenter.com'),
	(1005, 'Vanessa Ojen', 'ojen.v@gmail.com', '+1 430 555 1286', 'hi@quebeccenter.ca'),
	(1006, 'Valeria Uper', 'valeriauper@coldmail.com', '+1 528 476 4906', 'badcenter@hellomail.ca'),
	(1007, 'Suzanne Fox', 'fox.suzanne@gmail.com', '+1 276 366 1696', 'nicholasclinic@dingmail.com')
;


INSERT INTO Mother(hcardid, name, email, blood, phonenumber, profession, address, dateofbirth) VALUES
	('GUTV01020101', 'Victoria Gutierrez', 'gutirrez.victoria@gmail.com', 'A+', '+1 897 786 1334', 'Lepidopterist', '65 University Street, Montreal', '1979-01-05'),
	('OLGA69829129', 'Altagracia Olgica', 'olgica.alta@gmail.com', 'O+', '+1 371 861 4508', 'Professor', '532 Random Street, Quebec', '1987-05-29'),
	('THEM73833011', 'Muge Themar', 'mugethemar@hmail.com', 'A-', '+1 974 402 9089', 'Housewife', '423 Awesome Street, Montreal', '1980-12-12'),
	('RINS37759073', 'Sameera Rina', 'rinas@gmail.com', 'A-', '+1 870 717 6144', 'Housewife', '23 Unknown Street, Toronto', '1983-06-04'),
	('ALIL74509607', 'Liberia Alison', 'alisonl@gmail.com', 'B+', '+1 406 314 7755', 'Architect', '78 Hello Street, Montreal', '1995-08-16'),
	('ESTV86397320', 'Viktoria Esther', 'estherviktoria@mailservice.ca', 'AB+', '+1 467 332 9099', 'Music Composer', '996 Good Street, Montreal', '1979-03-08'),
	('CHEJ36149226', 'Janiyah Cher', 'cherj@gmail.com', 'O-', '+1 348 872 4630', 'Author', '834 Saint-Catherine Street, Montreal', '1983-11-27')
;

INSERT INTO Father(fid, name, email, hcardid, dateofbirth, blood, phonenumber, profession, address) VALUES
	(1001, 'Chandler Yolotli', 'yolot.chand@gmail.com', 'YOLC72538268', '1970-07-30', 'B-', '+1 120 987 9167', 'Pilot', '65 University Street, Montreal'),
	(1004, 'Robert Francois', 'francoisrobert@somemailservice.ca', 'FRAR62930071', '1979-10-11', 'A+', '+1 926 737 8915', 'Pharmacist', '23 Unknown Street, Toronto')
;


INSERT INTO Father(fid, name, email, dateofbirth, blood, phonenumber, profession) VALUES
	(1002, 'Villem Gunter', 'gunterv@gmail.com', '1983-02-12', 'O-', '+1 738 624 8276', 'Librarian')
;


INSERT INTO Father(fid, name, dateofbirth, blood, phonenumber, profession) VALUES
	(1003, 'Lewis Reinaldo', '1979-10-03', 'A+', '+1 736 712 5467', 'Computer Scientist'),
	(1005, 'Lacey Ascanio', '1985-03-18', 'O+', '+1 528 540 6104', 'Businessman')
;


INSERT INTO Couple(cid, mcardid, fid) VALUES
	(1001, 'GUTV01020101', 1001),
	(1002, 'RINS37759073', 1004),
	(1003, 'OLGA69829129', 1002),
	(1004, 'ESTV86397320', 1003),
	(1006, 'ALIL74509607', 1005)
;


INSERT INTO Couple(cid, mcardid) VALUES
	(1005, 'THEM73833011'),
	(1007, 'CHEJ36149226')
;


INSERT INTO InfoSession(midwifeid, sessiondate, sessiontime, language) VALUES
	(1001, '2022-02-15', '11:30:00', 'French'),
	(1001, '2022-02-18', '11:30:00', 'English'),
	(1001, '2022-02-18', '15:00:00', 'French'),
	(1003, '2022-02-15', '11:30:00', 'English'),
	(1004, '2022-02-19', '10:30:00', 'French'),
	(1007, '2022-02-19', '14:15:00', 'English'),
	(1007, '2022-03-02', '17:00:00', 'English')
;


INSERT INTO SessionInvites(midwifeid, sessiondate, sessiontime, coupleid, registered, attended) VALUES
	(1001, '2022-02-15', '11:30:00', 1001, 1, 0),
	(1001, '2022-02-15', '11:30:00', 1003, 0, 0),
	(1001, '2022-02-15', '11:30:00', 1004, 0, 0),
	(1001, '2022-02-15', '11:30:00', 1005, 1, 1),
	(1001, '2022-02-18', '11:30:00', 1002, 1, 1),
	(1001, '2022-02-18', '11:30:00', 1003, 1, 0),
	(1003, '2022-02-15', '11:30:00', 1004, 0, 0),
	(1007, '2022-02-19', '14:15:00', 1003, 1, 1),
	(1007, '2022-02-19', '14:15:00', 1006, 0, 0),
	(1007, '2022-03-02', '17:00:00', 1007, 1, 0)
;


INSERT INTO Pregnancy(id, numbr, finalduedate, initialduedate, birthplacedecided, expectedbirthtimeframe, lastperiod, cid, assistedby, backupby, birthat) VALUES
	(1001, 1, '2021-03-17', '2021-03-15', 1, '2021-03-01', '2021-09-16', 1001, 1002, 1001, 'theamazingbirthingcenter@email.com'),
	(1002, 1, '2022-07-05', '2022-07-09', 1, '2021-03-01', '2021-09-16', 1003, 1002, 1001, 'center421@email.com'),
	(1003, 2, '2022-02-19', '2022-02-19', 1, '2022-02-01', '2022-08-26', 1001, 1005, 1002, 'center421@email.com')
;


INSERT INTO Pregnancy(id, numbr, finalduedate, initialduedate, birthplacedecided, expectedbirthtimeframe, lastperiod, cid, assistedby, backupby) VALUES
	(1004, 1, '2022-07-03', '2022-06-29', 1, '2022-06-01', '2021-03-18', 1002, 1004, 1007),
	(1005, 2, '2021-10-21', '2021-10-23', 0, '2021-10-01', '2021-01-15', 1003, 1005, 1001)
;


INSERT INTO Pregnancy(id, numbr, expectedbirthtimeframe, cid, assistedby) VALUES
	(1006, 1, '2022-01-02', 1005, 1006),
	(1007, 1, '2022-07-01', 1002, 1007),
	(1008, 3, '2022-07-01', 1006, 1001)
;


INSERT INTO Pregnancy(id, numbr, cid, assistedby) VALUES
	(1009, 1, 1006, 1003),
	(1010, 1, 1002, 1004)
;


INSERT INTO Baby(id, name, gender, blood, birthdate, birthtime, pregn) VALUES
	(1001, 'Kevin', 'M', 'A+', '2021-03-17', '23:00:00', 1001),
	(1002, 'Marcel', 'M', 'A+', '2021-03-17', '23:10:00', 1001),
	(1003, 'Amelia', 'F', 'A-', '2022-02-19', '09:35:00', 1004),
	(1004, 'Nicholas', 'M', 'O+', '2022-07-05', '06:00:00', 1003),
	(1005, 'Alexander', 'M', 'AB-', '2022-07-05', '06:15:00', 1003),
	(1006, 'Dimitri', 'M', 'B-', '2022-07-09', '07:05:00', 1003)
;


INSERT INTO Baby(id, name, gender, pregn) VALUES
	(1007, 'Simonne', 'F', 1005)
;


INSERT INTO Baby(id, gender, pregn) VALUES
	(1008, 'F', 1004),
	(1009, 'M', 1004),
	(1010, 'F', 1007)
;


INSERT INTO Appointment(id, adate, atime, mainmidwife, pregn) VALUES
	(1001, '2021-01-17', '14:15:00', 1, 1001),
	(1002, '2021-01-23', '10:45:00', 1, 1001),
	(1003, '2021-02-02', '15:00:00', 0, 1001),
	(1004, '2021-02-16', '10:45:00', 1, 1001),
	(1005, '2021-10-30', '12:30:00', 1, 1002),
	(1006, '2021-12-31', '14:45:00', 1, 1002),
	(1007, '2022-02-03', '17:30:00', 0, 1003),
	(1008, '2022-02-27', '14:15:00', 0, 1003),
	(1009, '2022-03-19', '10:45:00', 1, 1003),
	(1010, '2022-09-14', '15:30:00', 1, 1004),
	(1011, '2022-07-28', '16:00:00', 0, 1005),
	(1012, '2022-01-03', '13:30:00', 0, 1005),
	(1013, '2022-10-04', '09:30:00', 1, 1006),
	(1014, '2022-03-21', '16:00:00', 1, 1008),
	(1015, '2022-03-24', '14:30:00', 1, 1008),
	(1016, '2022-03-21', '13:00:00', 1, 1007)
;


INSERT INTO Technician(id, name, phonenumber) VALUES
	(1001, 'Joseph Saranna', '+1 738 547 9035'),
	(1002, 'Fedlimid Magomet', '+1 694 838 1023'),
	(1003, 'Christos Kaison', '+1 837 536 9265'),
	(1004, 'Gratia Melody', '+1 739 536 9273'),
	(1005, 'Auxentios Gilbert', '+1 738 627 9274'),
	(1006, 'Vilma Heracleitus', '+1 637 827 0384')
;


INSERT INTO MedicalTest(id, testtype, dateprescribed, datesampletaken, datelabworkdone, result, appointmentid, techid, babyid) VALUES
	(1001, 'blood iron', '2021-01-22', '2021-01-23', '2021-01-26', 'There is a liquid in your veins.', 1002, 1003, 1002),
	(1002, 'blood iron', '2022-02-01', '2022-02-03', '2022-02-07', 'There is blood in your veins.', 1007, 1003, 1004),
	(1003, 'echography', '2022-02-04', '2022-02-05', '2022-02-08', 'There is a baby in your stomach.', 1008, 1002, 1004)
;


INSERT INTO MedicalTest(id, testtype, dateprescribed, datesampletaken, datelabworkdone, result, appointmentid, techid) VALUES
	(1004, 'blood iron', '2022-02-10', '2022-02-19', '2022-02-22', 'There is definitely blood in your veins.', 1008, 1002),
	(1005, 'blood iron', '2022-09-12', '2021-09-14', '2022-09-15', 'There may be blood in your veins.', 1010, 1006),
	(1008, 'blood iron', '2022-04-02', '2021-04-02', '2022-04-06', 'Some red content in your veins.', 1008, 1005)
;


INSERT INTO MedicalTest(id, testtype, dateprescribed, appointmentid) VALUES
	(1006, 'echography', '2022-07-27', 1011),
	(1007, 'blood iron', '2022-03-20', 1014),
	(1009, 'blood iron', '2022-04-02', 1007)
;


INSERT INTO MedicalNote(appointmentid, notedate, notetime, content) VALUES
	(1001, '2021-01-17', '14:25:00', 'Patient is having a baby.'),
	(1003, '2021-02-02', '15:05:00', 'Patient is very nice.'),
	(1003, '2021-02-02', '15:07:00', 'Sample note.'),
	(1005, '2021-10-30', '12:43:00', 'Testing'),
	(1012, '2022-01-03', '13:33:00', 'Everything seems okay.')
;


INSERT INTO MedicalNote(appointmentid, notedate, notetime) VALUES
	(1005, '2021-10-30', '12:37:00'),
	(1007, '2022-02-04', '18:05:00')
;

