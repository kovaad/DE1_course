
CREATE TABLE employee 
(id INTEGER NOT NULL,
employee_name VARCHAR(32) NOT NULL,
PRIMARY KEY(id));

SELECT state FROM birdstrikes LIMIT 144,1;


SELECT state, cost FROM birdstrikes ORDER BY state, cost ASC;


SELECT DISTINCT cost FROM birdstrikes ORDER BY cost DESC LIMIT 49,1;


SELECT state FROM birdstrikes WHERE state != '' AND bird_size != '' LIMIT 1,1;


SELECT DATEDIFF(DATE(NOW()), flight_date) AS time_elapsed 
FROM birdstrikes 
WHERE state = 'Colorado' AND WEEKOFYEAR(flight_date) = 52;

