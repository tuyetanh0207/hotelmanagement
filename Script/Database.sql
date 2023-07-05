IF EXISTS(SELECT 1 FROM sys.databases WHERE name = 'HotelManagement')
	BEGIN
			USE master
			ALTER DATABASE HotelManagement SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
			DROP DATABASE HotelManagement;
	END
GO

CREATE DATABASE HotelManagement;
GO
USE HotelManagement;
GO

CREATE TABLE ACCOUNT(
	USERNAME CHAR(5),
	PASSWORD CHAR(20),

	CONSTRAINT PK_ACC PRIMARY KEY (USERNAME)
)

CREATE TABLE EMPLOYEE(
	ID_EMP CHAR(5),
	NAME NVARCHAR(50),
	BIRTHDAY DATE,
	EMAIL CHAR(50),
	ADDRESS NVARCHAR(100),
	PHONE CHAR(11),
	IDENTITY_CARD CHAR(14),
	ROLE NVARCHAR(30),

	CONSTRAINT PK_EMP PRIMARY KEY (ID_EMP)
)

CREATE TABLE ITEM(
	ID_ITEM CHAR(4),
	NAME NVARCHAR(80),
	AMOUNT INT,
	TYPE NVARCHAR(30),
	PRICE INT,
	STORAGE_LOCATION NVARCHAR(100),
	ITEM_FUNCTION NVARCHAR(100),
	CHECKOUT_DATE DATETIME,
	
	MANAGER CHAR(5),

	CONSTRAINT PK_ITEM PRIMARY KEY (ID_ITEM)
)

CREATE TABLE ITEM_ROOM(
	ID_ITEM CHAR(4),
	ID_ROOM CHAR(4),
	AMOUNT INT,

	CONSTRAINT PK_ITEM_ROOM PRIMARY KEY (ID_ITEM, ID_ROOM)
)

CREATE TABLE ROOM(
	ID_ROOM CHAR(4),
	NAME NVARCHAR(10),
	STATUS NVARCHAR(40),
	PRICE INT,
	TYPE NVARCHAR(40),

	CONSTRAINT PK_ROOM PRIMARY KEY (ID_ROOM)
)

CREATE TABLE RESERVATION_ROOM(
	ID_ROOM CHAR(4),
	ARRIVAL_DATE DATETIME,
	DEPARTURE_DATE DATETIME,

	CONSTRAINT PK_RESERVATION_ROOM PRIMARY KEY (ID_ROOM, ARRIVAL_DATE, DEPARTURE_DATE)
)

CREATE TABLE BOOKING_ROOM(
	ID_BOOKING CHAR(10),
	ID_ROOM CHAR(4),
	
	CONSTRAINT PK_BOOKING_ROOM PRIMARY KEY (ID_ROOM, ID_BOOKING)
)

CREATE TABLE BOOKING_FORM(
	ID_BOOKING CHAR(10),
	ARRIVAL_DATE DATETIME,
	DEPARTURE_DATE DATETIME,
	AMOUNT INT,
	PRICE INT,
	STATUS NVARCHAR(40),
	SPECIAL_REQUIREMENTS NVARCHAR(200),
	PAYMENT_METHODS NVARCHAR(30),

	CUSTOMER CHAR(5),

	CONSTRAINT PK_BOOKING_FORM PRIMARY KEY (ID_BOOKING)
)

CREATE TABLE HOTEL_SERVICE(
	ID_SERVICE CHAR(10),
	NAME NVARCHAR(80),
	DESCRIPTION NVARCHAR(200),
	PRICE INT,
	UNIT NCHAR(20),
	TYPE NVARCHAR(50),
	STATUS NVARCHAR(30),

	CONSTRAINT PK_SERVICE PRIMARY KEY (ID_SERVICE)
)

CREATE TABLE ROOM_SERVICE(
	ID_ROOM CHAR(4),
	ID_SERVICE CHAR(10),

	CONSTRAINT PK_ROOM_SERVICE PRIMARY KEY (ID_ROOM, ID_SERVICE)
)

CREATE TABLE SERVICE_HISTORY(
	ID_SERVICE CHAR(10),
	ID_EMP CHAR(5),
	START_TIME DATETIME,
	END_TIME DATETIME,

	CONSTRAINT PK_SERVICE_HISTORY PRIMARY KEY (ID_EMP, ID_SERVICE)
)

