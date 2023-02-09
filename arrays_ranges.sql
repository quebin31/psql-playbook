select int4range(1, 4),
       numrange(1.618033, 3.141592, '[]'),
       daterange('20200101', '20501231', '()'),
       tsrange(localtimestamp, localtimestamp + interval '5 days', '(]');

select array [1, 2, 3],
       array [3.14159::float],
       array [current_date, current_date + 1];

drop table if exists a_table;
create temp table a_table
(
    a text[]
);
insert into a_table
values ('{a,b,c}');
select *
from a_table;

-- comparison operators
select array [1,2,3] = array [2,3,4]    as eq,
       array [1,2,3] != array [2,3,4]   as neq,
       array [1,2,3] < array [2,3,4]    as lt,
       array [2,3,4] <= array [2,3,4,5] as leq,
       array [1,2,3] > array [2,3,4]    as gt,
       array [2,3,4] >= array [2,3,4,5] as geq;

select int4range(1, 3) = int4range(1, 3)  as eq,
       int4range(1, 3) != int4range(1, 3) as neq,
       int4range(1, 3) < int4range(1, 5)  as lt,
       int4range(0, 9) <= int4range(1, 3) as leq,
       int4range(1, 3) > int4range(1, 3)  as gt,
       int4range(1, 3) >= int4range(1, 3) as geq;

select array [1,2,3] @> array [2,3]         as contains,
       array ['a', 'b'] <@ array ['a', 'b'] as contained_by,
       array [1,2,3] && array [2,3,4]       as "overlaps";

select array [2] <@ array [1,2,3];

select int4range(1, 5) << int4range(5, 6) as strictly_left_of,
       int4range(1, 5) >> int4range(5, 6) as strictly_rigth_of,
       int4range(1, 5) &< int4range(5, 6), -- does not extend to the right of
       int4range(1, 5) &> int4range(5, 6); -- does not extend to the left of

select int4range(1, 5) -|- int4range(5, 6) as adjacent,
       int4range(1, 5) + int4range(5, 6)   as "union",
       int4range(1, 5) * int4range(5, 6)   as intersection,
       int4range(1, 5) - int4range(5, 6)   as difference;

select array [1,2,3] || array [4,5,6], array_cat(array [1,2,3], array [4,5,6]);
select 3 || array [4,5,6], array_prepend(3, array [4,5,6]);
select array [4,5,6] || 7, array_append(array [4,5,6], 7);

select array_ndims(array [[1], [2]]),
       array_dims(array [[1], [2]]),
       array_length(array [1,2,3], 1),
       array_lower(array [1,2,3], 1),
       array_upper(array [1,2,3], 1),
       cardinality(array [[1], [2]]);

select array_cat(array [1,2], array [3,4]),
       array_append(array [1,2,3], 4),
       array_prepend(0, array [1,2,3]),
       array_remove(array [1,2,2], 2), -- occurrences
       array_replace(array [1,2,3], 3, 4);

select lower(int4range(1, 4)),
       upper(int4range(1, 4)),
       isempty('[4,4)'::int4range),
       lower_inc(int4range(1, 4)),
       upper_inc(int4range(1, 4)),
       lower_inf('(,)'::int4range),
       upper_inf('(,)'::int4range);

select 42 in (1, 2, 42),
       42 not in (1, 2, 42),
       42 = all (array [42,42,42]),
       42 = any (array [1,2,42]),
       42 = some (array [1,2,3]),
       42 = any (array [42, null]),
       42 != any (array [42, null]),
       42 = all (array [42, null]),
       42 != all (array [42, null]);

select int4range '(1,42)', int4range(1, 4)::text;

select string_to_array('1,2,3', ','),
       string_to_array('1,2,3,xx,5', ',', 'xx'), -- empty value into null
       string_to_array('1,2,3,,5', ',', '');

select array_to_string(array [1,2,3], '|'),
       array_to_string(array [1,2,null, 4], '/', 'oops'),
       array_to_json(array [1,2,3]);

drop table if exists test_arrays;
create temp table test_arrays
(
    an_array int[]
);
insert into test_arrays(an_array)
values ('{1,2,3}');
select an_array, an_array::text
from test_arrays;