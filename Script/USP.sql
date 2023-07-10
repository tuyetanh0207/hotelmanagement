USE HotelManagement
GO 
-- TAO ID CUSTOMER TU DONG
CREATE 
--ALTER
FUNCTION CREATE_IDCUSTOMER()
RETURNS CHAR(5)
AS
BEGIN
	DECLARE @ID CHAR(5)
	IF(NOT EXISTS (SELECT *
				   FROM CUSTOMER))
	BEGIN
		SET @ID = 'C0001'
		RETURN @ID
	END
	ELSE
	BEGIN
		SELECT @ID = CAST(CAST(MIN(RIGHT(ID_CUSTOMER,4)) AS INT) + 1 AS CHAR(5))
		FROM CUSTOMER
		WHERE (RIGHT(ID_CUSTOMER,4) + 1) NOT IN (SELECT RIGHT(ID_CUSTOMER,4) FROM CUSTOMER)
	END

	DECLARE @TEMP INT = CAST(@ID AS INT)
	DECLARE @COUNT INT = 0

	WHILE(@TEMP > 0)
	BEGIN
		SET @TEMP = @TEMP/10
		SET @COUNT = @COUNT + 1
	END
    
	DECLARE @CNT int = 0
	WHILE(@CNT <> (4-@COUNT))
	BEGIN
		SET @ID = '0' + @ID
		SET @CNT = @CNT + 1
	END
	SET @ID = 'C' + @ID
	RETURN @ID
END
GO
-- INSERT CUSTOMER
--CREATE
ALTER
PROC USP_AddCUSTOMER(
	@NAME NVARCHAR(30),
	@GENDER NCHAR(3),
	@BIRTHDAY DATE,
	@EMAIL CHAR(20),
	@PHONE CHAR(11),
	@IDENTIFY_CARD CHAR(14),
	@TYPE NVARCHAR(20),
	@ARRIVAL_DATE DATE,
	@NUMBER_ROOMS INT,
	@NUMBER_STAYS INT,
	@SPECIAL_REQUIREMENTS NVARCHAR(200),
	@GROUP_NAME NVARCHAR(20),
	@REGISTERED_NAME NVARCHAR(20),
	@GROUP_SIZE INT
	)
AS
BEGIN TRANSACTION
	BEGIN TRY
		IF(EXISTS (SELECT NAME FROM CUSTOMER WHERE NAME = @NAME))
		BEGIN
			ROLLBACK TRAN
			RETURN 0
		END
	END TRY

	BEGIN CATCH
		print(N'Thông tin không hợp lệ')
		ROLLBACK TRAN
	END CATCH
	DECLARE @IDCUSTOMER CHAR(5) = DBO.CREATE_IDCUSTOMER()
	INSERT INTO CUSTOMER VALUES(@IDCUSTOMER,@NAME,@GENDER,@BIRTHDAY,@EMAIL, @PHONE, @IDENTIFY_CARD)
	EXEC USP_AddINFORMATIONFORM @TYPE, @ARRIVAL_DATE, @NUMBER_ROOMS, @NUMBER_STAYS, @SPECIAL_REQUIREMENTS, @IDCUSTOMER, @GROUP_NAME, @REGISTERED_NAME, @GROUP_SIZE 

	SELECT ID_CUSTOMER FROM CUSTOMER WHERE ID_CUSTOMER = @IDCUSTOMER
COMMIT

GO

-- TEST 
DECLARE @_BIRTHDAY DATE, @_ARRIVAL_DATE DATE
SET @_BIRTHDAY = CONVERT(DATE, '2002-07-09')
SET @_ARRIVAL_DATE = CONVERT(DATE, '2023-11-11')
EXEC USP_AddCUSTOMER @NAME = N'TEST17', @GENDER = N'Nam', @BIRTHDAY = @_BIRTHDAY, @EMAIL = 'phanthiennhan@example.com', @PHONE = '09612512712', @IDENTIFY_CARD = '43757', @TYPE = N'Đảm Bảo', @ARRIVAL_DATE = @_ARRIVAL_DATE, @NUMBER_ROOMS = 4, @NUMBER_STAYS = 20, @SPECIAL_REQUIREMENTS = N'Không có', @GROUP_NAME = N'HOA HƯỚNG DƯƠNG', @REGISTERED_NAME = N'NHÂN', @GROUP_SIZE = 10
GO
select * from INFORMATION_FORM

