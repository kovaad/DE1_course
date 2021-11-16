/*
Term project of Adam Jozsef Kovacs for the course SQL and Different Shapes of Data
*/

#create the schema
DROP SCHEMA IF EXISTS SOCCER;

CREATE SCHEMA SOCCER;
USE SOCCER;

#check if we can read in data - modify to make sure
SHOW VARIABLES LIKE "secure_file_priv";
SET GLOBAL local_infile = 'ON';
SHOW VARIABLES LIKE 'local_infile';

#create table and read in data on leagues
DROP TABLE IF EXISTS leagues;

CREATE TABLE leagues (
leagueID INTEGER NOT NULL,
name VARCHAR(32),
understatNotation VARCHAR(32),
PRIMARY KEY(leagueID));

#load in data - change path to where you store the data in your local environment
LOAD DATA LOCAL INFILE '/Users/adamkovacs/CEU/DE1_course/HW1/leagues.csv' 
INTO TABLE leagues 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

#check out the table
SELECT * FROM leagues;

#create table and read in data on teams
DROP TABLE IF EXISTS teams;

CREATE TABLE teams (
teamID INTEGER NOT NULL,
name VARCHAR(32),
PRIMARY KEY(teamID));

#load in data - change path to where you store the data in your local environment
LOAD DATA LOCAL INFILE '/Users/adamkovacs/CEU/DE1_course/HW1/teams.csv' 
INTO TABLE teams 
CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

#check out table
SELECT * FROM teams;

#create table and read in data on players
DROP TABLE IF EXISTS players;

CREATE TABLE players (
playerID INTEGER NOT NULL,
name VARCHAR(32),
PRIMARY KEY(playerID));

#load in data - change path to where you store the data in your local environment
LOAD DATA LOCAL INFILE '/Users/adamkovacs/CEU/DE1_course/HW1/players.csv' 
INTO TABLE players 
CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

#check out table
SELECT * FROM players;

#create table and read in data on games
DROP TABLE IF EXISTS games;

CREATE TABLE games (
gameID INTEGER NOT NULL,
leagueID INTEGER NOT NULL,
season INTEGER NOT NULL,
date DATETIME NOT NULL,
homeTeamID INTEGER NOT NULL,
awayTeamID INTEGER NOT NULL,
homeGoals INTEGER,
awayGoals INTEGER,
homeProbability FLOAT,
drawProbability FLOAT, 
awayProbability FLOAT, 
homeGoalsHalfTime INTEGER, 
awayGoalsHalfTime INTEGER, 
B365H FLOAT, 
B365D FLOAT, 
B365A FLOAT, 
BWH FLOAT,
BWD FLOAT,
BWA FLOAT,
IWH FLOAT,
IWD FLOAT,
IWA FLOAT,
PSH FLOAT,
PSD FLOAT,
PSA FLOAT,
WHH FLOAT,
WHD FLOAT,
WHA FLOAT,
VCH FLOAT,
VCD FLOAT,
VCA FLOAT,
PSCH FLOAT,
PSCD FLOAT,
PSCA FLOAT,
PRIMARY KEY(gameID),
KEY leagueID (leagueID),
KEY homeTeamID(homeTeamID),
KEY awayTeamID (awayTeamID),
#INDEX fk_games_leagues1_idx (leagueID ASC) VISIBLE,
CONSTRAINT fk_games_ibfk1 FOREIGN KEY (leagueID) REFERENCES SOCCER.leagues (leagueID),
CONSTRAINT fk_games_ibfk2 FOREIGN KEY (homeTeamID) REFERENCES SOCCER.teams (teamID),
CONSTRAINT fk_games_ibfk3 FOREIGN KEY (awayTeamID) REFERENCES SOCCER.teams (teamID)
);

LOAD DATA LOCAL INFILE '/Users/adamkovacs/CEU/DE1_course/HW1/games.csv' 
INTO TABLE games 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

#check out the table
SELECT * FROM games;

#create table and read in data on appearances
DROP TABLE IF EXISTS appearances;

