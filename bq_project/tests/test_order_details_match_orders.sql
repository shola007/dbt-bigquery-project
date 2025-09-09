WITH orders_details AS(
    SELECT
        order_id,
        count(*) AS num_of_items_in_order
    FROM
        {{ref('stg_ecommerce__order_items')}}
    GROUP BY 1
)
SELECT
    o.*,
    od.*
FROM {{ref('stg_ecommerce__orders')}} AS o
FULL OUTER JOIN orders_details AS od
USING(order_id)
-- Find orders that do not have matching order details or vice versa
WHERE o.order_id IS NULL OR od.order_id IS NULL
-- find orders where the number of items do not match
OR o.num_items_ordered <> od.num_of_items_in_order