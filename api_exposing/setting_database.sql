-- create database recipes;

SELECT * FROM recipes.jamie_oliver_all;

DROP TABLE foodcom_recipes_search_terms;

/* ALTER TABLE jamie_oliver_all
  RENAME TO jamie_oliver_RAW;*/
  
-- create database global_goals;

CREATE TABLE IF NOT EXISTS recipes.websites  (
    website_id INTEGER NOT NULL,
    name CHAR(255),
    url CHAR (255),
    total_recipes INTEGER,
CONSTRAINT pk_websites PRIMARY KEY (website_id)
);

CREATE TABLE  IF NOT EXISTS recipes.diets (
    diet_id INTEGER NOT NULL,
    name CHAR (255),
    description CHAR (255),
    total_recipes INTEGER,
    websites_id INT,
    CONSTRAINT pk_diets_id PRIMARY KEY(diet_id)
);



INSERT INTO recipes.diets 
VALUES ('02', 'vegetarian', 'No consumption of meat, poultry or fish. Consumes dairy products and honey.', NULL, NULL ),
 ('03', 'omnivore', 'Consumption of meat, poultry and/or fish. Consumes dairy products, honey and other animal derivatives.', NULL, NULL )
;

INSERT INTO recipes.websites
VALUES ('01', 'Jamie Oliver', 'https://www.jamieoliver.com/', NULL),
 ('02', 'Veganuary', 'https://veganuary.com/', NULL),
  ('03', 'Food.com', 'https://www.food.com/', NULL)
;

CREATE TABLE IF NOT EXISTS recipes.websites_diets (
    website_id INTEGER,
    diet_id INTEGER,
    PRIMARY KEY (website_id, diet_id),
	FOREIGN KEY (website_id) REFERENCES recipes.websites(website_id),
    FOREIGN KEY (diet_id) REFERENCES recipes.diets(diet_id)
);



INSERT INTO recipes.websites_diets
VALUES ('01', '01'),
	('01', '02'),
	('01', '03'),
 ('02', '01'),
  ('03', '01'),
   ('03', '02'),
      ('03', '03')
;

INSERT INTO recipes.websites
VALUES ('04', 'The Simple Veganista', 'https://simple-veganista.com/', NULL)
;

INSERT INTO recipes.websites_diets
VALUES ('04', '01')
;

ALTER TABLE veganista_recipes
ADD COLUMN diet_id INTEGER, 
ADD CONSTRAINT fk_diet_id
FOREIGN KEY (diet_id) REFERENCES diets(diet_id);

ALTER TABLE veganista_recipes
MODIFY COLUMN recipe_id VARCHAR(255);

ALTER TABLE veganista_recipes
ADD CONSTRAINT pk_veganis PRIMARY KEY (recipe_id);
SELECT * FROM veganista_recipes;

UPDATE veganista_recipes
SET diet_id = 1;

SELECT * FROM veganuary_raw;

RENAME TABLE jamie_oliver_urls TO jamie_oliver_recipes;

SELECT DISTINCT diet FROM jamie_oliver_all;

ALTER TABLE veganista_recipes
ADD CONSTRAINT pk_veganis PRIMARY KEY (recipe_id);

ALTER TABLE veganista_recipes
ADD COLUMN website_id INTEGER, 
ADD CONSTRAINT web_id
FOREIGN KEY (website_id) REFERENCES websites(website_id);

SELECT * FROM websites;

UPDATE veganista_recipes
SET website_id = 4;

CREATE TABLE categories AS
SELECT category_id, category FROM veganuary_categories;

ALTER TABLE categories
ADD CONSTRAINT cat_cat PRIMARY KEY (category_id);

DROP TABLE jamie_oliver_prep_ingr;

ALTER TABLE meal_ids
ADD CONSTRAINT cat_m PRIMARY KEY (meal_id);

ALTER TABLE veganuary_recipes
MODIFY COLUMN recipe_id VARCHAR (255);

ALTER TABLE veganuary_recipes
ADD CONSTRAINT cat_oks PRIMARY KEY (recipe_id);

ALTER TABLE veganista_recipes
MODIFY COLUMN recipe_id VARCHAR (255);

ALTER TABLE veganista_recipes
ADD CONSTRAINT cat_pkok PRIMARY KEY (recipe_id);

SELECT * FROM veganista_recipes;

SELECT constraint_name
FROM information_schema.table_constraints
WHERE table_name = 'veganista_recipes' AND constraint_type = 'PRIMARY KEY';

SELECT * FROM veganista_recipes;

SELECT * FROM websites;

ALTER TABLE foodcom_re_se
ADD COLUMN website_id INTEGER;

ALTER TABLE foodcom_recipes_raw
ADD COLUMN website_id INTEGER;

UPDATE foodcom_re_se
SET website_id = 3;

UPDATE foodcom_recipes_raw
SET website_id = 3;

DROP TABLE simplevegrecipes;

SELECT website_id, COUNT(recipe_id) FROM recipes_all
GROUP BY website_id
;

CREATE VIEW veganista_recipe_details AS
SELECT vp.recipe_id, vr.recipe, vr.url, vr.meal, 
vp.list_ingredients, vp.list_instructions,  vr.diet_id, d.name, 
vp.category_id, c.category, vr.website_id, w.name AS website
FROM recipes.veganista_prep vp
JOIN recipes.veganista_recipes vr
ON vp.recipe_id = vr.recipe_id
JOIN diets d
ON d.diet_id = vr.diet_id
JOIN categories c
ON vp.category_id = c.category_id
JOIN websites w
ON w.website_id =  vr.website_id
 ;

SELECT * FROM websites;


Select * from recipes_all
where diet_id = 0;

UPDATE jamie_oliver_recipes
SET diet_id = 2
WHERE diet_id = 0;

select * from jamie_oliver_raw;

