/*# Homework 2: Basic SQL 

-  	Due on Friday, May 17 at 11:59pm
-  	Weight: 8% of total grade
-  	Upload one .sql file with your queries

# SELECT

1. Write a query that returns everything in the customer table.
*/
	Select * from customer
/*
2. Write a query that displays all of the columns and 10 rows from the customer table, sorted by customer_last_name, then customer_first_ name.
*/
	Select  *  from customer
	order by customer_first_name, customer_last_name
	limit 10

/*
# WHERE
1. Write a query that returns all customer purchases of product IDs 4 and 9.
*/
	Select * from customer_purchases
	where product_id in (4, 9)
/*
2. Write a query that returns all customer purchases and a new calculated column 'price' (quantity * cost_to_customer_per_qty), filtered by vendor IDs between 8 and 10 (inclusive) using either:
	1.  two conditions using AND
	2.  one condition using BETWEEN
*/
	select *, quantity * cost_to_customer_per_qty as 'price'
	from customer_purchases
	where vendor_id between 8 and 10 

/*
# CASE
1. Products can be sold by the individual unit or by bulk measures like lbs. or oz. Using the product table, write a query that outputs the `product_id` and `product_name` columns and add a column called `prod_qty_type_condensed` that displays the word “unit” if the `product_qty_type` is “unit,” and otherwise displays the word “bulk.”

*/
	Select product_id ,  product_name ,
	CASE WHEN product_qty_type = 'unit' then 'unit'
	ELSE 'bulk'
	END as  prod_qty_type_condensed
	from product

/*
2. We want to flag all of the different types of pepper products that are sold at the market. Add a column to the previous query called `pepper_flag` that outputs a 1 if the product_name contains the word “pepper” (regardless of capitalization), and otherwise outputs 0.
*/
	Select product_id ,  product_name ,
	CASE WHEN product_qty_type = 'unit' then 'unit'
	ELSE 'bulk'
	END as  prod_qty_type_condensed,

	CASE WHEN instr(UPPER(product_name), 'PEPPER') > 0    THEN  1
	else 0 
	end as pepper_flag

	from product

/*
# JOIN
1. Write a query that `INNER JOIN`s the `vendor` table to the `vendor_booth_assignments` table on the `vendor_id` field they both have in common, and sorts the result by `vendor_name`, then `market_date`.

*/
	Select * from vendor as v
	inner join vendor_booth_assignments as vba on v.vendor_id = vba.vendor_id
	order  by vendor_name ,  market_date