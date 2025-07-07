use pizza_db;
show tables;
select * from pizzas;
select * from order_details;
select * from pizza_types;
select * from orders;
#--------------------------------------------------------Querries--------------------------------------------------------------------#
#1List all unique pizza types available.
select distinct category from pizza_types; 

#2Show all the distinct pizza sizes.
select distinct size from pizzas;

#3Count how many different pizza types are offered in each category.
select category,count(name) as type_of_pizzas_in_category
from pizza_types
group by category;

#4Find the total number of orders placed.
select count(distinct order_id) as no_of_order_placed from order_details;

#5Which pizza was ordered the most times?
select pizza_id,sum(quantity) as most_ordered from
order_details
group by pizza_id
order by most_ordered desc limit 1;
#---------------------------------------------or----------------------------------------#
select p1.name as most_ordered_pizza,sum(order_details.quantity) as quantity_ordered
from pizza_types as p1
join pizzas as p2
on p1.pizza_type_id=p2.pizza_type_id
join order_details
on order_details.pizza_id=p2.pizza_id
group by p1.name order by quantity_ordered desc limit 1;

#6Which pizza category has the highest total sales quantity?
select p1.category as pizza_category,sum(ord.quantity) as quantity_ordered
from pizza_types as p1
join pizzas as p2
on p1.pizza_type_id=p2.pizza_type_id
join order_details as ord
on ord.pizza_id=p2.pizza_id
group by p1.category order by quantity_ordered
desc limit 1;

#7Find the top 5 most ordered pizzas by quantity
select p1.name as pizza_name,sum(ord.quantity) as quantity_ordered
from pizza_types as p1
join pizzas as p2
on p1.pizza_type_id=p2.pizza_type_id
join order_details as ord
on p2.pizza_id=ord.pizza_id
group by pizza_name order by
quantity_ordered desc limit 5;

#8What is the total quantity of pizzas ordered across all orders?
select sum(ord.quantity) as total_quantity 
from order_details as ord;

#9Show the total quantity sold for each pizza size.
select p.size as pizza_size,sum(ord.quantity) as quantity_ordered
from pizzas as  p
join order_details as ord 
on p.pizza_id=ord.pizza_id
group by pizza_size
order by quantity_ordered;

#10Calculate total revenue generated.
select round(sum(order_details.quantity*pizzas.price),2) as total_revenue
from pizzas
join order_details
on pizzas.pizza_id=order_details.pizza_id;

#11Which pizza generated the highest revenue?
select p1.name as pizza_name,sum(ord.quantity*p2.price) as revenue
from pizza_types as p1
join pizzas as p2
on p1.pizza_type_id=p2.pizza_type_id
join order_details as ord
on ord.pizza_id=p2.pizza_id
group by pizza_name
order by revenue desc limit 1;

#12What is the average revenue per order?
select round(avg(ord.quantity*p.price),2) as avg_revenue
from pizzas as p
join order_details as ord
on ord.pizza_id=p.pizza_id;

#13Show monthly sales revenue
select month(od.date) as ord_month,round(sum(ord.quantity*p.price),2) as sale
from pizzas as p
join order_details as ord
join orders as od
on ord.order_id=od.order_id
group by ord_month 
order by sale;

#14Find the number of pizzas sold by each category.
select p1.category as pizza_category, sum(ord.quantity) as no_of_pizza
from pizza_types as p1
join pizzas as p2
on p1.pizza_type_id=p2.pizza_type_id
join order_details as ord
on p2.pizza_id=ord.pizza_id
group by pizza_category
order by no_of_pizza;

#15Show the number of orders that contain more than 3 pizzas.
select count(*) as orders_with_more_than_3_pizza
from(
select
orders.order_id,sum(quantity) as total_pizza from
order_details as ord
join orders
on orders.order_id=ord.order_id
group by order_id
having total_pizza>3) as sub;

#16Find orders where only one type of pizza was ordered.
select order_id 
from order_details
group by order_id
having
count(distinct pizza_id)=1;

#17Show daily order count for the past week.
select date(date) as past_week_order,
count(order_id) as order_details
from orders
where 
date>=curdate()-interval 7 day
group by date(date)
order by past_week_order;

#18Compare weekend vs. weekday order volumes.
select 
case when dayofweek(date) in (1,7)
then "weekend"
else "weekday"
end as day_types, count(*) as order_volumes
from orders 
group by day_types;

#19What is the most popular pizza on Fridays?
select p1.name as pizza_name, sum(ord.quantity) as order_quantity
from orders as o
join order_details as ord
on ord.order_id=o.order_id
join pizzas as p2
on p2.pizza_id=ord.pizza_id
join pizza_types as p1
on p1.pizza_type_id=p2.pizza_type_id
where dayofweek(o.date)=6
group by p1.name
order by order_quantity desc limit 1;

