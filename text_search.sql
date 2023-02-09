-- LIKE, SIMILAR TO and Regex?
-- - No natural language support
-- - No ordering or ranking
-- - Slow without indexing

select 'Arthur and Trillian travelled with Ford and Zaphod'::tsvector @@ 'Arthur & Ford'::tsquery;

select to_tsvector('Arthur and Trillian travelled with Ford and Zaphod') @@
       to_tsquery('Arthur & Ford')
;

select 'Arthur and Trillian travelled with Ford and Zaphod' @@ 'Arthur & Ford';

