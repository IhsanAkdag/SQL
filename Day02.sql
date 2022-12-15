CREATE TABLE NOTLAR
AS
SELECT isim,not_ort FROM ogrenciler;
SELECT * FROM notlar; --tabloyu cagiriyoruz

--INSERT - TABLO ICINE VERI EKLEMEK

INSERT INTO notlar VALUES ('haydar',75.7);


select isim from notlar; -- sadece isimleri getirir

create table ogrenciler2
(
ogrenci_no char(7) unique,--tekrarsiz olmasini istiyorsam
	isim varchar(20) not null, --null deger almaz 
	soyisim varchar(25),
	not_ort real,
	kayit_tarih date
);

INSERT INTO ogrenciler2 VALUES ('1234567','OMER','DAG',75.5,now());
INSERT INTO ogrenciler2 VALUES ('1234567','OMER','DAG',75.5,now()); --ogr no unique old icin hata verir ayni olamaz
INSERT INTO ogrenciler2 VALUES (ogrenci_no,soyisim,not_ort) VALUES ('1234569','EVREN','85,6');-- isimde not null oldg icin hata verir

--PRIMARY KEY OLUSTURMA

create table ogrenciler3
(
ogrenci_no char(7) primary key,-- pri key atamasi yaptik
	isim varchar(20), 
	soyisim varchar(25),
	not_ort real, 
	kayit_tarih date
);

--PRIMARY KEY OLUSTURMA 2.yol
create table ogrenciler4
(
ogrenci_no char(7) ,
	isim varchar(20), 
	soyisim varchar(25),
	not_ort real, 
	kayit_tarih date,	
CONSTRAINT ogr PRIMARY KEY(ogrenci_no) --bir CONSTRAINT olusturarak atamamizi sagliyor 	
);

--PRIMARY KEY OLUSTURMA 3.yol

create table ogrenciler5
(
ogrenci_no char(7) ,
	isim varchar(20), 
	soyisim varchar(25),
	not_ort real, 
	kayit_tarih date,
	PRIMARY KEY (ogrenci_no)
);

--FOREING KEY
/*
“tedarikciler3” isimli bir tablo olusturun. Tabloda “tedarikci_id”, “tedarikci_ismi”,  
“iletisim_isim” field’lari olsun ve “tedarikci_id” yi Primary Key yapin.
“urunler” isminde baska bir tablo olusturun “tedarikci_id” ve “urun_id” field’lari olsun ve
“tedarikci_id” yi Foreign Key yapin.
*/

CREATE TABLE tedarikciler3
(
tedarikci_id char(5) PRIMARY KEY,
tedarikci_ismi varchar(20),
iletisim_isim varchar(20)
);

CREATE TABLE urunler
(
tedarikci_id char(5),
urunler_id char(5),
FOREIGN KEY (tedarikci_id) REFERENCES tedarikciler3(tedarikci_id)
--CONSTRAINT urn_fk FOREIGN KEY (tedarikci_id) REFERENCES tedarikciler3(tedarikci_id) yazarak isim verebiliriz
);

----------------------------------------
/*
“calisanlar” isimli bir Tablo olusturun. Icinde “id”, “isim”, “maas”, “ise_baslama”  
field’lari olsun. “id” yi Primary Key yapin, “isim” i Unique, “maas” i Not Null yapın. 
“adresler” isminde baska bir tablo olusturun.Icinde “adres_id”, “sokak”, “cadde” ve 
“sehir” fieldlari olsun.  “adres_id” field‘i ile Foreign Key oluşturun.
*/
CREATE TABLE calisanlar
(
id char(5) PRIMARY KEY,
isim varchar(20) UNIQUE,
maas int NOT NULL,
ise_baslama date
);

CREATE TABLE adresler
(
adres_id varchar(30),
sokak varchar(30),
cadde varchar(30),
sehir varchar(30),
FOREIGN KEY(adres_id) REFERENCES calisanlar(id)
);

INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14'); 
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10010', 'Mehmet Yılmaz', 5000, '2018-04-14'); -- UNIQUE CONS. Kabul etmez
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); -- NOT NULL CONS. Kabul etmez
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); -- UNIQUE CONS. Kabul etmez
--INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14'); -- INT / STRING
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14'); -- PRIMARY KEY HICLIGI KABUL ETTI ama bir kez 
--INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); -- PRIMARY KEY daha once hiclik oldugu icin kabul etmez
--INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); -- PRIMARY KEY 
--INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); -- PRIMARY KEY null kabul etmez

INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');

-- Parent tabloda olmayan id ile child a ekleme yapamayiz
INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep'); --10012 parent tabloda yok ekleyemeyiz

-- FK'ye null değeri atanabilir.
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Maraş');

SELECT * FROM calisanlar;
SELECT * FROM adresler;

-- CHECK CONSTRAINT

CREATE TABLE calisanlar2
(
id varchar(15) PRIMARY KEY,
isim varchar(30) UNIQUE,
maas int CHECK (maas>10000) NOT NULL, --10000 den buyuk verileri girebilirsiniz
ise_baslama date    
);

INSERT INTO calisanlar2 VALUES('10002', 'Mehmet Yılmaz' ,19000, '2018-04-14'); 

-- DQL -- WHERE KULLANIMI

SELECT * FROM calisanlar;
SELECT isim FROM calisanlar;

-- Calisanlar tablosundan maası 5000 den buyuk olan isimleri listeleyiniz
SELECT isim,maas FROM calisanlar WHERE maas>5000;

-- Calisanlar tablosundan ismi Veli Han olan tüm verileri listeleyiniz
SELECT * FROM calisanlar WHERE isim='Veli Han';

-- Calisanlar tablosundan maası 5000 olan tüm verileri listeleyiniz
SELECT * FROM calisanlar WHERE maas=5000;

-- DML -- DELETE KOMUTU
DELETE FROM calisanlar; -- Eğer parent tablo başka bir child tablo ile iliskili ise önce child tablo silinmelidir
DELETE FROM adresler; --tablo silinmez tablonun icindeki veriler silinir

SELECT * FROM adresler;

--Adresler tablosundan sehri Antep olan verileri silelim
DELETE FROM adresler WHERE sehir = 'Antep';


-----yeni tablo olusturalim------
CREATE TABLE ogrenciler3
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int       
);

INSERT INTO ogrenciler3 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler3 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler3 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler3 VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler3 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler3 VALUES(127, 'Mustafa Bak', 'Ali', 99);

SELECT * FROM ogrenciler3;



















