DROP DATABASE IF EXISTS `sql_faturalar`;
CREATE DATABASE `sql_faturalar`; 
USE `sql_faturalar`;

SET NAMES utf8 ;
SET character_set_client = utf8mb4 ;

CREATE TABLE `odeme_yontemleri` (
  `odeme_yontemi_id` tinyint NOT NULL AUTO_INCREMENT,
  `isim` varchar(50) NOT NULL,
  PRIMARY KEY (`odeme_yontemi_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `odeme_yontemleri` VALUES (1,'Kredi Kartı');
INSERT INTO `odeme_yontemleri` VALUES (2,'Nakit');
INSERT INTO `odeme_yontemleri` VALUES (3,'PayPal');
INSERT INTO `odeme_yontemleri` VALUES (4,'Havale/EFT');

CREATE TABLE `kurumsal_musteriler` (
  `kurumsal_musteri_id` int NOT NULL,
  `isim` varchar(50) NOT NULL,
  `adres` varchar(50) NOT NULL,
  `sehir` varchar(50) NOT NULL,
  `eyalet` char(2) NOT NULL,
  `telefon` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`kurumsal_musteri_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `kurumsal_musteriler` VALUES (1,'Vinte','3 Nevada Parkway','Syracuse','NY','315-252-7305');
INSERT INTO `kurumsal_musteriler` VALUES (2,'Myworks','34267 Glendale Parkway','Huntington','WV','304-659-1170');
INSERT INTO `kurumsal_musteriler` VALUES (3,'Yadel','096 Pawling Parkway','San Francisco','CA','415-144-6037');
INSERT INTO `kurumsal_musteriler` VALUES (4,'Kwideo','81674 Westerfield Circle','Waco','TX','254-750-0784');
INSERT INTO `kurumsal_musteriler` VALUES (5,'Topiclounge','0863 Farmco Road','Portland','OR','971-888-9129');

CREATE TABLE `faturalar` (
  `fatura_id` int NOT NULL,
  `no` varchar(50) NOT NULL,
  `kurumsal_musteri_id` int NOT NULL,
  `fatura_toplami` decimal(9,2) NOT NULL,
  `odeme_toplami` decimal(9,2) NOT NULL DEFAULT '0.00',
  `fatura_tarihi` date NOT NULL,
  `vade_tarihi` date NOT NULL,
  `odeme_tarihi` date DEFAULT NULL,
  PRIMARY KEY (`fatura_id`),
  KEY `FK_kurumsal_musteri_id` (`kurumsal_musteri_id`),
  CONSTRAINT `FK_kurumsal_musteri_id` FOREIGN KEY (`kurumsal_musteri_id`) REFERENCES `kurumsal_musteriler` (`kurumsal_musteri_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `faturalar` VALUES (1,'91-953-3396',2,101.79,0.00,'2019-03-09','2019-03-29',NULL);
INSERT INTO `faturalar` VALUES (2,'03-898-6735',5,175.32,8.18,'2019-06-11','2019-07-01','2019-02-12');
INSERT INTO `faturalar` VALUES (3,'20-228-0335',5,147.99,0.00,'2019-07-31','2019-08-20',NULL);
INSERT INTO `faturalar` VALUES (4,'56-934-0748',3,152.21,0.00,'2019-03-08','2019-03-28',NULL);
INSERT INTO `faturalar` VALUES (5,'87-052-3121',5,169.36,0.00,'2019-07-18','2019-08-07',NULL);
INSERT INTO `faturalar` VALUES (6,'75-587-6626',1,157.78,74.55,'2019-01-29','2019-02-18','2019-01-03');
INSERT INTO `faturalar` VALUES (7,'68-093-9863',3,133.87,0.00,'2019-09-04','2019-09-24',NULL);
INSERT INTO `faturalar` VALUES (8,'78-145-1093',1,189.12,0.00,'2019-05-20','2019-06-09',NULL);
INSERT INTO `faturalar` VALUES (9,'77-593-0081',5,172.17,0.00,'2019-07-09','2019-07-29',NULL);
INSERT INTO `faturalar` VALUES (10,'48-266-1517',1,159.50,0.00,'2019-06-30','2019-07-20',NULL);
INSERT INTO `faturalar` VALUES (11,'20-848-0181',3,126.15,0.03,'2019-01-07','2019-01-27','2019-01-11');
INSERT INTO `faturalar` VALUES (13,'41-666-1035',5,135.01,87.44,'2019-06-25','2019-07-15','2019-01-26');
INSERT INTO `faturalar` VALUES (15,'55-105-9605',3,167.29,80.31,'2019-11-25','2019-12-15','2019-01-15');
INSERT INTO `faturalar` VALUES (16,'10-451-8824',1,162.02,0.00,'2019-03-30','2019-04-19',NULL);
INSERT INTO `faturalar` VALUES (17,'33-615-4694',3,126.38,68.10,'2019-07-30','2019-08-19','2019-01-15');
INSERT INTO `faturalar` VALUES (18,'52-269-9803',5,180.17,42.77,'2019-05-23','2019-06-12','2019-01-08');
INSERT INTO `faturalar` VALUES (19,'83-559-4105',1,134.47,0.00,'2019-11-23','2019-12-13',NULL);

CREATE TABLE `odemeler` (
  `odeme_id` int NOT NULL AUTO_INCREMENT,
  `kurumsal_musteri_id` int NOT NULL,
  `fatura_id` int NOT NULL,
  `tarih` date NOT NULL,
  `tutar` decimal(9,2) NOT NULL,
  `odeme_yontemi` tinyint NOT NULL,
  PRIMARY KEY (`odeme_id`),
  KEY `fk_kurumsal_musteri_id_idx` (`kurumsal_musteri_id`),
  KEY `fk_fatura_id_idx` (`fatura_id`),
  KEY `fk_odeme_odeme_yontemi_idx` (`odeme_yontemi`),
  CONSTRAINT `fk_odeme_kurumsal_musteri` FOREIGN KEY (`kurumsal_musteri_id`) REFERENCES `kurumsal_musteriler` (`kurumsal_musteri_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_odeme_fatura` FOREIGN KEY (`fatura_id`) REFERENCES `faturalar` (`fatura_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_odeme_odeme_yontemi` FOREIGN KEY (`odeme_yontemi`) REFERENCES `odeme_yontemleri` (`odeme_yontemi_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `odemeler` VALUES (1,5,2,'2019-02-12',8.18,1);
INSERT INTO `odemeler` VALUES (2,1,6,'2019-01-03',74.55,1);
INSERT INTO `odemeler` VALUES (3,3,11,'2019-01-11',0.03,1);
INSERT INTO `odemeler` VALUES (4,5,13,'2019-01-26',87.44,1);
INSERT INTO `odemeler` VALUES (5,3,15,'2019-01-15',80.31,1);
INSERT INTO `odemeler` VALUES (6,3,17,'2019-01-15',68.10,1);
INSERT INTO `odemeler` VALUES (7,5,18,'2019-01-08',32.77,1);
INSERT INTO `odemeler` VALUES (8,5,18,'2019-01-08',10.00,2);


DROP DATABASE IF EXISTS `sql_magaza`;
CREATE DATABASE `sql_magaza`;
USE `sql_magaza`;

CREATE TABLE `urunler` (
  `urun_id` int NOT NULL AUTO_INCREMENT,
  `isim` varchar(50) NOT NULL,
  `stok_miktari` int NOT NULL,
  `birim_fiyat` decimal(4,2) NOT NULL,
  PRIMARY KEY (`urun_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `urunler` VALUES (1,'Foam Dinner Plate',70,1.21);
INSERT INTO `urunler` VALUES (2,'Pork - Bacon,back Peameal',49,4.65);
INSERT INTO `urunler` VALUES (3,'Lettuce - Romaine, Heart',38,3.35);
INSERT INTO `urunler` VALUES (4,'Brocolinni - Gaylan, Chinese',90,4.53);
INSERT INTO `urunler` VALUES (5,'Sauce - Ranch Dressing',94,1.63);
INSERT INTO `urunler` VALUES (6,'Petit Baguette',14,2.39);
INSERT INTO `urunler` VALUES (7,'Sweet Pea Sprouts',98,3.29);
INSERT INTO `urunler` VALUES (8,'Island Oasis - Raspberry',26,0.74);
INSERT INTO `urunler` VALUES (9,'Longan',67,2.26);
INSERT INTO `urunler` VALUES (10,'Broom - Push',6,1.09);


CREATE TABLE `nakliyeciler` (
  `nakliyeci_id` smallint NOT NULL AUTO_INCREMENT,
  `isim` varchar(50) NOT NULL,
  PRIMARY KEY (`nakliyeci_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `nakliyeciler` VALUES (1,'Hettinger LLC');
INSERT INTO `nakliyeciler` VALUES (2,'Schinner-Predovic');
INSERT INTO `nakliyeciler` VALUES (3,'Satterfield LLC');
INSERT INTO `nakliyeciler` VALUES (4,'Mraz, Renner and Nolan');
INSERT INTO `nakliyeciler` VALUES (5,'Waters, Mayert and Prohaska');


CREATE TABLE `bireysel_musteriler` (
  `bireysel_musteri_id` int NOT NULL AUTO_INCREMENT,
  `isim` varchar(50) NOT NULL,
  `soyisim` varchar(50) NOT NULL,
  `dogum_tarihi` date DEFAULT NULL,
  `telefon` varchar(50) DEFAULT NULL,
  `adres` varchar(50) NOT NULL,
  `sehir` varchar(50) NOT NULL,
  `eyalet` char(2) NOT NULL,
  `puan` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`bireysel_musteri_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `bireysel_musteriler` VALUES (1,'Babara','MacCaffrey','1986-03-28','781-932-9754','0 Sage Terrace','Waltham','MA',2273);
INSERT INTO `bireysel_musteriler` VALUES (2,'Ines','Brushfield','1986-04-13','804-427-9456','14187 Commercial Trail','Hampton','VA',947);
INSERT INTO `bireysel_musteriler` VALUES (3,'Freddi','Boagey','1985-02-07','719-724-7869','251 Springs Junction','Colorado Springs','CO',2967);
INSERT INTO `bireysel_musteriler` VALUES (4,'Ambur','Roseburgh','1974-04-14','407-231-8017','30 Arapahoe Terrace','Orlando','FL',457);
INSERT INTO `bireysel_musteriler` VALUES (5,'Clemmie','Betchley','1973-11-07',NULL,'5 Spohn Circle','Arlington','TX',3675);
INSERT INTO `bireysel_musteriler` VALUES (6,'Elka','Twiddell','1991-09-04','312-480-8498','7 Manley Drive','Chicago','IL',3073);
INSERT INTO `bireysel_musteriler` VALUES (7,'Ilene','Dowson','1964-08-30','615-641-4759','50 Lillian Crossing','Nashville','TN',1672);
INSERT INTO `bireysel_musteriler` VALUES (8,'Thacher','Naseby','1993-07-17','941-527-3977','538 Mosinee Center','Sarasota','FL',205);
INSERT INTO `bireysel_musteriler` VALUES (9,'Romola','Rumgay','1992-05-23','559-181-3744','3520 Ohio Trail','Visalia','CA',1486);
INSERT INTO `bireysel_musteriler` VALUES (10,'Levy','Mynett','1969-10-13','404-246-3370','68 Lawn Avenue','Atlanta','GA',796);


CREATE TABLE `siparis_durumlari` (
  `siparis_durumu_id` tinyint NOT NULL,
  `isim` varchar(50) NOT NULL,
  PRIMARY KEY (`siparis_durumu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `siparis_durumlari` VALUES (1,'Processed');
INSERT INTO `siparis_durumlari` VALUES (2,'Shipped');
INSERT INTO `siparis_durumlari` VALUES (3,'Delivered');


CREATE TABLE `siparisler` (
  `siparis_id` int NOT NULL AUTO_INCREMENT,
  `bireysel_musteri_id` int NOT NULL,
  `siparis_tarihi` date NOT NULL,
  `durum` tinyint NOT NULL DEFAULT '1',
  `yorumlar` varchar(2000) DEFAULT NULL,
  `nakliye_tarihi` date DEFAULT NULL,
  `nakliyeci_id` smallint DEFAULT NULL,
  PRIMARY KEY (`siparis_id`),
  KEY `fk_siparisler_bireysel_musteris_idx` (`bireysel_musteri_id`),
  KEY `fk_siparisler_nakliyeciler_idx` (`nakliyeci_id`),
  KEY `fk_siparisler_siparis_durumlari_idx` (`durum`),
  CONSTRAINT `fk_siparisler_bireysel_musteris` FOREIGN KEY (`bireysel_musteri_id`) REFERENCES `bireysel_musteriler` (`bireysel_musteri_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_siparisler_siparis_durumlari` FOREIGN KEY (`durum`) REFERENCES `siparis_durumlari` (`siparis_durumu_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_siparisler_nakliyeciler` FOREIGN KEY (`nakliyeci_id`) REFERENCES `nakliyeciler` (`nakliyeci_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `siparisler` VALUES (1,6,'2019-01-30',1,NULL,NULL,NULL);
INSERT INTO `siparisler` VALUES (2,7,'2018-08-02',2,NULL,'2018-08-03',4);
INSERT INTO `siparisler` VALUES (3,8,'2017-12-01',1,NULL,NULL,NULL);
INSERT INTO `siparisler` VALUES (4,2,'2017-01-22',1,NULL,NULL,NULL);
INSERT INTO `siparisler` VALUES (5,5,'2017-08-25',2,'','2017-08-26',3);
INSERT INTO `siparisler` VALUES (6,10,'2018-11-18',1,'Aliquam erat volutpat. In congue.',NULL,NULL);
INSERT INTO `siparisler` VALUES (7,2,'2018-09-22',2,NULL,'2018-09-23',4);
INSERT INTO `siparisler` VALUES (8,5,'2018-06-08',1,'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis.',NULL,NULL);
INSERT INTO `siparisler` VALUES (9,10,'2017-07-05',2,'Nulla mollis molestie lorem. Quisque ut erat.','2017-07-06',1);
INSERT INTO `siparisler` VALUES (10,6,'2018-04-22',2,NULL,'2018-04-23',2);


CREATE TABLE `siparis_ogeleri` (
  `siparis_id` int NOT NULL AUTO_INCREMENT,
  `urun_id` int NOT NULL,
  `adet` int NOT NULL,
  `birim_fiyat` decimal(4,2) NOT NULL,
  PRIMARY KEY (`siparis_id`,`urun_id`),
  KEY `fk_siparis_ogeleri_urunler_idx` (`urun_id`),
  CONSTRAINT `fk_siparis_ogeleri_siparisler` FOREIGN KEY (`siparis_id`) REFERENCES `siparisler` (`siparis_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_siparis_ogeleri_urunler` FOREIGN KEY (`urun_id`) REFERENCES `urunler` (`urun_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `siparis_ogeleri` VALUES (1,4,4,3.74);
INSERT INTO `siparis_ogeleri` VALUES (2,1,2,9.10);
INSERT INTO `siparis_ogeleri` VALUES (2,4,4,1.66);
INSERT INTO `siparis_ogeleri` VALUES (2,6,2,2.94);
INSERT INTO `siparis_ogeleri` VALUES (3,3,10,9.12);
INSERT INTO `siparis_ogeleri` VALUES (4,3,7,6.99);
INSERT INTO `siparis_ogeleri` VALUES (4,10,7,6.40);
INSERT INTO `siparis_ogeleri` VALUES (5,2,3,9.89);
INSERT INTO `siparis_ogeleri` VALUES (6,1,4,8.65);
INSERT INTO `siparis_ogeleri` VALUES (6,2,4,3.28);
INSERT INTO `siparis_ogeleri` VALUES (6,3,4,7.46);
INSERT INTO `siparis_ogeleri` VALUES (6,5,1,3.45);
INSERT INTO `siparis_ogeleri` VALUES (7,3,7,9.17);
INSERT INTO `siparis_ogeleri` VALUES (8,5,2,6.94);
INSERT INTO `siparis_ogeleri` VALUES (8,8,2,8.59);
INSERT INTO `siparis_ogeleri` VALUES (9,6,5,7.28);
INSERT INTO `siparis_ogeleri` VALUES (10,1,10,6.01);
INSERT INTO `siparis_ogeleri` VALUES (10,9,9,4.28);

CREATE TABLE `sql_magaza`.`siparis_ogeleri_notlari` (
  `not_id` INT NOT NULL,
  `siparis_Id` INT NOT NULL,
  `urun_id` INT NOT NULL,
  `not` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`not_id`));

INSERT INTO `siparis_ogeleri_notlari` (`not_id`, `siparis_Id`, `urun_id`, `not`) VALUES ('1', '1', '2', 'first not');
INSERT INTO `siparis_ogeleri_notlari` (`not_id`, `siparis_Id`, `urun_id`, `not`) VALUES ('2', '1', '2', 'second not');


DROP DATABASE IF EXISTS `sql_ik`;
CREATE DATABASE `sql_ik`;
USE `sql_ik`;


CREATE TABLE `ofisler` (
  `ofis_id` int NOT NULL,
  `adres` varchar(50) NOT NULL,
  `sehir` varchar(50) NOT NULL,
  `eyalet` varchar(50) NOT NULL,
  PRIMARY KEY (`ofis_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `ofisler` VALUES (1,'03 Reinke Trail','Cincinnati','OH');
INSERT INTO `ofisler` VALUES (2,'5507 Becker Terrace','New York sehir','NY');
INSERT INTO `ofisler` VALUES (3,'54 Northland Court','Richmond','VA');
INSERT INTO `ofisler` VALUES (4,'08 South Crossing','Cincinnati','OH');
INSERT INTO `ofisler` VALUES (5,'553 Maple Drive','Minneapolis','MN');
INSERT INTO `ofisler` VALUES (6,'23 North Plaza','Aurora','CO');
INSERT INTO `ofisler` VALUES (7,'9658 Wayridge Court','Boise','ID');
INSERT INTO `ofisler` VALUES (8,'9 Grayhawk Trail','New York sehir','NY');
INSERT INTO `ofisler` VALUES (9,'16862 Westend Hill','Knoxville','TN');
INSERT INTO `ofisler` VALUES (10,'4 Bluestem Parkway','Savannah','GA');



CREATE TABLE `personeller` (
  `personel_id` int NOT NULL,
  `isim` varchar(50) NOT NULL,
  `soyisim` varchar(50) NOT NULL,
  `gorev` varchar(50) NOT NULL,
  `maas` int NOT NULL,
  `mudur_id` int DEFAULT NULL,
  `ofis_id` int NOT NULL,
  PRIMARY KEY (`personel_id`),
  KEY `fk_personeller_ofisler_idx` (`ofis_id`),
  KEY `fk_personeller_personeller_idx` (`mudur_id`),
  CONSTRAINT `fk_personeller_mudurler` FOREIGN KEY (`mudur_id`) REFERENCES `personeller` (`personel_id`),
  CONSTRAINT `fk_personeller_ofisler` FOREIGN KEY (`ofis_id`) REFERENCES `ofisler` (`ofis_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `personeller` VALUES (37270,'Yovonnda','Magrannell','Executive Secretary',63996,NULL,10);
INSERT INTO `personeller` VALUES (33391,'D\'arcy','Nortunen','Account Executive',62871,37270,1);
INSERT INTO `personeller` VALUES (37851,'Sayer','Matterson','Statistician III',98926,37270,1);
INSERT INTO `personeller` VALUES (40448,'Mindy','Crissil','Staff Scientist',94860,37270,1);
INSERT INTO `personeller` VALUES (56274,'Keriann','Alloisi','VP Marketing',110150,37270,1);
INSERT INTO `personeller` VALUES (63196,'Alaster','Scutchin','Assistant Professor',32179,37270,2);
INSERT INTO `personeller` VALUES (67009,'North','de Clerc','VP urun Management',114257,37270,2);
INSERT INTO `personeller` VALUES (67370,'Elladine','Rising','Social Worker',96767,37270,2);
INSERT INTO `personeller` VALUES (68249,'Nisse','Voysey','Financial Advisor',52832,37270,2);
INSERT INTO `personeller` VALUES (72540,'Guthrey','Iacopetti','ofis Assistant I',117690,37270,3);
INSERT INTO `personeller` VALUES (72913,'Kass','Hefferan','Computer Systems Analyst IV',96401,37270,3);
INSERT INTO `personeller` VALUES (75900,'Virge','Goodrum','Information Systems mudur',54578,37270,3);
INSERT INTO `personeller` VALUES (76196,'Mirilla','Janowski','Cost Accountant',119241,37270,3);
INSERT INTO `personeller` VALUES (80529,'Lynde','Aronson','Junior Executive',77182,37270,4);
INSERT INTO `personeller` VALUES (80679,'Mildrid','Sokale','Geologist II',67987,37270,4);
INSERT INTO `personeller` VALUES (84791,'Hazel','Tarbert','General mudur',93760,37270,4);
INSERT INTO `personeller` VALUES (95213,'Cole','Kesterton','Pharmacist',86119,37270,4);
INSERT INTO `personeller` VALUES (96513,'Theresa','Binney','Food Chemist',47354,37270,5);
INSERT INTO `personeller` VALUES (98374,'Estrellita','Daleman','Staff Accountant IV',70187,37270,5);
INSERT INTO `personeller` VALUES (115357,'Ivy','Fearey','Structural Engineer',92710,37270,5);


DROP DATABASE IF EXISTS `sql_envanter`;
CREATE DATABASE `sql_envanter`;
USE `sql_envanter`;


CREATE TABLE `urunler` (
  `urun_id` int NOT NULL AUTO_INCREMENT,
  `isim` varchar(50) NOT NULL,
  `stok_miktari` int NOT NULL,
  `birim_fiyat` decimal(4,2) NOT NULL,
  PRIMARY KEY (`urun_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `urunler` VALUES (1,'Foam Dinner Plate',70,1.21);
INSERT INTO `urunler` VALUES (2,'Pork - Bacon,back Peameal',49,4.65);
INSERT INTO `urunler` VALUES (3,'Lettuce - Romaine, Heart',38,3.35);
INSERT INTO `urunler` VALUES (4,'Brocolinni - Gaylan, Chinese',90,4.53);
INSERT INTO `urunler` VALUES (5,'Sauce - Ranch Dressing',94,1.63);
INSERT INTO `urunler` VALUES (6,'Petit Baguette',14,2.39);
INSERT INTO `urunler` VALUES (7,'Sweet Pea Sprouts',98,3.29);
INSERT INTO `urunler` VALUES (8,'Island Oasis - Raspberry',26,0.74);
INSERT INTO `urunler` VALUES (9,'Longan',67,2.26);
INSERT INTO `urunler` VALUES (10,'Broom - Push',6,1.09);



