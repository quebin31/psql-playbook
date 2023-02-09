select 2 + 3   as "addition",
       2 - 3   as "substraction",
       2 * 3   as "multiplication",
       5 / 2   as "div (int)",
       5 / 2.0 as "div"
;

-- operators (syntax sugar)
select 5 % 2 as "modulo",       -- ok
       mod(5, 2),               -- good
       5 ^ 2 as "exp (pow)",    -- ok
       power(5, 2),             -- good
       |/ 16 as "square root",  -- ugly
       sqrt(16),                -- good
       @ -42 as "absolute val", -- ugly
       abs(-42) -- good
;

select ||/ 27 as "cube root", -- ugly (wtf)
       cbrt(27),              -- good
       factorial(5) -- good
;

-- bitwise functions
select 42 & 24 as "and",
       42 | 24 as "or",
       42 # 24 as "xor",
       ~1      as "not",
       42 << 1 as "lshift",
       42 >> 1 as "rshift"
;

-- scalar functions
select abs(-42),
       mod(5, 2),
       log(2, 8),
       ln(42),
       log(round(exp(1))::int, 42) -- not close
;

select exp(1),
       power(5, 2),
       sqrt(2),
       floor(3.14159),
       ceil(3.14159)
;

select cbrt(42),
       degrees(42),
       radians(42),
       log(42),
       pi()
;

select round(42.4),
       round(42.1234, 2),
       scale(42.5321) -- no. digits after decimal point
;

select sign(-1),
       trunc(42.5),
       trunc(42.1234, 2)
;

select setseed(.42);

select random();

select width_bucket(3.14159, 0, 5, 10),
       width_bucket(42, array [30, 45, 50]);

select sin(.42),
       cos(.42),
       tan(.42)
;

select asin(.42),
       acos(.42),
       atan(.42)
;

select cot(.42),
       atan2(1, 42)
;

-- with degrees
select sind(.42),
       cosd(.42),
       cotd(.42),
       tand(.42)
;

-- with degrees
select asind(.42),
       acosd(.42),
       atand(.42),
       atan2d(1, 42)
;