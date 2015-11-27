select c1.name,c2.name
from country c1,city c2
where c1.code = c2.country
and c2.population = (select max(population) from city where country = c2.country);

create index city_ind on city(country,population);

select c1.name,c2.name
from country c1,city c2
where c1.code = c2.country
and c2.population = (select max(population) from city where country = c2.country);

drop index city_ind;