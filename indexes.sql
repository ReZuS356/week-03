-- Databáza: superstore
-- Seminár 3 - Zadanie 3a, Úloha 4 az 7: indexy a analýza plánu dotazu

-- Úloha 4 - Index pre vyhľadávanie objednávok zákazníka
CREATE INDEX idx_orders_customer_id
ON orders (customer_id);

SELECT *
FROM orders
WHERE customer_id = 'C001';
-- Index je k dispozícii query planneru, ale PostgreSQL ho použije len vtedy,
-- ak je to výhodnejšie než sekvenčné čítanie tabuľky (pri malej tabuľke
-- môže planner zvoliť Seq Scan).


-- Úloha 5 - Index nad dátumom objednávky
CREATE INDEX idx_orders_order_date
ON orders (order_date);

SELECT
    DATE_TRUNC('month', order_date)::DATE AS month,
    SUM(sales) AS sum
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month ASC;
-- 2024-01-01 ->  5921.44
-- 2024-02-01 ->  6062.89
-- 2024-03-01 ->  6664.95
-- 2024-04-01 -> 10472.55


-- Úloha 6 - Viacstĺpcový index a filtrovanie podľa regiónu a dátumu
CREATE INDEX idx_orders_region_category
ON orders (customer_id, order_date);

SELECT
    c.customer_name,
    c.region,
    o.order_id,
    o.order_date,
    o.sales,
    o.profit
FROM orders o
JOIN customers c
    ON c.customer_id = o.customer_id
WHERE
    c.region = 'West'
    AND o.order_date >= '2024-01-01';
-- Customer_25 -> profit = 34.53


-- Úloha 7 - Analýza plánu vykonania dotazu
EXPLAIN ANALYZE
SELECT *
FROM orders
WHERE customer_id = 'C001';
-- Tvrdenie je pravdivé: aj keď index nad customer_id existuje, planner môže
-- zvoliť Seq Scan, ak vyhodnotí sekvenčné čítanie ako lacnejšie.