CREATE TABLE appearances (
gameID INTEGER NOT NULL,
playerID INTEGER NOT NULL,
goals INTEGER,
ownGoals INTEGER,
shots INTEGER,
xGoals FLOAT,
xGoalsChain FLOAT,
xGoalsBuildup FLOAT,
assists FLOAT, 
keyPasses INTEGER, 
xAssists FLOAT, 
position VARCHAR(32), 
positionOrder INTEGER, 
yellowCard INTEGER, 
redCard INTEGER, 
time INTEGER, 
substituteIn INTEGER,
substituteOut INTEGER, 
leagueID INTEGER NOT NULL,
PRIMARY KEY(gameID, playerID),
KEY leagueID (leagueID),
#INDEX fk_appearances_players1_idx (playerID ASC) VISIBLE,
#INDEX fk_appearances_leagues1_idx (`leagueID` ASC) VISIBLE,
CONSTRAINT fk_appearances_players1 FOREIGN KEY (playerID) REFERENCES SOCCER.players (playerID),
CONSTRAINT fk_appearances_leagues1 FOREIGN KEY (leagueID) REFERENCES SOCCER.leagues (leagueID),
CONSTRAINT fk_appearances_games1 FOREIGN KEY (gameID) REFERENCES SOCCER.games (gameID)
    );

LOAD DATA LOCAL INFILE '/Users/adamkovacs/CEU/DE1_course/HW1/appearances.csv' 
INTO TABLE appearances 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

#check out table
SELECT * FROM appearances;

#create table and read in data on shots
DROP TABLE IF EXISTS shots;

CREATE TABLE shots (
gameID INTEGER NOT NULL,
shooterID INTEGER NOT NULL,
assisterID INTEGER,
minute INTEGER,
situation VARCHAR(32),
lastAction VARCHAR(32),
shotType VARCHAR(32),
shotResult VARCHAR(32),
xGoal FLOAT,
positionX FLOAT,
positionY FLOAT,
PRIMARY KEY(gameID, shooterID, minute),
#INDEX `fk_shots_games1_idx` (`gameID` ASC) VISIBLE,
CONSTRAINT fk_shots_games1 FOREIGN KEY (gameID) REFERENCES SOCCER.games (gameID)
);

LOAD DATA LOCAL INFILE '/Users/adamkovacs/CEU/DE1_course/HW1/shots.csv' 
INTO TABLE shots 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

#check out data
SELECT * FROM shots;

#create table and read in data on teamstats
DROP TABLE IF EXISTS teamstats;

CREATE TABLE teamstats (
gameID INTEGER NOT NULL,
teamID INTEGER NOT NULL,
season INTEGER NOT NULL,
date DATETIME NOT NULL,
location VARCHAR(32),
goals INTEGER,
xGoals FLOAT,
shots INTEGER,
shotsOnTarget INTEGER,
deep INTEGER,
ppda FLOAT,
fouls INTEGER,
corners INTEGER,
yellowCards INTEGER,
redCards INTEGER,
result VARCHAR(32),
PRIMARY KEY(gameID, teamID),
#INDEX `fk_teamstats_teams1_idx` (`teamID` ASC) VISIBLE,
CONSTRAINT fk_teamstats_teams1 FOREIGN KEY (teamID) REFERENCES SOCCER.teams (teamID),
CONSTRAINT fk_teamstats_games1 FOREIGN KEY (gameID) REFERENCES SOCCER.games (gameID)
);

LOAD DATA LOCAL INFILE '/Users/adamkovacs/CEU/DE1_course/HW1/teamstats.csv' 
INTO TABLE teamstats 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

#check out table
SELECT * FROM teamstats;

#check out tables
SHOW TABLES;


#columns to be used to create the analytics layer
#facts:team name, wins (teams, teamstats)
#dimension 1: average odds at home, away (games)
#dimension 2: expected goals and actual goals (teamstats)
#dimension 3: avg shots per game (shots)

#hypothesis, those teams win that have the lowest odds, the most shots and from these the most expected goals - that is correlated with actual goals - cannot overperform on the long term

#alternative:
#facts: player name (players), player goals, player assists -- player dimension
#dimension 1: team name (teams), league name (leagues) team and league dimension
#dimension 2: expected goals, number_of_goals_with_left, number_of_goals_with_right (shots) -- shot dimension
#dimension 3: position, xgoalschain, xgoalsbuildup, xassists (appearences) -- player dimension


#create two analytical tables -- one for games and one for players

#create analytical table for games

#third alternative
#facts: game, hometeamID, awayteamID, avgoddshome, avgoddsaway, 
#first dimension: team names -- home and away
#second dimension: shots, result (if teamID = hometeamID join from teamstats)
#third dimension: league name

select * from appearances;

/* Create stored procedure that creates this table
ETL elements:
E -- it joins to selected columns of the "games" table selected columns of the "teams", "teamstats" and "leagues" tables 
T -- it creates a avg_odds columns for the home and away team by calculating the avg of all 7 betting companies that provided odds
L -- Inserting into the game_result table is the load part
*/

