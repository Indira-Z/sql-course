SELECT c.CustomerId,
       c.FirstName,
       c.LastName,
       c.City,
       c.Company
FROM   Customer AS c
WHERE 
-- c.City IN ( 'London','Paris','Rome','Berlin') AND
-- c.LastName LIKE 'S%'
c.Company IS NOT NULL
ORDER BY 
c.Company
-- c.LastName DESC
;

SELECT --top 3 
c.Country, COUNT(*) as NumberOfCustomers 
FROM Customer AS c
GROUP BY c.Country
ORDER BY c.Country DESC
;

SELECT
/* i.InvoiceId,
       i.InvoiceDate,
       i.CustomerId,
       i.Total*/
       i.CustomerId, 
       i.BillingCountry , 
       SUM(i.Total) AS InvoiceTotal
FROM   Invoice AS i
GROUP BY i.CustomerId, i.BillingCountry
ORDER BY i.CustomerId, i.BillingCountry
;