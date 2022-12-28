--drop tables if exist
DROP TABLE IF EXISTS automobile_t;
DROP TABLE IF EXISTS consumption_t;
DROP TABLE IF EXISTS customer_t;
DROP TABLE IF EXISTS employee_t;
DROP TABLE IF EXISTS equipment_t;
DROP TABLE IF EXISTS equipmentrequirement_t;
DROP TABLE IF EXISTS equipmentutilized_t;
DROP TABLE IF EXISTS manager_t;
DROP TABLE IF EXISTS parts_t;
DROP TABLE IF EXISTS partsrequirement_t;
DROP TABLE IF EXISTS repair_t;
DROP TABLE IF EXISTS repairestimate_t;
DROP TABLE IF EXISTS skill_t;
DROP TABLE IF EXISTS skillrequirement_t;
DROP TABLE IF EXISTS technician_t;




--customer table
CREATE TABLE customer_t(
	customerid numeric PRIMARY KEY NOT NULL,
    customername varchar,
    customerphonenumber bigint,
    customeraddress varchar
	);
 
INSERT INTO customer_t
(customerid, customername, customerphonenumber, customeraddress)
 
VALUES
('13023332', 'Parker Siu', '4085915612', '2088 Outback Blvd'),
('90212931', 'Pearl Tay', '4902818452', '4532 Trader Way'),
('38102313', 'Walker Kisler', '9183129212', '0122 Seattle St'),
('29321233', 'Ella Morris', '9393933112', '45 Market St'),
('22233432', 'Harry Should', '9193233232', '41 Train Blvd'),
('83021431', 'Tray Young', '9902123212', '411 Park Ave'),
('82123411', 'Thomas Trota', '9192213121', '422 Allen Rd'),
('80921215', 'Dominic Perry', '9101231021', '1234 Race Way'),
('12369441', 'Jack Hammer', '5031231212', '919 Shots Rd'),
('82123351', 'Anna Welo', '9031234981', '4133 Steep Way');




--automobile table
CREATE TABLE automobile_t(
	automobilevin varchar PRIMARY KEY NOT NULL,
    automobileyear int,
    automobilemake varchar,
    automobilemodel varchar,
    customerid numeric,
CONSTRAINT automobile_FK FOREIGN KEY (customerid) REFERENCES customer_t(customerid)
);
 
INSERT INTO automobile_t
(automobilevin,automobileyear, automobilemake, automobilemodel,customerid)
 
VALUES
('8BDS212','2011','Mazda','CX5','13023332'),
('922DSA4','2009','Porsche','Cayman5','90212931'),
('123DST4','2020','Honda','CRV','38102313'),
('33TRE92','2022','Toyota','Prius','29321233'),
('39T2PL2','2020','Mercedes','C63','22233432'),
('311R3AL','2014','BMW','I8','83021431'),
('321AS11','2003','Audi','A4','82123411'),
('9210REE','2019','Lexus','GS400','80921215'),
('332HMAR','2012','Lexus','ES330','12369441'),
('3231PAL','2017','Acura','TLX','82123351');





--employee table
CREATE TABLE employee_t(
	employeeid numeric PRIMARY KEY NOT NULL,
	employeename varchar,
	employeephonenumber bigint,
	employeedatehired date,
	employeetype varchar
	);

INSERT INTO employee_t
(employeeid,employeename,employeephonenumber,employeedatehired,employeetype)

VALUES
('12344345', 'Phil Smithens', '4085545321', '2019-11-12','Technician'),
('33244566', 'Lawrence Taylor', '2049019805', '2019-04-22', 'Manager'),
('45456078', 'Robert Cherry', '3034210441', '2014-06-12', 'Manager'),
('12334412', 'River Schindler', '1221560333', '2022-09-28', 'Manager'),
('30933428', 'Desmond Tripp', '8809332391', '2012-12-13', 'Technician'),
('12988093', 'Olivia Marie', '9013233784', '2017-10-03', 'Technician'),
('84842033', 'Candice Pressley', '4088839123', '2002-01-14', 'Manager'),
('38321234', 'Andrew Phelps', '4081123212', '2011-09-15', 'Manager'),
('19478294', 'Cole Norton', '3813839402', '2022-05-19', 'Technician'),
('12398482', 'Trent Norton', '3813839044', '2022-05-19', 'Technician');




