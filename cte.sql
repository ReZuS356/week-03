-- Databáza: datacraftinglab_db
-- Tabuľka: flourmills_sales
-- Seminár 3 - Zadanie 3b: CTE, window functions a rekurzívne CTE

-- Úloha 1 - Dni s mimoriadne vysokým predajom
WITH daily_sales AS (
    SELECT
        sale_date,
        SUM(total_amount) AS total_daily_sales
    FROM flourmills_sales
    GROUP BY sale_date
)
SELECT
    sale_date,
    total_daily_sales
FROM daily_sales
WHERE total_daily_sales > 3000000
ORDER BY total_daily_sales DESC;
-- Prvých 5 riadkov:
-- 2023-01-22 -> 100714415.97
-- 2023-06-30 ->  99408647.63
-- 2023-08-24 ->  98980443.52
-- 2022-04-21 ->  91126961.61
-- 2024-11-02 ->  87024708.52


-- Úloha 2 - Predaj podľa produktových kategórií
WITH category_sales AS (
    SELECT
        product_category,
        SUM(total_amount) AS total_sales
    FROM flourmills_sales
    GROUP BY product_category
)
SELECT
    product_category,
    total_sales
FROM category_sales
ORDER BY total_sales DESC;
-- Noodles -> 8025966980.13


-- Úloha 3 - Top produkty v jednotlivých kategóriách
WITH product_sales AS (
    SELECT
        product_category,
        product_name,
        SUM(total_amount) AS total_product_sales
    FROM flourmills_sales
    GROUP BY
        product_category,
        product_name
),
category_ranking AS (
    SELECT
        product_category,
        product_name,
        total_product_sales,
        RANK() OVER (
            PARTITION BY product_category
            ORDER BY total_product_sales DESC
        ) AS category_rank
    FROM product_sales
)
SELECT
    product_category,
    product_name,
    total_product_sales,
    category_rank
FROM category_ranking
WHERE category_rank <= 3
ORDER BY
    product_category,
    category_rank;


-- Úloha 4 - Podiel zákazníckych typov na celkovom predaji
WITH customer_type_sales AS (
    SELECT
        customer_type,
        SUM(total_amount) AS revenue
    FROM flourmills_sales
    GROUP BY customer_type
),
revenue_share AS (
    SELECT
        customer_type,
        revenue,
        SUM(revenue) OVER () AS total_revenue,
        ROUND(revenue * 100 / SUM(revenue) OVER (), 2) AS revenue_percentage
    FROM customer_type_sales
)
SELECT
    customer_type,
    revenue,
    total_revenue,
    revenue_percentage
FROM revenue_share
ORDER BY revenue DESC;
-- revenue_percentage = 33.31 -> Distributor


-- Úloha 5 - Posledný nákup každého zákazníka
WITH customer_purchases AS (
    SELECT
        customer_id,
        product_name,
        sale_date,
        total_amount,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY sale_date DESC
        ) AS rn
    FROM flourmills_sales
)
SELECT
    customer_id,
    product_name,
    sale_date,
    total_amount
FROM customer_purchases
WHERE rn = 1
ORDER BY customer_id ASC;
-- Prvých 5 riadkov:
-- 1000 -> Golden Penny Semovita 5kg      2024-03-31 ->  2474807.81
-- 1001 -> Golden Penny Vegetable Oil 1L  2023-08-01 ->  6433230.47
-- 1005 -> Golden Penny Flour 50kg        2023-05-01 -> 12000887.73
-- 1006 -> Golden Penny Vegetable Oil 1L  2022-08-11 -> 13194291.00
-- 1007 -> Golden Penny Vegetable Oil 1L  2024-05-25 ->   615983.15


-- Úloha 6 - Súvislý kalendár predajov
WITH RECURSIVE sales_range AS (
    SELECT
        MIN(sale_date) AS first_date,
        MAX(sale_date) AS last_date
    FROM flourmills_sales
),
calendar AS (
    SELECT
        first_date AS calendar_date,
        last_date
    FROM sales_range

    UNION ALL

    SELECT
        (calendar_date + 1)::DATE,
        last_date
    FROM calendar
    WHERE calendar_date < last_date
)
SELECT
    calendar_date
FROM calendar
ORDER BY calendar_date ASC;
-- 2022-01-01 az 2024-12-31 -> 1096 dátumov


-- Úloha 7 - Dosiahnutie hranice 500 miliónov kumulatívneho predaja
WITH RECURSIVE monthly_revenue AS (
    -- Krok 1: mesačný predaj
    SELECT
        DATE_TRUNC('month', sale_date)::DATE AS month,
        SUM(total_amount) AS revenue
    FROM flourmills_sales
    GROUP BY DATE_TRUNC('month', sale_date)
),
ordered_months AS (
    -- Krok 2: mesiace zoradené a očíslované
    SELECT
        ROW_NUMBER() OVER (ORDER BY month) AS rn,
        month,
        revenue
    FROM monthly_revenue
),
cumulative_revenue AS (
    -- Krok 3: kumulatívny súčet pomocou rekurzie
    SELECT
        rn,
        month,
        revenue,
        revenue AS cumulative_revenue
    FROM ordered_months
    WHERE rn = 1

    UNION ALL

    SELECT
        om.rn,
        om.month,
        om.revenue,
        cr.cumulative_revenue + om.revenue
    FROM cumulative_revenue cr
    JOIN ordered_months om
        ON om.rn = cr.rn + 1
    WHERE cr.cumulative_revenue < 500000000
)
SELECT
    rn,
    month,
    revenue,
    cumulative_revenue
FROM cumulative_revenue
WHERE cumulative_revenue >= 500000000
ORDER BY rn
LIMIT 1;
-- Hranica 500 000 000 je prvýkrát dosiahnutá v mesiaci 2022-01
