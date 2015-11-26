-- Pair1.sql

-- Demonstrate how many pairs of cities there are joined by a river

select count(*) from located l1,located l2
where l1.river = l2.river and l1.city < l2.city;

-- Demonstrate how many pairs of countries there are with differently-named capital cities

select count(*) from country c1,country c2
where c1.capital < c2.capital;

-- Define indexes

create index country_ind on country(capital);
create index located_ind on located(city,river);

-- Write a pair of equivalent queries to retrieve pairs of capital cities linked by a river

-- Firstly in a manner which allows use of the optimizer:

select c1.capital,c2.capital,l1.river
from country c1,country c2,located l1,located l2
where c1.capital = l1.city
and c2.capital = l2.city
and c1.capital < c2.capital
and l1.river = l2.river;

-- Secondly in a manner which restricts the freedom of the optimizer:

select c1.capital,c2.capital,l1.river
from country c1 cross join country c2 join located l1 join located l2
on c1.capital < c2.capital
and c1.capital = l1.city
and c2.capital = l2.city
and l1.river = l2.river;

-- Remove the indices
drop index country_ind;
drop index located_ind;