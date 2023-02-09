-- Motivating example
select region, state, max(age)
from customers
group by region, state;

select region, state, max(age) over (partition by region, state) as max_age
from customers
order by region, state;

select s.region, s.state, s.firstname, s.lastname, s.age
from (select *, max(age) over (partition by region, state) as max_age from customers) as s
where s.age = s.max_age
order by s.region, s.state;

select s.region, s.state, concat(firstname, ', ', lastname) as name, s.age, s.income, round(s.avg_income, 2)
from (select *, avg(income) over (partition by region, state) as avg_income from customers) as s
where s.income >  avg_income
order by s.region, s.state;

select orderid,
       prod_id,
       quantity,
       sum(quantity) over (partition by prod_id) as tot_quantity,
       min(quantity) over (partition by prod_id) as min_quantity,
       max(quantity) over (partition by prod_id) as max_quantity,
       avg(quantity) over (partition by prod_id) as avg_quantity
from orderlines;

select state,
       firstname,
       lastname,
       row_number() over (partition by state order by lastname desc)
from customers
where length(state) > 0;

select n as value,
       row_number() over (order by n),
       rank() over (order by n),
       dense_rank() over (order by n),
       percent_rank() over (order by n),
       cume_dist() over (order by n)
from (values (1), (1), (2), (3), (3)) v(n)
order by n;

select orderid,
       prod_id,
       quantity,
       sum(quantity) over (partition by orderid)                   as sum_unordered,
       sum(quantity) over (partition by orderid order by prod_id)  as sum_prod_ordered,
       sum(quantity) over (partition by orderid order by quantity) as sum_quan_ordered
from orderlines
where orderid = 1
order by prod_id;

select orderid,
       prod_id,
       quantity,
       sum(quantity) over (partition by orderid)                   as sum_unordered,
       sum(quantity) over (partition by orderid order by prod_id)  as sum_prod_ordered,
       sum(quantity) over (partition by orderid order by quantity) as sum_quan_ordered
from orderlines
where orderid = 1
order by quantity;

select a,
       n,
       lag(n) over (partition by a order by n)              as prev_row,
       lead(n) over (partition by a order by n)             as next_row,
       lag(n, 2) over (partition by a order by n desc)      as "lag 2 (desc)",
       lead(n, 2, 42) over (partition by a order by n desc) as default_value,
       first_value(n) over (partition by a order by n),
       last_value(n) over (partition by a order by n),
       nth_value(n, 2) over (partition by a order by n desc),
       row_number() over (partition by a order by n)
from (values ('a', 1), ('a', 2), ('b', 1), ('b', 2), ('b', 3)) v(a, n)
order by a, n;

select orderid,
       orderdate,
       lead(orderid) over (order by orderdate)   as next_id,
       lead(orderdate) over (order by orderdate) as next_date
from orders;

-- Limiting rows

select state,
       city,
       avg(age) filter (where city like 'B%') over (partition by state)
from customers
where state like 'O%'
order by state, city;


-- Changing clause frame
select orderid,
       prod_id,
       quantity,
       sum(quantity)
       over (partition by orderid order by prod_id rows between unbounded preceding and current row)         as default_sum,
       sum(quantity)
       over (partition by orderid order by prod_id rows 2 preceding)                                         as two_preceding,
       sum(quantity)
       over (partition by orderid order by prod_id rows between current row and 2 following)                 as two_following,
       sum(quantity)
       over (partition by orderid order by prod_id rows between unbounded preceding and unbounded following) as entire_window
from orderlines
where orderid = 1;

select customerid,
       orderid,
       orderdate,
       netamount,
       sum(netamount) over (order by orderdate range between '2 days' preceding and '2 days' following)
from orders
where orderdate between '1 Dec 2009' and '31 Dec 2009'
order by orderdate;

select a,
       n,
       lag(n) over w1         as prev_row,
       lead(n) over w1        as next_row,
       lag(n, 2) over w2      as "lag 2 (desc)",
       lead(n, 2, 42) over w2 as default_value,
       first_value(n) over w1,
       last_value(n) over w1,
       nth_value(n, 2) over w2,
       row_number() over w1
from (values ('a', 1), ('a', 2), ('b', 1), ('b', 2), ('b', 3)) v(a, n)
    window w1 as (partition by a order by n),
        w2 as (partition by a order by n desc)
order by a, n;