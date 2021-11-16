use birdstrikes;

SHOW TABLES;

DESCRIBE birdstrikes;

SELECT * FROM birdstrikes;

SELECT cost FROM birdstrikes;

SELECT airline, cost FROM birdstrikes;

create table new_birdstrikes like birdstrikes;

show tables;
DESCRIBE new_birdstrikes;
SELECT * FROM new_birdstrikes;

drop table if exists new_birdstrikes;

drop table employee;

CREATE TABLE employee 
(id INTEGER NOT NULL,
employee_name VARCHAR(32) NOT NULL,
PRIMARY KEY(id));

INSERT INTO employee (id,employee_name) VALUES(1,'Student1');
INSERT INTO employee (id,employee_name) VALUES(2,'Student2');
INSERT INTO employee (id,employee_name) VALUES(3,'Student3');

SELECT * FROM employee;

INSERT INTO employee (id,employee_name) VALUES(3,'Student4');

UPDATE employee SET employee_name='Arnold Schwarzenegger' WHERE id = '1';
UPDATE employee SET employee_name='The Other Arnold' WHERE id = '2';

SELECT * FROM employee;

DELETE FROM employee WHERE id = 3;

SELECT * FROM employee;

TRUNCATE employee;

SELECT * FROM employee;

CREATE USER 'kovacsa'@'%' IDENTIFIED BY 'kovacsa';

GRANT ALL ON birdstrikes.employee TO 'kovacsa'@'%';

GRANT SELECT (state) ON birdstrikes.birdstrikes TO 'kovacsa'@'%';

DROP USER 'kovacsa'@'%';

SELECT *, speed/2 FROM birdstrikes;

SELECT *, speed/2 AS halfspeed FROM birdstrikes;

SELECT * FROM birdstrikes LIMIT 10;

SELECT * FROM birdstrikes LIMIT 10,1;

SELECT state FROM birdstrikes LIMIT 144,1;

SELECT state, cost FROM birdstrikes ORDER BY cost;

SELECT state, cost FROM birdstrikes ORDER BY state, cost ASC;

SELECT state, cost FROM birdstrikes ORDER BY cost DESC;

SELECT flight_date FROM birdstrikes ORDER BY flight_date DESC LIMIT 1;

SELECT DISTINCT damage FROM birdstrikes;

SELECT DISTINCT airline, damage FROM birdstrikes;

SELECT DISTINCT cost FROM birdstrikes ORDER BY cost DESC LIMIT 49,1;

SELECT * FROM birdstrikes WHERE state = 'Alabama';

SELECT * FROM birdstrikes WHERE state != 'Alabama';

SELECT DISTINCT state FROM birdstrikes WHERE state LIKE 'A%';

SELECT DISTINCT state FROM birdstrikes WHERE state LIKE 'a%';

SELECT DISTINCT state FROM birdstrikes WHERE state LIKE 'ala%';

SELECT DISTINCT state FROM birdstrikes WHERE state LIKE 'North _a%';

SELECT DISTINCT state FROM birdstrikes WHERE state NOT LIKE 'a%' ORDER BY state;

SELECT * FROM birdstrikes WHERE state = 'Alabama' AND bird_size = 'Small';
SELECT * FROM birdstrikes WHERE state = 'Alabama' OR state = 'Missouri';

SELECT DISTINCT state FROM birdstrikes WHERE state IS NOT NULL AND state != '' ORDER BY state;

SELECT * FROM birdstrikes WHERE state IN ('Alabama', 'Missouri','New York','Alaska');

SELECT DISTINCT state FROM birdstrikes WHERE LENGTH(state) = 5;

SELECT * FROM birdstrikes WHERE speed = 350;

SELECT * FROM birdstrikes WHERE speed >= 10000;

SELECT ROUND(SQRT(speed/2) * 10) AS synthetic_speed FROM birdstrikes;

SELECT * FROM birdstrikes where cost BETWEEN 20 AND 40;

SELECT state FROM birdstrikes WHERE state != '' AND bird_size != '' LIMIT 1,1;

SELECT * FROM birdstrikes WHERE flight_date = "2000-01-02";

SELECT * FROM birdstrikes WHERE flight_date >= '2000-01-01' AND flight_date <= '2000-01-03';

SELECT * FROM birdstrikes where flight_date BETWEEN "2000-01-01" AND "2000-01-03";

SELECT DATEDIFF(DATE(NOW()), flight_date) AS time_elapsed 
FROM birdstrikes 
WHERE state = 'Colorado' AND WEEKOFYEAR(flight_date) = 52;

