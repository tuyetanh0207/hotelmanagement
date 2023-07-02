﻿select * from ITEM_ROOM
select * from ITEM
select * from PARTNER
select * from PARTNER_TOUR
select * from ROOM
select * from BOOKING_ROOM

-- Liệt kê danh sách vật dụng theo mã phòng
CREATE FUNCTION fu_List_Of_Items_Room 
( @room_id INT )
RETURNS VARCHAR(50)
AS
BEGIN
DECLARE @room_id VARCHAR(50);

select distinct I.NAME, IR.AMOUNT
from ITEM I join ITEM_ROOM IR on I.ID_ITEM = IR.ID_ITEM
where IR.ID_ROOM = '1005'

-- @room_id;
RETURN @room_id;
END;

-- Liệt kê tất cả vật dụng
-- done
SELECT * FROM RESERVATION_ROOM
SELECT * FROM ITEM_ROOM
SELECT * FROM ITEM
select distinct IR.ID_ROOM,I.NAME, IR.AMOUNT from ITEM I join ITEM_ROOM IR on I.ID_ITEM = IR.ID_ITEM where IR.ID_ROOM = '1005'
select I.NAME from ITEM I join ITEM_ROOM IR on I.ID_ITEM = IR.ID_ITEM where IR.ID_ROOM = '1005'
select IR.AMOUNT from ITEM I join ITEM_ROOM IR on I.ID_ITEM = IR.ID_ITEM where IR.ID_ROOM = '1005'
select I.NAME from ITEM I join ITEM_ROOM IR on I.ID_ITEM = IR.ID_ITEM where IR.ID_ROOM = '1005'
select distinct IR.ID_ROOM,I.NAME, IR.AMOUNT from ITEM I join ITEM_ROOM IR on I.ID_ITEM = IR.ID_ITEM where IR.ID_ROOM = '1005'
select distinct ID_ROOM from ITEM I join ITEM_ROOM IR on I.ID_ITEM = IR.ID_ITEM order by ID_ROOM asc;
select * from ITEM I join ITEM_ROOM IR on I.ID_ITEM = IR.ID_ITEM order by ID_ROOM asc
SELECT * FROM BOOKING_FORM BF where ID_BOOKING = 'BK00680615'
select * from BOOKING_ROOM BR JOIN ROOM R ON BR.ID_ROOM = R.ID_ROOM
select * from ITEM I join ITEM_ROOM IR on I.ID_ITEM = IR.ID_ITEM order by ID_ROOM asc
SELECT * FROM BOOKING_FORM ORDER BY ID_BOOKING ASC
select * from CUSTOMER
--

SELECT BF.*, C.NAME
INTO BOOKING_FORM_CUSTOMER_NAME
FROM BOOKING_FORM BF JOIN CUSTOMER C ON BF.CUSTOMER = C.ID_CUSTOMER 
ORDER BY ID_BOOKING ASC
select * from BOOKING_FORM_CUSTOMER_NAME
UPDATE BOOKING_FORM_CUSTOMER_NAME 
SET NAME = N'Le Thi Thuy Duong' 
WHERE ID_BOOKING = 'BK01648993'

--CREATE FUNCTION Edit_Reservation(@booking_id varchar(10), @name nvarchar(50) )
--RETURNS TABLE
--AS
--RETURN
--(
--    UPDATE CUSTOMER 
--	SET NAME = @name
--	WHERE ID_BOOKING = @booking_id
--)
--GO
SELECT * FROM BOOKING_FORM_CUSTOMER_NAME
CREATE FUNCTION edit_Reservation
( @booking_id INT )
RETURNS VARCHAR(50)
AS
BEGIN
DECLARE @customer_name NVARCHAR(50);
DECLARE @date_arrive DATE;
DECLARE @date_leaving DATE;
DECLARE @number_of_people INT;
DECLARE @special_require NVARCHAR(50);
DECLARE @room_type VARCHAR(50);

IF @booking_id NOT NULL
SET @nhanvien_name = 'Smith';
ELSE
SET @nhanvien_name = 'Lawrence';

RETURN @nhanvien_name;

END;
--
select DISTINCT R.TYPE from BOOKING_ROOM BR JOIN ROOM R ON BR.ID_ROOM = R.ID_ROOM


select * from BOOKING_ROOM
SELECT * FROM BOOKING_FORM
select * from ROOM
select * from BOOKING_FORM_CUSTOMER_NAME
--

    --drop table BOOKING_FORM_CUSTOMER_NAME
go
begin 
SELECT BF.*, C.NAME, BR.ID_ROOM, R.TYPE
INTO BOOKING_FORM_CUSTOMER_NAME
FROM BOOKING_FORM BF JOIN BOOKING_ROOM BR ON BF.ID_BOOKING = BR.ID_BOOKING 
		 JOIN CUSTOMER C ON BF.CUSTOMER = C.ID_CUSTOMER 
		 JOIN ROOM R ON BR.ID_ROOM = R.ID_ROOM
ORDER BY ID_BOOKING ASC
end
go
UPDATE BOOKING_FORM_CUSTOMER_NAME
SET NAME = N'Le Thi Thuy Duong' 
WHERE ID_BOOKING = 'BK034'
go
select * from BOOKING_FORM_CUSTOMER_NAME

-- Tạo bảng mới để lưu thông tin đơn đặt hàng
SELECT BF.*, C.NAME, BR.ID_ROOM, R.TYPE
	INTO BOOKING_FORM_CUSTOMER_NAME
	FROM BOOKING_FORM BF JOIN BOOKING_ROOM BR ON BF.ID_BOOKING = BR.ID_BOOKING 
			 JOIN CUSTOMER C ON BF.CUSTOMER = C.ID_CUSTOMER 
			 JOIN ROOM R ON BR.ID_ROOM = R.ID_ROOM
	ORDER BY ID_BOOKING ASC
--
go
create 
--drop 
proc usp_edit_reservation(
	@customer_name nvarchar(80),
	@idbooking char(10)
	) 
as 
	go
	DECLARE @customer_name nvarchar(50)
	UPDATE BOOKING_FORM_CUSTOMER_NAME
	SET NAME = @customer_name
	WHERE ID_BOOKING = 'BK123';
	go
	--select * from BOOKING_FORM_CUSTOMER_NAME
go
exec usp_edit_reservation N'Lê Thị Thùy Dương'