SELECT * FROM CUSTOMER
SELECT * FROM INFORMATION_FORM
SELECT * FROM SUPPLY_FORM
----------------------------------
-- TAO ID BOOKING_FORM TU DONG

USE HotelManagement
GO 
drop function CREATE_IDBOOKINGFORM
USE HotelManagement
go
CREATE
--ALTER
FUNCTION CREATE_IDBOOKINGFORM()
RETURNS CHAR(5)
AS
BEGIN
	DECLARE @ID CHAR(5)
	IF(NOT EXISTS (SELECT *
				   FROM BOOKING_FORM))
	BEGIN
		SET @ID = 'BK001'
		RETURN @ID
	END
	ELSE
	BEGIN
		--SELECT @ID = CAST(MIN(RIGHT(ID_BOOKING,3)) AS CHAR(10))
		
		SELECT @ID = CAST(CAST(MIN(RIGHT(ID_BOOKING,3)) AS INT) + 1 AS CHAR(5))
		FROM BOOKING_FORM
		WHERE (RIGHT(ID_BOOKING,3) + 1) NOT IN (SELECT RIGHT(ID_BOOKING,3) FROM BOOKING_FORM)
		--SELECT @ID = ID_BOOKING
        --FROM BOOKING_FORM
        --WHERE CAST(SUBSTRING(ID_BOOKING, 3, 3) AS INT) = (SELECT MAX(CAST(SUBSTRING(ID_BOOKING, 3, 3) AS INT)) FROM BOOKING_FORM)
	END
	
	DECLARE @TEMP INT = CAST(@ID AS INT)
	DECLARE @COUNT INT = 0

	WHILE(@TEMP >0)
	BEGIN
		SET @TEMP = @TEMP/10
		SET @COUNT = @COUNT + 1
	end
    
	DECLARE @CNT int =0
	WHILE(@CNT <> (3-@COUNT))
	BEGIN
		SET @ID = '0' + @ID
		SET @CNT = @CNT + 1
	END
	SET @ID = 'BK' + @ID
	RETURN @ID
	 -- Tăng giá trị lên 
        --SET @NewID = CAST(SUBSTRING(@ID, 3, 3) AS INT) + 1
        
        -- Chuyển đổi giá trị thành chuỗi ký tự CHAR
        --SET @ID = 'BK' + RIGHT('00' + CAST(@NewID AS VARCHAR(3)), 3)
    --RETURN @ID
END
GO
-- INSERT BOOKINGFORM
USE HotelManagement
GO
--CREATE
ALTER
PROC USP_AddBOOKINGFORM(
	@ARRIVAL_DATE DATETIME,
	@DEPARTURE_DATE DATETIME,
	@AMOUNT INT,
	@PRICE INT,
	@STATUS NVARCHAR(20),
	@SPECIAL_REQUIREMENTS NVARCHAR(200),
	@PAYMENT_METHODS NVARCHAR(20),
	@CUSTOMER CHAR(5),
	@ROOM_FEE INT,
	@SERVICE_PRICE INT,
	@DAMAGED_PRICE INT,
	@DEPOSIT_PRICE INT,
	@TOTAL_PRICE INT,
	@STATUS_BILL NVARCHAR(30),
	@FORM_CREATOR CHAR(5)
	)
