/*
Term project of Adam Jozsef Kovacs for the course SQL and Different Shapes of Data
This file contains the script with which the analytical layer was created
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