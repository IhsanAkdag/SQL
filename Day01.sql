--DDL DATA DEFINITION LANG.
--CREATE - TABLO OLUSTURMA
create table ogrenciler
(
ogrenci_no char(7),--uzunlugunu bildigimiz stringler icin
	isim varchar(20), --uzunlugunu bilmedigimiz stringler icin
	soyisim varchar(25),
	not_ort real, --ondalikli sayilar
	kayit_tarih date
);

--VAROLAN TABLODAN YENI BIR TABLO OLUSTURMA
CREATE TABLE ogrenci_notlari --yeni tablomuzun ismi
AS
SELECT isim,soyisim,not_ort FROM ogrenciler; --yukaridaki varolan tablomuzdan aldik

-- DML -- DATA MANIPULATION LANGUAGE
--INSERT (database e veri ekleme)
INSERT INTO ogrenciler VALUES (1234567,'Said','ILHAN',85.5,now()); --now yerine tarihte yazabiliriz 2020-12-11
INSERT INTO ogrenciler VALUES (1234568,'Hasan','HAN',80.5,'2020-01-09');

--BIR TABLOYA PARCALI VERI EKLEMEK ISTERSEK
INSERT INTO ogrenciler (isim,soyisim) VALUES ('ihsan','akdag');

--DQL -DATA QUERY LANG.
-- SELECT
select * FROM ogrenciler;

