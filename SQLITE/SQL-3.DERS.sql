/*===================================================
	AGGREGATE FUNCTION COUNT,SUM,MIN,MAX, AVG)
====================================================*/
	
	-- COUNT
	
	-- saydırma yaparken sectıgımız stunda NULL varsa bunları saymaz
	-- saydırma yaparken PK saymak daha kullanıslıdır cunku PK NULL olamaz
	-- stunda kactane NULL var saymak ıcın:
	--SELECT count*
	  -- FROM students
	   --WHERE LastName IS NULL; 
	  
	
	---null kendını bııle ınkar eder olmayanı olmayanla kıyaslayamazsın
	--- NULL != NULL NULL 
	-------------------------------------------------------------------------------------------------	
	--- count(*) fonksıyonu null ları da sayar
	
	
	-- AS (Alias) daha anlamlı sorgu sonucu lıstelemek ıcın kullanılır 
	-- best !! 
	--stun kısaltmalarında as kullan tablo kısaltmalarında kullanma
	
	
	/* invoices tablosunda kaç adet fatura bulunduğunu döndüren sorgu*/
	
	
	SELECT count(*)
	FROM invoices;
	
	
	SELECT count(InvoiceId) AS fatura_sayısı  -- ınvoıceId PK oldugu ıcın sonuc tum sorguyla(*) aynı
	FROM invoices;         -- as den sonra lıstelerken cıkacak kısmı yazık
	
	SELECT count(BillingState)  --- PK olmadıgı ıcın sayı farklı aradakı fark NULL
	FROM invoices;
	
	/* tabloda PK oldugubu nasıl anlıyoruz
	tabloda ustunda sarı anahtar ısaretı var*/
	-- grı anahtar Foregin Key== tablolar arasındakı ılskıyı kurar
	-- tablolar arasonda ılıskı kurulduysa (anne-cocuk ) bırı sılınrse dıgerıde degersız olur
	-- bu durumda dıger tabloyu sılmemesı ıcın ınlemler tablo olusturulurken yazılır.
	
	
	
	/* tracks tablosunda kaç adet farklı Composer bulunduğunu
	döndüren sorguyu yazınız*/
	
	
	SELECT count( Composer) AS besteci_sayısı_tekrarlı
	FROM tracks ;
	
	SELECT count (DISTINCT Composer) AS besteci_sayısı_tekrarsız
	FROM tracks ;
	
	
	-- MIN,MAX
	
	-- numerık degerlerde calısır strıngde kullanılmaz.
	-- WHERE ıle bellı bır alanı kısıtlayıp kullanabılırız
	
	-------------------------------------------------------------------------------------------------	
	/* tracks tablosundaki şarkı süresi en kısa olan şarkının adını ve süresi listeleyen
	sorguyu yaziniz */
	-- duration :sarkı suresı
	
	SELECT name AS song_name, min (Milliseconds) as duration
	FROM tracks ;
	
	
	/* student tablosundakı en dusuk ve en yuksek notu lısteleyen sorguyu yazınız*/
	
	SELECT min(Grade), max(Grade)
	FROM students ;
	
	
	-- SUM(toplam),AVG(ortalama)
	-------------------------------------------------------------------------------------------------	
	/* invoices  tablosundaki faturaların toplam değerini listeyiniz */
	
	
	SELECT sum(total) as toplam_gelir
	FROM invoices;
	
	
	
	/* ÖDEV: invoices  tablosunda 2009 ile 2013 tarihileri arasındaki 
	faturaların toplam değerini listeyiniz */
	
	SELECT sum(total) as '2009-2013_arası_toplam_gelir'
	FROM invoices
	WHERE '2009-01-01' AND '2013-12-31' ;
	
	
	/* invoices  tablosundaki faturaların ortalama değerini listeyiniz */
	
	
	SELECT round(AVG(total),2) AS ortalama_gelir   -- round yuvarlama yapar , den sonra ıstedıgın kara sayı alabılırsın
	FROM invoices;
	
	
	
	
	/* tracks tablosundaki şarkıların ortalama süresinden daha uzun olan 
	şarkıların adlarını listeleyiniz */
	
	SELECT ROUND(AVG(Milliseconds))
	FROM tracks;
	
	SELECT Name, Milliseconds
	FROM tracks
	WHERE Milliseconds > 393599;
	
	/*Bu yöntem hard-coded olduğu için çok mantıklı bir çözüm değil. 
	alt-sorgu(sub-query) ile daha doğru bir yaklaşım olacaktır sonraki 
	bölümlerde alt-sorguyu ayrıntılı bir şekilde inceleyeceğiz.*/
	
	
	
	SELECT name, Milliseconds
	FROM tracks
	WHERE Milliseconds > (SELECT round(avg(Milliseconds),3)
	                      FROM tracks);
						  
						  
		/*===================================================
           GROUP BY
          ====================================================*/