CREATE TABLE DISCOUNT_PROMOTION(
	ID_DISCOUNT CHAR(10),
	NAME NVARCHAR(80),
	START_TIME DATETIME,
	END_TIME DATETIME,
	DESCRIPTION NVARCHAR(200),
	TYPEDISCOUNT NVARCHAR(30),
	REQUIREMENT INT,
	DISCOUNT_RATE FLOAT,
	
	CONSTRAINT PK_DISCOUNT_PROMOTION PRIMARY KEY (ID_DISCOUNT)
)

CREATE TABLE DISCOUNT_SERVICE(
	ID_DISCOUNT CHAR(10),
	ID_SERVICE CHAR(10),
		
	CONSTRAINT PK_DISCOUNT_SERVICE PRIMARY KEY (ID_DISCOUNT, ID_SERVICE)
)

CREATE TABLE SERVICE_FORM(
	ID_SERVICE_FORM CHAR(5),
	NAME NVARCHAR(80),
	DESCRIPTION NVARCHAR(200),
	PRICE INT,
	AMOUNT INT,

	ID_SERVICE CHAR(10),
	FORM_CREATOR CHAR(5),
	CUSTOMER CHAR(5),

	CONSTRAINT PK_SERVICE_FORM PRIMARY KEY (ID_SERVICE_FORM)
)

CREATE TABLE SERVICE_BILL(
	ID_SERVICE_BILL CHAR(5),
	USED_DATE DATETIME,
	TOTAL_PRICE INT,
	DISCOUNT FLOAT,
	SUBTOTAL_PRICE INT,
	STATUS NVARCHAR(30),

	ID_SERVICE_FORM CHAR(5),
	ID_BILL CHAR(5),

	CONSTRAINT PK_SERVICE_BILL PRIMARY KEY (ID_SERVICE_BILL)
)

CREATE TABLE BILL(
	ID_BILL CHAR(5),
	ROOM_FEE INT,
	SERVICE_PRICE INT,
	DAMAGED_PRICE INT,
	DEPOSIT_PRICE INT,
	TOTAL_PRICE INT,
	PAYMENT_METHODS NVARCHAR(30),
	STATUS NVARCHAR(30),

	FORM_CREATOR CHAR(5),
	ID_BOOKING CHAR(10),

	CONSTRAINT PK_BILL PRIMARY KEY (ID_BILL)
)

CREATE TABLE FEEDBACK(
	STT INT,
	CONTENT NVARCHAR(200),
	CREATED_DATE DATETIME,
	RATING INT,

	ID_BILL CHAR(5),

	CONSTRAINT PK_FEEDBACK PRIMARY KEY (STT)
)

CREATE TABLE PARTNER(
	ID_PARTNER CHAR(10),
	NAME NVARCHAR(80),
	PHONE CHAR(11),
	EMAIL CHAR(40),
	ADDRESS NVARCHAR(100),

	CONSTRAINT PK_PARTNER PRIMARY KEY (ID_PARTNER)
)

CREATE TABLE PARTNER_TOUR(
	ID_TOUR CHAR(5),
	NAME NVARCHAR(80),
	DESCRIPTION NVARCHAR(200),
	DEPARTURE_POINT NVARCHAR(200),
	DESTINATION NVARCHAR(200),
	MINIMUM_NUMBER INT,
	MAXIMUM_NUMBER INT,
	PRICE INT,
	TOTAL_DAY INT,

	OWNER CHAR(10),
	SUPERVISOR CHAR(5),

	CONSTRAINT PK_PARTNER_TOUR PRIMARY KEY (ID_TOUR)
)

CREATE TABLE REGISTER(
	ID_CUSTOMER CHAR(5),
	ID_TOUR CHAR(5),

	CONSTRAINT PK_REGISTER PRIMARY KEY (ID_TOUR,ID_CUSTOMER)
)

CREATE TABLE SCHEDULE(
	ID_TOUR CHAR(5),
	START_TIME DATETIME,
	END_TIME DATETIME,

	CONSTRAINT PK_SCHEDULE PRIMARY KEY (ID_TOUR, START_TIME, END_TIME)
)

