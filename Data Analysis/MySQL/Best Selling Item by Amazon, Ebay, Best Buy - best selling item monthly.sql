-- Best Selling Item by Amazon, Ebay, Best Buy
-- Reference: https://platform.stratascratch.com/coding/10172-best-selling-item?code_type=3

-- Find the best selling item for each month (no need to separate months by year) where the biggest total invoice was paid.
-- The best selling item is calculated using the formula (unitprice * quantity). 
-- Output the month, the description of the item along with the amount paid.

with CTE1 as
(select month(invoicedate) as month_only, description, SUM(quantity * unitprice) as total_invoice, dense_rank() OVER(partition by month(invoicedate) order by SUM(quantity * unitprice) desc)as month_rank
from online_retail
group by month_only, description
)
select month_only, description, total_invoice
from CTE1
where month_rank = 1
group by month_only
order by month_only
;