AS
BEGIN TRANSACTION
	BEGIN TRY
		IF(0=1)
		BEGIN
			ROLLBACK TRAN
			RETURN 0
		END
	END TRY

	BEGIN CATCH
		print(N'Thông tin không hợp lệ')
		ROLLBACK TRAN
	END CATCH
	DECLARE @IDBOOKINGFORM CHAR(5) = DBO.CREATE_IDBOOKINGFORM()
	INSERT INTO BOOKING_FORM VALUES(@IDBOOKINGFORM, @ARRIVAL_DATE,@DEPARTURE_DATE,@AMOUNT,@PRICE,@STATUS,@SPECIAL_REQUIREMENTS,@PAYMENT_METHODS,@CUSTOMER)
	EXEC USP_AddBILL @ROOM_FEE, @SERVICE_PRICE, @DAMAGED_PRICE, @DEPOSIT_PRICE,@TOTAL_PRICE, @PAYMENT_METHODS, @STATUS_BILL, @FORM_CREATOR, @IDBOOKINGFORM
COMMIT

GO
-- TEST 
USE HotelManagement
GO
DECLARE @ARRIVAL_DATE DATE, @DEPARTURE_DATE DATE
SET @ARRIVAL_DATE = CONVERT(DATE,'2026-12-22 10:30:35.000');
SET @DEPARTURE_DATE = CONVERT(DATE,'2023-05-22 12:01:36.000');
EXEC USP_AddBOOKINGFORM @ARRIVAL_DATE, @DEPARTURE_DATE, 1, 4345, N'Chờ xử lý', N'Phòng cấm hút thuốc', N'Check', 'C4740', 2000, NULL, NULL, 1000, NULL, N'Đã thanh toán tiền cọc', 'EMP11'
GO
select * from BILL
USE HotelManagement
GO
DELETE FROM BOOKING_FORM WHERE ID_BOOKING = 'BK001'
SELECT * FROM BOOKING_FORM
SELECT * FROM BILL


---------------------------------------
-- TAO ID INFORMATION_FORM TU DONG
 
USE HotelManagement
go
CREATE
--ALTER
FUNCTION CREATE_IDINFORMATIONFORM()
RETURNS CHAR(5)
AS
BEGIN
	DECLARE @ID CHAR(5)
	IF(NOT EXISTS (SELECT *
				   FROM INFORMATION_FORM))
	BEGIN
		SET @ID = 'I0001'
		RETURN @ID
	END
	ELSE
	BEGIN
		SELECT @ID = CAST(CAST(MIN(RIGHT(ID_INFORMATION_FORM,4)) AS INT) + 1 AS CHAR(5))
		FROM INFORMATION_FORM
		WHERE (RIGHT(ID_INFORMATION_FORM,4) + 1) NOT IN (SELECT RIGHT(ID_INFORMATION_FORM,4) FROM INFORMATION_FORM)
	END

	DECLARE @TEMP INT = CAST(@ID AS INT)
	DECLARE @COUNT INT = 0

	WHILE(@TEMP > 0)
	BEGIN
		SET @TEMP = @TEMP/10
		SET @COUNT = @COUNT + 1
	END
    
	DECLARE @CNT int = 0
	WHILE(@CNT <> (4-@COUNT))
	BEGIN
		SET @ID = '0' + @ID
		SET @CNT = @CNT + 1
	END
	SET @ID = 'I' + @ID
	RETURN @ID
END
GO
-- INSERT INFORMATION FORM
USE HotelManagement
go
--CREATE
ALTER
PROC USP_AddINFORMATIONFORM(
	@TYPE NVARCHAR(20),
	@ARRIVAL_DATE DATE,
	@NUMBER_ROOMS INT,
	@NUMBER_STAYS INT,
	@SPECIAL_REQUIREMENTS NVARCHAR(200),
	@CUSTOMER CHAR(5),
	@GROUP_NAME NVARCHAR(20),
	@REGISTERED_NAME NVARCHAR(20),
	@GROUP_SIZE INT
 	)