CREATE TABLE CUSTOMER_TOUR(
	ID_CUSTOMER_TOUR CHAR(10),
	START_DATE DATETIME,
	NUMBER_PARTICIPATION INT,
	PRICE INT,
	TRAVEL_METHOD NVARCHAR(40),
	STATUS NVARCHAR(40),

	ID_TOUR_ORIGIN CHAR(5),
	CUSTOMER CHAR(5),

	CONSTRAINT PK_CUSTOMER_TOUR PRIMARY KEY (ID_CUSTOMER_TOUR)
)

CREATE TABLE CUSTOMER(
	ID_CUSTOMER CHAR(5),
	NAME NVARCHAR(30),
	GENDER NCHAR(3),
	BIRTHDAY DATE,
	EMAIL CHAR(20),
	PHONE CHAR(11),
	IDENTIFY_CARD CHAR(14),

	CONSTRAINT PK_CUSTOMER PRIMARY KEY (ID_CUSTOMER)
)

CREATE TABLE WAITING_LIST(
	ID_CUSTOMER CHAR(5),

	CONSTRAINT PK_WAITING_LIST PRIMARY KEY (ID_CUSTOMER)
)

CREATE TABLE INFORMATION_FORM(
	ID_INFORMATION_FORM CHAR(5),
	TYPE NVARCHAR(20),
	ARRIVAL_DATE DATE,
	NUMBER_ROOMS INT,
	NUMBER_STAYS INT,
	SPECIAL_REQUIREMENTS NVARCHAR(200),
	
	CUSTOMER CHAR(5),

	CONSTRAINT PK_INFORMATION_FORM PRIMARY KEY (ID_INFORMATION_FORM)
)

CREATE TABLE SUPPLY_FORM(
	ID_INFORMATION_FORM CHAR(5),
	GROUP_NAME NVARCHAR(20),
	REGISTERED_NAME NVARCHAR(20),
	GROUP_SIZE INT,

	CONSTRAINT PK_SUPPLY_FORM PRIMARY KEY (ID_INFORMATION_FORM)
)

CREATE TABLE RULES(
	ID_RULE CHAR(5),
	NAME NVARCHAR(80),
	CONTENT NVARCHAR(200),
	CREATED_DATE DATETIME,

	MANAGER CHAR(5),

	CONSTRAINT PK_RULES PRIMARY KEY (ID_RULE)
)
GO

-- ITEM(MANAGER) -> EMPLOYEE(ID_EMP)
ALTER TABLE ITEM
ADD CONSTRAINT FK_MANAGER_ITEM
FOREIGN KEY (MANAGER)
REFERENCES EMPLOYEE(ID_EMP)

-- ITEM_ROOM(ID_ITEM) -> ITEM(ID_ITEM)
ALTER TABLE ITEM_ROOM
ADD CONSTRAINT FK_R_ITEM
FOREIGN KEY (ID_ITEM)
REFERENCES ITEM(ID_ITEM)

-- ITEM_ROOM(ID_ROOM) -> ROOM(ID_ROOM)
ALTER TABLE ITEM_ROOM
ADD CONSTRAINT FK_I_ROOM
FOREIGN KEY (ID_ROOM)
REFERENCES ROOM(ID_ROOM)

-- RESERVATION_ROOM(ID_ROOM) -> ROOM(ID_ROOM)
ALTER TABLE RESERVATION_ROOM
ADD CONSTRAINT FK_RESER_ROOM
FOREIGN KEY (ID_ROOM)
REFERENCES ROOM(ID_ROOM)

-- BOOKING_ROOM(ID_ROOM) -> ROOM(ID_ROOM)
ALTER TABLE BOOKING_ROOM
ADD CONSTRAINT FK_B_ROOM
FOREIGN KEY (ID_ROOM)
REFERENCES ROOM(ID_ROOM)

-- BOOKING_ROOM(ID_BOOKING) -> BOOKING_FORM(ID_BOOKING)
ALTER TABLE BOOKING_ROOM
ADD CONSTRAINT FK_B_BOOKING
FOREIGN KEY (ID_BOOKING)
REFERENCES BOOKING_FORM(ID_BOOKING)

