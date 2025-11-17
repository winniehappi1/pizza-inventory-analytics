-- =============================================================================
-- View / Query: Stock 1 – Ingredient Usage & Cost by Menu Item
-- File: stock1_ingredient_usage_cost.sql
--
-- Purpose:
--   - Calculate how much of each ingredient is used based on all customer orders
--   - Compute the total ordered weight of each ingredient
--   - Derive the unit cost (price per weight unit)
--   - Calculate the total ingredient cost used for each menu item
--
-- Used For:
--   - Cost analysis per pizza / menu item
--   - Ingredient usage reporting
--   - Feeding Looker Studio dashboards for inventory & cost visuals
-- =============================================================================


SELECT
    s1.item_name,   -- Menu item name (e.g., specific pizza)
    s1.ing_id,      -- Ingredient ID used in the recipe
    s1.ing_name,    -- Ingredient name (e.g., cheese, tomato sauce)
    s1.ing_weight,  -- Weight of one ingredient unit (e.g., grams per pack)
    s1.ing_price,   -- Price of one ingredient unit (e.g., cost per pack)
    s1.order_quantity,      -- Total number of this menu item ordered
    s1.recipe_quantity,     -- Ingredient quantity required per item (recipe)
    s1.order_quantity * s1.recipe_quantity AS ordered_weight,
        -- Total weight of this ingredient used across all orders

    s1.ing_price / s1.ing_weight AS unit_cost,
        -- Cost per single weight unit (e.g., cost per gram)

    (s1.order_quantity * s1.recipe_quantity) * (s1.ing_price / s1.ing_weight)
        AS ingredient_cost
        -- Total cost of this ingredient used for this menu item
FROM (
    -- =====================================================================
    -- Subquery:
    --   - Joins orders → items → recipes → ingredients
    --   - Aggregates total orders and pulls ingredient/package info
    -- =====================================================================
    SELECT
        o.item_id,                  -- Item ID from orders table
        i.sku,                      -- SKU used to map to recipe_id
        i.item_name,                -- Menu item name
        r.ing_id,                   -- Ingredient used in the recipe
        ing.ing_name,               -- Ingredient name
        r.quantity AS recipe_quantity,
            -- Ingredient quantity required per one item (recipe amount)

        SUM(o.quantity) AS order_quantity,
            -- Total number of this item ordered across all orders

        ing.ing_weight,             -- Weight of one full ingredient unit
        ing.ing_price               -- Price of one full ingredient unit
    FROM orders o
    LEFT JOIN item i 
        ON o.item_id = i.item_id        -- Link each order to its menu item
    LEFT JOIN recipe r 
        ON i.sku = r.recipe_id          -- Link item SKU to its recipe
    LEFT JOIN ingredient ing 
        ON ing.ing_id = r.ing_id        -- Link recipe to ingredient details
    GROUP BY
        o.item_id,
        i.sku,
        i.item_name,
        r.ing_id,
        r.quantity,
        ing.ing_name,
        ing.ing_weight,
        ing.ing_price
) AS s1;
