-- Seminár 3 - Zadanie 3a, príprava databázy retail_sales

-- 1. Vytvorenie databázy (spustiť v databáze postgres)
CREATE DATABASE retail_sales;

-- Nasledujúce príkazy sa už spúšťajú v databáze retail_sales.

-- 2. Vytvorenie tabuľky orders
CREATE TABLE orders (
    order_id    VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    product_id  VARCHAR(20) NOT NULL,
    order_date  DATE NOT NULL,
    region      VARCHAR(20) NOT NULL,
    category    VARCHAR(50) NOT NULL,
    ship_mode   VARCHAR(30) NOT NULL,
    sales       DECIMAL(10, 2) NOT NULL,
    profit      DECIMAL(10, 2) NOT NULL
);

-- 3. Formát dátumu v súbore je mesiac - deň - rok
ALTER DATABASE retail_sales SET datestyle TO 'ISO, MDY';

-- 4. Dátový súbor retail_sales.csv je uložený v repozitári spolu so skriptom.

-- 5. Import dát: pgAdmin -> pravý klik na tabuľku orders -> Import/Export Data
--    - formát: CSV
--    - delimiter: ,
--    - Header: zapnuté
--    - stĺpce CSV musia zodpovedať štruktúre tabuľky

-- 6. Overenie importovaných dát
SELECT *
FROM orders;