--repair estimate table 
CREATE TABLE repairestimate_T (
	repairestimateid numeric PRIMARY KEY NOT NULL,
	repairestimatedescription varchar,
	repairestimateamount numeric,
	repairestimatecompletiondate date,
    customerid numeric,
	automobilevin varchar,
	employeeid numeric,
CONSTRAINT repairestimate_FK FOREIGN KEY (employeeid) REFERENCES employee_t(employeeid),
CONSTRAINT repairestimate_FK2 FOREIGN KEY (customerid) REFERENCES customer_t(customerid),
CONSTRAINT repairestimate_FK3 FOREIGN KEY (automobilevin) REFERENCES automobile_t(automobilevin)
	);

INSERT INTO repairestimate_t
(repairestimateid, repairestimatedescription, repairestimateamount, repairestimatecompletiondate, customerid, automobilevin, employeeID)

VALUES
('123','Broken Window','400','2020-03-23','13023332','8BDS212','84842033'),
('32','Bumper Fix','322','2022-06-20','90212931','922DSA4','45456078'),
('14','Oil Leak','200','2021-05-25','38102313','123DST4','38321234'),
('177','Broken Muffler','102','2021-05-28','29321233','33TRE92','12334412'),
('190','Spark Plug Fix','900','2020-09-28','22233432','39T2PL2','33244566'),
('199','Broken Trunk','2333','2022-04-26','83021431','311R3AL','30933428'),
('2212','Broken Cable','929','2019-04-25','82123411','321AS11','19478294'),
('125','Broken Windshield','221','2018-09-02','80921215','9210REE','12988093'),
('9231','Flat Tire','110','2017-03-24','12369441','332HMAR','12398482'),
('212','Battery Repair','1111','2019-04-09','82123351','3231PAL','12344345');




--repair table
CREATE TABLE repair_t(
	repairid numeric PRIMARY KEY NOT NULL,
	repairdescription varchar,
	repairinitiationdate date,
	repairdepositamount numeric,
	repaircompletiondate date,
	repairtotalamount int,
	customerid numeric,
	automobilevin varchar,
	repairestimateid numeric,
CONSTRAINT repair_FK FOREIGN KEY (customerid) REFERENCES customer_t(customerid),
CONSTRAINT repair_FK2 FOREIGN KEY (automobilevin) REFERENCES automobile_t(automobilevin),
CONSTRAINT repair_FK3 FOREIGN KEY (repairestimateid) REFERENCES repairestimate_t(repairestimateid)
);

INSERT INTO repair_t
(repairid, repairdescription, repairinitiationdate, repairdepositamount, 
 repaircompletiondate, repairtotalamount, customerid, automobilevin, repairestimateid)

VALUES
('127','Broken Window','2020-03-01','100', '2020-03-23','400','13023332','8BDS212','123'),
('999','Bumper Fix','2022-05-18','20', '2022-06-20','322','90212931','922DSA4','32'),
('194','Oil Leak','2021-05-04','10', '2021-05-24','200','38102313','123DST4','14'),
('324','Broken Muffler','2021-05-01','30', '2021-05-28','102','29321233','33TRE92','177'),
('266','Spark Plug Fix','2020-09-10','100', '2020-09-29','900','22233432','39T2PL2','190'),
('910','Broken Trunk','2022-04-21','234', '2022-04-26','2333','83021431','311R3AL','199'),
('231','Broken Cable','2019-04-02','100', '2019-04-25','929','82123411','321AS11','2212'),
('193','Broken Windshield','2018-08-11','100', '2018-09-04','221','80921215','9210REE','125'),
('192','Flat Tire','2017-03-13','10', '2017-03-23','110','12369441','332HMAR','9231'),
('432','Battery Repair','2019-04-01','100', '2019-04-09','1111','82123351','3231PAL','212');




