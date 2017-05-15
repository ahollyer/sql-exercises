-- 1. Create a table for local restaurants
CREATE TABLE restaurant (
  id SERIAL NOT NULL PRIMARY KEY,
  name VARCHAR,
  distance_from_hq DECIMAL(3,2),
  stars INTEGER CHECK (stars >= 0) CHECK (stars < 6),
  category VARCHAR,
  fav_dish VARCHAR,
  does_takeout BOOLEAN DEFAULT FALSE,
  last_went DATE
);


-- 2. Write INSERT statements to  enter data into the restaurant table.
INSERT INTO restaurant VALUES(DEFAULT, 'Moon Tower', 0.1, 5, 'Pub Food', 'veg tacos', TRUE, '2017-05-01');
INSERT INTO restaurant VALUES(DEFAULT, 'Villa Arcos', 0.2, 4, 'Tex Mex', 'pot-egg-chz tacos', TRUE, '2017-05-10');
INSERT INTO restaurant VALUES(DEFAULT, 'Toot Suite', 1.1, 3, 'Cafe', 'fruit tart', TRUE, '2017-05-01');
INSERT INTO restaurant VALUES(DEFAULT, 'Restaurante Monte Cristo', 0.3, 3, 'Tex Mex', NULL, FALSE, '2016-03-05');
INSERT INTO restaurant VALUES(DEFAULT, 'Mia Bella Tratoria', 1.5, 3, 'Italian', NULL, FALSE, '2015-01-01');
INSERT INTO restaurant VALUES(DEFAULT, 'Kim Son Restaurant', 1.4, 3, 'Vietnamese', NULL, FALSE, '2017-05-01');
INSERT INTO restaurant VALUES(DEFAULT, 'Subway', 0.3, 2, 'Fast Food', 'breakfast sandwich', TRUE, '2017-03-05');
INSERT INTO restaurant VALUES(DEFAULT, 'Ninfa''s', 0.5, 5, 'Tex Mex', 'enchiladas', TRUE, '2017-04-01');
INSERT INTO restaurant VALUES(DEFAULT, 'El Tiempo Cantina', 0.3, 3, 'Tex Mex', 'enchiladas', TRUE, '2017-02-01');
INSERT INTO restaurant VALUES(DEFAULT, 'BBQ Yo Mama', 2.5, 1, 'BBQ', NULL, FALSE, NULL);

-- 3. Write queries to get specific data

-- Names of restaurants you gave 5 stars to:
SELECT * FROM restaurant WHERE stars = 5;
-- Favorite dishes of all 5-star restaurants:
SELECT fav_dish FROM restaurant WHERE stars = 5;
-- The id of a restaurant by a specific name, e.g. 'Moon Tower':
SELECT id FROM restaurant WHERE name = 'Moon Tower';
-- Restaurants in the category of 'BBQ':
SELECT * FROM restaurant WHERE category = 'BBQ';
-- Restaurants that do takeout:
SELECT * FROM restaurant WHERE does_takeout;
-- Restaurants that do takeout in the category of 'BBQ':
SELECT * FROM restaurant WHERE does_takeout AND category = 'BBQ';
-- Restaurants within 2 miles
SELECT * FROM restaurant WHERE distance_from_hq < 2;
-- Restaurants where you haven't eaten in the past week:
SELECT * FROM restaurant WHERE last_went <= '2017-05-08';
-- 5-star restaurants where you haven't eaten in the past week:
SELECT * FROM restaurant WHERE last_went <= '2017-05-08' AND stars = 5;

-- 4. Aggregation & Sorting Exercises

-- List restaurants by closest distance
SELECT * FROM restaurant ORDER BY distance_from_hq;
-- List top 2 restaurants by distance
SELECT * FROM restaurant ORDER BY distance_from_hq LIMIT 2;
-- List top 2 restaurants by stars
SELECT * FROM restaurant ORDER BY stars DESC LIMIT 2;
-- List top 2 restaurants by stars where distance is less than 2 miles
SELECT name FROM restaurant WHERE distance_from_hq < 2 ORDER BY stars DESC LIMIT 2;
-- Count the number of restaurants in the db
SELECT COUNT(*) FROM restaurant;
-- Count the number of restaurants by category
SELECT name, COUNT(category) FROM restaurant GROUP BY category;
-- Get the average stars per restaurant by category
SELECT category, AVG(stars) AS avg_stars FROM restaurant GROUP BY category;
-- Get the max stars of a restaurant by category
SELECT category, MAX(stars) AS highest_rated FROM restaurant GROUP BY category;
