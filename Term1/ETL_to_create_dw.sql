/* 
Term project of Adam Jozsef Kovacs for the course SQL and Different Shapes of Data
This file contains the script with which the stored procedure that creates the datawarehouse was created
*/

#select to use schema
USE SOCCER;

#create stored procedure that creates the datawarehouse table: games_detailed
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

#call the stored procedure that creates the game_result table, which is the datawarehouse
CALL CreateDetailedGamesTable();

#check out datawarehouse
SELECT * FROM games_detailed;
