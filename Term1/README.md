# Ádám József Kovács -  Term project 1 documentation

This folder contains all my workfiles used for the [term project](https://ceu-economics-and-business.github.io/ECBS-5146-Different-Shapes-of-Data/term1/index.html) in Data Engineering 1. In this project, I built a schema in MySQL using the **Football database** available on Kaggle - [link](https://www.kaggle.com/technika148/football-database).

### Task interpretation ###

I was hired by a betting company that is specialized on football (soccer) betting and was not able to get the profit from their operation that they had hoped over the past year. To take care of this setback, they decided to give me the job of building a reliable datawarehouse that their analysts can use to look at all games over the past 6 years in the top 5 European football leagues and derive valuable information on the predictability of the matches and seasons.  Moreover, I was also given the task of creating separate views of the datawarehouse that serve the different levels at which people can bet (players, games, seasons) and also separate matches for which betting companies such as the one that hired me generally place different odds:
 - the first two views are on team level and contain average (useful for betting on games e.g. results, nr of corners etc.) and season total (useful for betting on seasons e.g. who will win the championship, how many goals will the team score) of statistics over each season they played first division football including average odds given by 7 betting companies
    - there are two such views, because due to the home advantage, betting companies tend to separate home and away matches of teams, so these statistics are available for each team when they played home and away in separate views
- the second two views are on player level and show all players who accumulated the most expected goals/assists in the matches of their team and also scored/assisted a goal in the same match (in this way, their goal/assist) was predictable 
    - such patterns are useful for betting companies when setting odds both for match level (people bet on who will score) and season level (who will be the top scorer)

I implemented the solution to these tasks in MySQL.

###  Operational layer ###

The operational layer consists of [6 tables stored in csv](/Term1/data) - all of them are related to football games that occured between 2014 and 2020. The below EER diagrams represent the star schema of the operational layer with the **games** table being the fact table in the center. It shows the football games in relation to teams, leagues, statistics of teams, players and their appearances on these games:
    * In the **games** table, every observation is a football match between two teams 
    * The **leagues** table contains the names of the top 5 European first division soccer leagues
    * The **teams** table contains the names of the teams
    * The **teamstats** table contains detailed statistics of the performance of teams in every game they played 
    * The **players** table contains the names of the players
    * The **appearances** table contains detailed statistics of the performance of players in every game they played 

![Database diagram](/Term1/EER_diagram.png)

There was one issue with the data I had to address when creating my data warehouse, namely that there is no direct link between teams and players - they are connected only by the **games** table, so we only know that they played in a particular game, but we do not know in which team. Thus, I decided to focus on the best performers of the game, not by teams. This is practical as well, because when betting on players, people bet on the scorers or the assisters, not by team, but across the two teams in any game.   

Operational layer was created using the following [queries](/Term1/Operational_layer.sql).

###  Analytics plan ###

My analytics plan is the following:
1. Loading in the data
2. Creating an ETL pipeline to create a data warehouse 
3. Creating an ETL pipeline to create data marts

This is illustrated in the below figure: 

![Analytics plan diagram](/Term1/Analytics_plan.png.png)

###  Analytical layer ###
 
In the analytical layer, I created one central denormalised data warehouse with a game in each observation. First, I took the games table that contains basic information on the game and betting statistics. I transformed the latter to display the average of the odds by the different betting companies and display only two decimals in the estimated probability of outcome as well. Then, I joined the names of both the home and away teams, the name of the league in which the game was played. Then, I also join sophisticated statistics of both teams for the games (e.g. expected goals, shots, cards, corners). Finally, I also use the more granular player level data of the dataset by joining to the datawarehouse the player with the highest accumulated expected goal and expected assist in each match as well as the names of the scorers and assisters of the games. The figure below depicts an illustration of the information stored in the data warehouse. 

Analytical layer was created using the following [queries](/Term1/ETL_to_create_dw.sql).

![DW diagram](/Term1/data_warehouse.PNG)

###  Data Marts ###
 
I created two pairs of data marts for further analysis by the analysts of the company. These are the following: 
 
##### Home_teams_view and Away_teams_view #####

In these views, the analysts can see the performance of each team for each season that they played in the first division of any of the top 5 European football (soccer). They can see the average of performance statistics such as goals, shots, cards, corners etc. that people can bet on, and also that can be used to analyze the outcome of games. This view also contains the avergae odds of betting companies, which is perfect to train models to calculate odds for upcoming seasons, games. Since home games of teams can be different in terms of the performance of teams due to the home advantage given by factors such as lack of travelling, support of fans, comformity with size of pitch etc. therre are separate views for the home and away performance of the teams. 

##### Players_xg_view and Players_xa_view #####

In these views the analysts can analyze the most important players in the dataset from a betting perspective. The Players_xg_view contains those players that accumulated the highest expected goal in at least one of their matches and ended up scoring at least one goal as well. Similarly, the Players_xa_view contains those players that accumulated the highest expected assist in at least one of their matches and ended up getting at least one assist as well. The views contain these statistics aggreagated to season level, showing the count of times this happened for each player. These views are important for the analysts as they show the most predictably well-performing players in terms of goals and assists, the two statistics people bet on at the player level. 

Data marts were created using the following [queries](/Term1/ETL_to_create_data_mart.sql).