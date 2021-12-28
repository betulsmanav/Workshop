/*1. Write a query that displays InvoiceId, CustomerId and total dollar amount 
for each invoice, sorted first by CustomerId (in ascending order),
and then by total dollar amount  (in descending order).*/
 
SELECT InvoiceId, CustomerId, total
FROM invoices
ORDER BY CustomerId ASC, total DESC;

/*2. Write a query that displays InvoiceId, CustomerId and total dollar amount for each invoice,
 but this time sorted first by total dollar amount (in descending order), 
 and then by CustomerId (in ascending order).*/

SELECT InvoiceId, CustomerId, total
from invoices
ORDER BY total DESC, CustomerId ASC;

/*3. Compare the results of these two queries above. 
How are the results different when you switch the column you sort on first?
 (Explain it in your own words.)*/
 
 /*her iki tabloda 412 rows dondurdu

babloda sutunlarin sergilenme sirasi degismedi (once customerId sonra total)

birinci sorguda customerid nin siralamasini once yapti sonra total degerlerini aralarinda siraladi

ikinci sorguda tam tersi sonuc oldu

yani yazim sirasina gore oncelik olusturuyor. */



 
/*4. Write a query to pull the first 10 rows and all columns 
from the invoices table that have a dollar
 amount of total greater than or equal to 10*/
 
 
 SELECT *
 FROM invoices
 WHERE total >= 10
 LIMIT 10;
 
 /*5. Write a query to pull the first 5 rows and 
 all columns from the invoices table that
 have a dollar amount of total less than 10.*/
 
 SELECT *
 FROM invoices
 WHERE total < 10
 LIMIT 5;
 
/*Find all track names that start with 
'B' and end with 's'.*/

SELECT name
FROM tracks
WHERE name like 'B%' AND name like '%s';


/*7. Use the invoices table to find all 
information regarding invoices whose billing 
address is USA or Germany or Norway or Canada
 and invoice date is at any point in 2010, 
 sorted from newest to oldest.*/
 
 
SELECT BillingCountry, InvoiceDate
FROM  invoices
WHERE (BillingCountry IN('USA', 'Germany', 'Norway', 'Canada')) AND (InvoiceDate  BETWEEN '2010-01-01 00:00:00'  AND  '2010-12-31 00:00:00')
ORDER by InvoiceDate desc;