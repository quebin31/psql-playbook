-- can short-circuit preventing the sub-query to complete
select c.*
from customers c
where exists(select * from orders o where c.customerid = o.customerid)
order by c.customerid;

select distinct c.*
from customers c
         join orders o on c.customerid = o.customerid
order by c.customerid;

-- identical queries
with e as (select c.*
           from customers c
           where exists(select * from orders o where c.customerid = o.customerid)),
     j as (select distinct c.*
           from customers c
                    join orders o on c.customerid = o.customerid)

select count(*) over (), *
from e
except
select count(*) over (), *
from j;

-- prove of non existence, sub query is no longer short-circuited
select c.*
from customers c
where not exists(select * from orders o where c.customerid = o.customerid);

select c.*
from customers c
         left join orders o on c.customerid = o.customerid
where o.customerid is null;


with cte1 as (select * from (values (1), (2), (null)) v(n)),
     cte2 as (select * from (values (null::int)) v(n))

select cte1.*
from cte1
where cte1.n is not null
  and not exists(select * from cte2 where cte2.n = cte1.n);

-- similar to the first query with 'exists', can also short-circuit
select c.*
from customers c
where c.customerid in (select o.customerid from orders o);

-- again a join can be used, but it's not short-circuited
select distinct c.*
from customers c
         join orders o on c.customerid = o.customerid;

-- identical queries
with e as (select c.*
           from customers c
           where c.customerid in (select o.customerid from orders o)),
     j as (select distinct c.*
           from customers c
                    join orders o on c.customerid = o.customerid)

select count(*) over (), *
from e
except
select count(*) over (), *
from j;

-- prove of non existence
select c.*
from customers c
where c.customerid not in (select o.customerid from orders o);

select c.*
from customers c
left join orders o on c.customerid = o.customerid
where o.customerid is null;

with cte1 as (select * from (values (1), (2), (null)) v(n)),
     cte2 as (select * from (values (null::int)) v(n))

select cte1.*
from cte1
where cte1.n is not null and cte1.n not in (select cte2.n from cte2 where cte2.n is not null);

-- can short-circuit
select c.*
from customers c
where c.customerid = any (select o.customerid from orders o); -- equivalent to in

select *
from (values (1), (2)) v(n)
where v.n = any (select * from (values (1), (2)) v(n));

select *
from (values (1), (2)) v(n)
where v.n = some (select * from (values (1), (2)) v(n));

-- empty, no customer can be equal to all customers in orders
select c.*
from customers c
where c.customerid = all (select o.customerid from orders o);

select *
from (values (1), (2)) v(n)
where v.n != all (select * from (values (1), (1)) v(n));