-- BOOKING_FORM(CUSTOMER) -> CUSTOMER(ID_CUSTOMER)
ALTER TABLE BOOKING_FORM
ADD CONSTRAINT FK_BOOKING_FORM
FOREIGN KEY (CUSTOMER)
REFERENCES CUSTOMER(ID_CUSTOMER)

-- ROOM_SERVICE(ID_ROOM) -> ROOM(ID_ROOM)
ALTER TABLE ROOM_SERVICE
ADD CONSTRAINT FK_S_ROOM
FOREIGN KEY (ID_ROOM)
REFERENCES ROOM(ID_ROOM)

-- ROOM_SERVICE(ID_SERVICE) -> HOTEL_SERVICE(ID_SERVICE)
ALTER TABLE ROOM_SERVICE
ADD CONSTRAINT FK_R_SERVICE
FOREIGN KEY (ID_SERVICE)
REFERENCES HOTEL_SERVICE(ID_SERVICE)

-- SERVICE_HISTORY(ID_SERVICE) -> HOTEL_SERVICE(ID_SERVICE)
ALTER TABLE SERVICE_HISTORY
ADD CONSTRAINT FK_SH_SERVICE
FOREIGN KEY (ID_SERVICE)
REFERENCES HOTEL_SERVICE(ID_SERVICE)

-- SERVICE_HISTORY(ID_EMP) -> EMPLOYEE(ID_EMP)
ALTER TABLE SERVICE_HISTORY
ADD CONSTRAINT FK_SH_EMP
FOREIGN KEY (ID_EMP)
REFERENCES EMPLOYEE(ID_EMP)

-- DISCOUNT_SERVICE(ID_DISCOUNT) -> DISCOUNT_PROMOTION(ID_DISCOUNT)
ALTER TABLE DISCOUNT_SERVICE
ADD CONSTRAINT FK_DS_PROMOTION
FOREIGN KEY (ID_DISCOUNT)
REFERENCES DISCOUNT_PROMOTION(ID_DISCOUNT)

-- DISCOUNT_SERVICE(ID_SERVICE) -> HOTEL_SERVICE(ID_SERVICE)
ALTER TABLE DISCOUNT_SERVICE
ADD CONSTRAINT FK_DS_SERVICE
FOREIGN KEY (ID_SERVICE)
REFERENCES HOTEL_SERVICE(ID_SERVICE)

-- SERVICE_FORM(ID_SERVICE) -> HOTEL_SERVICE(ID_SERVICE)
ALTER TABLE SERVICE_FORM
ADD CONSTRAINT FK_SF_SERVICE
FOREIGN KEY (ID_SERVICE)
REFERENCES HOTEL_SERVICE(ID_SERVICE)

-- SERVICE_FORM(FORM_CREATOR) -> EMPLOYEE(ID_EMP)
ALTER TABLE SERVICE_FORM
ADD CONSTRAINT FK_SF_CREATOR
FOREIGN KEY (FORM_CREATOR)
REFERENCES EMPLOYEE(ID_EMP)

-- SERVICE_FORM(CUSTOMER) -> CUSTOMER(ID_CUSTOMER)
ALTER TABLE SERVICE_FORM
ADD CONSTRAINT FK_SF_CUSTOMER
FOREIGN KEY (CUSTOMER)
REFERENCES CUSTOMER(ID_CUSTOMER)

-- SERVICE_BILL(ID_SERVICE_FORM) -> SERVICE_FORM(ID_SERVICE_FORM)
ALTER TABLE SERVICE_BILL
ADD CONSTRAINT FK_SB_SFORM
FOREIGN KEY (ID_SERVICE_FORM)
REFERENCES SERVICE_FORM(ID_SERVICE_FORM)

-- SERVICE_BILL(ID_BILL) -> BILL(ID_BILL)
ALTER TABLE SERVICE_BILL
ADD CONSTRAINT FK_SB_BILL
FOREIGN KEY (ID_BILL)
REFERENCES BILL(ID_BILL)

-- BILL(ID_BOOKING) -> BOOKING_FORM(ID_BOOKING)
ALTER TABLE BILL
ADD CONSTRAINT FK_BILL_BF
FOREIGN KEY (ID_BOOKING)
REFERENCES BOOKING_FORM(ID_BOOKING)

