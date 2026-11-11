create database ecommerce;
use ecommerce;
show databases;
create table customers (customer_id int primary key,customer_name varchar(100),email varchar(100),phone varchar(15),city varchar(50));
select * from customers;
create table categories (category_id int primary key, category_name varchar(100));
select * from categories;
create table products (product_id int primary key,category_id int,product_name varchar(100),price varchar(20),stock_quantity int,foreign key (category_id) references categories(category_id));
select * from products;
drop table orders;
create table orders (order_id int primary key , customer_id int , product_id int,quantity int,order_date date,order_status varchar(30),foreign key(customer_id) references customers(customer_id),
foreign key(product_id)references products(product_id));
select * from orders;
create table payments (payment_id int primary key,order_id int,foreign key(order_id) references orders(order_id),
payment_method varchar(50),payment_amount decimal(10,2),payment_status varchar(30),payment_date varchar(20));
desc payments;
insert into Customers values
(101,'Aarav Sharma','aarav@gmail.com','9876500001','Hyderabad'),
(102,'Bhavya Reddy','bhavya@gmail.com','9876500002','Vijayawada'),
(103,'Charan Kumar','charan@gmail.com','9876500003','Visakhapatnam'),
(104,'Divya Patel','divya@gmail.com','9876500004','Bengaluru'),
(105,'Esha Gupta','esha@gmail.com','9876500005','Chennai'),
(106,'Farhan Ali','farhan@gmail.com','9876500006','Mumbai'),
(107,'Gopi Krishna','gopi@gmail.com','9876500007','Warangal'),
(108,'Harini Rao','harini@gmail.com','9876500008','Guntur'),
(109,'Ishaan Verma','ishaan@gmail.com','9876500009','Pune'),
(110,'John Mathew','john@gmail.com','9876500010','Kochi');
desc customers;

insert into Categories values
(201,'Electronics'),
(202,'Fashion'),
(203,'Books'),
(204,'Home Appliances'),
(205,'Sports');
desc categories;

insert into Products values
(301,201,'Laptop',65000,20),
(302,201,'Smartphone',25000,40),
(303,201,'Bluetooth Speaker',3000,50),
(304,202,'Running Shoes',4500,35),
(305,202,'Backpack',1800,60),
(306,203,'Python Programming',700,100),
(307,203,'SQL Complete Guide',650,80),
(308,204,'Mixer Grinder',4200,25),
(309,204,'Air Fryer',5500,18),
(310,205,'Cricket Bat',2200,30);
desc products;
insert into Orders values
(401,101,301,1,'2026-07-01','Delivered'),
(402,102,302,1,'2026-07-02','Delivered'),
(403,103,304,2,'2026-07-03','Shipped'),
(404,104,306,1,'2026-07-04','Delivered'),
(405,105,309,1,'2026-07-05','Pending'),
(406,106,303,3,'2026-07-06','Delivered'),
(407,107,307,2,'2026-07-07','Delivered'),
(408,108,305,1,'2026-07-08','Cancelled'),
(409,109,308,1,'2026-07-09','Delivered'),
(410,110,310,2,'2026-07-10','Shipped'),
(411,101,302,1,'2026-07-11','Delivered'),
(412,103,301,1,'2026-07-12','Pending');
desc orders;

insert into Payments values
(501,401,'UPI',65000,'Paid','2026-07-01'),
(502,402,'Credit Card',25000,'Paid','2026-07-02'),
(503,403,'Debit Card',9000,'Paid','2026-07-03'),
(504,404,'UPI',700,'Paid','2026-07-04'),
(505,405,'Net Banking',5500,'Pending','2026-07-05'),
(506,406,'UPI',9000,'Paid','2026-07-06'),
(507,407,'Credit Card',1300,'Paid','2026-07-07'),
(508,408,'Cash on Delivery',1800,'Cancelled','2026-07-08'),
(509,409,'UPI',4200,'Paid','2026-07-09'),
(510,410,'Debit Card',4400,'Paid','2026-07-10'),
(511,411,'UPI',25000,'Paid','2026-07-11'),
(512,412,'Credit Card',65000,'Pending','2026-07-12');
desc payments;

#1. Display all products along with their prices and available stock.
select product_name,price,stock_quantity from products;

#2.Increase the price of all products in a particular category by 5%.
update products set price = 0.05 * price where category_id = 101;
desc products;
#3.Change the payment status of a pending payment to Paid.
set sql_safe_updates=1;
update payments set payment_status = 'paid' where payment_status = 'pending payment';
desc payments;
#3 Delete a cancelled order.
delete from orders where order_status = 'cancelled';
desc orders;
#5. Display all customer names in uppercase and lowercase.
select customer_name,upper(customer_name) as uppercase_name,lower(customer_name) as lowercase_name from customers;

