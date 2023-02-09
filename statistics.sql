select stddev_pop(age),
       stddev_samp(age) filter ( where state = 'NY' ),
       var_samp(income) filter ( where age < 25 ),
       var_pop(income),
       variance(income)
from customers;


select c.state,
       corr(c.age, o.netamount),
       covar_pop(c.age, o.netamount),
       regr_intercept(c.age, o.netamount)
from orders o
         inner join customers c on c.customerid = o.customerid
where c.state in ('NY', 'CA', 'FL')
group by c.state;

select mode() within group ( order by age ),
       percentile_cont(0.5) within group ( order by age ),
       percentile_disc(array [0, 0.25, 0.5, 0.75, 1]) within group ( order by age )
from customers;