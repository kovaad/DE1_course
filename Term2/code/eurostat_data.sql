
Drop schema if exists eurostat_data;
create schema eurostat_data;
use eurostat_data;

-- Education
drop table if exists education;
create table education(
id int not null auto_increment,
time integer,
geo varchar(255),
unit varchar(10),
ISCED11 varchar(255),
age varchar(255),
value integer,
primary key (id)
);

TRUNCATE education;
show variables like "secure_file_priv";
SET GLOBAL local_infile= 'on';
show variables like "local_infile";

load data infile '/Users/adamkovacs/CEU/DE1_course/Term2/raw_data/education.csv'
into table education
fields terminated by ','
-- optionally enclosed by '"'
lines terminated by '\r\n'
ignore 1 lines(time, GEO, UNIT, ISCED11, AGE, @a_Value)

set 
value = nullif(@a_value, ':' );

select * from education;

-- Poverty
drop table if exists poverty;
create table poverty(
id int not null auto_increment,
time integer,
geo varchar(500),
unit varchar(255),
age varchar(255),
sex varchar(255),
value integer,
primary key (id)
);

TRUNCATE poverty;
show variables like "secure_file_priv";
SET GLOBAL local_infile= 'on';
show variables like "local_infile";

load data infile '/Users/adamkovacs/CEU/DE1_course/Term2/raw_data/poverty.csv'
into table poverty
fields terminated by ','
-- optionally enclosed by '"'
lines terminated by '\r\n'
ignore 1 lines(time, GEO, UNIT, AGE, SEX, @a_Value)

set 
Value = nullif(@a_Value, ':' );

select * from poverty;

-- Life Expectancy
drop table if exists lifeexp;
create table lifeexp(
id int not null auto_increment,
time integer,
geo varchar(500),
sex varchar(255),
age varchar(255),
unit varchar(255),
value integer,
primary key (id)
);

TRUNCATE lifeexp;
show variables like "secure_file_priv";
SET GLOBAL local_infile= 'on';
show variables like "local_infile";

load data infile '/Users/adamkovacs/CEU/DE1_course/Term2/raw_data/lifeexp.csv'
into table lifeexp
fields terminated by ','
-- optionally enclosed by '"'
lines terminated by '\r\n'
ignore 1 lines(time, GEO, SEX, AGE, UNIT, @a_Value)

set 
Value = nullif(@a_Value, ':' );

select * from lifeexp;

-- Creating Store Procedure
drop procedure if exists eurostat_data_warehouse;
Delimiter $$
create procedure eurostat_data_warehouse()

Begin
Drop table if exists eurostat_data_table;
create table eurostat_data_table as 

select
poverty.time as year,
poverty.geo as country,
poverty.value as poverty_rate,

education.value as education,

lifeexp.value as lifeExp

from poverty
inner join education on education.geo = poverty.geo and education.time = poverty.time
inner join lifeexp on lifeexp.geo = poverty.geo and lifeexp.time = poverty.time
order by poverty.geo;

End $$
Delimiter ;

call eurostat_data_warehouse();

select * from eurostat_data_table;

-- View one:
drop view if exists average_poverty;
	create view average_poverty as 
select distinct eu.year, avg(eu.poverty_rate) from eurostat_data_table as eu 
group by eu.year
order by eu.year;

-- View two:

drop view if exists lifeExp_Poverty;
	create view alifeExp_Poverty as 
select distinct eu.year, avg(eu.poverty_rate), avg(eu.lifeExp) from eurostat_data_table as eu 
group by eu.year
order by eu.year;