DROP PROCEDURE IF EXISTS CreateDetailedGamesTable;

DELIMITER //

CREATE PROCEDURE CreateDetailedGamesTable()
BEGIN
	#DROP TABLE IF EXISTS games_detailed;

	#CREATE TABLE games_detailed AS
	SELECT 
		t1.season AS Season,
		t6.name AS League,
		t2.name AS Home_team,
		t3.name AS Away_team,
		t1.homeGoals AS Home_goals,
		t1.awayGoals AS Away_goals,
		t4.result AS Home_result, 
		t5.result AS Away_result, 
		ROUND(t1.homeProbability, 2) AS Home_prob,
		ROUND((t1.B365H + t1.BWH + t1.IWH + t1.PSH + t1.WHH + t1.VCH + t1.PSCH) / 7.0, 2) AS Home_avg_odds,
		ROUND(t1.drawProbability, 2) AS Draw_prob,
		ROUND((t1.B365D + t1.BWD + t1.IWD + t1.PSD + t1.WHD + t1.VCD + t1.PSCD) / 7.0, 2) AS Draw_avg_odds,
		ROUND(t1.awayProbability, 2) AS Away_prob,
		ROUND((t1.B365A + t1.BWA + t1.IWA + t1.PSA + t1.WHA + t1.VCA + t1.PSCA) / 7.0, 2) AS Away_avg_odds,
		ROUND(t4.xGoals, 2) AS Home_xg,
		ROUND(t5.xGoals, 2) AS Away_xg,
		t4.shots AS Home_shots,
		t5.shots AS Away_shots,
		t4.shotsOnTarget AS Home_shots_on_target,
		t5.shotsOnTarget AS Away_shots_on_target,
		t4.fouls AS Home_fouls,
		t5.fouls AS Away_fouls,
		t4.corners AS Home_corners,
		t5.corners AS Away_corners,
		t4.yellowCards AS Home_yellows,
		t5.yellowCards AS Away_yellows,
		t4.redCards AS Home_reds,
		t5.redCards AS Away_reds,
		t7.name AS Max_xg_player,
		ROUND(t7.max_xg_by_player, 2) AS Max_xg,
		t8.name AS Max_xa_player,
		ROUND(t8.max_xa_by_player, 2) AS Max_xa,
		t9.scorers AS Scorers,
		t10.assisters AS Assisters


	FROM games t1
		INNER JOIN teams t2
		ON t1.hometeamID = t2.teamID
		INNER JOIN teams t3
		ON t1.awayteamID = t3.teamID
		INNER JOIN teamstats t4
		ON t1.gameID = t4.gameID AND t1.hometeamID = t4.teamID
		INNER JOIN teamstats t5
		ON t1.gameID = t5.gameID AND t1.awayteamID = t5.teamID
		INNER JOIN leagues t6
		USING (leagueID)
		LEFT JOIN ( SELECT g1.gameID, g1.max_xg_by_player, p1.name
		FROM appearances a
		INNER JOIN
		(SELECT gameID, MAX(xGoals) AS max_xg_by_player
		FROM appearances
		GROUP BY gameID) g1
		ON a.gameID = g1.gameID AND a.xGoals = g1.max_xg_by_player
		LEFT JOIN players p1
		USING (playerID)) t7
		ON t1.gameID = t7.gameID
		LEFT JOIN ( SELECT g2.gameID, g2.max_xa_by_player, p2.name
		FROM appearances a2
		INNER JOIN
		(SELECT gameID, MAX(xAssists) AS max_xa_by_player
		FROM appearances
		GROUP BY gameID) g2
		ON a2.gameID = g2.gameID AND a2.xAssists= g2.max_xa_by_player
		LEFT JOIN players p2
		USING (playerID)) t8
		ON t1.gameID = t8.gameID
		LEFT JOIN ( SELECT g3.gameID, GROUP_CONCAT(p3.name separator ', ') AS scorers
		FROM (SELECT gameID, goals, playerID
		FROM appearances
		where goals > 0) g3
		LEFT JOIN players p3
		USING (playerID)
		GROUP BY gameID) t9
		ON t1.gameID = t9.gameID
		LEFT JOIN ( SELECT g4.gameID, GROUP_CONCAT(p4.name separator ', ') AS assisters
		FROM (SELECT gameID, goals, playerID
		FROM appearances
		where assists > 0) g4
		LEFT JOIN players p4
		USING (playerID)
		GROUP BY gameID) t10
		ON t1.gameID = t10.gameID;
