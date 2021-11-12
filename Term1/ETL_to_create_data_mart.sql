/* Create stored procedure that creates data marts
ETL elements:
E -- 
T -- 
L -- 
*/

USE SOCCER;

SELECT * FROM games_detailed;

SELECT season,  
		league,
        Home_team,
        AVG(CASE WHEN Home_result = 'W' THEN 3 WHEN Home_result = 'D' THEN 1 ELSE 0 END) AS Avg_points,
        ROUND(AVG(Home_goals - Home_xg), 2) AS Avg_xg_over_under_perform,
        ROUND(AVG(Home_prob), 2) AS Avg_win_prob,
        ROUND(AVG(Home_avg_odds), 2) AS Avg_odds, 
        ROUND(AVG(Home_goals), 2) AS Avg_goals,
        ROUND(AVG(Home_shots), 2) AS Avg_shots,
        ROUND(AVG(Home_shots_on_target), 2) AS Avg_shots_on_target,
        ROUND(AVG(Home_goals / Home_shots_on_target), 2) AS Avg_conversion,
        ROUND(AVG(Home_fouls), 2) AS Avg_fouls,
        ROUND(AVG(Home_corners), 2) AS Avg_corners,
        ROUND(AVG(Home_yellows), 2) AS Avg_yellows,
        ROUND(AVG(Home_reds), 2) AS Avg_reds,
        SUM(CASE WHEN Home_result = 'W' THEN 3 WHEN Home_result = 'D' THEN 1 ELSE 0 END) AS Points,
        ROUND(SUM(Home_goals - Home_xg), 2) AS Xg_over_under_perform,
        SUM(Home_goals) AS Goals,
        SUM(Home_shots) AS Shots,
        SUM(Home_shots_on_target) AS Shots_on_target,
        SUM(Home_fouls) AS Fouls,
        SUM(Home_corners) AS Corners,
        SUM(Home_yellows) AS Yellows,
        SUM(Home_reds) AS Reds
    FROM games_detailed
    GROUP BY season
    , league
    ,Home_team
    ORDER BY Home_team, season;
    
SELECT season,  
		league,
        Away_team,
        AVG(CASE WHEN Away_result = 'W' THEN 3 WHEN Away_result = 'D' THEN 1 ELSE 0 END) AS Avg_points,
        ROUND(AVG(Away_goals - Away_xg), 2) AS Xg_over_under_perform,
        ROUND(AVG(Away_prob), 2) AS Avg_win_prob,
        ROUND(AVG(Away_avg_odds), 2) AS Avg_odds, 
        ROUND(AVG(Away_goals), 2) AS Avg_goals,
        ROUND(AVG(Away_shots), 2) AS Avg_shots,
        ROUND(AVG(Away_shots_on_target), 2) AS Avg_shots_on_target,
        ROUND(AVG(Away_goals / Away_shots_on_target), 2) AS Avg_conversion,
        ROUND(AVG(Away_fouls), 2) AS Avg_fouls,
        ROUND(AVG(Away_corners), 2) AS Avg_corners,
        ROUND(AVG(Away_yellows), 2) AS Avg_yellows,
        ROUND(AVG(Away_reds), 2) AS Avg_reds
    FROM games_detailed
    GROUP BY season
    , league
    ,Away_team
    ORDER BY Away_team, season;

    
SELECT season,  
		league,
        Home_team,
        SUM(CASE WHEN Home_result = 'W' THEN 3 WHEN Home_result = 'D' THEN 1 ELSE 0 END) AS Points,
        ROUND(SUM(Home_goals - Home_xg), 2) AS Xg_over_under_perform,
        SUM(Home_goals) AS Goals,
        SUM(Home_shots) AS Shots,
        SUM(Home_shots_on_target) AS Shots_on_target,
        SUM(Home_fouls) AS Fouls,
        SUM(Home_corners) AS Corners,
        SUM(Home_yellows) AS Yellows,
        SUM(Home_reds) AS Reds
    FROM games_detailed
    GROUP BY season
    , league
    ,Home_team
    ORDER BY Home_team, season;
    
SELECT Max_xg_player AS Player, COUNT(Max_xg_player) AS Scored_when_max_xg, League, Season
   FROM games_detailed
   WHERE scorers like CONCAT('%',Max_xg_player,'%')
   GROUP BY Max_xg_player, league, season
   ORDER BY league, season, Scored_when_max_xg DESC;

SELECT Max_xa_player AS Player, COUNT(Max_xa_player) AS Assisted_when_max_xa, League, Season
   FROM games_detailed
   WHERE assisters like CONCAT('%',Max_xa_player,'%')
   GROUP BY Max_xa_player, league, season
   order by league, season, Assisted_when_max_xa DESC;
   

   



DROP PROCEDURE IF EXISTS CreateDataMarts;

DELIMITER //