#6. Display the first five characters of each product name.
select prod_name,  left(prod_name, 5) as  first_five_characters from products;
#7. Concatenate the customer name and city.
select * from customers;
select concat(c_name,city) as customer_details from customers;
#8. Replace the word Guide with Handbook in product names.
select prod_name,replace(prod_name,'guid','handbook') as updated_name from products;
# 9. Display last week orders.
select * from Orders where order_date >= date_sub(curdate(), interval 7 day) and order_date < curdate() + interval 1 day;# error
#10. Find the number of days since each order was placed.
select order_id, order_date, datediff(curdate(), order_date) as days_since_order from Orders;
#11. Display the payment date in DD-Mon-YYYY format.
select payment_id, date_format(payment_date, '%d-%b-%Y') as formatted_date from Payments;
#12. Display the month and year of every order.
select order_id, date_format(order_date, '%m%Y') as order_month_yesr from orders;
#13. Count the total number of products in each category.
select c.category_name,count(p.product_id) as total_products from products p inner join categories c on p.category_id = c.category_id group by c.category_id, c.category_name;
#14. Display the average product price for each category.
select c.category_name,avg(p.price) as average_price from categories c join products p on c.category_id=p.category_id group by c.category_name;
select c.category_name,(select avg(p.price) from products p where p.category_id = c.category_id) as average_price from categories c;
#15. Find the highest-priced product.
select product_name,price from products where price = (select max(price) from products);
#16. Display the total sales amount collected through each payment method
select payment_method,sum(payment_amount) as total_sales from payments where payment_status = 'paid' group by payment_method;
#17. Find the average quantity ordered for each product.
select p.product_name,avg(o.quantity) as average_quantity from products p join orders o on p.product_id=o.product_id group by p.product_id,p.product_name;
#18. Display customer names, product names, and order dates.
select c.customer_name,p.product_name,o.order_date from customers c inner join orders o on c.customer_id=o.customer_id inner join products p on o.product_id=p.product_id;
#19. Display customer names, ordered products, and payment status.
select c.customer_name,p.product_name,pay.payment_status from customers c join orders o on c.customer_id = o.customer_id join products p on 
o.product_id=p.product_id join payments pay on o.order_id=pay.order_id;
#20. Display customer names, product names, quantity ordered, and paymentamount.
select c.customer_name,p.product_name,o.quantity,pay.payment_amount from customers c join orders o on c.customer_id=o.customer_id join products p on
o.product_id=p.product_id join payments pay on o.order_id=pay.order_id;
#21. Display all products along with their category names, even if no orders have been placed for them.
select p.product_name,c.category_name from products p left join categories c on p.category_id=c.category_id;
#22. Display all customers and their order details.
select c.customer_name,o.order_id,o.quantity,o.order_date,o.order_status from customers c left join orders o on c.customer_id=o.customer_id;
#23. Display category names, product names, customer names, and order status in a single result.
select c.category_name,p.product_name,cu.customer_name,o.order_status from categories c join products p on c.category_id=p.category_id join
orders o on p.product_id=o.product_id join customers cu on o.customer_id=cu.customer_id;
#24. Find customers whose payment amount is greater than the average payment amount.
select c.customer_name,pay.payment_amount from customers c join orders o on c.customer_id=o.customer_id join payments pay on o.order_id=pay.order_id
 where pay.payment_amount>(select avg(payment_amount) from payments);
#25. Display the category that contains the most expensive product.
select c.category_name,p.product_name,p.price from categories c join products p on c.category_id =p.category_id where p.price = (select max(price) from Products);
#26. Find customers who purchased the highest-priced product.
select c.customer_name,p.product_name,p.price from customers c inner join orders o on c.customer_id=o.customer_id 
inner join products p on o.product_id = p.product_id order by p.price desc limit 1;
desc customers;
select * from customers;
select * from orders;
select * from products;
select * from categories;
select * from payments;
#27. Display products whose price is greater than the average price of all products.
(select avg(price) from products);
select product_name,price from products where price > (select avg(price) from products);

#28. Find customers who have never placed an order using NOT EXISTS.
select customer_name,customer_id from customers c where not exists(select 1 from orders o where o.customer_id = c.customer_id);
 
#29. Create a view named Customer_Order_Details displaying customer name, product name,quantity, order date, and payment status.
create view customer_order_details as select c.customer_name,p.product_name,o.quantity,o.order_date,pay.payment_status from customers c join orders o
on c.customer_id=o.customer_id join products p on o.product_id=p.product_id left join  payments pay on o.order_id = pay.order_id;
desc customers;
select * from customer_order_details;

#30. Create another view named Category_Sales_Report displaying category name, total products sold, and total sales amount.
drop view category_sales_report;
create view category_sales_report as select c.category_name,count(p.product_id), sum(pa.payment_amount) from categories c join 
products p on c.category_id=p.category_id join orders o on p.product_id=o.product_id join payments pa on pa.order_id=o.order_id group by c.category_id;
select * from category_sales_report; 
select * from categories;
select * from products;
select * from orders;
select  * from payments;


#31. Retrieve records from both views.
select * from customer_order_details;
select * from category_sales_report; 

#32. Start a transaction. Update the stock quantity of a product. Create a SAVEPOINT.
#Then update the payment status of an order. Roll back to the savepoint. Commit the transaction.
start transaction;
update products set stock_quantity = stock_quantity - 1 where product_id = 301;
desc products;
savepoint sp1;
update payments set payment_status = 'paid' where payment_id=501;
rollback to savepoint sp1;
commit;
select * from payments;
# 33.Create a stored procedure to display products whose stock quantity is below a given value.
 #• Input: stock_limit  • Display product name, price, and stock quantity.
 call low_stock_products(30);
 
 #34. Create a stored procedure to find the total number of orders placed by customers from a particular city. 
 #• Input: city  • Display the number of orders
 call city_orders('Hyderabad');
# 35 Create a stored procedure to display the details of a particular order.  
#• Input: order_id  • Display customer name, product name, quantity, order date, order status, and payment status.
call get_order_details(401);
select * from products;
#36. Create a trigger on the Products table. If someone tries to set stock_quantity to a negative value, set it to 0
update products set stock_quantity = -40 where product_id = 302;
#37. Create a trigger on the Orders table. Whenever a new order is placed, automatically reduce the corresponding products
 #stock_quantity based on the ordered quantity. 
 select * from orders;
 select product_id,product_name,stock_quantity from products where product_id=301;


 