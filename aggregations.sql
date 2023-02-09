select count(*),
       count(distinct state),
       min(age),
       max(age),
       avg(age),
       sum(income),
       avg(age) filter ( where state in ('NY', 'CA') ) as avg_filtered
from customers;

select state, min(age), max(age), round(avg(age))
from customers
group by state;

explain
select state, avg(income) as avg_income
from customers
where state != ''
group by state
having max(age) > 50
order by state;

-- bitwise aggregation (for bitmasks)
select bit_and(age), bit_or(age)
from customers;