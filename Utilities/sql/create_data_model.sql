CREATE DATABASE IF NOT EXISTS pegaso_db;

USE pegaso_db;

SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

DROP TABLE IF EXISTS raw_data;

CREATE TABLE
raw_data (
id VARCHAR(60) PRIMARY KEY,
brand VARCHAR(60),
model VARCHAR(60),
price_c MEDIUMINT,
price_f MEDIUMINT,
kilometers MEDIUMINT,
power INT,
doors INT,
professional_vendor VARCHAR(5),
automatic_gearbox VARCHAR(5),
year YEAR,
source VARCHAR(60),
hash VARCHAR(64),
batch_ts DATE
);


CREATE OR REPLACE VIEW batch_dates_variables
AS
SELECT 
(select rd.batch_ts from raw_data rd group by rd.batch_ts order by rd.batch_ts desc LIMIT 0,1) as curr_batch,
(select rd.batch_ts from raw_data rd group by rd.batch_ts order by rd.batch_ts desc LIMIT 1,1) as last_batch
from dual;


CREATE OR REPLACE VIEW recent_statistics
AS
SELECT  
   (select count(*) from raw_data) as ncars_all
  ,(select AVG(price_c) from raw_data) as av_price_all
  ,(select STD(price_c) from raw_data) as sd_price_all 
  ,(select count(*) from raw_data where batch_ts in (select curr_batch from batch_dates_variables))     as ncars_current_week
  ,(select AVG(price_c) from raw_data where batch_ts in (select curr_batch from batch_dates_variables)) as av_price_current_week
  ,(select STD(price_c) from raw_data where batch_ts in (select curr_batch from batch_dates_variables)) as sd_price_current_week
  ,(select count(*) from raw_data where batch_ts in (select last_batch from batch_dates_variables))     as ncars_last_week
  ,(select AVG(price_c) from raw_data where batch_ts in (select last_batch from batch_dates_variables)) as av_price_last_week
  ,(select STD(price_c) from raw_data where batch_ts in (select last_batch from batch_dates_variables)) as sd_price_last_week
from dual;


CREATE OR REPLACE VIEW global_statistics
AS
SELECT
  DISTINCT batch_ts as 'week',
  count(id) over (partition by batch_ts) as 'number_of_cars',
  ROUND(AVG(price_c)  over (partition by batch_ts),2) as 'avg_price',
  ROUND(STD(price_c)  over (partition by batch_ts),2) as 'sd_price'
FROM 
  raw_data
ORDER BY
  batch_ts desc;


CREATE OR REPLACE VIEW top_ten_most_expensive_current_week
AS
SELECT
  brand, model, price_c, price_f, kilometers, year, power, doors, professional_vendor
FROM 
  raw_data
WHERE
  batch_ts=(select curr_batch from batch_dates_variables)
ORDER BY
  price_c DESC
LIMIT 0,10;


CREATE OR REPLACE VIEW top_ten_cheapest_current_week
AS
SELECT
  brand, model, price_c, price_f, kilometers, year, power, doors, professional_vendor
FROM 
  raw_data
WHERE
  batch_ts=(select curr_batch from batch_dates_variables)
ORDER BY
  price_c ASC
LIMIT 0,10;


CREATE OR REPLACE VIEW brands_count
AS
SELECT 
  DISTINCT brand,
  COUNT(id) OVER (PARTITION BY brand) AS num_cars
FROM
  raw_data;