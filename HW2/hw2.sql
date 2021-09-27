/* 
Based on the previous chapter, create a table called “employee” 
with two columns: “id” and “employee_name”. 
NULL values should not be accepted for these 2 columns.
*/
CREATE TABLE employee 
(id INTEGER NOT NULL,
employee_name VARCHAR(32) NOT NULL,
PRIMARY KEY(id));

/* 
What state figures in the 145th line of our database?
*/

SELECT state FROM birdstrikes LIMIT 144,1;

/* 
Answer: Tennesse
*/

/* 
What is flight_date of the latest birstrike in this database?
*/

SELECT flight_date FROM birdstrikes ORDER BY flight_date DESC LIMIT 1;

/* 
Answer: 2000-04-18
*/

/* 
What was the cost of the 50th most expensive damage?
*/

SELECT DISTINCT cost FROM birdstrikes ORDER BY cost DESC LIMIT 49,1;

/* 
Answer: 5345
*/

/* 
What state figures in the 2nd record, if you filter out all records 
which have no state and no bird_size specified?
*/

SELECT state FROM birdstrikes WHERE state != '' AND bird_size != '' LIMIT 1,1;

/* 
Answer: Colorado
*/

/* 
How many days elapsed between the current date and the flights happening in week 52, for incidents from Colorado? (Hint: use NOW, DATEDIFF, WEEKOFYEAR)
*/

SELECT DATEDIFF(DATE(NOW()), flight_date) AS time_elapsed 
FROM birdstrikes 
WHERE state = 'Colorado' AND WEEKOFYEAR(flight_date) = 52;

/* 
Answer: 7940
*/
