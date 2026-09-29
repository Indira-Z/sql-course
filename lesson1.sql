SELECT c.CustomerId,
       c.FirstName,
       c.LastName,
       --c.FirstName + ' ' + c.LastName AS CustomerName,
       CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
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
       c.FirstName,
       c.LastName,
       CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
       --i.BillingCountry , 
       SUM(i.Total) AS InvoiceTotal,
       COUNT(*) AS NumberOfInvoices
FROM   Invoice AS i INNER JOIN Customer AS c ON i.CustomerId = c.CustomerId
GROUP BY i.CustomerId, c.FirstName, c.LastName, CONCAT(c.FirstName, ' ', c.LastName) --, i.BillingCountry
ORDER BY i.CustomerId --, i.BillingCountry
;

--*****************************************
SELECT
    i.CustomerId,
    SUM(i.Total) As InvoiceTotal,
    COUNT(*) AS NumberOfInvoices
FROM   Invoice AS i
group by i.CustomerId
order by i.CustomerId;

-- Alternative way
SELECT ibc.CustomerId, 
       CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
       ibc.InvoiceTotal, ibc.NumberOfInvoices
FROM (
SELECT
    i.CustomerId,
    SUM(i.Total) As InvoiceTotal,
    COUNT(*) AS NumberOfInvoices
FROM Invoice AS i
group by i.CustomerId
) AS ibc JOIN Customer c ON ibc.CustomerId = c.CustomerId
--order by i.CustomerId;
;

-- Customers and employees
SELECT e.EmployeeId,
    --   e.FirstName,
      -- e.LastName,
       CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
       CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName
FROM   Employee AS e JOIN Customer c on e.EmployeeId = c.SupportRepId;

SELECT ibc.CustomerId, 
       CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
       CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
       ibc.InvoiceTotal, ibc.NumberOfInvoices
       --e.EmployeeId, --e.FirstName, e.LastName
 FROM (
SELECT
    i.CustomerId,
    SUM(i.Total) As InvoiceTotal,
    COUNT(*) AS NumberOfInvoices
FROM Invoice AS i
group by i.CustomerId
) AS ibc JOIN Customer c ON ibc.CustomerId = c.CustomerId
JOIN Employee e ON c.SupportRepId = e.EmployeeId
--order by i.CustomerId;
;