AS
BEGIN TRANSACTION
	BEGIN TRY
		IF(EXISTS (SELECT ARRIVAL_DATE FROM BOOKING_FORM WHERE ARRIVAL_DATE = @ARRIVAL_DATE))
		BEGIN
			ROLLBACK TRAN
			RETURN 0
		END
	END TRY

	BEGIN CATCH
		print(N'Thông tin không hợp lệ')
		ROLLBACK TRAN
	END CATCH
	DECLARE @IDINFORMATIONFORM CHAR(5) = DBO.CREATE_IDINFORMATIONFORM()
	INSERT INTO INFORMATION_FORM VALUES(@IDINFORMATIONFORM,@TYPE,@ARRIVAL_DATE,@NUMBER_ROOMS,@NUMBER_STAYS,@SPECIAL_REQUIREMENTS, @CUSTOMER)
	INSERT INTO SUPPLY_FORM VALUES(@IDINFORMATIONFORM, @GROUP_NAME, @REGISTERED_NAME, @GROUP_SIZE)
COMMIT

GO

-- TEST
use HotelManagement
go
exec  USP_AddINFORMATIONFORM N'Không đảm bảo', '2024-06-11', 3, 19, N'Phòng cấm hút thuốc', 'C0250', 'NEWGROUP', 'NEWRES', 20
USE HotelManagement
GO
select * from INFORMATION_FORM
SELECT * FROM SUPPLY_FORM
--------------------------------------------
-- INSERT SUPPLY_FORM
USE HotelManagement
go
SELECT * FROM SUPPLY_FORM
CREATE
--ALTER
PROC USP_AddSUPLLYFORM(
	@ID_INFORMATION_FORM CHAR(5),
	@GROUP_NAME NVARCHAR(20),
	@REGISTERED_NAME NVARCHAR(20),
	@GROUP_SIZE INT
)
AS
BEGIN TRANSACTION
	BEGIN TRY
		IF(EXISTS (SELECT ID_INFORMATION_FORM FROM SUPPLY_FORM WHERE ID_INFORMATION_FORM = @ID_INFORMATION_FORM))
		BEGIN
			ROLLBACK TRAN
			RETURN 0
		END
	END TRY

	BEGIN CATCH
		print(N'Thông tin không hợp lệ')
		ROLLBACK TRAN
	END CATCH
	INSERT INTO SUPPLY_FORM VALUES(@ID_INFORMATION_FORM,@GROUP_NAME,@REGISTERED_NAME,@GROUP_SIZE)
COMMIT
GO
-- TEST 
use HotelManagement
go
exec  USP_AddSUPPLYFORM @IDINFORMATIONFORM, N'Phòng vip 8 người', N'Đỗ Thị Hồng', 39
select * from SUPPLY_FORM
SELECT * FROM EMPLOYEE

---------------------------------------------
-- INSERT BOOKING_ROOM
USE HotelManagement
go
CREATE
--ALTER
PROC USP_AddBOOKINGROOM(
	@ID_BOOKING CHAR(10),
	@ID_ROOM CHAR(4)
)
AS
BEGIN TRANSACTION
	BEGIN TRY
		IF(EXISTS (SELECT ID_BOOKING FROM BOOKING_ROOM WHERE ID_BOOKING = @ID_BOOKING))
		BEGIN
			ROLLBACK TRAN
			RETURN 0
		END
	END TRY

	BEGIN CATCH
		print(N'Thông tin không hợp lệ')
		ROLLBACK TRAN
	END CATCH
	INSERT INTO BOOKING_ROOM VALUES(@ID_BOOKING,@ID_ROOM)
COMMIT
GO
----------------------------
-- INSERT RESERVATION_FORM
USE HotelManagement
go
CREATE
--ALTER
PROC USP_UpdateRESERVATION_ROOM(
	@ID_ROOM CHAR(4),
	@ARRIVAL_DATE DATETIME,
	@DEPARTURE_DATE DATETIME
)
AS
BEGIN TRANSACTION
	UPDATE RESERVATION_ROOM 
	SET ARRIVAL_DATE = @ARRIVAL_DATE, DEPARTURE_DATE = @DEPARTURE_DATE
	WHERE ID_ROOM = @ID_ROOM;
