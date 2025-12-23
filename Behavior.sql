use behave

select count(Customer_ID) from shpbhv

select avg(Purchase_Amount_USD) from shpbhv

select min(Previous_Purchases) from shpbhv

select max(Previous_Purchases) from shpbhv

select avg(Previous_Purchases) from shpbhv

select sum(Purchase_Amount_USD) from shpbhv

select * from shpbhv order by Purchase_Amount_USD desc

-- select count(Customer_ID) as jumlahcustomer, avg(Purchase_Amount_USD) as rataratabelanja, min(Previous_Purchases) as minprev, max(Previous_Purchases) as maxprev, avg(Previous_Purchases) as ratarataprev, sum(Purchase_Amount_USD) as totalbelanja from shpbhv group by Customer_ID Order By Purchase_Amount_USD desc

create view segmen as
select Customer_ID,Previous_Purchases,Review_Rating,Subscription_Status,Purchase_Amount_USD,
case
when Purchase_Amount_USD Between 20 and 40 then 'Low'
when Purchase_Amount_USD between 41 and 80 then 'Medium'
when Purchase_Amount_USD > 80 then 'High'
else null 
end as spender from shpbhv;

select spender, 
count(Customer_ID) as jumlahcustomer,
avg(Previous_Purchases) as ratarataprev 
from segmen group by spender

select spender, 
count(Customer_ID) as jumlahcustomer,
count(Subscription_status) as Langganan,
avg(Previous_Purchases) as ratarataprev 
from segmen where Subscription_Status = 'yes' group by spender

SELECT 
    spender,
    COUNT(*) AS total_customer,
    SUM(CASE WHEN Subscription_Status = 'Yes' THEN 1 ELSE 0 END) AS total_subscriber,
    CAST(SUM(CASE WHEN Subscription_Status = 'Yes' THEN 1 ELSE 0 END) AS FLOAT) 
        / COUNT(*) * 100 AS subscription_rate_percent
FROM segmen
GROUP BY spender
ORDER BY subscription_rate_percent DESC;