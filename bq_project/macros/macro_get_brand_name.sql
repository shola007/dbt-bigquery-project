
{% macro get_brand_name() %}
    CREATE OR REPLACE FUNCTION {{ target.schema }}.get_brand_name(weblink STRING)
    RETURNS STRING
    AS (
        REGEXP_EXTRACT(weblink, r'.+/brand/(.+)')
    )
{% endmacro %}