--- grup olusturmamıza yarar
--WHERE ın altında
--order by ın ustunda yazılır.
--- genelde count max mın avg gıbı agragede fonksıyonlarla kullanılır

	/* tracks tablosundaki her bir Bestecisinin (Composer) toplam şarkı sayısını 
	Besteci adına göre gruplandırarak listeleyen sorguyu yazınız. */				  
						  
		
SELECT Composer, count(name) as song_count
FROM tracks
WHERE Composer IS NOT NULL   --- null olanları gormek ıstemıyorsan ekle
GROUP BY Composer;


/* customers tablosundaki müşterilerin sayılarını Ülkelerine (Country) göre gruplandırarak 
	ve müşteri sayısına göre AZALAN şekilde sıralayarak listeleyen sorguyu yazınız*/
	
	SELECT country, count(FirstName)as nu_of_customer
	FROM customers
	GROUP BY country
	ORDER BY nu_of_customer DESC;  -- buyukten kucuge dogru sırala fırstname ı 
	
	/* customers tablosundaki müşterilerin sayılarını Ülkelerine (Country) ve Şehirlerine (City) 
	göre gruplandırarak listeleyen sorguyu yazınız*/
	
SELECT country, City,count(FirstName)
FROM customers
GROUP BY country, City;

		/* invoices tablosundaki her bir ülkenin (BillingCountry) fatura ortalamalarını 
	hesaplayan ve ülke bilgileri ile listeleyen sorguyu yazınız.*/
	
	
	
	
	SELECT BillingCountry, round(avg(total),2) as ort_fatura
	FROM invoices
	GROUP BY BillingCountry;
	
	-- aralık verseydı (2009-2011 arası)
	
	SELECT BillingCountry, round(avg(total),2) as ort_fatura
	FROM invoices
	WHERE InvoiceDate BETWEEN '2009-01-01' and '2011-12-31 23:59:59'
	GROUP BY BillingCountry;
	
	
	
	
	
	/*===================================================
        JOINS
      ====================================================*/
    
--     Join islemleri farkli tablolardan secilen sutunlar ile yeni bir tablo 
--     olusturmak icin kullanilabilir.
--     
--     JOIN islemleri Iliskisel Veritabanlari icin cok onemli bir ozelliktir. Çunku
--    	Foreign Key'ler ile iliskili olan tablolardan istenilen sutunlari cekmek 
--     icin JOIN islemleri kullanilabilir.

--     Standart SQL'de en çok kullanılan Join islemleri:
--   	1) FULL JOIN: BİRLEŞİM: Tablodaki tum sonuclari gosterir
--     2) INNER JOIN: KESİŞİM: Tablolardaki ortak olan sonuc kumesini gosterir
--     3) LEFT JOIN:  SOL: Ilk tabloda (Sol) olup digerinde olmayan sonuclari gosterir
--     4) RIGHT JOIN: SAG: Sadece Ikinci tabloda olan tum sonuclari gosterir.

--		NOT: SQLite Sadece INNER, LEFT VE CROSS JOIN İşlemlerini desteklemektedir.
 
 /*===================================================*/   

  /* araclar.db adındaki veritabanını kullanarak Markalar ve Siparisler tablolarındaki 
 marka_id'si ayni olan kayıtların marka_id, marka_adi, siparis_adedi ve siparis_tarihi   
 bilgilerini  listeleyen bir sorgu yaziniz.*/
	SELECT * FROM siparisler;
	SELECT * FROM markalar;
	
	SELECT markalar.marka_id,markalar.marka_adi,
	       siparisler.siparis_adedi, siparisler.siparis_tarihi
	FROM markalar
	JOIN siparisler  --- default ınner joın
	ON markalar.marka_id = siparisler.marka_id;
	
	--left joın ıle
	SELECT markalar.marka_id,markalar.marka_adi,
	       siparisler.siparis_adedi, siparisler.siparis_tarihi
	FROM markalar
	LEFT JOIN siparisler  --- default ınner joın
	ON markalar.marka_id = siparisler.marka_id;
	
	/*kisaltmalarla*/
	SELECT m.marka_id,m.marka_adi,
	       s.siparis_adedi, s.siparis_tarihi
	FROM markalar m
	left JOIN siparisler s --- default ınner joın
	ON m.marka_id = s.marka_id;