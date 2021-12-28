			   
	/*===================================================
								 LOGICAL OPERATORS (AND,OR,NOT)
====================================================*/

	/* invoices tablosunda ülkesi (BillingCountry) USA olmayan kayıtları total değerine
	göre  AZALAN sırada listeyiniz */ 
			
SELECT *
FROM invoices
WHERE NOT BillingCountry='USA' --WHERE BillingCountry <> 'USA'
ORDER BY total DESC;
	
	
	/* invoices tablosunda, ülkesi (BillingCountry) USA veya Germany olan kayıtları, 
	InvoiceId sırasına göre artan sırada listeyiniz */ 
	
	SELECT *
	FROM invoices
	WHERE BillingCountry = 'USA' OR BillingCountry = 'Germany' --string ifadelerde casesesetive
	ORDER BY InvoiceId ASC;
	
	/* invoices tablosunda fatura tarihi (InvoiceDate) 01-01-2012 ile 03-01-2012 
	tarihleri arasındaki faturaların tüm bilgilerini listeleyiniz */ 
	
	SELECT *
	FROM invoices
	WHERE InvoiceDate >= '2012-01-01' AND InvoiceDate <= '2012-01-03' ;
	

	/* invoices tablosunda fatura tarihi (InvoiceDate) 01-01-2012 ile 02-01-2013 
	tarihleri arasındaki faturaların tüm bilgilerini listeleyiniz */
	
	
	SELECT *
	FROM invoices
	WHERE InvoiceDate >= '2012-01-01' AND InvoiceDate <= '2013-01-02' ;
	
	
	
	
	/* invoices tablosunda fatura tarihi (InvoiceDate) 2009 ila 2011 tarihleri arasındaki
	en yeni faturayı listeleyen sorguyu yazınız */ 
	
	SELECT*
	FROM invoices
	WHERE InvoiceDate BETWEEN '2009-01-01 00:00:00' AND '2011-12-3100:00:00'
	ORDER BY InvoiceDate DESC
	LIMIT 1 ;
	
	/*===================================================
								                   IN
====================================================*/
	/* customers tablosunda Belgium, Norway veya  Canada  ülkelerinden sipariş veren
		müşterilerin FirstName  LastName ve country bilgilerini listeyiniz	*/
	
	
	SELECT FirstName, LastName, country
	FROM customers 
	WHERE country IN ('Belgium', 'Norway', 'USA', 'Canada')
	ORDER BY FirstName ASC;
	 
	
	
	
	/*===================================================
								                    LIKE
====================================================*/
	/* tracks tablosunda Composer sutunu Bach ile biten kayıtların Name bilgilerini 
	listeyen sorguyu yazınız*/
	
	SELECT name, Composer
	FROM tracks
	WHERE Composer like '%bach'; 
	
	
	/* albulms tablosunda Title (başlık) sutununda Greatest içeren kayıtların tüm bilgilerini 
	listeyen sorguyu yazınız*/
	
	SELECT *
	FROM albums
	WHERE Title like '%Greatest%';
	
	/* invoices tablosunda, 2010 ve 2019 arası bir tarihte (InvoiceDate) Sadece şubat
	aylarında gerçekleşmiş olan faturaların	tüm bilgilerini listeleyen sorguyu yazınız*/
	
	SELECT *
	FROM invoices
	WHERE InvoiceDate like '201_-02%';
	
	
	
	/*customers tablosunda, ısımlerı (fırstname) uc harflı olan musterılerın fırstname, lastname, city, 
	adess bılgılerını lısteleyen sorguyu yazınız*/
	
	SELECT FirstName, LastName, City, Address
	FROM customers
	WHERE FirstName like '___';
	
	/* customers tablosunda soyısımlerı sch veya go ıle baslayan musterılerın fırstname lastname ve 
	cıty bılgılerını lısteleyen sorguyu yazınız*/

    SELECT FirstName, LastName, City
    FROM customers	
	WHERE LastName like  'Sch%' or LastName like 'Go%';
	
	