--equipment table
CREATE TABLE equipment_t(
	equipmentid	numeric PRIMARY KEY	NOT NULL,
	equipmentdescription varchar,
	equipmentmanufacturer varchar,
	equipmentmodel varchar
	);
	
INSERT INTO equipment_t
(equipmentid, equipmentdescription, equipmentmanufacturer, equipmentmodel)

VALUES
('113', 'Hammer', 'Home Depot', 'Alpha3'),
('390', 'Forklift', 'CAT', 'CAT5'),
('221', 'Wrench', 'Arm & Hammer', 'TR2'),
('421', 'Flywheel', 'Bentley', 'Wheel10'),
('363', 'Tire Pump', 'Orchard Supply', 'Track3'),
('408', 'Engine Lock', 'Oreily', 'Lock4'),
('11', 'Engine Cylinder', 'National', 'Beta112'),
('90', 'Piston Rod', 'CAT', 'Rod3'),
('34', 'Screwdriver', 'Home Depot', 'Drive9'),
('12', 'Chassis', 'Toyota', 'SedanChassis');




--equipment requirement table
CREATE TABLE equipmentrequirement_t(
	repairestimateid numeric NOT NULL,
	equipmentid	numeric NOT NULL,
	equipmenthoursrequired int,
	CONSTRAINT equipmentrequirement_PK PRIMARY KEY (repairestimateid, equipmentid)
	);

INSERT INTO equipmentrequirement_t
(repairestimateid, equipmentid, equipmenthoursrequired)

VALUES
('123','113','124'),
('32','390','23'),
('14','221','32'),
('177','421','170'),
('190','363','19');




--manager table
CREATE TABLE manager_t(
	repairid numeric NOT NULL,
	memployeeid	numeric	NOT NULL,
CONSTRAINT manager_PK PRIMARY KEY (repairid, memployeeid)
);

INSERT INTO manager_t
(repairid, memployeeid)

VALUES
('127','84842033'),
('999','45456078'),
('194','38321234'),
('324','12334412'),
('266','33244566');




--technician table
CREATE TABLE technician_t(
	repairid numeric NOT NULL,
	temployeeid numeric NOT NULL,
	technicianstartdatetime date,
	technicianenddatetime date,
CONSTRAINT technician_PK PRIMARY KEY (repairid, temployeeid)
);

INSERT INTO Technician_t
(repairid, temployeeid, technicianstartdatetime, technicianenddatetime)

VALUES
('910','30933428','2022-04-22 09:00:00','2022-04-25 18:00:00'),
('231','19478294','2019-04-02 09:30:00','2019-04-25 20:30:00'),
('193','12988093','2018-08-12 10:00:00','2018-09-04 20:30:00'),
('192','12398482','2017-03-14 09:00:00','2017-03-22 18:00:00'),
('432','12344345','2019-04-01 10:30:00','2019-04-08 19:00:00');





--equipment utilized table
CREATE TABLE equipmentutilized_t(
	equipmentid numeric	NOT NULL,
	repairid numeric NOT NULL,
	equipmentcheckindatetime date,
	equipmentcheckoutdatetimedate date,
	temployeeid	numeric,
CONSTRAINT equipmentutilized_PK PRIMARY KEY (equipmentid, repairid),
CONSTRAINT equipmentutilized_FK FOREIGN KEY (temployeeid) REFERENCES employee_t(employeeid)
);

INSERT INTO equipmentutilized_t
(equipmentid, repairid, equipmentcheckindatetime, equipmentcheckoutdatetimedate, temployeeid)

