-- Basis of possible query pair. Finds countries who are members of an organisation 
-- based in an adjacent country (with which they share a land border) - returns 367 tuples.

create index org_country_ind on organization(country);
create index org_abb_ind on organization(abbreviation);

select c1.name as Member_Country,o.name as Organization,c2.name as Based_In
from country c1,country c2,organization o, ismember i,borders b
where c1.code = i.country
and i.organization = o.abbreviation and o.country = c2.code
and ((b.country1 = c1.code and b.country2 = o.country)
or (b.country2 = c1.code and b.country1 = o.country));

-- Now use unary + to prevent use of org_abb_ind index

select c1.name as Member_Country,o.name as Organization,c2.name as Based_In
from country c1,country c2,organization o, ismember i,borders b
where c1.code = i.country
and i.organization = +o.abbreviation and o.country = c2.code
and ((b.country1 = c1.code and b.country2 = o.country)
or (b.country2 = c1.code and b.country1 = o.country));

-- Now use unary + to prevent use of org_country_ind index

select c1.name as Member_Country,o.name as Organization,c2.name as Based_In
from country c1,country c2,organization o, ismember i,borders b
where c1.code = i.country
and i.organization = o.abbreviation and +o.country = c2.code
and ((b.country1 = c1.code and b.country2 = o.country)
or (b.country2 = c1.code and b.country1 = o.country));

-- Drop indices

drop index org_country_ind;
drop index org_abb_ind;
