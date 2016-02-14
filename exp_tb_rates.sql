select 	 
country, 
round(avg(population)), 
round(avg(rate_per_100thsd)) avgRate_per_100thsd,
CASE 
WHEN regr_slope(rate_per_100thsd, year) > 0 THEN 'higher'
WHEN regr_slope(rate_per_100thsd, year) < 0 THEN 'lower'	 
ELSE 'na'
END trend,
regr_slope(rate_per_100thsd, year) regr_slope
from 	 tb_rates
where 1=1
and   rate_per_100thsd <> 0
group by country
order by round(avg(rate_per_100thsd)) desc 
limit 25    