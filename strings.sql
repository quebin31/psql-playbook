select 'Today is ' || current_date;

select upper('abc'),
       lower('ABC'),
       char_length('ABC'),
       octet_length('π'),
       trim('   ABC   '),
       trim(leading '-' from '---ABC---'),
       trim(trailing '-' from '---ABC---'),
       trim(both '-' from '---ABC---')
;

select position('Trillian' in 'Arthur and Trillian'),
       substring('Arthur and Trillian' from 12 for 4),
       overlay('Arthur and Trillian' placing 'Zaphod' from 1 for 6)
;

select ascii('X'),
       chr(88),
       length('42'),
       initcap('lorem IPSUM'),
       left('The Answer', 7),
       right('The Answer', 3),
       ltrim('   42'),
       rtrim('42---', '-x'),
       lpad('42', 5),
       rpad('42', 5, '-x'),
       repeat('Rr', 5)
;

select replace('Arthur and Trillian', 'Arthur', 'Ford'),
       reverse('Slartibartfast'),
       split_part('/tmp/dir/dir', '/', 3),
       strpos('Arthur and Trillian', 'Trillian'),
       substr('Lorem', 2, 3),
       translate('Lorem Ipsum', 'm', 'x'),
       translate('Lorem Ipsum', 'rum', 'abc')
;

select string_agg(categoryname, ',')                                         as "unsorted",
       string_agg(categoryname, ',' order by categoryname desc)              as "sorted",
       string_agg(categoryname, ',') filter ( where categoryname like '%s' ) as "filtered and unsorted"
from categories;

select state,
       string_agg(distinct age::text, ',' order by age::text desc)
       filter ( where mod(age, 2) = 1 and age < 30) as "evens under thirty",

       string_agg(distinct age::text, ',' order by age::text desc)
       filter ( where mod(age, 2) = 0 and age > 80) as "odds over eighty"
from customers
where state like '%A%'
group by state
order by state;

select concat(age, income, state)
from customers
where customerid < 5;

select concat_ws(',', age, income, state)
from customers
where customerid < 5;