END //
DELIMITER ;

#call the stored procedure that creates the game_result table
CALL CreateDetailedGamesTable();



DROP PROCEDURE IF EXISTS CreateDetailedGamesTable;

DELIMITER //

CREATE PROCEDURE CreateDetailedGamesTable()
BEGIN

	DROP TABLE IF EXISTS games_detailed;

	CREATE TABLE games_detailed AS
	SELECT 
		t1.season AS Season,
		t6.name AS League,
		t2.name AS Home_team,
		t3.name AS Away_team,
		t1.homeGoals AS Home_goals,
		t1.awayGoals AS Away_goals,
		t4.result AS Home_result, 
		t5.result AS Away_result, 
		t1.homeProbability AS Home_prob,
		(t1.B365H + t1.BWH + t1.IWH + t1.PSH + t1.WHH + t1.VCH + t1.PSCH) / 7.0, 2 AS Home_avg_odds,
		t1.drawProbability AS Draw_prob,
		(t1.B365D + t1.BWD + t1.IWD + t1.PSD + t1.WHD + t1.VCD + t1.PSCD) / 7.0 AS Draw_avg_odds,
		t1.awayProbability AS Away_prob,
		(t1.B365A + t1.BWA + t1.IWA + t1.PSA + t1.WHA + t1.VCA + t1.PSCA) / 7.0 AS Away_avg_odds,
		t4.xGoals AS Home_xg,
		t5.xGoals AS Away_xg,
		t4.shots AS Home_shots,
		t5.shots AS Away_shots,
		t4.shotsOnTarget AS Home_shots_on_target,
		t5.shotsOnTarget AS Away_shots_on_target,
		t4.fouls AS Home_fouls,
		t5.fouls AS Away_fouls,
		t4.corners AS Home_corners,
		t5.corners AS Away_corners,
		t4.yellowCards AS Home_yellows,
		t5.yellowCards AS Away_yellows,
		t4.redCards AS Home_reds,
		t5.redCards AS Away_reds,
		t7.name AS Max_xg_player,
		t7.max_xg_by_player AS Max_xg,
		t8.name AS Max_xa_player,
		t8.max_xa_by_player AS Max_xa,
		t9.scorers AS Scorers,
		t10.assisters AS Assisters

		FROM games t1
		INNER JOIN teams t2
		ON t1.hometeamID = t2.teamID
		INNER JOIN teams t3
		ON t1.awayteamID = t3.teamID
		INNER JOIN teamstats t4
		ON t1.gameID = t4.gameID AND t1.hometeamID = t4.teamID
		INNER JOIN teamstats t5
		ON t1.gameID = t5.gameID AND t1.awayteamID = t5.teamID
		INNER JOIN leagues t6
		USING (leagueID)
		LEFT JOIN ( SELECT g1.gameID, g1.max_xg_by_player, p1.name
		FROM appearances a
		INNER JOIN
		(SELECT gameID, MAX(xGoals) AS max_xg_by_player
		FROM appearances
		GROUP BY gameID) g1
		ON a.gameID = g1.gameID AND a.xGoals = g1.max_xg_by_player
		LEFT JOIN players p1
		USING (playerID)) t7
		ON t1.gameID = t7.gameID
		LEFT JOIN ( SELECT g2.gameID, g2.max_xa_by_player, p2.name
		FROM appearances a2
		INNER JOIN
		(SELECT gameID, MAX(xAssists) AS max_xa_by_player
		FROM appearances
		GROUP BY gameID) g2
		ON a2.gameID = g2.gameID AND a2.xAssists= g2.max_xa_by_player
		LEFT JOIN players p2
		USING (playerID)) t8
		ON t1.gameID = t8.gameID
		LEFT JOIN ( SELECT g3.gameID, GROUP_CONCAT(p3.name separator ', ') AS scorers
		FROM (SELECT gameID, goals, playerID
		FROM appearances
		where goals > 0) g3
		LEFT JOIN players p3
		USING (playerID)
		GROUP BY gameID) t9
		ON t1.gameID = t9.gameID
		LEFT JOIN ( SELECT g4.gameID, GROUP_CONCAT(p4.name separator ', ') AS assisters
		FROM (SELECT gameID, goals, playerID
		FROM appearances
		where assists > 0) g4
		LEFT JOIN players p4
		USING (playerID)
		GROUP BY gameID) t10
		ON t1.gameID = t10.gameID;

