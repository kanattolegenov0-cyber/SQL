SELECT ID_client
FROM transactions
WHERE date_new BETWEEN '2015-06-01' AND '2016-06-01'
GROUP BY ID_client
HAVING COUNT(DISTINCT DATE_FORMAT(date_new, '%Y-%m')) = 12;
 


SELECT 
    ID_client,
    DATE_FORMAT(date_new, '%Y-%m') AS month,
    COUNT(*) AS operations_count,
    SUM(Sum_payment) AS total_amount,
    AVG(Sum_payment) AS avg_check
FROM transactions
WHERE ID_client IN (
    SELECT ID_client
    FROM transactions
    WHERE date_new BETWEEN '2015-06-01' AND '2016-06-01'
    GROUP BY ID_client
    HAVING COUNT(DISTINCT DATE_FORMAT(date_new, '%Y-%m')) = 12
)
GROUP BY ID_client, DATE_FORMAT(date_new, '%Y-%m')
ORDER BY ID_client, month;

select 
date_format(date_new, '%Y-%m') as month,
avg(Sum_payment) as AVG_check
from transactions
group by date_format(date_new, '%Y-%m')
order by date_format(date_new, '%Y-%m');

select 
sum(Sum_payment)
from transactions;

select 
count(ID_check)/count(distinct date_format(date_new, "%Y-%m")) as avg_count_check
from transactions
where date_new between '2015-06-01' and '2016-06-01';

select 
count(ID_check)/12 as avg_count_check
from transactions;



SELECT 
    t.ID_client,
    AVG(t.Sum_payment) AS avg_sum_pay_month,
    COUNT(t.ID_check)/12 AS avg_count_check
FROM transactions t
WHERE t.date_new BETWEEN '2015-06-01' AND '2016-06-01'
  AND t.ID_client IN (
      SELECT ID_client
      FROM transactions
      WHERE date_new BETWEEN '2015-06-01' AND '2016-06-01'
      GROUP BY ID_client
      HAVING COUNT(DISTINCT DATE_FORMAT(date_new, '%Y-%m')) = 12
  )
GROUP BY t.ID_client
ORDER BY t.ID_client;


SELECT AVG(client_count) AS avg_clients_per_month
FROM (
    SELECT 
        date_format(date_new, "%y-%m") AS month,
        COUNT(DISTINCT ID_client) AS client_count   
    FROM transactions
    WHERE date_new >= '2015-06-01' 
      AND date_new <  '2016-06-01'
    GROUP BY date_format(date_new, "%y-%m") 
) t;

select 
count(ID_check)
from 
transactions;

SELECT 
    ID_client,
    client_count,
    client_count * 1.0 / total_count AS share_of_year
FROM (
    SELECT 
        ID_client,
        COUNT(ID_check) AS client_count,
        (SELECT COUNT(ID_check) 
         FROM transactions 
         WHERE date_new BETWEEN '2015-06-01' AND '2016-06-01') AS total_count
    FROM transactions
    WHERE date_new BETWEEN '2015-06-01' AND '2016-06-01'
    GROUP BY ID_client
) t;



SELECT 
    ID_client,
    MONTH(date_new) AS month,
    SUM(Sum_payment) / SUM(SUM(Sum_payment)) OVER (PARTITION BY MONTH(date_new)) AS share_of_month
FROM transactions
WHERE date_new BETWEEN '2015-06-01' AND '2016-06-01'
GROUP BY ID_client, MONTH(date_new);


select 
Gender,
date_format(t.date_new, '%m') as month,
sum(Sum_payment)/
(select 
sum(Sum_payment)
from transactions
where date_new between '2015-06-01' AND '2016-06-01') as Total_sum
from transactions t
join customers c
on c.Id_client = t.ID_client
group by Gender, date_format(t.date_new, '%m')
order by date_format(t.date_new, '%m');


select 
sum(Sum_payment)
from transactions
where date_new between '2015-06-01' AND '2016-06-01';

Select 
	case 
    when Age between 0 and 10 Then '0-10'
    when Age between 11 and 20 Then '11-20'
    when Age between 21 and 30 Then '21-30'
    when Age between 31 and 40 Then '31-40'
    when Age between 41 and 50 Then '41-50'
    when Age between 51 and 60 Then '51-60'
    when Age between 61 and 70 Then '61-70'
    when Age between 71 and 80 Then '71-80'
    when Age between 81 and 90 Then '81-90'
	else 'Unknown'
END AS Age_group,
count(t.Id_client) as Client_count,
SUM(Sum_payment) as total_sum,
Count(Sum_payment) count_sum,
SUM(Sum_payment)/(
select sum(Sum_payment)
from transactions
where date_new between '2015-06-01' AND '2016-06-01') as Procent_of_sum,
Count(Sum_payment)/(
select count(Sum_payment)
from transactions
where date_new between '2015-06-01' AND '2016-06-01') as Procent_of_count
from transactions t
join customers c
on t.ID_client = c.Id_client
group by Age_group
order by Age_group; 


Select 
	case 
    when Age between 0 and 10 Then '0-10'
    when Age between 11 and 20 Then '11-20'
    when Age between 21 and 30 Then '21-30'
    when Age between 31 and 40 Then '31-40'
    when Age between 41 and 50 Then '41-50'
    when Age between 51 and 60 Then '51-60'
    when Age between 61 and 70 Then '61-70'
    when Age between 71 and 80 Then '71-80'
    when Age between 81 and 90 Then '81-90'
	else 'Unknown'
END AS Age_group,
year(date_new) as year,
quarter(date_new) as quarter,
avg(Sum_payment) as avg_sum_quarter
from transactions t
join customers c
on t.ID_client=c.Id_client
group by year(date_new), quarter(date_new), Age_group
order by year(date_new), quarter(date_new), Age_group;