COMMIT
GO
select * from ROOM_SERVICE
--------------
use HotelManagement
go
exec  USP_UpdateRESERVATION_ROOM @ID_ROOM, @ARRIVAL_DATE, @DEPARTURE_DATE
select * from RESERVATION_ROOM	




-------------
-------------
---------------------------------------
-- TAO ID BILL TU DONG
 
USE HotelManagement
go
CREATE
--ALTER
FUNCTION CREATE_IDBILL()
RETURNS CHAR(5)
AS
BEGIN
	DECLARE @ID CHAR(5)
	IF(NOT EXISTS (SELECT *
				   FROM BILL))
	BEGIN
		SET @ID = 'B0000'
		RETURN @ID
	END
	ELSE
	BEGIN
		SELECT @ID = ID_BILL 
        FROM BILL
        WHERE CAST(SUBSTRING(ID_BILL, 2, 4) AS INT) = (SELECT MAX(CAST(SUBSTRING(ID_BILL, 2, 4) AS INT)) FROM BILL)
	END
	 -- Tăng giá trị lên 1
        DECLARE @NewID INT
        SET @NewID = CAST(SUBSTRING(@ID, 2, 4) AS INT) + 1
        
        -- Chuyển đổi giá trị thành chuỗi ký tự CHAR
        SET @ID = 'B' + RIGHT('000' + CAST(@NewID AS VARCHAR(4)), 4)
    RETURN @ID
END
GO
-- INSERT BILL
USE HotelManagement
go
--CREATE
ALTER
PROC USP_AddBILL(
	@ROOM_FEE INT,
	@SERVICE_PRICE INT,
	@DAMAGED_PRICE INT,
	@DEPOSIT_PRICE INT,
	@TOTAL_PRICE INT,
	@PAYMENT_METHODS NVARCHAR(30),
	@STATUS NVARCHAR(30),
	@FORM_CREATOR CHAR(5),
	@ID_BOOKING CHAR(5)
	)
AS
BEGIN TRANSACTION
	DECLARE @ID_BILL CHAR(5)
	SET @ID_BILL = DBO.CREATE_IDBILL()
	INSERT INTO BILL VALUES(@ID_BILL,@ROOM_FEE, @SERVICE_PRICE, @DAMAGED_PRICE, @DEPOSIT_PRICE, @TOTAL_PRICE, @PAYMENT_METHODS, @STATUS, @FORM_CREATOR, @ID_BOOKING)
COMMIT

--EXEC USP_AddBILL @ROOM_FEE, @SERVICE_PRICE, @DAMAGED_PRICE, @DEPOSIT_PRICE,@TOTAL_PRICE, @PAYMENT_METHODS, @STATUS, @FORM_CREATOR, @IDBOOKINGFORM

GO
---------------------
-------
---------------
---------------
-- EXEC USP_AddCUSTOMER
---------------
---------------
USE HotelManagement
GO
--EXEC USP_AddCUSTOMER @NAME = 'CusInfo.Name', @GENDER = 'CusInfo.Gender', @BIRTHDAY = CONVERT(DATE, 'CusInfo.Birthday', 103), @EMAIL = 'CusInfo.Email', @PHONE = 'CusInfo.Phone', @IDENTIFY_CARD = 'CusInfo.Identify_Card';
--EXEC USP_AddCUSTOMER @NAME = 'TEST', @GENDER = 'CusInfo.Gender', @BIRTHDAY = CONVERT(DATE, 'CusInfo.Birthday', 103), @EMAIL = 'CusInfo.Email', @PHONE = 'CusInfo.Phone', @IDENTIFY_CARD = 'CusInfo.Identify_Card';
DECLARE @BIRTHDAY_CONVERTED DATE;
SET @BIRTHDAY_CONVERTED = CONVERT(DATE, '28-06-1989', 103);
EXEC USP_AddCUSTOMER @NAME = 'Test', @GENDER = 'Nam', @BIRTHDAY = @BIRTHDAY_CONVERTED, @EMAIL = 'nhan@gmail.com', @PHONE = '0344193909', @IDENTIFY_CARD = '12345';
SELECT*FROM CUSTOMER