END //
DELIMITER ;

#call the stored procedure that creates the game_result table
CALL CreateDetailedGamesTable();

#check out the newly created table
SELECT * FROM games_detailed;




#creating data marts

DROP VIEW IF EXISTS Chelsea_matches;

CREATE VIEW `Chelsea_matches` AS
SELECT * FROM game_result WHERE game_result.h_team = 'Chelsea' OR game_result.a_team = 'Chelsea';

SELECT * FROM chelsea_matches;

DROP VIEW IF EXISTS home_wins_pl;

CREATE VIEW `Home_wins_PL` AS
SELECT * FROM game_result WHERE game_result.h_result = 'W' AND game_result.league = "Premier League";

SELECT * FROM home_wins_pl;





#add trigger that adds new row to table created if a new game is added

#for this first create a table called messages
CREATE TABLE IF NOT EXISTS messages (message VARCHAR(100) NOT NULL);

#create the trigger
DROP TRIGGER IF EXISTS after_game_insert; 

DELIMITER //

CREATE TRIGGER after_game_insert
AFTER INSERT
ON games FOR EACH ROW
BEGIN
	
	-- log the order number of the newley inserted order
    	INSERT INTO messages SELECT CONCAT('new game: ', NEW.gameID);

	-- archive the order and assosiated table entries to product_sales
  	INSERT INTO game_result
	SELECT
		t1.gameID,
		t2.name AS h_team,
		t3.name AS a_team,
		t1.homeGoals AS h_goals,
		t1.awayGoals AS a_goals,
		t4.result AS h_result, 
		t5.result AS a_result, 
		(t1.B365H + t1.BWH + t1.IWH + t1.PSH + t1.WHH + t1.VCH + t1.PSCH) / 7.0 AS h_avg_odds,
		(t1.B365A + t1.BWA + t1.IWA + t1.PSA + t1.WHA + t1.VCA + t1.PSCA) / 7.0 AS a_avg_odds,
		t6.name AS league,
		t1.season
	FROM games t1
	INNER JOIN teams t2
	ON t1.hometeamID = t2.teamID
	INNER JOIN teams t3
	ON t1.awayteamID = t3.teamID
	INNER JOIN teamstats t4
	ON t1.gameID = t4.gameID AND t1.hometeamID = t4.teamID
	INNER JOIN teamstats t5
	ON t1.gameID = t5.gameID AND t1.awayteamID = t5.teamID
	INNER JOIN leagues t6
	USING (leagueID);
        
END //

DELIMITER ;

#check current state of game_results
SELECT * FROM game_result ORDER BY gameID;

select * from games limit 1;

#now let's activate the trigger created 
INSERT INTO games VALUES(99998,1,2021,'2021-05-05 15:45:00',89,82,1,0,0.2,0.3,0.5,1,0,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3);
INSERT INTO teamstats  VALUES(999999,89,2021,'2021-05-05 15:45:00','h',1,0.5,3,2,10,7.2,2,12,2,0,'W');
INSERT INTO teamstats  VALUES(999999,82,2021,'2021-05-05 15:45:00','a',0,0.2,1,0,3,3.1,0,1,1,0,'L');

select * from teamstats;

SELECT * FROM games WHERE gameID = 99998;

select * from messages;







#check the state of event scheduler
SHOW VARIABLES LIKE "event_scheduler";
#if it were off, turn it on
SET GLOBAL event_scheduler = ON;















#second dimension -- player: playerName, 
#third dimension -- shot

SELECT * FROM appearances LEFT JOIN shots USING (gameID) WHERE goals > 0 AND shotResult = "Goal";

SELECT 
t1.gameID, 
t1.shooterID, 
t1.shotType, 
t1.shotResult, 
t2.homeTeamID, 
t2.awayTeamID
#t2.homeGoals, 
#t2.awayGoals 
FROM shots t1 
LEFT JOIN games t2 
USING (gameID) 
WHERE t1.shotResult = "Goal";
#GROUP BY shooterID;

SELECT 
t1.playerID,
t1.name AS playerName,
t2.position,
t2.goals,
t2.gameID,
t7.shotResult,
t7.shooterID,
t2.gameID
FROM players t1
LEFT JOIN appearances t2
USING (playerID)
LEFT JOIN shots t7
ON t1.playerID = t7.shooterID
WHERE t7.shotResult = "Goal";

