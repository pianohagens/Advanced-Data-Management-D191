
-- CREATING  -------------------------------------------------------------------------------------
DROP TABLE IF EXISTS actor;
CREATE TABLE actor
(
	actor_id int,
	first_name character varying(45) ,
	last_name character varying(45) ,
	last_update timestamp,
	PRIMARY KEY (actor_id)
)


-- Veiw the actor table 
SELECT * FROM actor; 

-- Index: idx_actor_last_name

-- DROP INDEX public.idx_actor_last_name;

CREATE INDEX idx_actor_last_name
	ON public.actor USING btree
	(last_name COLLATE pg_catalog."default" ASC NULLS LAST)
	TABLESPACE pg_default;
	
-- Trigger: last_updated

-- DROP TRIGGER last_updated ON public.actor;

CREATE TRIGGER last_updated
	BEFORE UPDATE
	ON public.actor
	FOR EACH ROW
	EXECUTE FUNCTION public.last_updated();
    
 
-- CREATING  -----------------------------------------------------------------------------------------------   

DROP TABLE IF EXISTS adress;
CREATE TABLE adress
(
    address_id int,
    address character (50),
    address2 character (50),
    district character (20),
    city_id smallint,
    postal_code character (10),
    phone character (20),
    last_update timestamp,
	PRIMARY KEY (address_id)
)

-- Veiw the adress table 
SELECT * FROM adress; 


TABLESPACE pg_default;

ALTER TABLE public.address 
    OWNER to postgres;
-- Index: idx_fk_city_id

-- DROP INDEX public.idx_fk_city)id;

CREATE INDEX idx_fk_city_id
    ON public.address USING btree
    (city_id ASC NULLS LAST)
    TABLESPACE pg_default;
    
-- Trigger: last_updated
    
-- DROP TRIGGER last_updated ON public.address
    
CREAT TRIGGER last_updated
    BEFORE UPDATE
    ON public.address
    FOR EACH ROW
    EXECUTE FUNCTION public.last_updated();
    

-- CREATING  -------------------------------------------------------------------------------------
 
DROP TABLE IF EXISTS category;   
CREATE TABLE category
(
        category_id int,
        name character (25),
        last_update timestamp ,
        PRIMARY KEY (category_id)
)
-- Veiw the category table 
SELECT * FROM category; 

TABLESPACE pg_default;

ALTER TABLE public.category
    OWNER to pstgres;
    
-- Trigger: last_updated

-- DROP TRIGGER last_updated ON public.category;

CREATE TRIGGER last_updated
    BEFORE UPDATE
    ON public.category
    FOR EACH ROW
    EXECUTE FUNCTION public.last_updated();
    

-- CREATING  -------------------------------------------------------------------------------------
DROP TABLE IF EXISTS country;
CREATE TABLE country
(
    country_id int,
    country character (50),
    last_update timestamp ,
    PRIMARY KEY (country_id)
)
-- Veiw the country table 
SELECT * FROM country; 

TABLESPACE pg_default;
    
ALTER TABLE public.country
    OWNER to pstgres;
    
-- Trigger: last_updated
    
-- DROP TRIGGER last_updated ON public.country;
    
CREATE TRIGGER last_updated
    BEFORE UPDATE
    ON public.country
    FOR EACH ROW
    EXECUTE FUNCTION public.last_updated();
    
  
-- CREATING  -------------------------------------------------------------------------------------
DROP TABLE IF EXISTS city;
CREATE TABLE city
(
city_id int,
city character (50) ,
country_id smallint ,
last_update timestamp,
PRIMARY KEY (city_id)
)
-- Veiw the city table 
SELECT * FROM city; 


TAVLESPACE pg_default;

ALTER TABLE public.city
    OWNER to postgres;
 
 
-- Index: idx_fk_country_id

-- DROP INDEX public.idx_fk_country_id;

