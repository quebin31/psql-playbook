drop table if exists some_types;
create temp table some_types
(
    a cardinal_number, -- non-negative integer
    b character_data,  -- without max length
    c sql_identifier,  -- string for SQL identifiers
    d time_stamp,      -- domain over the type timestamp with time zone
    e yes_or_no        -- wtf, yeah booleans came later
);

select *
from information_schema.information_schema_catalog_name;

select string_agg(schema_name, ',')
from information_schema.schemata
where schema_name not like 'pg%';

select string_agg(table_name, ',')
from information_schema.tables
where table_schema = 'public';

select table_name
from information_schema.views
where table_schema = 'information_schema';

select column_name, data_type, dtd_identifier
from information_schema.columns
where table_name = 'orderlines';

drop table if exists demo;
create temp table demo
(
    i int[],
    t text[]
);
select c.table_name, c.column_name, c.data_type
from information_schema.columns c
         left join information_schema.element_types e
                   on ((c.table_catalog, c.table_schema, c.table_name, 'TABLE', c.dtd_identifier) =
                       (e.object_catalog, e.object_schema, e.object_name, e.object_type, e.collection_type_identifier))
where c.table_schema like '%temp%'
order by c.ordinal_position;

select current_catalog,
       current_database(),
       current_schema,
       current_user,
       session_user;

select version();

select has_database_privilege('ds2', 'CREATE'),
       has_schema_privilege('public', 'USAGE'),
       has_table_privilege('customers', 'SELECT'),
       has_any_column_privilege('customers', 'SELECT');

select has_column_privilege('postgres', 'customers', 'firstname', 'UPDATE');

select unnest(string_to_array(pg_get_functiondef('login'::regproc::int), E'\n'));

select current_setting('timezone');
select set_config('timezone', 'UTC', true);

select pg_stat_file('/etc/passwd');
select pg_read_file('/etc/passwd');

select pg_ls_dir('/etc');