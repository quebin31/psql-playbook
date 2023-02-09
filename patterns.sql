-- like
select categoryname
from categories
where categoryname like 'S%'
   or categoryname like '%s'
   or categoryname like '%s%'
   or categoryname like '_r%'
   or categoryname ilike 'a%';
-- case insensitive

-- similar to
select '42' similar to '42'             as "exact",
       '42' similar to '4%'             as "wildcard",
       '42' similar to '4_'             as "single character",
       '42' similar to '%(4|2)%'        as "alternation",
       '42' similar to '[4567][012]'    as "character class",
       '42' not similar to '43'         as "not match",
       '%2' similar to '\%2' escape '\' as "escaped"
;

-- regexp
select 'Arthur' ~ '.*Arthur.*',
       'Arthur' ~* '.*Arthur.*',
       'Arthur' !~ '.*Arthur.*',
       'Arthur' !~* '.*Arthur.*'
;

select substring('Arthur & Trillian' from 'r . T');

select regexp_match('Arthur & Trillian', 'r . T'),
       (regexp_match('Arthur & Trillian', 'r . T'))[1],
       regexp_match('Arthur & Trillian', '(.*ur) & (.*an)');

select regexp_matches('Ford hitchikerhopehere', '(h[^h]+)(h[^h]+)', 'g');

select regexp_replace('Heart of Darkness', 'D.*', 'Gold');

select regexp_split_to_array('hitchiker towel hope guide here', ' (towel|guide) ');

select regexp_split_to_table('hitchiker towel hope guide here', ' (towel|guide) ');

select regexp_split_to_array('first, second, third', ', ');

select regexp_split_to_table('first, second, third', ', ');