-- Databáza: superstore
-- Seminár 3 - Zadanie 3a, Úloha 8 az 10: uložené procedúry (PROCEDURE)

-- Úloha 8 - Celkový predaj zákazníka pomocou procedúry
CREATE OR REPLACE PROCEDURE get_customer_sales(p_customer_id VARCHAR(20))
LANGUAGE plpgsql
AS $procedure$
DECLARE
    v_total_sales NUMERIC(12, 2);
BEGIN
    SELECT SUM(sales)
    INTO v_total_sales
    FROM orders
    WHERE customer_id = p_customer_id;

    RAISE NOTICE 'Zákazník %: celkový predaj = %', p_customer_id, v_total_sales;
END;
$procedure$;

CALL get_customer_sales('C001');
-- RAISE NOTICE vypíše 1 záznam (zákazník + celkový predaj)


-- Úloha 9 - Procedúra na aplikovanie regionálnej zľavy
CREATE OR REPLACE PROCEDURE apply_regional_discount(
    region_name   VARCHAR(50),
    discount_rate NUMERIC(5, 2)
)
LANGUAGE plpgsql
AS $procedure$
BEGIN
    UPDATE orders o
    SET sales = o.sales * (1 - discount_rate)
    FROM customers c
    WHERE
        o.customer_id = c.customer_id
        AND c.region = region_name;

    RAISE NOTICE 'Zľava % bola aplikovaná na región %', discount_rate, region_name;
END;
$procedure$;

CALL apply_regional_discount('West', 0.10);
-- Druhé volenie s rovnakými parametrami opäť zníži už znížené hodnoty
-- o ďalších 10 % (procedúra nemá žiadnu kontrolu, či už bola aplikovaná).


-- Úloha 10 - Celkový predaj medzi dvoma dátumami
CREATE OR REPLACE PROCEDURE get_sales_between(
    start_date DATE,
    end_date   DATE
)
LANGUAGE plpgsql
AS $procedure$
DECLARE
    v_total NUMERIC(12, 2);
BEGIN
    SELECT SUM(sales)
    INTO v_total
    FROM orders
    WHERE order_date BETWEEN start_date AND end_date;

    RAISE NOTICE 'Predaj od % do %: %', start_date, end_date, v_total;
END;
$procedure$;

CALL get_sales_between('2024-01-01', '2024-03-31');
-- RAISE NOTICE vypíše celkový predaj 18649.28
