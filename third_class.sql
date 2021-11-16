use birdstrikes;

select * from birdstrikes;

SELECT userid, COUNT(pingtime) 
        FROM mobility
        GROUP BY userid, pingdate
        LIMIT 1000;

SELECT aircraft, COUNT(speed)
FROM birdstrikes
GROUP BY aircraft
LIMIT 1;

SELECT aircraft, COUNT(speed)
FROM birdstrikes
WHERE aircraft = "Airplane";

SELECT MIN(speed), aircraft FROM birdstrikes GROUP BY aircraft;

SELECT aircraft, airline, cost, 
    CASE 
        WHEN cost  = 0
            THEN 'NO COST'
        WHEN  cost >0 AND cost < 100000
            THEN 'MEDIUM COST'
        ELSE 
            'HIGH COST'
    END
    AS cost_category   
FROM  birdstrikes
ORDER BY cost_category;

/*
Do the same with speed. If speed is NULL or speed < 100 create a “LOW SPEED” category, otherwise, 
mark as “HIGH SPEED”. Use IF instead of CASE!
*/

SELECT aircraft, airline, speed, 
    IF(speed IS NULL OR speed < 100, "LOW SPEED", "HIGH SPEED")
    AS speed_category   
FROM  birdstrikes
ORDER BY speed_category;

SELECT COUNT(*) FROM birdstrikes;

SELECT COUNT(reported_date) FROM birdstrikes;

SELECT DISTINCT state FROM birdstrikes;

SELECT COUNT(DISTINCT state) FROM birdstrikes;

-- How many distinct ‘aircraft’ we have in the database?

SELECT COUNT(DISTINCT aircraft) FROM birdstrikes;

-- 3

SELECT SUM(cost) FROM birdstrikes;

SELECT (AVG(speed)*1.852) as avg_kmh FROM birdstrikes;

SELECT DATEDIFF(MAX(reported_date),MIN(reported_date)) from birdstrikes;

-- What was the lowest speed of aircrafts starting with ‘H’

SELECT MIN(speed) FROM birdstrikes WHERE aircraft LIKE 'H%';

-- 9

SELECT MIN(speed), aircraft FROM birdstrikes GROUP BY aircraft;

SELECT state, aircraft, SUM(cost) AS sum FROM birdstrikes WHERE state !='' GROUP BY state, aircraft ORDER BY sum DESC;

-- Which phase_of_flight has the least of incidents?

SELECT COUNT(id) AS count FROM birdstrikes GROUP BY phase_of_flight ORDER BY count ASC LIMIT 1;

-- 2

-- What is the rounded highest average cost by phase_of_flight?

SELECT ROUND(AVG(cost),2) AS rounded_cost FROM birdstrikes GROUP BY phase_of_flight ORDER BY rounded_cost DESC LIMIT 1;

-- 54672.98

SELECT AVG(speed) AS avg_speed,state FROM birdstrikes GROUP BY state WHERE ROUND(avg_speed) = 50;

SELECT AVG(speed) AS avg_speed,state FROM birdstrikes GROUP BY state HAVING ROUND(avg_speed) = 50;

-- before aggregation WHERE

SELECT AVG(speed) AS avg_speed,state FROM birdstrikes WHERE GROUP BY state HAVING ROUND(avg_speed) = 50;

-- What the highest AVG speed of the states with names less than 5 characters?

SELECT AVG(speed) AS avg_speed FROM birdstrikes GROUP BY state HAVING LENGTH(state) < 5 ORDER BY avg_speed DESC LIMIT 1;

-- 2862.5







