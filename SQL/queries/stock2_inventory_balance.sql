-- =============================================================================
-- View / Query: Stock 2 – Inventory Balance After Ingredient Usage
-- File: stock2_inventory_balance.sql
--
-- Purpose:
--   - Compare ingredient inventory (from inventory table) against total
--     ingredient usage (from Stock 1)
--   - Determine how much inventory remains after fulfilling all orders
--   - Used for inventory planning, cost control, and Looker Studio dashboards
--
-- Workflow:
--   1. Aggregate ingredient usage from Stock 1
--   2. Multiply inventory quantity by ingredient package weight
--   3. Subtract total ordered weight to compute remaining weight
-- =============================================================================


SELECT
    s2.ing_name,                  -- Ingredient name
    s2.ordered_weight,            -- Total weight used across all orders (from Stock 1)

    ing.ing_weight * inv.quantity AS total_inv_weight,
        -- Total available inventory weight
        -- (package weight × number of packages in inventory)

    (ing.ing_weight * inv.quantity) - s2.ordered_weight AS remaining_weight
        -- Remaining weight after fulfilling all customer orders

FROM (
        -- =====================================================================
        -- Subquery:
        --   Summarize ingredient usage from Stock 1
        --   (Stock 1 must be created as a view OR a table)
        -- =====================================================================
        SELECT 
            ing_id, 
            ing_name, 
            SUM(ordered_weight) AS ordered_weight
        FROM stock1
        GROUP BY ing_name, ing_id
) AS s2

LEFT JOIN inventory inv 
    ON inv.item_id = s2.ing_id      -- Match inventory records to ingredient ID

LEFT JOIN ingredient ing 
    ON ing.ing_id = s2.ing_id;      -- Retrieve weight & price info for math
