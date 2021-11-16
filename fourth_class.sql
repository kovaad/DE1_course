use classicmodels;

SHOW TABLES;

SELECT *
FROM left_table
INNER JOIN right_table
ON left_table.id = right_table.id;

SELECT * 
FROM products 
INNER JOIN productlines  
ON products.productline = productlines.productline;

SELECT *
FROM products t1
INNER JOIN productlines t2 
ON t1.productline = t2.productline;

SELECT *
FROM products 
INNER JOIN productlines 
USING(productline);

SELECT t1.productName, t1.productLine, t2.textDescription
FROM products t1
INNER JOIN productlines t2 
ON t1.productline = t2.productline;

-- Ex1: Join all fields of order and orderdetails

SELECT *
FROM orders 
INNER JOIN orderdetails 
USING(orderNumber);

-- Join all fields of order and orderdetails. 
-- Display only orderNumber, status and sum of totalsales (quantityOrdered * priceEach) for each orderNumber.

SELECT
	t1.orderNumber,
    t1.status,
    SUM(quantityOrdered * priceEach) totalsales
FROM orders t1
INNER JOIN orderdetails t2
	ON t1.orderNumber = t2.orderNumber
GROUP BY orderNumber;


SELECT *
FROM left_table
INNER JOIN right_table
ON left_table.id = right_table.id
INNER JOIN another_table
ON left_table.id = another_table.id;

-- We want to know how the employees are performing. Join orders, customers and employees and return orderDate,lastName, firstName

SELECT 
	t1.orderDate, 
	t3.lastName,
    t3.firstName
FROM orders t1
INNER JOIN customers t2
ON t1.customerNumber = t2.customerNumber
INNER JOIN employees t3
ON t2.salesRepEmployeeNumber = t3.employeeNumber;


SELECT 
    CONCAT(m.lastName, ', ', m.firstName) AS Manager,
    CONCAT(e.lastName, ', ', e.firstName) AS 'Direct report'
FROM
    employees e
INNER JOIN employees m ON 
    m.employeeNumber = e.reportsTo
ORDER BY 
    Manager;
    
-- Why President is not in the list? He does not report to anyone

SELECT
    c.customerNumber,
    customerName,
    orderNumber,
    status
FROM
    customers c
LEFT JOIN orders o 
    ON c.customerNumber = o.customerNumber;
    
SELECT
    c.customerNumber,
    customerName,
    orderNumber,
    status
FROM
    customers c
INNER JOIN orders o 
    ON c.customerNumber = o.customerNumber;
    
    
SELECT 
    o.orderNumber, 
    customerNumber, 
    productCode
FROM
    orders o
LEFT JOIN orderDetails 
    USING (orderNumber)
WHERE
    orderNumber = 10123;
    
    
SELECT 
    o.orderNumber, 
    customerNumber, 
    productCode
FROM
    orders o
LEFT JOIN orderDetails d 
    ON o.orderNumber = d.orderNumber AND 
       o.orderNumber = 10123;
    

    
    
    
    
    
    
