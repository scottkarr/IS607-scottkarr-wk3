/* if null data exists in any count, force 0 and filter in RStudio */
DROP TABLE IF EXISTS tb_rates;

CREATE TABLE tb_rates AS
	SELECT 	tb.country, 
		tb.year, 
		coalesce(tb.child+tb.adult+tb.elderly,null,0) AS cases, 
		pop.population,
		round(cast(coalesce(tb.child+tb.adult+tb.elderly,null,0) AS numeric)/cast(pop.population AS numeric), 6) * 100000 AS rate_per_100thsd
	FROM 	tb, population pop
	WHERE 	1=1
	AND	tb.country = pop.country
	AND	tb.year = pop.year
;

COPY (
	SELECT 	tb.country, 
		tb.year, 
		coalesce(tb.child+tb.adult+tb.elderly,null,0) AS cases, 
		pop.population,
		round(cast(coalesce(tb.child+tb.adult+tb.elderly,null,0) AS numeric)/cast(pop.population AS numeric), 6) * 100000 AS rate_per_100thsd
	FROM 	tb, population pop
	WHERE 	1=1
	AND	tb.country = pop.country
	AND	tb.year = pop.year
) TO '/tmp/tbrates.csv' With CSV Header;