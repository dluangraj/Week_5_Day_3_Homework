-- Question 1: List all customers who live in Texas
SELECT district, city.city_id
FROM address
FULL JOIN city
ON address.city_id = city.city_id
WHERE district = 'Texas';
-- Answer: 5

-- Question 2: Get all payments above $6.99 with the customer's full name
SELECT first_name, last_name, amount
FROM payment
FULL JOIN customer
ON payment.customer_id = customer.customer_id
WHERE amount > 6.99;
-- Answer: 1406 payments

-- Question 3: Show all customers names who have made payments over $175
SELECT payment.customer_id, first_name, last_name, SUM(amount)
FROM payment
FULL JOIN customer
ON payment.customer_id = customer.customer_id
GROUP BY payment.customer_id, first_name, last_name
HAVING SUM(amount) > 175;
-- Answer: 6 customers

-- Question 4: List all customers that live in Nepal
SELECT first_name, last_name, country
FROM city
FULL JOIN country
ON city.country_id = country.country_id
FULL JOIN address
ON city.city_id = address.city_id
FULL JOIN customer
ON address.address_id = customer.address_id
WHERE country = 'Nepal';
-- ANSWER: 1 customer

-- Question 5: Which staff member had the most transactions?
SELECT staff.first_name, staff.last_name, COUNT(payment.staff_id) AS transactions_
FROM staff
FULL JOIN payment
ON staff.staff_id = payment.staff_id
GROUP BY staff.first_name, staff.last_name;
-- Answer: Jon with 7304

-- Question 6: How many movies of each rating are there?
SELECT rating, COUNT(film.film_id)
FROM film
FULL JOIN film_category
ON film.film_id = film_category.film_id
GROUP BY rating;
-- ANSWER: R = 195, NC-17 = 210, PG-13 = 223, G = 178, PG = 194

-- Question 7: Show all customers who have made a single payment above $6.99

SELECT customer_id, amount
FROM payment
WHERE customer_id IN (
	SELECT DISTINCT customer_id
	FROM customer
	GROUP BY customer_id, first_name, last_name
	HAVING COUNT(customer_id) = 1
)
GROUP BY customer_id, amount
HAVING amount > 6.99
ORDER BY customer_id;
-- Answer: COULD NOT GET THE RIGHT ANSWER.

SELECT COUNT(DISTINCT customer_id)
FROM payment; 
SELECT customer_id, amount
FROM payment
WHERE amount > 6.99
GROUP BY customer_id, amount
ORDER BY COUNT(customer_id);

-- Question 8: How many free rentals did our stores give away?
SELECT store.store_id, COUNT(amount)
FROM store
FULL JOIN staff
ON store.store_id = staff.store_id
FULL JOIN payment
ON staff.staff_id = payment.staff_id
WHERE amount = 0
GROUP BY store.store_id;
-- Answer: 24





