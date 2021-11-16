
Drop schema if exists inequality_index;
create schema inequality_index;
use inequality_index;

-- GINI Index
drop table if exists gini;
create table gini(
id integer,
country varchar(255),
c3 varchar(10),
c2 varchar(10),
year integer,
gini_reported integer,
palma integer,
ratio_top20bottom20 integer,
bottom40 integer,
q1 integer,
q2 integer,
q3 integer,
q4 integer,
q5 integer,
d1 integer,
d2 integer,
d3 integer,
d4 integer,
d5 integer,
d6 integer,
d7 integer,
d8 integer,
d9 integer,
d10 integer,
bottom5 integer,
top5 integer,
resource varchar(255),
resource_detailed varchar(255),
scale varchar(255),
scale_detailed varchar(255),
sharing_unit varchar(255),
reference_unit varchar(255),
areacovr varchar(255),
areacovr_detailed varchar(255),
popcovr varchar(255),
popcovr_detailed varchar(255),
region_un varchar(255),
region_un_sub varchar(255),
region_wb varchar(255),
eu varchar(100),
oecd varchar(100),
incomegroup	varchar(255),
mean integer,
median integer,
currency varchar(255),
reference_period varchar(255),
exchangerate integer,
mean_usd integer,
median_usd integer,
gdp_ppp_pc_usd2011 integer,
population integer,
revision varchar(255),
quality	varchar(255),
quality_score integer,
primary key (id)
);

TRUNCATE gini;
show variables like "secure_file_priv";
SET GLOBAL local_infile= 'on';
show variables like "local_infile";

load data infile '/Users/adamkovacs/CEU/DE1_course/Term2/raw_data/gini.csv'
into table gini
fields terminated by ','
-- optionally enclosed by '"'
lines terminated by '\r\n'
ignore 1 lines(id, country, c3, @_c2, year, @a_gini_reported, @a_palma, 

@a_ratio_top20bottom20, @a_bottom40, @a_q1, @a_q2, @a_q3, @a_q4, @a_q5, 

@a_d1, @a_d2, @a_d3, @a_d4, @a_d5, @a_d6, @a_d7, @a_d8, @a_d9, @a_d10, 

@a_bottom5, @a_top5, @a_resource, resource_detailed, @a_scale, @a_scale_detailed, 

@a_sharing_unit, @a_reference_unit, areacovr, @a_areacovr_detailed, 
popcovr, popcovr_detailed, region_un, region_un_sub, region_wb, eu, oecd, incomegroup, 
@a_mean, @a_median, @a_currency, @a_reference_period, @a_exchangerate, @a_mean_usd, 
@a_median_usd, @a_gdp_ppp_pc_usd2011, @a_population, @a_revision, @a_quality, quality_score)

SET
c2 = nullif(@a_c2, 'NA' ),
gini_reported = nullif(@a_gini_reported, 'NA' ),
palma = nullif(@a_palma, 'NA' ),
ratio_top20bottom20 = nullif(@a_ratio_top20bottom20, 'NA' ),
bottom40 = nullif(@a_bottom40, 'NA' ),
q1 = nullif(@a_q1, 'NA' ),
q2 = nullif(@a_q2, 'NA' ),
q3 = nullif(@a_q3, 'NA' ),
q4 = nullif(@a_q4, 'NA' ),
q5 = nullif(@a_q5, 'NA' ),
d1 = nullif(@a_d1, 'NA' ),
d2 = nullif(@a_d2, 'NA' ),
d3 = nullif(@a_d3, 'NA' ),
d4 = nullif(@a_d4, 'NA' ),
d5 = nullif(@a_d5, 'NA' ),
d6 = nullif(@a_d6, 'NA' ),
d7 = nullif(@a_d7, 'NA' ),
d8 = nullif(@a_d8, 'NA' ),
d9 = nullif(@a_d9, 'NA' ),
d10 = nullif(@a_d10, 'NA' ),
bottom5 = nullif(@a_bottom5, 'NA' ),
top5 = nullif(@a_top5, 'NA' ),
resource = nullif(@a_resource, 'NA' ),
scale = nullif(@a_scale, 'NA' ),
scale_detailed = nullif(@a_scale_detailed, 'NA' ),
sharing_unit = nullif(@a_sharing_unit, 'NA' ),
reference_unit = nullif(@a_reference_unit, 'NA' ),
areacovr_detailed  = nullif(@a_areacovr_detailed, 'NA' ),
mean = nullif(@a_mean, 'NA' ),
median = nullif(@a_median, 'NA' ),
currency = nullif(@a_currency, 'NA' ),
reference_period = nullif(@a_reference_period, 'NA' ),
exchangerate = nullif(@a_exchangerate, 'NA' ),
mean_usd = nullif(@a_mean_usd, 'NA' ),
median_usd = nullif(@a_median_usd, 'NA' ),
gdp_ppp_pc_usd2011 = nullif(@a_gdp_ppp_pc_usd2011, 'NA' ),
population = nullif(@a_population, 'NA' ),
revision = nullif(@a_revision, 'NA' ),
quality = nullif(@a_quality, 'NA' );


select scale_detailed from gini;