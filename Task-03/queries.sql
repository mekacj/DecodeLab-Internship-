-- Create a new database
Create database Internship

use Internship;

-- Import the .csv data using the import data function

-- Check if the rows are complete
select count(*)
from internship.dataset;

-- Preview and check for null 
select *
from Internship.dataset 
Limit 100;

select 
sum(case when couponcode is null then 1 else 0 end) as null_couponcode
from internship.dataset d ;

-- Total Revenue from all orders
select round(Sum(totalprice), 2) as total_revenue
from internship.dataset d;

-- revenue by product 
select product, 
	count(*) as total_orders,
	round(sum(totalprice), 2) as total_revenue
from internship.dataset d 
group by d.product 
order by total_revenue desc;

-- Best selling product by quantty sold
select product, Sum(d.quantity) as total_units_sold
	from internship.dataset d 
	group by d.product 
	order by total_units_sold desc;

-- How manu orders are in each status
select orderstatus, 
	count(*) as count, 
	round(count(*) * 100.0 / (select count(*) from internship.dataset), 1) as percentage
From internship.dataset
Group by orderstatus
order by count desc ;

-- Revenue lost to cancellations and returns
select orderstatus, round(sum(Totalprice),2) as lost_revenue
from internship.dataset d 
where orderstatus  in ('Cancelled','Returned')
group by d.orderstatus;

-- which referral source brings the most orders
select referralsource,
	count(*) as total_orders, 
	round(sum(totalprice),2) as total_revenue
from internship.dataset d 
group by referralsource 
order by total_orders desc;

-- which referral source has the most conversion (most delivered orders)
select referralsource,
	count(*) as deleivered_orders
from internship.dataset d 
where orderstatus = 'Delivered'
group by d.referralsource 
order by deleivered_orders desc;

-- How many orders used a coupon VS none?
select 
	case when couponcode is null then 'No Coupon' else CouponCode end as coupon,
	count(*) as total_orders,
	round(sum(totalprice),2) as total_revenue
from internship.dataset d 
group by coupon 
order by total_orders desc;

-- most popular payment methed 
select paymentmethod,
	count(*) as total_orders,
	round(sum(totalprice),2) as total_revenue
from internship.dataset d 
group by d.paymentmethod 
order by total_orders desc;

-- Top 10 customers by total spend
select customerid,
	count(*) as total_orders, 
	round(sum(totalprice),2) as total_spent
from internship.dataset d 
group by customerid
order by total_spent desc
limit 10;
