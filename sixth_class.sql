USE classicmodels;

SELECT *
FROM orders
INNER JOIN orderdetails 
USING (orderNumber);

SELECT t1.orderNumber AS SalesID, 
		t2.priceEach AS Price, t2.quantityOrdered AS Unit, 
        t3.productName AS Product, t3.productLine AS Brand,
        t4.city AS City, t4.country AS Country,
        t1.orderDate AS Date, WEEK(t1.orderDate) AS WeekOfYear
FROM orders AS t1
INNER JOIN orderdetails AS t2 
USING (orderNumber)
INNER JOIN products AS t3
USING (productCode)
INNER JOIN customers AS t4
USING (customerNumber);

-- this is good, but it does not copy the data, only the structure
CREATE TABLE new_order LIKE orders;

DROP Table new_order;

-- this is now really good
CREATE TABLE new_order AS SELECT * FROM orders; 

SELECT * FROM new_order;

-- create stored procedure to create this table
DROP PROCEDURE IF EXISTS CreateProductSalesStore;

DELIMITER //

CREATE PROCEDURE CreateProductSalesStore()
BEGIN

	DROP TABLE IF EXISTS product_sales;

	CREATE TABLE product_sales AS
	SELECT 
	   orders.orderNumber AS SalesId, 
	   orderdetails.priceEach AS Price, 
	   orderdetails.quantityOrdered AS Unit,
	   products.productName AS Product,
	   products.productLine As Brand,   
	   customers.city As City,
	   customers.country As Country,   
	   orders.orderDate AS Date,
	   WEEK(orders.orderDate) as WeekOfYear
	FROM
		orders
	INNER JOIN
		orderdetails USING (orderNumber)
	INNER JOIN
		products USING (productCode)
	INNER JOIN
		customers USING (customerNumber)
	ORDER BY 
		orderNumber, 
		orderLineNumber;

END //
DELIMITER ;


CALL CreateProductSalesStore();

SELECT * FROM classicmodels.product_sales;

-- EVENTS

SHOW VARIABLES LIKE "event_scheduler";

SET GLOBAL event_scheduler = ON;

SET GLOBAL event_scheduler = OFF;

SET GLOBAL event_scheduler = ON;

DROP EVENT CreateProductSalesStoreEvent;

TRUNCATE messages;

DELIMITER $$

CREATE EVENT CreateProductSalesStoreEvent
ON SCHEDULE EVERY 1 MINUTE
STARTS CURRENT_TIMESTAMP
ENDS CURRENT_TIMESTAMP + INTERVAL 1 HOUR
DO
	BEGIN
		INSERT INTO messages SELECT CONCAT('event:',NOW());
    		CALL CreateProductSalesStore();
	END$$
DELIMITER ;

SHOW EVENTS;

SELECT * FROM messages;


DELIMITER $$

CREATE TRIGGER trigger_namex
    AFTER INSERT ON table_namex FOR EACH ROW
BEGIN
    -- statements
    -- NEW.orderNumber, NEW.productCode etc
END$$    

DELIMITER ;

-- Copy the birdstrikes structure into a new table called birdstrikes2. Insert into birdstrikes2 the line where id is 10

USE birdstrikes;

CREATE TABLE birdstrikes2 LIKE birdstrikes;

INSERT INTO birdstrikes2 SELECT * FROM birdstrikes WHERE id = 10;

USE classicmodels;

TRUNCATE messages;

DROP TRIGGER IF EXISTS after_order_insert; 

DELIMITER $$

CREATE TRIGGER after_order_insert
AFTER INSERT
ON orderdetails FOR EACH ROW
BEGIN
	
	-- log the order number of the newley inserted order
    	INSERT INTO messages SELECT CONCAT('new orderNumber: ', NEW.orderNumber);

	-- archive the order and assosiated table entries to product_sales
  	INSERT INTO product_sales
	SELECT 
	   orders.orderNumber AS SalesId, 
	   orderdetails.priceEach AS Price, 
	   orderdetails.quantityOrdered AS Unit,
	   products.productName AS Product,
	   products.productLine As Brand,
	   customers.city As City,
	   customers.country As Country,   
	   orders.orderDate AS Date,
	   WEEK(orders.orderDate) as WeekOfYear
	FROM
		orders
	INNER JOIN
		orderdetails USING (orderNumber)
	INNER JOIN
		products USING (productCode)
	INNER JOIN
		customers USING (customerNumber)
	WHERE orderNumber = NEW.orderNumber
	ORDER BY 
		orderNumber, 
		orderLineNumber;
        
END $$

DELIMITER ;

SELECT * FROM product_sales ORDER BY SalesId;

INSERT INTO orders  VALUES(16,'2020-10-01','2020-10-01','2020-10-01','Done','',131);
INSERT INTO orderdetails  VALUES(16,'S18_1749','1','10',1);

SELECT * FROM messages;

SELECT COUNT(*) FROM product_sales;

SELECT * FROM product_sales ORDER BY Date;



DROP VIEW IF EXISTS Vintage_Cars;

CREATE VIEW Vintage_Cars AS
SELECT * FROM product_sales WHERE product_sales.Brand = 'Vintage Cars';

SELECT * FROM Vintage_Cars;

DROP VIEW IF EXISTS USA;

CREATE VIEW USA AS
SELECT * FROM product_sales WHERE country = 'USA';

SELECT * FROM USA;

-- Create a view, which contains product_sales rows of 2003 and 2005.

DROP VIEW IF EXISTS Sales;

CREATE VIEW Sales AS
SELECT * FROM product_sales WHERE YEAR(Date) = 2003 OR YEAR(Date) = 2005;

SELECT COUNT(*) FROM Sales;
-- 1575



