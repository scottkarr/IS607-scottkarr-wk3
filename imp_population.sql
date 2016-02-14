CREATE TABLE population
(
	COUNTRY varchar, 
	YEAR int, 
	POPULATION int
);
COPY population FROM '/private/tmp/population.csv' DELIMITER ',' CSV HEADER;
