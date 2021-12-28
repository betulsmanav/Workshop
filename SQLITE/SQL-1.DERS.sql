/* tracks tablosundaki track isimlerini(name)
 sorgulayiniz*/
SELECT name FROM tracks;

/* tracks tablosundaki track isimlerini(name) 
sorgulayiniz*/
SELECT Composer,name FROM tracks;

/* tracks tablosundaki tum bilgileri sorgulayiniz*/
SELECT * FROM tracks;


/* tracks tablosundaki composer bilgileri  sorgulayiniz*/
SELECT Composer FROM tracks;

/* tracks tablosundaki tum bilgileri sorgulayiniz (tekrarsiz)_*/
SELECT DISTINCT Composer FROM tracks;

/* tracks tablosundaki albumId ve mediaId tekrarsiz sorgulayiniz*/
SELECT DISTINCT AlbumId,MediaTypeId FROM tracks;

/* composer i jimi henriks olan sarkilari sorgula*/
SELECT name 
FROM tracks 
WHERE Composer = "Jimi Hendrix";

/* invoices tablosundaki total degeri 10$ dan buyuk olan 
 tum degerleri goster*/
 
 SELECT * 
 FROM invoices 
 WHERE total>10;
 
 
 
 


======= LIMIT=====

/*invoices tablosunda Total değeri 10$'dan büyük olan ilk 4 kayıt'ın InvoiceId, 
	InvoiceDate ve total bilgilerini sorgulayiniz */

SELECT InvoiceId, InvoiceDate, total
 FROM invoices
 WHERE total>10
 LIMIT 4;

===order by===

/*invoices tablosunda Total değeri 10$'dan büyük olan kayıtları Total değerine göre 
	ARTAN sırada sıralayarak sorgulayiniz */
	
SELECT * 
FROM invoices 
WHERE total >10 
ORDER BY total ASC; -- order by komutunun default u asc dir

/*invoices tablosunda Total değeri 10$'dan büyük olan kayıtlardan işlem tarihi 
	(InvoiceDate) 	en yeni olan 10 kaydın tüm bilgilerini listeyiniz
 (yani buyukten kucuge sirala) 	*/ 

SELECT * 
FROM invoices 
WHERE total >10 
ORDER BY InvoiceDate DESC
LIMIT 10;
