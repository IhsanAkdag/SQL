-- DISTINCT KULLANIMI

CREATE TABLE musteri_urun 
(
id int, 
musteri_isim varchar(50),
maas int,
Primary Key (id,musteri_isim)    
);

INSERT INTO musteri_urun VALUES (10, 'Ali', 5000); 
INSERT INTO musteri_urun VALUES (10, 'Ali', 7500); 
INSERT INTO musteri_urun VALUES (20, 'Veli', 10000); 
INSERT INTO musteri_urun VALUES (30, 'Ayse', 9000); 
INSERT INTO musteri_urun VALUES (20, 'Ali', 6500); 
INSERT INTO musteri_urun VALUES (10, 'Adem', 8000); 
INSERT INTO musteri_urun VALUES (40, 'Veli', 8500); 
INSERT INTO musteri_urun VALUES (20, 'Elif', 5500);

SELECT * FROM musteri_urun

-- Musteri urun tablosundan musteri isimlerini tekrarsız(grup) listeleyiniz

--GROUP BY ÇÖZÜMÜ
SELECT musteri_isim FROM musteri_urun
GROUP BY musteri_isim

--DISTINCT ÇÖZÜMÜ
SELECT DISTINCT(musteri_isim) FROM musteri_urun;

-- Tabloda kaç farklı meyve vardır

SELECT urun_isim, count(urun_isim) FROM musteri_urun
GROUP BY urun_isim

-- FETCH NEXT () ROW ONLY / OFFSET / LIMIT

-- Musteri urun tablosundan ilk üç kaydı listeleyiniz

SELECT * FROM musteri_urun ORDER BY musteri_isim
FETCH NEXT 3 ROW ONLY

-- LIMIT
SELECT * FROM musteri_urun ORDER BY musteri_isim
limit 3

-- Musteri urun tablosundan ilk kaydı listeleyiniz
SELECT * FROM musteri_urun ORDER BY musteri_isim
limit 1

-- Müsteri urun tablosundan son üç kaydı listeleyiniz
SELECT * FROM musteri_urun ORDER BY musteri_isim DESC
limit 3

-- EN yüksek maası alan müsteriyi listeleyiniz
SELECT * FROM musteri_urun ORDER BY maas DESC limit 1

-- musteri_urun tablosundan en yüksek ikinci maası listeleyiniz
SELECT * FROM musteri_urun ORDER BY maas DESC offset 1 limit 1
-- OFFSET --> Satır atlamak istediğimizde offset komutunu kullanırız

SELECT * FROM musteri_urun ORDER BY maas desc
OFFSET 1 
FETCH NEXT 1 ROW ONLY

-- musteri_urun tablosundan en düşük dördüncü maası listeleyiniz
SELECT * FROM musteri_urun ORDER BY maas offset 3 limit 1

-- DDL --> ALTER TABLE
drop table personel -- Tabloyu ortadan kaldırmak için kullanılır

CREATE TABLE personel  (
id int,
isim varchar(50),  sehir varchar(50),  maas int,  
sirket varchar(20),
CONSTRAINT personel_pk PRIMARY KEY (id)
);

INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

SELECT * FROM personel

-- 1) ADD default deger ile tabloya bir field ekleme
ALTER TABLE personel add zipcode varchar(30), add adres varchar(30) 

ALTER TABLE personel
ADD adres varchar(50) DEFAULT 'Turkiye' -- DEFAULT yazarsak oluşturduğumuz sütüna belirttiğimiz veriyi tüm satırlara girer

-- 2) DROP tablodan sutun silme
ALTER TABLE personel DROP COLUMN zipcode

ALTER TABLE personel DROP COLUMN adres

ALTER TABLE personel DROP adres, drop sirket -- İki sutunu birden sildik


-- 3) RENAME COLUMN sutun adi degistirme
ALTER TABLE personel RENAME COLUMN sehir TO il

-- 4) RENAME tablonun ismini degistirme
ALTER TABLE personel RENAME TO isci

SELECT * FROM isci

-- 5) TYPE/SET(modify) sutunlarin ozelliklerini degistirme
ALTER TABLE isci ALTER COLUMN il TYPE varchar(30), ALTER COLUMN maas SET NOT NULL;

/*
Eğer numerik data türüne sahip bir sütunun data türüne string bir data türü atamak istersek
TYPE varchar(30) USING(maas::varchar(30)) bu formatı kullanırız
*/
ALTER TABLE isci
ALTER COLUMN maas TYPE int USING(maas::varchar(30))

DROP table ogrenciler2

-- TRANSACTION (BEGIN-SAVEPOINT-ROLLBACK-COMMIT)
/*
Transaction başlatmak için BEGIN komutu kullanmamız gerekir ve Transaction'ı sonlardırmak için
COMMIT komutunu çalıştırmalıyız
*/

CREATE TABLE ogrenciler2
(
id serial, -- Serial data türü otomatik olarak 1 den baslayarak sıralı olarak sayı ataması yapar
            -- INSERT INTO ile tabloya veri eklerken serial data türünü kullandığım veri değeri yerine DEFAULT yazarız
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real       
);

BEGIN;
INSERT INTO ogrenciler2 VALUES(default, 'Ali Can', 'Hasan',75.5);
INSERT INTO ogrenciler2 VALUES(default, 'Merve Gul', 'Ayse',85.3);
savepoint x;
INSERT INTO ogrenciler2 VALUES(default, 'Kemal Yasa', 'Hasan',85.6);
INSERT INTO ogrenciler2 VALUES(default, 'Nesibe Yilmaz', 'Ayse',95.3);
savepoint y;
INSERT INTO ogrenciler2 VALUES(default, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler2 VALUES(default, 'Can Bak', 'Ali', 67.5);
ROLLBACK to x;  --kayit yaptigim (x,y vs.. ye geri donebilirim)
COMMIT; --TRANSACTION commit ile sonladiririz sonlandirmadigimiz muddetce tabloyu silsemde ulasabilirim

SELECT * from ogrenciler2
delete from ogrenciler2
drop table ogrenciler2