VALUES
('113','127','2020-03-05 09:00:00','2020-03-20 18:00:00','30933428'),
('390','999','2022-05-24 09:30:00','2022-06-19 19:30:00','19478294'),
('221','194','2021-05-15 11:00:00','2021-05-22 20:30:00','12988093'),
('421','324','2021-05-09 10:00:00','2021-05-24 16:00:00','12398482'),
('363','266','2020-09-14 10:30:00','2020-09-20 19:00:00','12344345');




--skill table
CREATE TABLE skill_t(
	skillid	numeric PRIMARY KEY NOT NULL,
	skillname varchar,
	skilldescription varchar,
	temployeeid	numeric,
CONSTRAINT skill_FK FOREIGN KEY (temployeeid) REFERENCES employee_t(employeeid)
);

INSERT INTO skill_t
(skillid, skillname, skilldescription, temployeeid)

VALUES
('4092','diagnostics','Works with internal diagnostics','30933428'),
('1234','brake systems','Computes brake system','19478294'),
('932','electrical systems','Controls exterior electrical systems','12988093'),
('940','oil changes','Oil changing with funnel','12398482'),
('394','engine repairs','Repairs engine malfunctions','12344345'),
('2342','jumpstarting','Jumpstarting dead batteries and resetting','12988093'),
('2344','glasswork','Fixing broken windows and windshields','12988093'),
('234','installation','Installing new car parts','12344345'),
('235','electric wiring','Electrical wiring','12398482'),
('6664','power computing','Coordinates with interior power systems','12344345');




--skill requirement table
CREATE TABLE skillrequirement_t(
	repairestimateid numeric NOT NULL,
	skillid	numeric NOT NULL,
	skillhoursrequired int,
CONSTRAINT skillrequirement_PK PRIMARY KEY (repairestimateid, skillid)
);

INSERT INTO skillrequirement_t
(repairestimateid, skillid, skillhoursrequired)

VALUES
('2212','4092','27'),
('32','234','25'),
('190','932','20'),
('14','940','32'),
('125','2344','177');




--parts table
CREATE TABLE parts_t(
	partid numeric PRIMARY KEY NOT NULL,
	partdescription	varchar,
	partunitcost numeric,
	partquantityonhand int
	);

INSERT INTO parts_T
(partid, partdescription, partunitcost, partquantityonhand)

VALUES
('123', 'Muffler', '440.00', '333'),
('333', 'Engine', '4000.90', '45'),
('244', 'Door', '901.22', '122'),
('111', 'Transmission', '930.93', '450'),
('33', 'Headlights', '323.02', '41'),
('48', 'Bumper', '900.29', '4'),
('011', 'Tires', '192.03', '422'),
('943', 'Window', '510.12', '1234'),
('344', 'Battery', '502.12', '99'),
('112', 'Alternator', '9009.81', '12');




--parts requirement table
CREATE TABLE partsrequirement_t(
	repairestimateid numeric NOT NULL,
	partid numeric NOT NULL,
	partquantityrequired int,
CONSTRAINT partsestimate_PK PRIMARY KEY (repairestimateid, partid)
);

INSERT INTO partsrequirement_t
(repairestimateid, partid, partquantityrequired)

VALUES
('123','123','42'),
('32','333','6'),
('14','244','3'),
('177','111','23'),
('190','33','46'),
('199','48','31'),
('2212','11','5'),
('125','943','2'),
('9231','344','31'),
('212','112','54');




--consumption table
CREATE TABLE consumption_t(
	repairid numeric NOT NULL,
	partid numeric NOT NULL,
	partconsumptiondate	date,
	partquantityconsumer varchar,
CONSTRAINT partutilized_PK PRIMARY KEY (repairid, partid)
);

INSERT INTO consumption_t
(repairid, partid, partconsumptiondate, partquantityconsumer)

VALUES
('910','48','2022-04-22','Desmond Tripp'),
('231','11','2019-04-05','Cole Norton'),
('193','943','2018-08-12','Olivia Marie'),
('192','344','2017-03-14','Trent Norton'),
('432','112','2019-04-02','Phil Smithens');