-- coercion
select '42'::int,
       '42'::real,
       '42'::numeric(5, 2),
       '42'::money
;

select '1,000'::int; -- fails

select to_number('1,000', '9,999')::int;

select to_number('-$42.00', 'SL99999D9999')::money as money,
       to_number('42000', '99V9999')::int          as "int with right shift"
;

-- warning: Prefer to leave formatting to the application layer

select to_char(42, '000'),
       to_char(42.000, '99.999'),
       to_char(42.000, 'FM99.999')
;

select to_char(42, '999th'),
       to_char(42, 'FMRN'),
       to_char(42.00, 'LFM99999D0099SG')
;

-- converting
select convert('lorem ipsum dolor', 'utf8', 'WIN1252');
select convert_from('I''m already in UTF-8', 'UTF-8');
select convert_to('π', 'WIN1252');
-- fails

-- base64, hex, escape
select encode('lorem ipsum'::bytea, 'base64'),
       decode('01000010', 'hex')
;

-- printf alike
select format('Hello %s', 'world!'),
       format('The answer is %s', 6 * 7)
;

select format('%2$-4s is 2nd, %1$s is 1st', -1, 42);
select format('%s again %1$s', '42');
select format('%6s', 'Hello');

select format('insert into %I values (%L, %L, %L)', 'Value Table', 1, 2, 3);