CREATE INDEX idx_fk_country_id;
    ON public.city USING btree
    (country_id ASC NULLS LAST)
    TABLESPACE pg_default;
    
-- Trigger: last_updated

-- DROP TRIGGER last_updated ON public.city

CREATE TRIGGER last_updated
    BEFORE UPDATE
    ON public.city
    FOR EACH ROW
    EXECUTE FUNCTION public.last_updated();
    

-- CREATING  -------------------------------------------------------------------------------------

DROP TABLE IF EXISTS customer;
CREATE TABLE customer
(
    customer_id int,
    store_id smallint,
    first_name character (45) ,
    last_name character (45) ,
    email character (50) ,
    address_id smallint ,
    activebool boolean ,
    create_date date ,
    last_update timestamp ,
    active integer,
    PRIMARY KEY (customer_id)
)
-- Veiw the customer table 
SELECT * FROM customer; 

TABLESPACE pg_default;

ALTER TABLE public.customer
    OWNER to postgres;
-- Index: idx_fk_address_id

-- DROP INDEX public.idx_fk_address_id;

CREATE INDEX idx_fk_address_id
    ON public.customer USING btree
    (address_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_last_name
    
-- DROP INDEXT public.idx_kast_name;
    
CREATE INDEX idx_last_name
    ON public.customer USING btree
    (store_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_last_name

-- DROP INDEX public.idx_last_name;

CREATE INDEX idx_last_name
    ON public.customer USING btree
    (last_name COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
    
-- Trigger last_updated

-- DROP TRIGGER last_updated ON public.customer;

CRETE TRIGGER last_updated
    BEFORE UPDATE
    ON public.customer
    FOR EACH ROW
    EXECUTE FUNCTION public.last_updated();
    
 
-- CREATING  -------------------------------------------------------------------------------------
DROP TABLE IF EXISTS film;
CREATE TABLE film
(
    film_id int,
    title character (255),
    description text,
    release_year CHAR(4),
    language_id smallint,
    rental_duration smallint,
    rental_rate numeric(4,2),
    length smallint,
    replacement_cost numeric(5,2),
    rating CHAR(10),
    last_update timestamp ,
    special_features text[] ,
    fulltext tsvector,
    PRIMARY KEY (film_id)
)
-- Veiw the film table 
SELECT * FROM film; 

TABLESPACE pg_default;

ALTER TABLE oublic.film
    OWNER to postgres;
-- Indext: film_fulltext_idx

-- DROP INDEX public.film_fulltext_idx;

CREATE INDEX film_fulltext_idx
    ON public.film USING gist
    (fulltext)
    TABLESPACE pg_default;
-- Index: idx_fk_language_id

--DROP INDEX public.idx_fk_language_id;

CREATE INDEX idx_title
    ON publc.flm USING btree
    (tittle COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
    
-- Trigger: film_fulltext_trigger

-- DROP TIGGER film_fulltext_trigger ON public.film;

CREATE TRIGGER film_fulltext_trigger
    BEFORE INSERT OR UPDATE
    ON oublic.film
    FOR EACH ROW
    EXECUTE FUNCTION tsvector_update_trigger('fulltext', 'pg_catalog.english', 'title', 'description');
    
-- Trigger: last_updated

-- DROP TRIGGER last_updated ON public.film;

CREATE TRIGGER last_updated
    BEFORE UPDATE
    ON public.film
    FOREACH ROW
    EXECUTE FUNCTIOPN public.last_updated();
    

-- CREATING  -------------------------------------------------------------------------------------4

DROP TABLE IF EXISTS film_actor;    
CREATE TABLE film_actor
(
    actor_id smallint ,
    film_id smallint ,
    last_update timestamp ,
    PRIMARY KEY (actor_id, film_id)
)
-- Veiw the film_actor table 
SELECT * FROM film_actor; 


TABLESPACE pg_default;

ALTER TABLE public.film_actor
    OWNER to postgres;
-- Index: idx_fk_film_id

-- DROP INDEX public.idx_fk_film_id;

CREATE INDEX idx_fk_film_id
    ON public.fim_actor USING btree
    (film_id ASC NULLS LAST)
    TABLESPACE pg_default;
    
-- Trigger: last_updated

-- DROP TRIGGER last_updated ON public.film_actor;

CREATE TRIGGER last_pdated
    BEFORE UPDATE
    ON public.film_actor
    FOR EACH ROW
    EXECUTE FUNCTION public.last_updated();
    

-- CREATING  -------------------------------------------------------------------------------------

DROP TABLE IF EXISTS film_category;
CREATE TABLE film_category
(
film_id smallint,
category_id smallint,
last_update timestamp,
PRIMARY KEY (film_id, category_id)
    
)
-- Veiw the film_category table 
SELECT * FROM film_category; 


TABLESPACE pg_default;

ALTER TABLE public.film_category
   OWNER to postgres;
   
-- Trigger: last_updated

-- DROP TRIGGER last_updated ON public.film_category;    
    

CREATE TRIGGER last_pdated
    BEFORE UPDATE
    ON public.film_category
    FOR EACH ROW
    EXECUTE FUNCTION public.last_updated();   
    
 
-- CREATING  -------------------------------------------------------------------------------------

DROP TABLE IF EXISTS inventory;
CREATE TABLE inventory
(
    inventory_id int,
    film_id smallint,
    store_id smallint,
    last_update timestamp,
    PRIMARY KEY (inventory_id)
    
)
-- Veiw the inventory table 
SELECT * FROM inventory; 

    
TABLESPACE pg_default;

ALTER TABLE public.inventory
    OWNER to postgres;
-- Index: idx_store_id_film_id

-- DROP INDEX public.idx_store_id_film_id;

CREATE INDEX idx_store_id_film_id
    ON public.inventory USING btree
    (store_id ASC NULLS LAST, film_id ASC NULLS LAST)
    TABLESPACE pg_default;
    
-- Trigger: last_updated

-- DROP TRIGGER last_updated ON public.inventory;

CREATE TIGGER last_updated
    BEFORE UPDATE
    ON public.inventory
    FOR EACH ROW
    EXECUTE FUNCTION public.last_updated();

-- CREATING  -------------------------------------------------------------------------------------
DROP TABLE IF EXISTS language;
CREATE TABLE language
(
    language_id integer,
    name character(20),
    last_update timestamp ,
    PRIMARY KEY (language_id)
)
-- Veiw the language table 
SELECT * FROM language; 


TABLESPACE pg_default;
ALTER TABLE public.language
    OWNER to postgres;
    
-- Trigger: last_updated
--DROP TRIGGER last_updated ON public.language;

CREATE TIGGER last_updated
    BEFORE UPDATE
    ON public.language
    FOR EACH ROW
    EXECUTE FUNCTION public.last_updated();

-- CREATING  -------------------------------------------------------------------------------------
DROP TABLE IF EXISTS payment;
CREATE TABLE payment
(
    payment_id int,
    customer_id smallint,
    staff_id smallint,
    rental_id integer,
    amount numeric(5,2),
    payment_date timestamp ,
    PRIMARY KEY (payment_id)
)
-- Veiw the payment table 
SELECT * FROM payment; 


TABLESPACE pg_default;

ALTER TABLE public.payment
    OWNER to postgres;
-- Index: idx_fk_customer_id

-- DROP INDEX public.idx_fk_customer_id;

CREATE INDEX idx_fk_customer_id
    ON public.payment USING btree
    (customer_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_fk_rental_id

-- DROP INDEX public.idx_fk_rental_id;

CREATE INDEX idx_fk_rental_id
    ON public.payment USING btree
    (rental id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_fk_staff_id

-- DROP INDEX public.idx_fk_staff_id;

CREATE INDEX idx_fk_staff_id
    ON public.payment USING btree
    (staff_id ASC NULLS LAST)
    TABLESPACE pg_default;


-- CREATING  -------------------------------------------------------------------------------------
DROP TABLE IF EXISTS rental;
CREATE TABLE rental
(
    rental_id integer ,
    customer_id smallint,    
    rental_date timestamp ,
    return_date timestamp,
    inventory_id integer,
    last_update timestamp,
    staff_id smallint,
    PRIMARY KEY (rental_id)    
)
-- Veiw the rental table 
SELECT * FROM rental; 

DROP TABLE IF EXISTS actor;

TABLESPACE pg_default;

ALTER TABLE public.rental
    OWNER to postGres;
-- Index: idx_fk_inventory_id

-- DROP INDEX public.idx_fk_inventory_id;

CREATE INDEX idx_fk_inventory_id
    OWNER to postgres;
    (inventory_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_unq_rental_rental_date_inventory_id_customer_id

-- DROP INDEX public.idx_unq_rental_date_inventory_id_customer_id;

CREATE UNIQUE INDEX idx_unq_rental_rental_date_invetory_id_costomer_id
    ON public.rental USING btree
    (rental_date ASC NULLS LAST, inventory_id ASC NULLS lAST, customer_id ASC NULLS LAST)
    TABLESPACE pg_default;
    
-- Trigger: last_updated
    
-- DROP TRIGGER last_updated ON public.rental;

CREATE TRIGGER last_updated
    BEFORE UPDATE
    ON public.rental
    FOR EACH ROW
    EXECUTE FUNCTION public.last_updated();



-- CREATING  -------------------------------------------------------------------------------------
DROP TABLE IF EXISTS staff;
CREATE TABLE staff
(
    staff_id int,
    first_name character varying(45),
    last_name character varying(45),
    address_id smallint,
    email character (50) ,
    active boolean,
    username character (16) ,    
    password character (40),    
    last_update timestamp ,
    
    picture bytea,
    PRIMARY KEY (staff_id)
)
-- Veiw the staff table 
SELECT * FROM staff; 


TABLESPACE pg_default;

ALTER TABLE public.staff
    OWNER to postgres;
    
-- Trigger: last_updated

-- DROP TRIGGER last_updated ON public.staff;

CRETE TRIGGER last_updated
    BEFORE UPDATE
    ON public.staff
    FOR EACH ROW
    EXECUTE FUNCTION public.last_updated();

-- CREATING  ------------------------------------------------------------------------------------

-- CREATING  -----------------------------------------------------------------------------------------------

CREATE TABLE store(
	store_id int,
	manager_staff_id smallint,
	address_id smallint,
	last_update timestamp,
	PRIMARY KEY (store_id)
)
-- Veiw the store table 
SELECT * FROM store; 
-- CREATING  ------------------------------------------------------------------------------------
-- CREATING  ------------------------------------------------------------------------------------
-- CREATING  ------------------------------------------------------------------------------------
-- CREATING  ------------------------------------------------------------------------------------


-- CREATING  ---------------------------------------------------------------------------------------
-- - Section B1 Create report section of payment_detail-----

DROP TABLE IF EXISTS payment_detail;
CREATE TABLE payment_detail
(
    -- payment_id int,
    customer_id smallint,
    first_name character(45),
    last_name character(45),
    email character(50),    
    address_id smallint,
    rental_id integer,
    film_id integer, 
    rental_date timestamp ,
    return_date timestamp,
    amount numeric(5,2),
    payment_date timestamp ,
    staff_id smallint,
    PRIMARY KEY(payment_id, customer_id)
)
-- Veiw the payment_detail table 
SELECT * FROM payment_detail; 



-- CREATING  ---------------------------------------------------------------------------------------
-- Section B2 Create report section of payment_summary------


DROP TABLE IF EXISTS payment_summary;
CREATE TABLE payment_summary
(
    customer_id smallint,
    customer_full_name character(100),
    amount numeric(5,2),
    payment_id int,
    payment_date timestamp ,
    staff_id smallint,
    PRIMARY KEY(customer_id)
)
-- Veiw the payment_summary table 
SELECT * FROM payment_summary; 


-- CREATING  ------------------------------------------------------------------------------------

-- CREATING  --------------------------------------------------------------------------------------
-- Section C.1 Insert data to payment_detail table accurately-------


INSERT INTO payment_detail
SELECT payment.payment_id, 
        customer.customer_id, 
        customer.first_name, 
        customer.last_name, 
        customer.email, 
        customer.address_id, 
        rental.rental_id,
        film.film_id, 
        rental.rental_date,
        rental.return_date,
        payment.amount,
        payment.payment_date,    
        payment.staff_id 
        
FROM (((payment
       INNER JOIN customer ON payment.customer_id = customer.customer_id)
       INNER JOIN rental ON payment.rental_id = rental.rental_id)
       INNER JOIN film ON film.film_id = film.film_id);

-- Veiw the payment_detail table 
SELECT * FROM payment_detail;


-- CREATING  ------------------------------------------------------------------------------------

-- CREATING  -------------------------------------------------------------------------------------
-- CREATING  D 
-- Section D --  for ease read purpose. 
-- Section D --CREATE function to combine the first_name and last_name into one column named it customer_full_name for the summary table


CREATE OR REPLACE FUNCTION customer_full_name(c_id int)
RETURNS varchar(100)
LANGUAGE plpgsql
AS $$
DECLARE
	full_name varchar(100);
BEGIN
	SELECT CONCAT(first_name, ' ', last_name)
	INTO full_name
	FROM customer
	WHERE customer_id = c_id;	
	return full_name;
    
END;
$$;


-- Section D.s Insert data to payment_summarys

INSERT INTO payment_summary
SELECT 
        customer.customer_id, 
        customer_full_name, 
        payment.amount,
        payment.payment_id, 
        payment.payment_date,    
        payment.staff_id  0
        
FROM (((payment
       INNER JOIN customer ON payment.customer_id = customer.customer_id)
       INNER JOIN rental ON payment.rental_id = rental.rental_id)
       INNER JOIN film ON film.film_id = film.film_id);

-- Veiw the payment_summary table 
SELECT * FROM payment_summary;

-- Section D -- creates a trigger on the detailed table of the report that will continually update the summary table as data is added to the detailed table

CREATE OR REPLACE FUNCTION sum_rental_payments_detail(c_id int)
RETURNS numeric(10,2)
LANGUAGE plpgsql
AS $$
DECLARE
	payments_sum numeric(10,2);
BEGIN
	SELECT SUM(total)
	INTO payments_sum
	FROM customer_rental_payment_detail
	WHERE customer_id = c_id;	
	return payments_sum;  
    
END;
$$;

-- CREATING  ----------------------------------------------------------------------------------------
-- Section E, creates a trigger -----

-- Section E -- CREATING a trigger on the customer_rental_payment_detailed table of the report 
CREATE OR REPLACE FUNCTION update_customer_rental_payment_summary()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO customer_rental_payment_detail
	SELECT customec_id, customer_full_name(customer c_id) AS customer_name, sum_rental_payments(customer c_id) AS sum_total
	FROM customer;
	
	RETURN NEW;
END;$$;

-- Section E -- Update the summary table as data is added to the detailed table.
CREATE TRIGGER trigger_update
	AFTER INSERT
	ON customer_rental_payment_summary
	FOR EACH STATEMENT
	EXECUTE PROCEDURE update_customer_rental_payment_summary();



-- CREATING  -----------------------------------------------------------------------------------------------




-- CREATING  -----------------------------------------------------------------------------------------------




-- CREATING  -----------------------------------------------------------------------------------------------


