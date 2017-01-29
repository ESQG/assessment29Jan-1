-- Include your solutions to the More Practice problems in this file.

-- Warm Up
\dt
\d brands
\d models
SELECT * FROM brands LIMIT 10;
SELECT COUNT(brand_id) FROM brands;  --got 15
SELECT * FROM brands; --realized I could look at the whole table
SELECT * FROM models LIMIT 10;
SELECT COUNT(model_id) FROM models; --got 46
\d brands  --to look at dependencies
-- Indexes:
--     "brands_pkey" PRIMARY KEY, btree (brand_id)
-- Referenced by:
--     TABLE "models" CONSTRAINT "models_brand_id_fkey" FOREIGN KEY (brand_id) REFERENCES brands(brand_id)


-- Insert a Brand

INSERT INTO brands (brand_id, name, founded, headquarters)
VALUES ('sub', 'Subaru', 1953, 'Tokyo, Japan');

-- cars=# SELECT * FROM brands WHERE brand_id='sub';
--  brand_id |  name  | founded | headquarters | discontinued 
-- ----------+--------+---------+--------------+--------------
--  sub      | Subaru |    1953 | Tokyo, Japan |  



-- Insert Models
SELECT brand_id FROM brands WHERE name='Chevrolet';
SELECT brand_id FROM brands WHERE name='Subaru';

\d models

INSERT INTO models (name, brand_id, year)
VALUES ('Malibu', 'che', 2015);

INSERT INTO models (name, brand_id, year)
VALUES ('Outback', 'sub', 2015);

SELECT * FROM models WHERE name='Subaru';
-- model_id | year | brand_id |  name  
----------+------+----------+--------
--       47 | 2015 | sub      | Subaru
--(1 row)



-- Create an Awards Table

CREATE TABLE awards (
id SERIAL PRIMARY KEY,
name VARCHAR(30) NOT NULL,
year INTEGER,
winner_id INTEGER REFERENCES models);
--\d awards
--                                   Table "public.awards"
--   Column   |         Type          |                      Modifiers                      
-- -----------+-----------------------+-----------------------------------------------------
--  id        | integer               | not null default nextval('awards_id_seq'::regclass)
--  name      | character varying(30) | not null
--  year      | integer               | 
--  winner_id | integer               | 
-- Indexes:
--     "awards_pkey" PRIMARY KEY, btree (id)
-- Foreign-key constraints:
--     "awards_winner_id_fkey" FOREIGN KEY (winner_id) REFERENCES models(model_id)

--wasn't sure if award year should match model year?


-- Insert Awards

INSERT INTO awards (name, year, winner_id)
VALUES ('IIHS Safety Award', 2015, (SELECT model_id FROM models
WHERE name='Malibu' AND year='2015'));
--SELECT * FROM awards;
--  id |       name        | year | winner_id 
-- ----+-------------------+------+-----------
--   1 | IIHS Safety Award | 2015 |        48
-- (1 row)

INSERT INTO awards (name, year, winner_id)
VALUES ('IIHS Safety Award', 2015, (SELECT model_id FROM models
WHERE name='Outback' AND year='2015'));

INSERT INTO awards(name, year) VALUES ('Best in Class', 2015);

-- cars=# SELECT * FROM awards;
--  id |       name        | year | winner_id 
-- ----+-------------------+------+-----------
--   1 | IIHS Safety Award | 2015 |        48
--   2 | IIHS Safety Award | 2015 |        47
--   3 | Best in Class     | 2015 |          
-- (3 rows)