-- BILL(FORM_CREATOR) -> EMPLOYEE(ID_EMP)
ALTER TABLE BILL
ADD CONSTRAINT FK_BILL_CREATOR
FOREIGN KEY (FORM_CREATOR)
REFERENCES EMPLOYEE(ID_EMP)

-- FEEDBACK(ID_BILL) -> BILL(ID_BILL)
ALTER TABLE FEEDBACK
ADD CONSTRAINT FK_FEEDBACK
FOREIGN KEY (ID_BILL)
REFERENCES BILL(ID_BILL)

-- PARTNER_TOUR(OWNER) -> PARTNER(ID_PARTNER)
ALTER TABLE PARTNER_TOUR
ADD CONSTRAINT FK_OWNER
FOREIGN KEY (OWNER)
REFERENCES PARTNER(ID_PARTNER)

-- PARTNER_TOUR(SUPERVISOR) -> EMPLOYEE(ID_EMP)
ALTER TABLE PARTNER_TOUR
ADD CONSTRAINT FK_SUPERVISOR
FOREIGN KEY (SUPERVISOR)
REFERENCES EMPLOYEE(ID_EMP)

-- REGISTER(ID_CUSTOMER) -> CUSTOMER(ID_CUSTOMER)
ALTER TABLE REGISTER
ADD CONSTRAINT FK_REGIS
FOREIGN KEY (ID_CUSTOMER)
REFERENCES CUSTOMER(ID_CUSTOMER)

-- REGISTER(ID_TOUR) -> PARTNER_TOUR(ID_TOUR)
ALTER TABLE REGISTER
ADD CONSTRAINT FK_REGIS_TOUR
FOREIGN KEY (ID_TOUR)
REFERENCES PARTNER_TOUR(ID_TOUR)

--SCHEDULE(ID_TOUR) -> PARTNER_TOUR(ID_TOUR)
ALTER TABLE SCHEDULE
ADD CONSTRAINT FK_SCHEDULE
FOREIGN KEY (ID_TOUR)
REFERENCES PARTNER_TOUR(ID_TOUR)

-- CUSTOMER_TOUR(ID_TOUR_ORIGIN) -> PARTNER_TOUR(ID_TOUR)
ALTER TABLE CUSTOMER_TOUR
ADD CONSTRAINT FK_TOUR_CUS
FOREIGN KEY (ID_TOUR_ORIGIN)
REFERENCES PARTNER_TOUR(ID_TOUR)


-- CUSTOMER_TOUR(CUSTOMER) -> CUSTOMER(ID_CUSTOMER)
ALTER TABLE CUSTOMER_TOUR
ADD CONSTRAINT FK_TOUR_CUSTOMER
FOREIGN KEY (CUSTOMER)
REFERENCES CUSTOMER(ID_CUSTOMER)

-- INFORMATION_FORM(CUSTOMER) -> CUSTOMER(ID_CUSTOMER)
ALTER TABLE INFORMATION_FORM
ADD CONSTRAINT FK_INFOR_FORM_CUS
FOREIGN KEY (CUSTOMER)
REFERENCES CUSTOMER(ID_CUSTOMER)

-- WAITING_LIST(ID_CUSTOMER) -> CUSTOMER(ID_CUSTOMER)
ALTER TABLE WAITING_LIST
ADD CONSTRAINT FK_WAITING
FOREIGN KEY (ID_CUSTOMER)
REFERENCES CUSTOMER(ID_CUSTOMER)

-- SUPPLY_FORM(ID_INFORMATION_FORM) -> INFORMATION_FORM(ID_INFORMATION_FORM)
ALTER TABLE SUPPLY_FORM
ADD CONSTRAINT FK_SUPPLY_FORM
FOREIGN KEY (ID_INFORMATION_FORM)
REFERENCES INFORMATION_FORM(ID_INFORMATION_FORM)

-- RULES(MANAGER) -> EMPLOYEE(ID_EMP)
ALTER TABLE RULES
ADD CONSTRAINT FK_RULES
FOREIGN KEY (MANAGER)
REFERENCES EMPLOYEE(ID_EMP)

-- ACCOUNT(USERNAME) -> EMPLOYEE(ID_EMP)
ALTER TABLE ACCOUNT
ADD CONSTRAINT FK_ACC
FOREIGN KEY (USERNAME)
REFERENCES EMPLOYEE(ID_EMP)

GO