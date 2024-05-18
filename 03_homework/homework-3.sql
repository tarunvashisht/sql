/*# Homework 3: Essential SQL

-  	Due on Saturday, May 17 at 11:59pm
-  	Weight: 8% of total grade
-  	Upload one .sql file with your queries

# AGGREGATE
1. Write a query that determines how many times each vendor has rented a booth at the farmer’s market by counting the vendor booth assignments per `vendor_id`.
*/
    Select vba.vendor_id , v.vendor_name, count(vba.booth_number) 
    from vendor_booth_assignments as vba
    inner join vendor as v on v.vendor_id =  vba.vendor_id
    group by vba.vendor_id
/*
2. The Farmer’s Market Customer Appreciation Committee wants to give a bumper sticker to everyone who has ever spent more than $2000 at the market. Write a query that generates a list of customers for them to give stickers to, sorted by last name, then first name. 
**HINT**: This query requires you to join two tables, use an aggregate function, and use the HAVING keyword.
*/
    select c.customer_last_name, c.customer_first_name ,  sum(quantity* cost_to_customer_per_qty) as amount_purchased
    from customer c
    inner join customer_purchases as cp on c.customer_id = cp.customer_id
    group by c.customer_last_name, c.customer_first_name 
    HAVING amount_purchased > 2000
    order by c.customer_last_name, c.customer_first_name
/*
# Temp Table
1. Insert the original vendor table into a temp.new_vendor and then add a 10th vendor: Thomass Superfood Store, a Fresh Focused store, owned by Thomas Rosenthal
*/
    Drop table if EXISTS temp.new_vendor;

    CREATE TEMP TABLE new_vendor AS select * from vendor;
    INSERT into temp.new_vendor
        (
        vendor_id,
        vendor_name, 
        vendor_type, 
        vendor_owner_first_name, 
        vendor_owner_last_name
        )
    VALUES
        (10,
        'Thomass Superfood Store', 
        'Fresh Focused store' , 
        'Thomas' ,   
        'Rosenthal'
        );
    select * FROM temp.new_vendor
/*
**HINT**: This is two total queries -- first create the table from the original, then insert the new 10th vendor. When inserting the new vendor, you need to appropriately align the columns to be inserted (there are five columns to be inserted, I've given you the details, but not the syntax)

To insert the new row use VALUES, specifying the value you want for each column:  
`VALUES(col1,col2,col3,col4,col5)`

# Date
1. Get the customer_id, month, and year (in separate columns) of every purchase in the customer_purchases table.
**HINT**: you might need to search for strfrtime modifers sqlite on the web to know what the modifers for month and year are!
*/
    SELECT customer_id,  strftime( '%m' , market_date) as Month, strftime('%Y', market_date) as year
    from 	customer_purchases
/*
2. Using the previous query as a base, determine how much money each customer spent in April 2019. Remember that money spent is `quantity*cost_to_customer_per_qty`.
**HINTS**: you will need to AGGREGATE, GROUP BY, and filter...but remember, STRFTIME returns a STRING for your WHERE statement!!
*/
    SELECT customer_id,  strftime( '%m' , market_date) as Month, strftime('%Y', market_date) as year 
    ,  sum(quantity*cost_to_customer_per_qty) as amount_spent
    from 	customer_purchases
    GROUP by customer_id,   strftime( '%m' , market_date) , strftime('%Y', market_date)  
    having year ='2019' and Month = '04'