CREATE PROCEDURE CreateDataMarts()
BEGIN

	DROP VIEW IF EXISTS Home_teams_match_view;

	CREATE VIEW `Home_teams_view` AS
	SELECT season,  
		league,
        Home_team,
        AVG(CASE WHEN Home_result = 'W' THEN 3 WHEN Home_result = 'D' THEN 1 ELSE 0 END) AS Avg_points,
        ROUND(AVG(Home_goals - Home_xg), 2) AS Avg_xg_over_under_perform,
        ROUND(AVG(Home_prob), 2) AS Avg_win_prob,
        ROUND(AVG(Home_avg_odds), 2) AS Avg_odds, 
        ROUND(AVG(Home_goals), 2) AS Avg_goals,
        ROUND(AVG(Home_shots), 2) AS Avg_shots,
        ROUND(AVG(Home_shots_on_target), 2) AS Avg_shots_on_target,
        ROUND(AVG(Home_goals / Home_shots_on_target), 2) AS Avg_conversion,
        ROUND(AVG(Home_fouls), 2) AS Avg_fouls,
        ROUND(AVG(Home_corners), 2) AS Avg_corners,
        ROUND(AVG(Home_yellows), 2) AS Avg_yellows,
        ROUND(AVG(Home_reds), 2) AS Avg_reds,
        SUM(CASE WHEN Home_result = 'W' THEN 3 WHEN Home_result = 'D' THEN 1 ELSE 0 END) AS Points,
        ROUND(SUM(Home_goals - Home_xg), 2) AS Xg_over_under_perform,
        SUM(Home_goals) AS Goals,
        SUM(Home_shots) AS Shots,
        SUM(Home_shots_on_target) AS Shots_on_target,
        SUM(Home_fouls) AS Fouls,
        SUM(Home_corners) AS Corners,
        SUM(Home_yellows) AS Yellows,
        SUM(Home_reds) AS Reds
    FROM games_detailed
    GROUP BY season
    , league
    ,Home_team
    ORDER BY Home_team, season;

	DROP VIEW IF EXISTS Away_teams_match_view;

	CREATE VIEW `Away_teams_view` AS
	SELECT season,  
		league,
        Away_team,
        AVG(CASE WHEN Away_result = 'W' THEN 3 WHEN Away_result = 'D' THEN 1 ELSE 0 END) AS Avg_points,
        ROUND(AVG(Away_goals - Away_xg), 2) AS Avg_xg_over_under_perform,
        ROUND(AVG(Away_prob), 2) AS Avg_win_prob,
        ROUND(AVG(Away_avg_odds), 2) AS Avg_odds, 
        ROUND(AVG(Away_goals), 2) AS Avg_goals,
        ROUND(AVG(Away_shots), 2) AS Avg_shots,
        ROUND(AVG(Away_shots_on_target), 2) AS Avg_shots_on_target,
        ROUND(AVG(Away_goals / Away_shots_on_target), 2) AS Avg_conversion,
        ROUND(AVG(Away_fouls), 2) AS Avg_fouls,
        ROUND(AVG(Away_corners), 2) AS Avg_corners,
        ROUND(AVG(Away_yellows), 2) AS Avg_yellows,
        ROUND(AVG(Away_reds), 2) AS Avg_reds,
		SUM(CASE WHEN Away_result = 'W' THEN 3 WHEN Away_result = 'D' THEN 1 ELSE 0 END) AS Points,
        ROUND(SUM(Away_goals - Away_xg), 2) AS Xg_over_under_perform,
        SUM(Away_goals) AS Goals,
        SUM(Away_shots) AS Shots,
        SUM(Away_shots_on_target) AS Shots_on_target,
        SUM(Away_fouls) AS Fouls,
        SUM(Away_corners) AS Corners,
        SUM(Away_yellows) AS Yellows,
        SUM(Away_reds) AS Reds
    FROM games_detailed
    GROUP BY season
    , league
    ,Away_team
    ORDER BY Away_team, season;
    
    DROP VIEW IF EXISTS Players_xg_view;

	CREATE VIEW `Players_xg_view` AS
	SELECT Max_xg_player AS Player, COUNT(Max_xg_player) AS Scored_when_max_xg, League, Season
    FROM games_detailed
    WHERE scorers like CONCAT('%',Max_xg_player,'%')
    GROUP BY Max_xg_player, league, season
    ORDER BY league, season, Scored_when_max_xg DESC;
    
    DROP VIEW IF EXISTS Players_xa_view;

	CREATE VIEW `Players_xa_view` AS
	SELECT Max_xg_player AS Player, COUNT(Max_xg_player) AS Scored_when_max_xg, League, Season
    FROM games_detailed
    WHERE scorers like CONCAT('%',Max_xg_player,'%')
    GROUP BY Max_xg_player, league, season
    ORDER BY league, season, Scored_when_max_xg DESC;
    
END //
DELIMITER ;

CALL CreateDataMarts();

SELECT * FROM away_teams_view;