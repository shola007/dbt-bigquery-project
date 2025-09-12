{# #}
{%  set my_variable -%}

select 1 as my_variable

{%- endset %}

{{ my_variable }}

SELECT
    
{%- set my_list = ['user_id', 'created_at'] -%}
    {% for item in my_list%}
    {{item}}{%if not loop.last%},{%endif%}
{%- endfor%}

{% set columns = adapter.get_columns_in_relation(ref('dim_orders'))%}
    SELECT
        {%for column in columns -%}
            {%- if column.name.startswith('total')%}
            {{column.name.upper() }}
            {%- endif -%}
        {%- endfor %}
{% set values = dbt_utils.get_column_values(table=ref('dim_orders'), column='order_status')%}
{{ values}}