---------------
---------------
-- EXEC USP_AddINFORMATIONFORM
---------------
---------------
USE HotelManagement
GO
DECLARE @ARRIVAL_DATE_CONVERTED DATE 
SET @ARRIVAL_DATE_CONVERTED = CONVERT(DATE, '28-06-2023', 103);
EXEC USP_AddINFORMATIONFORM @TYPE = N'TEST2', @ARRIVAL_DATE = @ARRIVAL_DATE_CONVERTED, @NUMBER_ROOMS = 1, @NUMBER_STAYS = 2, @SPECIAL_REQUIREMENTS = 'KHONG CO';
SELECT * FROM INFORMATION_FORM
--EXEC USP_AddBOOKINGFORM @_IDBOOKINGFORM = '', @ARRIVAL_DATE = @_ARRIVAL_DATE, @DEPARTURE_DATE = @_DEPARTURE_DATE, @AMOUNT = @_AMOUNT,@PRICE = @_PRICE,@STATUS = @_STATUS,@SPECIAL_REQUIREMENTS = @_SPECIAL_REQUIREMENTS,@PAYMENT_METHODS = @_PAYMENT_METHODS,@CUSTOMER = @_CUSTOMER;

---------------
---------------
-- EXEC USP_AddBOOKINGFORM
---------------
---------------
USE HotelManagement
GO
DECLARE @ARRIVAL_DATE_CONVERTED DATE
SET @ARRIVAL_DATE_CONVERTED = CONVERT(DATE, '28-06-2023', 103);
DECLARE @DEPARTURE_DATE_CONVERTED DATE
SET @DEPARTURE_DATE_CONVERTED = CONVERT(DATE, '28-06-2023', 103);
EXEC USP_AddBOOKINGFORM @IDBOOKINGFORM = '', @ARRIVAL_DATE = @ARRIVAL_DATE_CONVERTED, @DEPARTURE_DATE = @DEPARTURE_DATE_CONVERTED, @AMOUNT = '1',@PRICE = '2000',@STATUS = N'da thanh toan', @SPECIAL_REQUIREMENTS = N'KHOONG',@PAYMENT_METHODS = 'CHECK',@CUSTOMER = N'C4740';

USE HotelManagement
GO
delete from BOOKING_FORM where ID_BOOKING = 'BK997'
delete from BOOKING_FORM where ID_BOOKING = 'BK998'
delete from BOOKING_FORM where ID_BOOKING = 'BK999'
SELECT * FROM BOOKING_FORM



---------------
---------------
-- EXEC USP_AddSUPLLYFORM
---------------
---------------

USE HotelManagement
GO
EXEC USP_AddSUPLLYFORM @ID_INFORMATION_FORM = N'I9799', @GROUP_NAME = N'KKK', @REGISTERED_NAME = N'CUSTOMERNAME', @GROUP_SIZE = '5';
USE HotelManagement
GO
SELECT * FROM SUPPLY_FORM

---------------
---------------
-- EXEC USP_AddBILL
---------------
---------------
USE HotelManagement
GO 
EXEC USP_AddBILL @ID_BILL = '', @STATUS =  N'Đã thanh toán',@ROOM_PRICE = 9999,@TOTAL_PRICE = 99999,@PAYMENT_METHODS = N'Credit Card',@FORM_CREATOR = 'EMP31',@CUSTOMER = 'C1229'

SELECT * FROM BILL



