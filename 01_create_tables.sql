--
-- PostgreSQL database dump
--

\restrict 9KggdDY4cRQH6JOpWlyEPna88wCwucAGWM6VKjbOin5TgdoSEdKxxnIgESeprAs

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-09-27 21:09:12

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 219 (class 1259 OID 16385)
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    customer_id character varying(20) NOT NULL,
    customer_name character varying(100),
    segment character varying(50),
    country character varying(50),
    region character varying(50)
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16397)
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    order_id character varying(20) NOT NULL,
    customer_id character varying(20),
    product_id character varying(20),
    order_date date,
    ship_date date,
    sales numeric(10,2),
    quantity integer,
    discount numeric(10,2),
    profit numeric(10,2)
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16391)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    product_id character varying(20) NOT NULL,
    category character varying(50),
    sub_category character varying(50),
    product_name character varying(100)
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 5018 (class 0 OID 16385)
-- Dependencies: 219
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (customer_id, customer_name, segment, country, region) FROM stdin;
customer_id	customer_name	segment	country	region
C001	Customer_1	Consumer	Kenya	East
C002	Customer_2	Consumer	South Africa	East
C003	Customer_3	Home Office	Ghana	South
C004	Customer_4	Home Office	South Africa	West
C005	Customer_5	Home Office	South Africa	South
C006	Customer_6	Consumer	South Africa	South
C007	Customer_7	Consumer	Kenya	East
C008	Customer_8	Corporate	Nigeria	Central
C009	Customer_9	Corporate	South Africa	South
C010	Customer_10	Corporate	South Africa	West
C011	Customer_11	Corporate	South Africa	West
C012	Customer_12	Consumer	South Africa	South
C013	Customer_13	Consumer	Ghana	West
C014	Customer_14	Home Office	Ghana	South
C015	Customer_15	Corporate	Ghana	Central
C016	Customer_16	Home Office	Kenya	Central
C017	Customer_17	Consumer	South Africa	Central
C018	Customer_18	Consumer	Kenya	Central
C019	Customer_19	Home Office	South Africa	Central
C020	Customer_20	Consumer	Kenya	West
C021	Customer_21	Consumer	Kenya	East
C022	Customer_22	Consumer	Ghana	Central
C023	Customer_23	Home Office	Nigeria	East
C024	Customer_24	Home Office	Nigeria	East
C025	Customer_25	Consumer	Kenya	West
C026	Customer_26	Consumer	South Africa	Central
C027	Customer_27	Corporate	Ghana	Central
C028	Customer_28	Consumer	Nigeria	East
C029	Customer_29	Home Office	Kenya	West
C030	Customer_30	Corporate	Nigeria	West
\.


