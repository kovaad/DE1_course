USE classicmodels;

DROP PROCEDURE IF EXISTS GetAllProducts;

DELIMITER //

CREATE PROCEDURE GetAllProducts()
BEGIN
	SELECT *  FROM products;
    SELECT * FROM offices;
END //

DELIMITER ;

CALL GetAllProducts();

DROP PROCEDURE IF EXISTS GetOfficeByCountry;

DELIMITER //

CREATE PROCEDURE GetOfficeByCountry(
	IN countryName VARCHAR(255), cityName VARCHAR(255)
)
BEGIN
	SELECT * 
 		FROM offices
			WHERE country = countryName AND city = cityName;
END //
DELIMITER ;

CALL GetOfficeByCountry('USA', 'New York');

CALL GetOfficeByCountry('France', 'Paris');

CALL GetOfficeByCountry();

-- Create a stored procedure which displays the first X entries of payment table. X is IN parameter for the procedure.

DELIMITER //

CREATE PROCEDURE FirstEntriesPayment(
	IN X INT
)
BEGIN
	SELECT * 
 		FROM payments
			LIMIT X;
END //
DELIMITER ;

CALL FirstEntriesPayment(5);

DROP PROCEDURE IF EXISTS GetOrderCountByStatus;

DELIMITER $$

CREATE PROCEDURE GetOrderCountByStatus (
	IN  orderStatus VARCHAR(25),
	OUT total INT
)
BEGIN
	SELECT COUNT(orderNumber)
	INTO total
	FROM orders
	WHERE status = orderStatus;
END$$
DELIMITER ;

CALL GetOrderCountByStatus('Shipped',@total);
SELECT @total;

-- Create a stored procedure which returns the amount for Xth entry of payment table. 
-- X is IN parameter for the procedure. Display the returned amount.

DROP PROCEDURE IF EXISTS AmountForEntry;

DELIMITER $$

CREATE PROCEDURE AmountForEntry (
	IN n INT,
	OUT total DECIMAL(10,2)
)
BEGIN
	SET n = n-1;
	SELECT amount
	INTO total
	FROM payments
	LIMIT n, 1;
END$$
DELIMITER ;

CALL AmountForEntry(100, @blabla);

SELECT @blabla;


DROP PROCEDURE IF EXISTS SetCounter;

DELIMITER $$

CREATE PROCEDURE SetCounter(
	INOUT counter INT,
    	IN inc INT
)
BEGIN
	SET counter = counter + inc;
END$$
DELIMITER ;

SET @counter = 1;
CALL SetCounter(@counter,1); 
SELECT @counter;
CALL SetCounter(@counter,1); 
SELECT @counter;
CALL SetCounter(@counter,-1); 
SELECT @counter;

DROP PROCEDURE IF EXISTS GetCustomerLevel;

DELIMITER $$

CREATE PROCEDURE GetCustomerLevel(
    	IN  pCustomerNumber INT, 
    	OUT pCustomerLevel  VARCHAR(20)
)
BEGIN
	DECLARE credit DECIMAL DEFAULT 0;

	SELECT creditLimit 
		INTO credit
			FROM customers
				WHERE customerNumber = pCustomerNumber;

	IF credit > 50000 THEN
		SET pCustomerLevel = 'PLATINUM';
	ELSE
		SET pCustomerLevel = 'NOT PLATINUM';
	END IF;
END$$
DELIMITER ;

CALL GetCustomerLevel(447, @level);
SELECT @level;

-- Create a stored procedure which returns category of a given row. Row number is IN parameter, 
-- while category is OUT parameter. Display the returned category. 
-- CAT1 - amount > 100.000, CAT2 - amount > 10.000, CAT3 - amount <= 10.000

DROP PROCEDURE IF EXISTS GetCustomerLevel;

DELIMITER $$

CREATE PROCEDURE CategoryOfRow(
    	IN  pRow INT, 
    	OUT pCategory  VARCHAR(20)
)
BEGIN
	DECLARE amounts DECIMAL DEFAULT 0;
    SET pRow = pRow=1; 

	SELECT amount 
		INTO amounts
			FROM payments
				LIMIT pRow, 1;

	IF amounts > 100.000 THEN
		SET pCategory = 'CAT1';
	ELSEIF amounts > 10.000 THEN
		SET pCategory = 'CAT2';
	ELSE 
		SET pCategory = 'CAT3';
	END IF;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS LoopDemo;

DELIMITER $$
CREATE PROCEDURE LoopDemo()
BEGIN
      
	myloop: LOOP 
		SELECT * FROM offices;
        LEAVE myloop;
	END LOOP myloop;
 END$$
DELIMITER ;

CALL LoopDemo();

-- Create a loop which counts to 5 and displays the actual count in each step as SELECT (eg. SELECT x)

CREATE TABLE IF NOT EXISTS messages (message VARCHAR(100) NOT NULL);

DROP PROCEDURE IF EXISTS NewLoop;

DELIMITER $$
CREATE PROCEDURE NewLoop()
BEGIN
	DECLARE x INT DEFAULT 0;
    
    TRUNCATE messages;
	adamloop: LOOP 
		SET x = x + 1;
		INSERT INTO messages SELECT CONCAT('x: ',x);
        
        IF (x=5) THEN
			LEAVE adamloop;
            END IF;
	END LOOP adamloop ;
 END$$
DELIMITER ;

CALL NewLoop();

SELECT * FROM messages;


DROP PROCEDURE IF EXISTS CursorDemo;

DELIMITER $$
CREATE PROCEDURE CursorDemo()
BEGIN
	DECLARE phone varchar(50);
	DECLARE finished INTEGER DEFAULT 0;
	-- DECLARE CURSOR
	DECLARE curPhone CURSOR FOR SELECT customers.phone FROM classicmodels.customers;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
	-- OPEN CURSOR
	OPEN curPhone;
	TRUNCATE messages;
	myloop: LOOP
		-- FETCH CURSOR
		FETCH curPhone INTO phone;
		INSERT INTO messages SELECT CONCAT('phone: ',phone);
		IF finished = 1 THEN LEAVE myloop;
		END IF;
	END LOOP myloop;
	-- CLOSE CURSOR
	CLOSE curPhone;
END$$
DELIMITER ;


CALL CursorDemo();

SELECT * FROM messages;

-- Loop through orders table. Fetch orderNumber + shippedDate. Write in both fields into messages as one line.

DROP PROCEDURE IF EXISTS CursorDemo2;

DELIMITER $$
CREATE PROCEDURE CursorDemo2()
BEGIN
	DECLARE ornumber INT;
    DECLARE sdate DATE;
	DECLARE finished INTEGER DEFAULT 0;
	-- DECLARE CURSOR
	DECLARE cursor1 CURSOR FOR SELECT orders.orderNumber, orders.shippedDate FROM classicmodels.orders;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
	-- OPEN CURSOR
	OPEN cursor1;
	TRUNCATE messages;
	myloop: LOOP
		-- FETCH CURSOR
		FETCH cursor1 INTO ornumber, sdate;
		INSERT INTO messages SELECT CCONCAT(ornumber, ":", COALESCE(sdate,‘’));
        INSERT INTO messages SELECT  COALESCE('shipdate: ',sdate);
		IF finished = 1 THEN LEAVE myloop;
		END IF;
	END LOOP myloop;
	-- CLOSE CURSOR
	CLOSE curNum;
    CLOSE curShip;
END$$
DELIMITER ;


CALL CursorDemo2();
SELECT * FROM messages;

