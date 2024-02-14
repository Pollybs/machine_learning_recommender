USE recipes;

SELECT r.diet_id, d.name, d.description,  COUNT( r.diet_id) AS "Total Recipes Scraped"
FROM recipes_all r
JOIN diets d
ON d.diet_id = r.diet_id
GROUP BY r.diet_id;

SELECT v.category_id, c.category, COUNT(v.category_id) AS "Total Recipes"
FROM veganuary_recipes v
JOIN categories c
ON c.category_id = v.category_id
GROUP BY v.category_id, c.category
ORDER BY COUNT(v.category_id) DESC 
LIMIT 10;

SELECT n_steps as "Number of steps", COUNT(recipe_id) as "Recipes"
FROM foodcom_recipes_raw
WHERE n_steps !=0
GROUP BY n_steps
ORDER BY n_steps ASC;


SELECT avg(n_steps) as "AVG Number of steps"
FROM foodcom_recipes_raw
;

SELECT n_ingredients as "Number of ingredients", COUNT(recipe_id) as "Recipes"
FROM foodcom_recipes_raw
WHERE n_ingredients !=0
GROUP BY n_ingredients
ORDER BY COUNT(recipe_id) DESC;


SELECT avg(n_ingredients) as "AVG Number of ingredients"
FROM foodcom_recipes_raw;

SELECT avg(minutes) as "AVG Number of minutes"
FROM foodcom_recipes_raw;

select v.recipe_id, v.recipe, v.meal_id, v.category_id, c.category
from veganuary_recipes v
join  categories  c
on c.category_id = v.category_id
where v.meal_id = 2
;
