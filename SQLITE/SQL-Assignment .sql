Assignment - 1

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


	/*Assignment - 2 (SQL | Aggregate Functions & JOINs)

	1-How many tracks does each album have? Your solution should include 
	Album id and its number of tracks sorted from highest to lowest.*/
	
	/*!! albumid leri ayni olan kac tane name var sayidr ve bunu name e gore azalan sirala*/
	
	SELECT AlbumId,count(name)as parca_sayisi
	FROM tracks
	group by AlbumId
	ORDER By  parca_sayisi DESC;

	/*2-Find the album title of the tracks. Your solution should include track name and its album title.
	tracks tablosu ve albums tablosunu coin ile birlestir name ve title sutunlarini listele*/
	

	SELECT * FROM tracks;
	SELECT * FROM albums;
	
	SELECT t.name, a.Title, a.AlbumId
	FROM tracks t
	JOIN albums a
	on a.AlbumId = t.AlbumId;
	
	
	/*3-Find the minimum duration of the track in each album.
	Your solution should include album id, album title and duration of the track
	sorted from highest to lowest.
	her albumun icindeki en kisa Milliseconds bul AlbumId Title Milliseconds olarak listele AlbumId desc olsun */

	
	SELECT a.AlbumId, a.Title, min(t.Milliseconds)as an_kisa_parca
	FROM tracks t
	JOIN albums a
	on a.AlbumId = t.AlbumId
	GROUP by a.Title
	ORDER by a.AlbumId DESC;
		
		
	/* 4- Find the total duration of each album. 
	Your solution should include album id, album title and its total duration sorted from highest to lowest.
	her albumdeki parcalarin suresinin toplamin bul AlbumId Title ve avg Milliseconds olarak listele*/
	
	
	SELECT a.AlbumId, a.Title, sum(t.Milliseconds) as toplam_sure
	FROM tracks t
	JOIN albums a
	on t.AlbumId = a.AlbumId
	GROUP BY a.AlbumId
	ORDER by toplam_sure DESC;
	
	
	
	/* 5- Based on the previous question, find the albums whose total duration is higher than 70 minutes. 
	Your solution should include album title and total duration*/
	
	
	SELECT a.Title, sum(t.Milliseconds) as toplam_sure
	FROM tracks t
	JOIN albums a
	on a.AlbumId = t.AlbumId
	GROUP by a.Title
	HAVING toplam_sure > 4200000;
	
	/*Assignment - 3 (SQL | Subqueries and DDL-DML Commands)*/
	
		/*Write a query to find the maximum duration among the tracks. 
		Your query should include TrackId, Name, Milliseconds.*/
	SELECT TrackId, name, Milliseconds 
	FROM tracks
	WHERE Milliseconds  in(SELECT max(Milliseconds) from tracks);

	/*Write a query to find the minimum duration among the tracks.
	Your query should include TrackId, Name, Milliseconds.*/
	
	SELECT TrackId, name, Milliseconds 
	FROM tracks
	WHERE Milliseconds  in(SELECT min(Milliseconds) from tracks);

	/*Write a query to find the tracks whose bytes are higher than the average of the bytes of all tracks.
	Your query should include TrackId, Name, Bytes, general average and should be ordered by Bytes from highest to lowest. 
	General average is the average of all tracks. General average should repeat in every row. 
	(Hint: You need to use two subqueries)*/


	SELECT TrackId, name, Bytes 
	FROM tracks
	WHERE Bytes >(SELECT avg(Bytes) from tracks)
	ORDER by Bytes DESC;
	
	/*Write a query that returns the customers whose sales representatives are Jane Peacock and Margaret Park. 
	Your query should include CustomerID, First Name and Last Name of the customers.
	Satış temsilcileri Jane Peacock ve Margaret Park olan müşterileri döndüren bir sorgu yazın. 
    Sorgunuz, müşterilerin Müşteri Kimliği, Adı ve Soyadı'nı içermelidir.*/
	
	SELECT CustomerId, FirstName, LastName, SupportRepId
	FROM customers
	WHERE SupportRepId in (SELECT EmployeeId
	                     FROM employees
						 WHERE FirstName = 'Jane' or FirstName = 'Margaret');
						 
	/*Rewrite the subquery above using the JOIN.*/

    SELECT c.CustomerId, c.FirstName, c. LastName,e.FirstName
	FROM customers c
	JOIN employees e
	on e.EmployeeId = c.SupportRepId
	WHERE e.FirstName = 'Jane' or e.FirstName = 'Margaret';


	/*Create a table inside the chinook database. This table tracks the employees’ courses inside the organization. Your table should have the followings features:

               Name of the table: courses
               Columns:
                    CourseId (Primary Key)
                    CourseName (Cannot be null)
                    EmployeeId (Foreign Key - Refers to EmployeeId of employees table ) 
                    CoursePrice*/
					
					
	CREATE TABLE  if not EXISTS courses (
		CourseId INTEGER,
		CourseName NOT NULL,
		EmployeeId INTEGER,
		CoursePrice INTEGER,
		PRIMARY KEY (CourseId),
		FOREIGN KEY (EmployeeId) REFERENCES employees (EmployeeId)
		
		);
		
		/*Insert at least 5 rows into the courses table.
		Your EmployeeId should contain the values of the EmployeeId column on the employees table. 
		You’re free to choose any values for other columns (CourseId, CourseName, CoursePrice)
		
		
		Dersler tablosuna en az 5 satır ekleyin. 
		Çalışan Kimliğiniz, çalışanlar tablosundaki Çalışan Kimliği sütununun değerlerini içermelidir. 
		Diğer sütunlar için herhangi bir değer seçmekte özgürsünüz (CourseId, CourseName, CoursePrice)*/
		
		
		INSERT INTO courses VALUES (12, 'matematik', 8, 5000);
		INSERT INTO courses VALUES (13, 'fizik', 7, 4000);
		INSERT INTO courses VALUES (14, 'kimya', 6, 7000);
		INSERT INTO courses VALUES (15, 'biyoloji', 5, 1000);
		INSERT INTO courses VALUES (16, 'ingilizce', 1, 3000);
		
		
	/*Delete the last row of your courses table.*/	
	DELETE
	FROM courses
	WHERE EmployeeId = 1;
	
	/*Add a new column to your courses table named StartDate. The new column cannot be null.*/	
		
		
	ALTER TABLE courses 
    ADD StarDate TEXT NOT NULL;
	
	/*Delete the CoursePrice column.*/
	
	ALTER TABLE courses
	DROP COLUMN CoursePrice;
	
	/*Delete the courses table.*/
	
	DROP TABLE if EXISTS courses;