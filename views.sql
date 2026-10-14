-- Databáza: superstore
-- Seminár 3 - Zadanie 3a, Úloha 1 az 3: databázové pohľady (VIEW)

-- Úloha 1 - Pohľad pre zákazníkov s vysokou hodnotou predaja
CREATE OR REPLACE VIEW high_value_customers AS
SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.sales) AS total_sales
FROM customers c
JOIN orders o
    ON o.customer_id = c.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
HAVING SUM(o.sales) > 2000;

SELECT *
FROM high_value_customers;
-- Výsledok: 4 zákazníci (C005, C006, C017, C027)


-- Úloha 2 - Mesačný predaj podľa regiónu
CREATE OR REPLACE VIEW regional_monthly_sales AS
SELECT
    c.region,
    DATE_TRUNC('month', o.order_date)::DATE AS month,
    SUM(o.sales) AS monthly_sales
FROM customers c
JOIN orders o
    ON o.customer_id = c.customer_id
GROUP BY
    c.region,
    DATE_TRUNC('month', o.order_date);

SELECT *
FROM regional_monthly_sales
WHERE region = 'West'
ORDER BY month;
-- West: 2024-01-01 -> 1333.84
--       2024-02-01 -> 1016.46
--       2024-03-01 -> 2004.98
--       2024-04-01 ->   29.79


-- Úloha 3 - Pohľad pre analytikov (bez stĺpca profit)
CREATE OR REPLACE VIEW analyst_orders AS
SELECT
    order_id,
    customer_id,
    product_id,
    sales,
    quantity,
    discount
FROM orders;

SELECT *
FROM analyst_orders;

-- Stĺpec profit sa v pohľade nenachádza. Aby ho analytik nezískal ani
-- priamo zo zdrojovej tabuľky, musí mať prístup iba cez pohľad:
-- REVOKE SELECT ON orders FROM analyst;
-- GRANT SELECT ON analyst_orders TO analyst;
