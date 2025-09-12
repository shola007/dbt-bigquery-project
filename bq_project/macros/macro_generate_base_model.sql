
{% macro generate_base_mymodel(source_name, table_name, case_sensitive_cols=False, materialized=None)%}
{% set columns = adapter.get_columns_in_relation(source(source_name, table_name))%}
{% set column_names = columns | map(attribute = 'name') %}
{% set base_model_sql %}
{% if materialized is not none -%}

{{ "{{config(materialized= ' "~ materialized ~ "' ) }}" }}

{%- endif -%}

WITH source AS (
    SELECT *
    FROM {% raw %}{{ source({% endraw %}'{{ source_name }}', '{{ table_name }}'{% raw %}) }}{% endraw %}
)

SELECT
{%- for column in column_names -%}
    {% if column == 'id' %}
        id AS {{table_name[:-1]}}_id{% if not loop.last%},{% endif %}
    {% else %}
        {{column}}{% if not loop.last%},{% endif %}
    {% endif %}
{%- endfor %}
FROM source
{% endset %}

{% if execute %}
{{log (base_model_sql, info=True) }}
{% do return(base_model_sql)%}
{% endif %}
{% endmacro %}