--
-- TOC entry 5020 (class 0 OID 16397)
-- Dependencies: 221
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (order_id, customer_id, product_id, order_date, ship_date, sales, quantity, discount, profit) FROM stdin;
O1001	C029	P011	2024-02-03	2024-02-06	1016.46	3	0.00	-77.08
O1002	C027	P013	2024-02-09	2024-02-15	1056.64	9	0.00	317.19
O1003	C005	P012	2024-02-20	2024-02-26	1057.99	10	0.00	-178.11
O1004	C001	P001	2024-04-01	2024-04-04	1999.17	9	0.10	402.27
O1005	C008	P006	2024-04-03	2024-04-05	179.87	9	0.10	14.05
O1006	C017	P014	2024-01-02	2024-01-04	306.94	7	0.05	98.86
O1007	C027	P022	2024-01-31	2024-02-05	1041.30	4	0.20	-114.56
O1008	C004	P007	2024-03-25	2024-03-27	646.95	8	0.10	44.63
O1009	C003	P002	2024-04-15	2024-04-19	1598.13	3	0.30	-39.57
O1010	C016	P020	2024-04-18	2024-04-22	1837.12	5	0.20	533.82
O1011	C018	P014	2024-01-23	2024-01-30	393.12	1	0.20	-25.68
O1012	C002	P004	2024-01-19	2024-01-26	1959.56	5	0.10	674.14
O1013	C022	P019	2024-04-01	2024-04-04	356.27	1	0.10	73.33
O1014	C006	P007	2024-04-18	2024-04-21	1709.48	5	0.30	523.59
O1015	C026	P010	2024-02-20	2024-02-24	1319.64	4	0.20	-58.44
O1016	C024	P006	2024-04-11	2024-04-15	98.00	8	0.05	20.82
O1017	C006	P007	2024-04-10	2024-04-17	956.75	6	0.20	312.18
O1018	C005	P002	2024-01-14	2024-01-20	551.32	9	0.00	112.79
O1019	C020	P030	2024-01-03	2024-01-05	1333.84	1	0.30	513.89
O1020	C028	P022	2024-02-25	2024-02-29	120.75	7	0.05	18.49
O1021	C009	P030	2024-03-23	2024-03-25	732.90	2	0.20	-98.47
O1022	C013	P010	2024-04-27	2024-05-03	29.79	6	0.00	0.40
O1023	C005	P020	2024-04-07	2024-04-10	1205.99	7	0.10	69.10
O1024	C014	P028	2024-01-11	2024-01-14	335.36	4	0.10	17.88
O1025	C025	P020	2024-03-06	2024-03-10	186.55	2	0.10	34.53
O1026	C017	P023	2024-03-14	2024-03-19	1944.33	5	0.30	415.11
O1027	C028	P026	2024-02-16	2024-02-20	1491.41	8	0.05	-226.74
O1028	C027	P007	2024-04-16	2024-04-18	501.98	6	0.10	148.25
O1029	C017	P013	2024-03-30	2024-04-01	1982.74	9	0.20	-60.12
O1030	C030	P005	2024-03-26	2024-03-31	1171.48	6	0.05	415.95
\.


--
-- TOC entry 5019 (class 0 OID 16391)
-- Dependencies: 220
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (product_id, category, sub_category, product_name) FROM stdin;
product_id	category	sub_category	product_name
P001	Furniture	Chair	Chair_1
P002	Furniture	Chair	Chair_2
P003	Furniture	Chair	Chair_3
P004	Furniture	Chair	Chair_4
P005	Furniture	Chair	Chair_5
P006	Furniture	Chair	Chair_6
P007	Furniture	Chair	Chair_7
P008	Furniture	Chair	Chair_8
P009	Furniture	Chair	Chair_9
P010	Furniture	Chair	Chair_10
P011	Furniture	Table	Table_1
P012	Furniture	Table	Table_2
P013	Furniture	Table	Table_3
P014	Furniture	Table	Table_4
P015	Furniture	Table	Table_5
P016	Furniture	Table	Table_6
P017	Furniture	Table	Table_7
P018	Furniture	Table	Table_8
P019	Furniture	Table	Table_9
P020	Furniture	Table	Table_10
P021	Furniture	Bookcase	Bookcase_1
P022	Furniture	Bookcase	Bookcase_2
P023	Furniture	Bookcase	Bookcase_3
P024	Furniture	Bookcase	Bookcase_4
P025	Furniture	Bookcase	Bookcase_5
P026	Furniture	Bookcase	Bookcase_6
P027	Furniture	Bookcase	Bookcase_7
P028	Furniture	Bookcase	Bookcase_8
P029	Furniture	Bookcase	Bookcase_9
P030	Furniture	Bookcase	Bookcase_10
\.


--
-- TOC entry 4864 (class 2606 OID 16390)
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customer_id);


--
-- TOC entry 4868 (class 2606 OID 16402)
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- TOC entry 4866 (class 2606 OID 16396)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- TOC entry 4869 (class 2606 OID 16403)
-- Name: orders orders_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);


--
-- TOC entry 4870 (class 2606 OID 16408)
-- Name: orders orders_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id);


-- Completed on 2026-09-27 21:09:13

--
-- PostgreSQL database dump complete
--

\unrestrict 9KggdDY4cRQH6JOpWlyEPna88wCwucAGWM6VKjbOin5TgdoSEdKxxnIgESeprAs

