select make_date(2020, 10, 11),
       make_time(1, 2, 3.45),
       make_timestamp(2020, 10, 11, 1, 2, 3.45)
;

select make_interval(42, 10, 11, 12, 1, 2, 3.42),
       make_timestamptz(2020, 10, 11, 1, 2, 3.45),
       make_timestamptz(2020, 10, 11, 1, 2, 3.45, 'UTC-5')
;

select extract(day from current_timestamp),
       date_part('DAY', current_timestamp),
       date_part('YEAR', current_date),
       extract(century from interval '200 years, 10 months, 11 days')
;

select date '20190301' + 13,
       '20190328'::date - 13,
       time '23:59:59' + interval '1 second'
;

select date '20190314' + time '1:59:26.535897',
       pg_typeof(date '20190314' + time '1:59:26.535897'),
       date '20191224' + interval '1 day',
       - interval '1 hour' = interval '1 hour ago'
;

select interval '30 minutes' - interval '15 minutes',
       interval '30 minutes' - interval '1 day' - interval '1800 seconds',
       interval '1:00' * 2,
       interval '2:00' / 2
;

select (date '2001-02-16', date '2001-12-21') overlaps (date '2001-10-30', date '2002-10-30'),
       (date '2001-02-16', interval '100 days') overlaps (date '2001-10-30', date '2002-10-30')
;

select *
from orders
where (orderdate, interval '0 days') overlaps (date '2009-12-01', date '2009-12-31')
limit 3;

select *
from orders
where orderdate between date '2009-12-01' and date '2009-12-31'
limit 3;

select current_date,
       current_time,
       current_timestamp,
       localtime,
       localtimestamp
;

select current_time(0),
       current_timestamp(2),
       localtime(4),
       localtimestamp(6)
;

select now(),
       transaction_timestamp(),
       statement_timestamp(),
       clock_timestamp()
;

select timeofday(),
       age(timestamp 'March 14, 1879'),
       age(timestamptz '1945-08-14 12:34:56', timestamptz '2000-01-01 01:02:03')
;

select extract(epoch from timestamptz '2019-12-28 15:03:10.50-01:00') -
       extract(epoch from timestamptz '2019-09-28 09:05:20.50+01:00')
;

select (extract(epoch from timestamptz '2013-07-01 12:00:00') - extract(epoch from timestamptz '2013-03-01 12:00:00')) /
       60 / 60 / 24,
       timestamptz '2013-07-01 12:00:00' - timestamptz '2013-03-01 12:00:00',
       age(timestamptz '2013-07-01 12:00:00', timestamptz '2013-03-01 12:00:00')
;

select current_timestamp,
       to_timestamp(extract(epoch from current_timestamp))
;

select to_date('2019-10-07', 'YYYY-MM-DD'),
       to_date('October 25, 1998', 'Month DD, YYYY'),
       to_date('25th Oct 1998', 'DDth Mon YYYY')
;

select to_timestamp('2019-10-7 11:20:10', 'YYYY-MM-DD HH:MI:SS'),
       to_timestamp('2019-10-07 11.30.35+04.30', 'YYYY-MM-DD HH.MI.SS+TZH.TZM')
;

select current_timestamp,
       to_char('2019-10-7T11:55:55-4:00'::timestamptz, 'FMMonth DDth YYYY hh:mm:ss TZ')
;

select prod_id,
       quantity,
       to_char(orderdate, 'FMDay DD FMMonth YYYY') as order_date
from orderlines
limit 3;