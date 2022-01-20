CREATE DATABASE IF NOT EXISTS pegaso_db;
USE pegaso_db;
DROP TABLE IF EXISTS raw_data;
CREATE TABLE
raw_data (
id VARCHAR(60),
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
