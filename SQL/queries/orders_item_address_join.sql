-- =============================================================================
-- Dashboard Query 1: Orders + Item + Address Join
-- Purpose:
--   - Combine order details with item information and delivery address data
--   - Used for sales analytics and delivery insights in Looker Studio
-- =============================================================================

SELECT
    o.order_id,              -- Unique order identifier
    i.item_price,            -- Price of the ordered item
    o.quantity,              -- Quantity ordered
    i.item_cat,              -- Item category (e.g., pizza, drink, sides)
    i.item_name,             -- Item name
    o.created_at,            -- Timestamp when the order was created
    a.delivery_address1,     -- Customer delivery address line 1
    a.delivery_address2,     -- Customer delivery address line 2
    a.delivery_city,         -- City for delivery
    a.delivery_zipcode,      -- Delivery ZIP code
    o.delivery               -- Delivery type (pickup vs delivery)
FROM orders o
LEFT JOIN item i 
    ON o.item_id = i.item_id       -- Match each order to its item details
LEFT JOIN address a 
    ON o.add_id = a.add_id;        -- Match order to delivery address