---------------
---------------
-- SERVICE TA
---------------
---------------
USE HotelManagement
GO
CREATE
-- ALTER
FUNCTION CREATE_IDSERVICE_BF()
RETURNS CHAR(5)
AS
BEGIN
	DECLARE @ID CHAR(10)
	IF(NOT EXISTS (SELECT *
				   FROM SERVICE_FORM))
	BEGIN
		SET @ID = 'SF001'
		RETURN @ID
	END
	ELSE
	BEGIN
		SELECT @ID = CAST(CAST(MIN(RIGHT(ID_SERVICE_FORM,3)) AS INT) + 1 AS CHAR(5))
		FROM SERVICE_FORM
		WHERE (RIGHT(ID_SERVICE_FORM,3) + 1) NOT IN (SELECT RIGHT(ID_SERVICE_FORM,3) FROM SERVICE_FORM)
	END

	DECLARE @TEMP INT = CAST(@ID AS INT)
	DECLARE @COUNT INT = 0

	WHILE(@TEMP >0)
	BEGIN
		SET @TEMP = @TEMP/10
		SET @COUNT = @COUNT + 1
	end
    
	DECLARE @CNT int =0
	WHILE(@CNT <> (3-@COUNT))
	BEGIN
		SET @ID = '0' + @ID
		SET @CNT = @CNT + 1
	END
	SET @ID = 'SF' + @ID
	RETURN @ID
END
GO
--CREATE
ALTER
PROC USP_AddSERVICE_BF(
	@IDCUS CHAR(5),
	@NAMESERVICE NVARCHAR(100),
	@SERVICEID CHAR(10),
	@DESCRIPT NVARCHAR(100),
	@PRICE INT,
	@AMOUNT INT,
	@EMPID CHAR(5),
	@TOTAL_PRICE INT,
	@USINGDATE DATETIME,
	@DISCOUNT FLOAT
	--@ID_BILL CHAR(5)
)
AS
BEGIN TRANSACTION
	DECLARE @IDSERVICE CHAR(10) = DBO.CREATE_IDSERVICE_BF()
	INSERT INTO SERVICE_FORM VALUES(@IDSERVICE,@NAMESERVICE,@DESCRIPT,@PRICE,@AMOUNT,@SERVICEID,@EMPID,@IDCUS)
	--INSERT INTO SERVICE_BILL VALUES(@IDSERVICE,@USINGDATE,@TOTAL_PRICE,@DISCOUNT,@TOTAL_PRICE*(100-@DISCOUNT)/100,'Đã thanh toán',@IDSERVICE,'B0043')
COMMIT

select * from SERVICE_BILL
select * from SERVICE_FORM
EXEC USP_AddSERVICE_BF NULL,N'gÂU GÂU',NULL,'LA LA',1241223,23,NULL,51253234,NULL,4


---------
use HotelManagement
go
DECLARE @BIRTHDAY_CONVERTED DATE, @ARRIVAL_DATE_CONVERTED DATE;
SET @BIRTHDAY_CONVERTED = CONVERT(DATE, '11-11-2001', 103);
SET @ARRIVAL_DATE_CONVERTED = CONVERT(DATE, '21-12-2023', 103);
EXEC USP_AddCUSTOMER @NAME = N'Phan Thien', @GENDER = N'Nam', @BIRTHDAY = @BIRTHDAY_CONVERTED, @EMAIL = N'nhan@gmai.com', 
@PHONE = '034131241', @IDENTIFY_CARD = N'1212122', @TYPE = N'Đảm bảo', @ARRIVAL_DATE = @ARRIVAL_DATE_CONVERTED,
@NUMBER_ROOMS = 6, @NUMBER_STAYS = 12, @SPECIAL_REQUIREMENTS = N'SpecialRequirements', @GROUP_NAME = N'GroupName', @REGISTERED_NAME = N'RegisteredName', @GROUP_SIZE = 6;

SELECT * FROM CUSTOMER
SELECT * FROM INFORMATION_FORM
SELECT * FROM SUPPLY_FORM
SELECT * FROM BOOKING_FORM
SELECT * FROM BILL