SELECT 
t1.playerID,
t1.name AS playerName,
t2.position,
t2.gameID,
t2.goals,
t2.assists,
t2.xGoalsChain,
t2.xGoalsBuildup,
t2.xAssists,
t2.keyPasses,
t3.gameID,
t3.homeTeamID,
t3.awayteamID,
t4.name AS teamname_h,
t5.name AS teamname_a,
t6.name AS leagueName,
t7.shotResult, 
t7.shooterID,
t7.assisterID


FROM players t1
LEFT JOIN appearances t2
USING (playerID)
LEFT JOIN games t3
ON t2.gameID = t3.gameID
INNER JOIN teams t4
ON t3.homeTeamID = t4.teamID
INNER JOIN teams t5
ON t3.awayTeamID = t5.teamID
INNER JOIN leagues t6
ON t3.leagueID = t6.leagueID
LEFT JOIN shots t7
ON t1.playerID = t7.shooterID;
#WHERE t7.shotResult = "Goal";
#GROUP BY t7.gameID;


#consistency in joining







SUM(t1.homeGoals), 
#SUM(t1.awayGoals), 
AVG((t1.B365H + t1.BWH + t1.IWH + t1.PSH + t1.WHH + t1.VCH + t1.PSCH) / 7.0) AS h_avg_odds,
#(t1.B365A + t1.BWA + t1.IWA + t1.PSA + t1.WHA + t1.VCA + t1.PSCA) / 7.0 AS a_avg_odds,
#t1.gameID, 
#t1.leagueID, 
t1.homeTeamID 
#t1.awayTeamID
FROM players t1
INNER JOIN appearances t2
USING (playerID)
INNER JOIN teams t3
ON t1.awayTeamID = t3.teamID
GROUP BY homeTeamID;


SELECT * FROM players;

SELECT * FROM teamstats;

SELECT * FROM shots;

SELECT * FROM appearances;

SELECT gameID, leagueID, homeTeamID, awayTeamID, homeGoals, awayGoals FROM games;

SELECT (B365H + BWH + IWH + PSH + WHH + VCH + PSCH)/7.0 AS h_avg_odds FROM games;

SELECT t2.name AS homeTeam,
#t3.name AS awayTeam,
SUM(t1.homeGoals), 
#SUM(t1.awayGoals), 
AVG((t1.B365H + t1.BWH + t1.IWH + t1.PSH + t1.WHH + t1.VCH + t1.PSCH) / 7.0) AS h_avg_odds,
#(t1.B365A + t1.BWA + t1.IWA + t1.PSA + t1.WHA + t1.VCA + t1.PSCA) / 7.0 AS a_avg_odds,
#t1.gameID, 
#t1.leagueID, 
t1.homeTeamID 
#t1.awayTeamID
FROM games t1
INNER JOIN teams t2
ON t1.homeTeamID = t2.teamID
INNER JOIN teams t3
ON t1.awayTeamID = t3.teamID
GROUP BY homeTeamID;

SELECT #t2.name AS homeTeam,
#t3.name AS awayTeam,
SUM(t1.homeGoals), 
#AVG(awayGoals), 
AVG((B365H + BWH + IWH + PSH + WHH + VCH + PSCH) / 7.0) AS h_avg_odds,
#AVG((B365A + BWA + IWA + PSA + WHA + VCA + PSCA) / 7.0) AS a_avg_odds,
#t1.gameID, 
#t1.leagueID, 
t2.name
homeTeamID 
FROM games t1

INNER JOIN teams t2
ON games.homeTeamID = t2.teamID;


SELECT * FROM games INNER JOIN teams ON games.homeTeamID = teams.teamID;

#GROUP BY leagueID

SELECT *
FROM left_table
INNER JOIN right_table
ON left_table.id = right_table.id
INNER JOIN another_table
ON left_table.id = another_table.id;


#B365D, BWD, IWD, PSD, WHD, VCD, PSCD

SELECT *
FROM games;


SELECT *
FROM games
INNER JOIN right_table
ON left_table.id = right_table.id;


DROP PROCEDURE IF EXISTS CreateTeamsWinsShots;

DELIMITER $$

CREATE PROCEDURE CreateTeamsWinsShots()
BEGIN

	DROP TABLE IF EXISTS goals_wins;

	CREATE TABLE goals_wins AS
	SELECT 
	   teams.name AS TeamName, 
	   teamstats.wins AS Wins, 
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

END $$
DELIMITER ;


CALL CreateProductSalesStore();