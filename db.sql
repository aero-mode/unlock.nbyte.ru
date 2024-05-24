-- MySQL dump 10.13  Distrib 5.1.73, for redhat-linux-gnu (x86_64)
--
-- Host: localhost    Database: investdb
-- ------------------------------------------------------
-- Server version	5.1.73

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `indf_access`
--

DROP TABLE IF EXISTS `indf_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_access` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор элемента модуля',
  `element_type` varchar(20) NOT NULL DEFAULT 'element' COMMENT 'тип элемента модуля',
  `module_name` varchar(50) NOT NULL DEFAULT '' COMMENT 'название модуля',
  `role_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор типа пользователя из таблицы `indf_users_role`',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `module_name` (`module_name`(2)),
  KEY `element_id` (`element_id`),
  KEY `element_type` (`element_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Доступ к элементам модулей';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_access`
--

LOCK TABLES `indf_access` WRITE;
/*!40000 ALTER TABLE `indf_access` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_admin`
--

DROP TABLE IF EXISTS `indf_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_admin` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `parent_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор родителя из таблицы `indf_admin`',
  `count_children` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'количество вложенных страниц',
  `group_id` enum('1','2','3','4','5') NOT NULL DEFAULT '1' COMMENT 'группа',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT 'название',
  `rewrite` varchar(30) NOT NULL DEFAULT '' COMMENT 'псевдоссылка',
  `act` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'показывать в меню: 0 - нет, 1 - да',
  `add` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'ссылка на добавление элемента в быстром меню: 0 - нет, 1 - да',
  `add_name` varchar(100) NOT NULL DEFAULT '' COMMENT 'текст ссылки на добавление элемента в быстром меню',
  `sort` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'порядковый номер для сортировки',
  `docs` varchar(255) NOT NULL DEFAULT '' COMMENT 'ссылка на раздел в документации',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=MyISAM AUTO_INCREMENT=100 DEFAULT CHARSET=utf8 COMMENT='Страницы в админки';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_admin`
--

LOCK TABLES `indf_admin` WRITE;
/*!40000 ALTER TABLE `indf_admin` DISABLE KEYS */;
INSERT INTO `indf_admin` VALUES (1,0,3,'5','Модули и БД','service','1','0','',32,''),(2,1,0,'5','Установка модулей','service','1','0','',1,''),(3,1,0,'5','Восстановление БД','service/repair','1','0','',2,''),(4,1,0,'5','Экспорт/импорт БД','service/db','1','0','',3,''),(5,0,0,'1','Страницы админки','admin','0','0','',4,''),(6,0,0,'5','Параметры сайта','config','1','0','',31,''),(7,0,0,'5','Обработка изображений','images','1','0','',33,''),(8,0,3,'1','Меню на сайте','menu','1','0','',3,''),(9,8,0,'1','Пункты меню','menu','1','0','',1,''),(10,8,0,'1','Меню','menu/category','1','0','',2,''),(11,8,0,'1','Настройки','menu/config','0','0','',3,''),(12,0,4,'1','Страницы сайта','site','1','1','Страница сайта',2,''),(13,12,0,'1','Страницы сайта','site','1','0','',1,''),(14,12,0,'1','Блоки на сайте','site/blocks','1','0','',2,''),(15,12,0,'1','Динамические блоки','site/dynamic','1','0','',3,''),(16,12,0,'1','Настройки','site/config','0','0','',4,''),(17,0,3,'3','On-line консультант','consultant','1','0','',26,''),(18,17,0,'3','JivoSite','consultant','1','0','',1,''),(19,17,0,'3','LiveTex','consultant/livetex','1','0','',2,''),(20,17,0,'3','RedHelper','consultant/redhelper','1','0','',3,''),(21,0,0,'3','Обновление CMS','update','1','0','',30,'http://www.diafan.ru/moduli/obnovleniya/'),(22,0,2,'4','Оплата','payment','1','0','',14,''),(23,22,0,'4','Методы оплаты','payment','1','0','',1,''),(24,22,0,'4','История платежей','payment/history','1','0','',2,''),(25,0,2,'5','Языки сайта','languages','1','0','',35,''),(26,25,0,'5','Языки сайта','languages','1','0','',1,''),(27,25,0,'5','Перевод интерфейса','languages/translate','1','0','',2,''),(28,0,7,'4','Каталог','shop','1','1','Товар',2,'http://www.diafan.ru/moduli/magazin/'),(29,28,0,'4','Товары','shop','1','0','',1,'http://www.diafan.ru/moduli/magazin/'),(30,28,0,'4','Скидки','shop/discount','1','0','',2,'http://www.diafan.ru/moduli/magazin/'),(31,28,0,'4','Производители','shop/brand','1','0','',3,'http://www.diafan.ru/moduli/magazin/'),(32,28,0,'4','Категории','shop/category','1','0','',4,'http://www.diafan.ru/moduli/magazin/'),(33,28,0,'4','Характеристики','shop/param','1','0','',5,'http://www.diafan.ru/moduli/magazin/'),(34,28,0,'4','Импорт/экспорт','shop/importexport','1','0','',6,'http://www.diafan.ru/moduli/magazin/'),(35,28,0,'4','Настройки','shop/config','0','0','',7,'http://www.diafan.ru/moduli/magazin/'),(36,0,0,'4','Заказы','shop/order','1','0','',12,'http://www.diafan.ru/moduli/magazin/'),(37,0,5,'4','Справочники','delivery','1','0','',13,'http://www.diafan.ru/moduli/magazin/'),(38,37,0,'4','Способы доставки','delivery','1','0','',1,'http://www.diafan.ru/moduli/magazin/'),(39,37,0,'4','Сопутствующие услуги','shop/additionalcost','1','0','',2,'http://www.diafan.ru/moduli/magazin/'),(40,37,0,'4','Форма оформления заказа','shop/orderparam','1','0','',3,'http://www.diafan.ru/moduli/magazin/'),(41,37,0,'4','Статусы заказа','shop/orderstatus','1','0','',4,'http://www.diafan.ru/moduli/magazin/'),(42,37,0,'4','Валюты','shop/currency','1','0','',5,'http://www.diafan.ru/moduli/magazin/'),(43,0,4,'4','Статистика','shop/ordercount','1','0','',15,'http://www.diafan.ru/moduli/magazin/'),(44,43,0,'4','Отчеты о заказах','shop/ordercount','1','0','',1,'http://www.diafan.ru/moduli/magazin/'),(45,43,0,'4','Отложенные товары','shop/wishlist','1','0','',2,'http://www.diafan.ru/moduli/magazin/'),(46,43,0,'4','Список ожиданий','shop/waitlist','1','0','',3,'http://www.diafan.ru/moduli/magazin/'),(47,43,0,'4','Статистика товаров','shop/counter','1','0','',4,'http://www.diafan.ru/moduli/magazin/'),(48,0,6,'2','Рассылки','subscribtion','1','0','',21,'http://www.diafan.ru/moduli/rassylki/'),(49,48,0,'2','E-mail рассылки','subscribtion','1','0','',1,'http://www.diafan.ru/moduli/rassylki/'),(50,48,0,'2','Категории','subscribtion/category','1','0','',2,'http://www.diafan.ru/moduli/rassylki/'),(51,48,0,'2','Подписчики','subscribtion/emails','1','0','',3,'http://www.diafan.ru/moduli/rassylki/'),(52,48,0,'2','SMS-рассылки','subscribtion/sms','1','0','',4,'http://www.diafan.ru/moduli/rassylki/'),(53,48,0,'2','Номера телефонов','subscribtion/phones','1','0','',5,'http://www.diafan.ru/moduli/rassylki/'),(54,48,0,'2','Настройки','subscribtion/config','0','0','',6,'http://www.diafan.ru/moduli/rassylki/'),(55,0,0,'2','Геокарта','geomap','1','0','',22,''),(56,0,1,'5','Captcha','captcha','1','0','',35,''),(57,56,0,'5','Настройки','captcha/config','0','0','',1,''),(58,0,0,'1','События','dashboard','0','0','',1,''),(59,0,3,'1','Баннеры','bs','1','1','Баннер',8,'http://www.diafan.ru/moduli/bannery/'),(60,59,0,'1','Баннеры','bs','1','0','',1,'http://www.diafan.ru/moduli/bannery/'),(61,59,0,'1','Категории','bs/category','1','0','',2,'http://www.diafan.ru/moduli/bannery/'),(62,59,0,'1','Настройка','bs/config','0','0','',3,'http://www.diafan.ru/moduli/bannery/'),(63,0,0,'5','Корзина','trash','1','0','',36,'http://www.diafan.ru/moduli/korzina/'),(64,0,0,'2','Ошибки на сайте','mistakes','1','0','',24,''),(65,0,4,'1','Новости','news','1','1','Новость',5,'http://www.diafan.ru/moduli/novosti/'),(66,65,0,'1','Новости','news','1','0','',1,'http://www.diafan.ru/moduli/novosti/'),(67,65,0,'1','Категории','news/category','1','0','',2,'http://www.diafan.ru/moduli/novosti/'),(68,65,0,'1','Статистика','news/counter','1','0','',3,'http://www.diafan.ru/moduli/novosti/'),(69,65,0,'1','Настройки','news/config','0','0','',4,'http://www.diafan.ru/moduli/novosti/'),(70,0,3,'3','Поиск по сайту','search','1','0','',31,'http://www.diafan.ru/moduli/poisk/'),(71,70,0,'3','Индексация','search','1','0','',1,'http://www.diafan.ru/moduli/poisk/'),(72,70,0,'3','История поиска','search/history','1','0','',2,'http://www.diafan.ru/moduli/poisk/'),(73,70,0,'3','Настройки','search/config','0','0','',3,'http://www.diafan.ru/moduli/poisk/'),(74,0,3,'2','Обратная связь','feedback','1','0','',19,'http://www.diafan.ru/moduli/obratnaya_svyaz/'),(75,74,0,'2','Сообщения','feedback','1','0','',1,'http://www.diafan.ru/moduli/obratnaya_svyaz/'),(76,74,0,'2','Конструктор формы','feedback/param','1','0','',2,'http://www.diafan.ru/moduli/obratnaya_svyaz/'),(77,74,0,'2','Настройки','feedback/config','0','0','',3,'http://www.diafan.ru/moduli/obratnaya_svyaz/'),(78,0,4,'2','Пользователи сайта','users','1','0','',16,'http://www.diafan.ru/moduli/polzovateli/'),(79,78,0,'2','Пользователи','users','1','0','',1,'http://www.diafan.ru/moduli/polzovateli/'),(80,78,0,'2','Права доступа','users/role','1','0','',2,'http://www.diafan.ru/moduli/polzovateli/'),(81,78,0,'2','Конструктор формы регистрации','users/param','1','0','',3,'http://www.diafan.ru/moduli/polzovateli/'),(82,78,0,'2','Настройки','users/config','0','0','',4,'http://www.diafan.ru/moduli/polzovateli/'),(83,0,3,'3','Перелинковка','keywords','1','0','',27,''),(84,83,0,'3','Ключевые слова','keywords','1','0','',1,''),(85,83,0,'3','Импорт/экспорт','keywords/importexport','1','0','',2,''),(86,83,0,'3','Настройки','keywords/config','0','0','',3,''),(87,0,0,'3','Темы и дизайн','custom','1','0','',29,''),(88,0,1,'2','Рейтинг','rating','1','0','',22,'http://www.diafan.ru/moduli/rejtingi/'),(89,88,0,'2','Настройки','rating/config','0','0','',1,'http://www.diafan.ru/moduli/rejtingi/'),(90,0,3,'2','Комментарии','comments','1','0','',23,'http://www.diafan.ru/moduli/kommentarii/'),(91,90,0,'2','Комментарии','comments','1','0','',1,'http://www.diafan.ru/moduli/kommentarii/'),(92,90,0,'2','Конструктор формы','comments/param','1','0','',2,'http://www.diafan.ru/moduli/kommentarii/'),(93,90,0,'2','Настройки','comments/config','0','0','',3,'http://www.diafan.ru/moduli/kommentarii/'),(94,0,0,'3','Цветовое оформление','csseditor','1','0','',25,''),(95,0,4,'1','Статьи','clauses','1','1','Статью',6,'http://www.diafan.ru/moduli/stati/'),(96,95,0,'1','Статьи','clauses','1','0','',1,'http://www.diafan.ru/moduli/stati/'),(97,95,0,'1','Категории','clauses/category','1','0','',2,'http://www.diafan.ru/moduli/stati/'),(98,95,0,'1','Статистика','clauses/counter','1','0','',3,'http://www.diafan.ru/moduli/stati/'),(99,95,0,'1','Настройки','clauses/config','0','0','',4,'http://www.diafan.ru/moduli/stati/');
/*!40000 ALTER TABLE `indf_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_admin_parents`
--

DROP TABLE IF EXISTS `indf_admin_parents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_admin_parents` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `element_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор страницы из таблицы `indf_admin`',
  `parent_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор страницы родителя из таблицы `indf_admin`',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=69 DEFAULT CHARSET=utf8 COMMENT='Родительские связи страниц админки';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_admin_parents`
--

LOCK TABLES `indf_admin_parents` WRITE;
/*!40000 ALTER TABLE `indf_admin_parents` DISABLE KEYS */;
INSERT INTO `indf_admin_parents` VALUES (1,2,1),(2,3,1),(3,4,1),(4,9,8),(5,10,8),(6,11,8),(7,13,12),(8,14,12),(9,15,12),(10,16,12),(11,18,17),(12,19,17),(13,20,17),(14,23,22),(15,24,22),(16,26,25),(17,27,25),(18,29,28),(19,30,28),(20,31,28),(21,32,28),(22,33,28),(23,34,28),(24,35,28),(25,38,37),(26,39,37),(27,40,37),(28,41,37),(29,42,37),(30,44,43),(31,45,43),(32,46,43),(33,47,43),(34,49,48),(35,50,48),(36,51,48),(37,52,48),(38,53,48),(39,54,48),(40,57,56),(41,60,59),(42,61,59),(43,62,59),(44,66,65),(45,67,65),(46,68,65),(47,69,65),(48,71,70),(49,72,70),(50,73,70),(51,75,74),(52,76,74),(53,77,74),(54,79,78),(55,80,78),(56,81,78),(57,82,78),(58,84,83),(59,85,83),(60,86,83),(61,89,88),(62,91,90),(63,92,90),(64,93,90),(65,96,95),(66,97,95),(67,98,95),(68,99,95);
/*!40000 ALTER TABLE `indf_admin_parents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_attachments`
--

DROP TABLE IF EXISTS `indf_attachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_attachments` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT 'название файла',
  `module_name` varchar(50) NOT NULL DEFAULT '' COMMENT 'название модуля',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор элемента модуля',
  `param_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор поля или характеристики с типом «файлы»',
  `extension` varchar(255) NOT NULL DEFAULT '' COMMENT 'расширение файла',
  `size` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'размер файла',
  `is_image` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'это изображение: 0 - нет, 1 - да',
  `access_admin` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'доступ только для администратора: 0 - нет, 1 - да',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `element_id` (`element_id`),
  KEY `module_name` (`module_name`(2))
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Прикрепленные файлы';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_attachments`
--

LOCK TABLES `indf_attachments` WRITE;
/*!40000 ALTER TABLE `indf_attachments` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_attachments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_bs`
--

DROP TABLE IF EXISTS `indf_bs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_bs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `name1` varchar(250) NOT NULL DEFAULT '' COMMENT 'название',
  `text1` text COMMENT 'описание',
  `alt1` varchar(250) NOT NULL DEFAULT '' COMMENT 'атрибут alt для баннера-изображения',
  `title1` varchar(250) NOT NULL DEFAULT '' COMMENT 'атрибут title для баннера-изображения',
  `act1` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'показывать на сайте: 0 - нет, 1 - да',
  `type` enum('1','2','3') NOT NULL DEFAULT '1' COMMENT 'тип: 1 - изображение, 2 - флэш, 3 - HTML',
  `file` varchar(250) NOT NULL DEFAULT '' COMMENT 'имя файла, загруженного в папку userfls/bs',
  `html` text COMMENT 'HTML код баннера-блока',
  `link1` text COMMENT 'ссылка на баннер-изображение или баннер-флэш',
  `cat_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор категории из таблицы `indf_bs_category`',
  `check_number` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'ограничить количество показов: 0 - нет, 1 - да',
  `check_click` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'ограничить по количеству кликов: 0 - нет, 1 - да',
  `show_click` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'ограничить по количеству кликов: осталось кликов',
  `created` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата создания',
  `date_start` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата начала показа',
  `date_finish` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата окончания показа',
  `show_number` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'ограничить количество показов: осталось показов',
  `click` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'всего кликов',
  `width` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'ширина флэш-баннера',
  `height` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'высота флэш-баннера',
  `check_user` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'ограничить количество показов посетителю в сутки: 0 - нет, 1 - да',
  `show_user` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'количество показов посетителю в сутки',
  `count_view` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'всего показов',
  `target_blank` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'открывать ссылку в новом окне',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'подрядковый номер для сортировки',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='Баннеры';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_bs`
--

LOCK TABLES `indf_bs` WRITE;
/*!40000 ALTER TABLE `indf_bs` DISABLE KEYS */;
INSERT INTO `indf_bs` VALUES (1,'Бизнес под ключ','Готовая прибыль сразу после покупки','','','1','1','slider2_1_1.jpg','','http://invest82.ru/shop/',1,'0','0',0,1494104400,0,0,0,0,0,0,'0',0,259,'0',1,'0'),(2,'Узкий баннер','','','','1','1','ban1_2_2.jpg','','http://invest82.ru/shop/oborudovanie/',2,'0','0',0,1496523600,0,0,0,0,0,0,'0',0,259,'0',2,'0'),(3,'Готовый бизнес','<p>в Крыму</p>','','','1','1','smeh_3.jpg','','http://invest82.ru/news/',1,'0','0',0,1496696400,0,0,0,1,0,0,'0',0,259,'0',4,'0'),(4,'Готовый бизнес','','','','1','1','4terminal.ru-gotoviy-bizness_220x220_4.jpg','','http://invest82.ru/shop/gotovyy-biznes/',3,'0','0',0,1496696400,0,0,0,1,0,0,'0',0,259,'0',4,'0'),(5,'Магазины','','','','1','1','magaz_5.jpg','','http://invest82.ru/shop/gotovyy-biznes/torgovlya-i-magaziny/',3,'0','0',0,1496782800,0,0,0,1,0,0,'0',0,259,'0',5,'0'),(6,'Оборудование','','','','1','1','oborudovanie_6.jpg','','http://invest82.ru/shop/oborudovanie/',3,'0','0',0,1496782800,0,0,0,7,0,0,'0',0,259,'0',6,'0'),(7,'Производство','','','','1','1','proizvodstvo_7.jpg','','http://invest82.ru/shop/gotovyy-biznes/proizvodstvo/',3,'0','0',0,1496782800,0,0,0,4,0,0,'0',0,259,'0',7,'0');
/*!40000 ALTER TABLE `indf_bs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_bs_category`
--

DROP TABLE IF EXISTS `indf_bs_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_bs_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `name` text COMMENT 'название',
  `act` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'показывать на сайте: 0 - нет, 1 - да',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'подрядковый номер для сортировки',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Категории баннеров';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_bs_category`
--

LOCK TABLES `indf_bs_category` WRITE;
/*!40000 ALTER TABLE `indf_bs_category` DISABLE KEYS */;
INSERT INTO `indf_bs_category` VALUES (1,'Баннер на главной','1',1,'0'),(2,'Узкий баннер на главной','1',2,'0'),(3,'Блок баннеров под слайдером','1',3,'0');
/*!40000 ALTER TABLE `indf_bs_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_bs_site_rel`
--

DROP TABLE IF EXISTS `indf_bs_site_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_bs_site_rel` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор баннера из таблицы `indf_bs_category`',
  `site_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор страницы сайта из таблицы `indf_site`',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='Данные о том, на каких страницах сайта выводятся баннеры';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_bs_site_rel`
--

LOCK TABLES `indf_bs_site_rel` WRITE;
/*!40000 ALTER TABLE `indf_bs_site_rel` DISABLE KEYS */;
INSERT INTO `indf_bs_site_rel` VALUES (22,1,0,'0'),(24,2,0,'0'),(21,3,0,'0'),(16,4,0,'0'),(13,5,0,'0'),(12,6,0,'0'),(10,7,0,'0');
/*!40000 ALTER TABLE `indf_bs_site_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_captcha`
--

DROP TABLE IF EXISTS `indf_captcha`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_captcha` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `name1` text COMMENT 'текст вопроса',
  `act1` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'показывать на сайте: 0 - нет, 1 - да',
  `is_write` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'ответы не отображаются на сайте: 0 - нет, 1 - да',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Вопросы для капчи типа Вопрос-ответ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_captcha`
--

LOCK TABLES `indf_captcha` WRITE;
/*!40000 ALTER TABLE `indf_captcha` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_captcha` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_captcha_answers`
--

DROP TABLE IF EXISTS `indf_captcha_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_captcha_answers` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `text1` text COMMENT 'текст ответа',
  `is_right` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'ответ правильный: 0 - нет, 1 - да',
  `captcha_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор вопроса из таблицы `indf_captcha`',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `captcha_id` (`captcha_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Варианты ответов для капчи типа Вопрос-ответ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_captcha_answers`
--

LOCK TABLES `indf_captcha_answers` WRITE;
/*!40000 ALTER TABLE `indf_captcha_answers` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_captcha_answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_clauses`
--

DROP TABLE IF EXISTS `indf_clauses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_clauses` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `name1` text COMMENT 'название',
  `act1` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'показывать на сайте: 0 - нет, 1 - да',
  `map_no_show` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'не показывать на карте сайта: 0 - нет, 1 - да',
  `changefreq` enum('always','hourly','daily','weekly','monthly','yearly','never') NOT NULL DEFAULT 'always' COMMENT 'Changefreq для sitemap.xml',
  `priority` varchar(3) NOT NULL DEFAULT '' COMMENT 'Priority для sitemap.xml',
  `noindex` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'не индексировать: 0 - нет, 1 - да',
  `created` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата создания',
  `date_start` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата начала показа',
  `date_finish` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата окончания показа',
  `cat_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор основной категории из таблицы `indf_clauses_category`',
  `site_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор страницы сайта из таблицы `indf_site`',
  `keywords1` varchar(250) NOT NULL DEFAULT '' COMMENT 'ключевые слова, тег Keywords',
  `descr1` text COMMENT 'описание, тэг Description',
  `canonical1` varchar(100) NOT NULL DEFAULT '' COMMENT 'канонический тег',
  `title_meta1` varchar(250) NOT NULL DEFAULT '' COMMENT 'заголовок окна в браузере, тег Title',
  `anons1` text COMMENT 'анонс',
  `anons_plus1` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'добавлять анонс к описанию: 0 - нет, 1 - да',
  `text1` longtext COMMENT 'описание',
  `timeedit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'время последнего изменения в формате UNIXTIME',
  `admin_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'пользователь из таблицы `indf_users`, добавивший или первый отредктировавший статью в административной части',
  `access` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'доступ ограничен: 0 - нет, 1 - да',
  `theme` varchar(50) NOT NULL DEFAULT '' COMMENT 'шаблон страницы сайта',
  `view` varchar(50) NOT NULL DEFAULT '' COMMENT 'шаблон модуля',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'подрядковый номер для сортировки',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Статьи';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_clauses`
--

LOCK TABLES `indf_clauses` WRITE;
/*!40000 ALTER TABLE `indf_clauses` DISABLE KEYS */;
INSERT INTO `indf_clauses` VALUES (1,'Открытие новых и развивающихся рынков в Крыму','1','0','monthly','0','0',1497387600,0,0,1,37,'','','','','','0','<p><span>ОТКРЫТИЕ НОВЫХ И РАЗВИВАЮЩИХСЯ РЫНКОВ В КРЫМУ</span><br><br><span>Рынки, которых нет, невозможно изучить. Крым тем и привлекает, что до сих пор многие рынке не сформированы и не созданы. А это важно для бизнеса.</span><span>&nbsp;</span><br><br><span>Менеджер, который думает, что знает будущее рынка в Симферополе, строит планы и инвестирует совсем иначе, чем менеджер, осознающий неопределенность развивающегося рынка Крыма.</span><span><br><br>Большинство специалистов по маркетингу в Симферополе во время учебы в университетах и на работе приобрели очень важный навык - они научились прислушиваться к мнению потребителей. Но мало кто из них хотя бы теоретически или практически подготовлен к созданию новых, еще не существующих рынков.<br><br>Беда такого однобокого опыта в том, что все это может парализовать вновь открытую компанию в Симферополе... И тем самым свести прибыль на нет.&nbsp;</span></p>\r\n<p><span>Вывод следующий: Для давно созданных рынков требуется маркетолог знающий Крымский рынок, мыслящий стандартно, понимающий как работает бизнес в Крыму, а вот для новых рынков потребуется креативный мыслящий не стандартно Крымчанин, знакомый со здешним менталитетом, обладающий навыком видения Крымского тренда.</span></p>',1497469140,1,'0','','',1,'0');
/*!40000 ALTER TABLE `indf_clauses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_clauses_category`
--

DROP TABLE IF EXISTS `indf_clauses_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_clauses_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `name1` text COMMENT 'название',
  `act1` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'показывать на сайте: 0 - нет, 1 - да',
  `map_no_show` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'не показывать на карте сайта: 0 - нет, 1 - да',
  `changefreq` enum('always','hourly','daily','weekly','monthly','yearly','never') NOT NULL DEFAULT 'always' COMMENT 'Changefreq для sitemap.xml',
  `priority` varchar(3) NOT NULL DEFAULT '' COMMENT 'Priority для sitemap.xml',
  `noindex` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'не индексировать: 0 - нет, 1 - да',
  `parent_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор родителя из таблицы `indf_clauses_category`',
  `count_children` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'количество вложенных категорий',
  `site_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор страницы сайта из таблицы `indf_site`',
  `keywords1` varchar(250) NOT NULL DEFAULT '' COMMENT 'ключевые слова, тег Keywords',
  `descr1` text COMMENT 'описание, тэг Description',
  `canonical1` varchar(100) NOT NULL DEFAULT '' COMMENT 'канонический тег',
  `title_meta1` varchar(250) NOT NULL DEFAULT '' COMMENT 'заголовок окна в браузере, тег Title',
  `anons1` text COMMENT 'анонс',
  `anons_plus1` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'добавлять анонс к описанию: 0 - нет, 1 - да',
  `text1` text COMMENT 'описание',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'подрядковый номер для сортировки',
  `timeedit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'время последнего изменения в формате UNIXTIME',
  `admin_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'пользователь из таблицы `indf_users`, добавивший или первый отредктировавший категорию в административной части',
  `access` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'доступ ограничен: 0 - нет, 1 - да',
  `theme` varchar(50) NOT NULL DEFAULT '' COMMENT 'шаблон страницы сайта',
  `view` varchar(50) NOT NULL DEFAULT '' COMMENT 'шаблон модуля',
  `view_element` varchar(50) NOT NULL DEFAULT '' COMMENT 'шаблон модуля для элементов в категории',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Категории статей';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_clauses_category`
--

LOCK TABLES `indf_clauses_category` WRITE;
/*!40000 ALTER TABLE `indf_clauses_category` DISABLE KEYS */;
INSERT INTO `indf_clauses_category` VALUES (1,'Статьи','1','0','monthly','0','0',0,0,37,'','','','','','0','',1,1497469060,1,'0','','','','0');
/*!40000 ALTER TABLE `indf_clauses_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_clauses_category_parents`
--

DROP TABLE IF EXISTS `indf_clauses_category_parents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_clauses_category_parents` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор категории из таблицы `indf_clauses_category`',
  `parent_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор категории-родителя из таблицы `indf_clauses_category`',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Родительские связи категорий статей';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_clauses_category_parents`
--

LOCK TABLES `indf_clauses_category_parents` WRITE;
/*!40000 ALTER TABLE `indf_clauses_category_parents` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_clauses_category_parents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_clauses_category_rel`
--

DROP TABLE IF EXISTS `indf_clauses_category_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_clauses_category_rel` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор статьи из таблицы `indf_clauses`',
  `cat_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор категории из таблицы `indf_clauses_category`',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `cat_id` (`cat_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Связи статей и категорий';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_clauses_category_rel`
--

LOCK TABLES `indf_clauses_category_rel` WRITE;
/*!40000 ALTER TABLE `indf_clauses_category_rel` DISABLE KEYS */;
INSERT INTO `indf_clauses_category_rel` VALUES (3,1,1,'0');
/*!40000 ALTER TABLE `indf_clauses_category_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_clauses_counter`
--

DROP TABLE IF EXISTS `indf_clauses_counter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_clauses_counter` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор статьи из таблицы `indf_clauses`',
  `count_view` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'количество просмотров',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `element_id` (`element_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Счетчик просмотров статей';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_clauses_counter`
--

LOCK TABLES `indf_clauses_counter` WRITE;
/*!40000 ALTER TABLE `indf_clauses_counter` DISABLE KEYS */;
INSERT INTO `indf_clauses_counter` VALUES (1,1,1,'0');
/*!40000 ALTER TABLE `indf_clauses_counter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_clauses_rel`
--

DROP TABLE IF EXISTS `indf_clauses_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_clauses_rel` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор статьи из таблицы `indf_clauses`',
  `rel_element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор связанной статьи из таблицы `indf_clauses`',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Связи похожих статей';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_clauses_rel`
--

LOCK TABLES `indf_clauses_rel` WRITE;
/*!40000 ALTER TABLE `indf_clauses_rel` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_clauses_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_comments`
--

DROP TABLE IF EXISTS `indf_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_comments` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор пользователя из таблицы `indf_users`',
  `text` text COMMENT 'текст комментария',
  `act` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'показывать на сайте: 0 - нет, 1 - да',
  `created` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата создания',
  `module_name` varchar(50) NOT NULL DEFAULT '' COMMENT 'название модуля',
  `element_type` enum('element','cat') NOT NULL DEFAULT 'element' COMMENT 'тип элемента модуля',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор элемента модуля',
  `parent_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор родителя из таблицы `indf_comments`',
  `count_children` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'количество вложенных комментариев',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `element_id` (`element_id`),
  KEY `module_name` (`module_name`(2))
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Комментарии';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_comments`
--

LOCK TABLES `indf_comments` WRITE;
/*!40000 ALTER TABLE `indf_comments` DISABLE KEYS */;
INSERT INTO `indf_comments` VALUES (1,1,'В наличии есть?','1',1497352439,'shop','element',10,0,0,'0');
/*!40000 ALTER TABLE `indf_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_comments_mail`
--

DROP TABLE IF EXISTS `indf_comments_mail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_comments_mail` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `mail` varchar(64) NOT NULL DEFAULT '' COMMENT 'e-mail пользователя',
  `module_name` varchar(50) NOT NULL DEFAULT '' COMMENT 'название модуля',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор элемента модуля',
  `element_type` enum('element','cat') NOT NULL DEFAULT 'element' COMMENT 'тип элемента модуля',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `element_id` (`element_id`),
  KEY `module_name` (`module_name`(2))
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Подписка пользователей на новые комментарии';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_comments_mail`
--

LOCK TABLES `indf_comments_mail` WRITE;
/*!40000 ALTER TABLE `indf_comments_mail` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_comments_mail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_comments_param`
--

DROP TABLE IF EXISTS `indf_comments_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_comments_param` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `name1` varchar(250) NOT NULL DEFAULT '' COMMENT 'название',
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT 'тип',
  `module_name` varchar(50) NOT NULL DEFAULT '' COMMENT 'название модуля',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'подрядковый номер для сортировки',
  `required` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'обязательно для заполнения: 0 - нет, 1 - да',
  `show_in_list` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'показывать в списке: 0 - нет, 1 - да',
  `show_in_form_auth` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'показывать в форме авторизованным пользователям: 0 - нет, 1 - да',
  `show_in_form_no_auth` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'показывать в списке: 0 - нет, 1 - да',
  `text1` text COMMENT 'описание',
  `config` text COMMENT 'серилизованные настройки поля',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Дополнительные поля комментариев';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_comments_param`
--

LOCK TABLES `indf_comments_param` WRITE;
/*!40000 ALTER TABLE `indf_comments_param` DISABLE KEYS */;
INSERT INTO `indf_comments_param` VALUES (1,'Имя','text','',1,'1','1','0','1',NULL,NULL,'0');
/*!40000 ALTER TABLE `indf_comments_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_comments_param_element`
--

DROP TABLE IF EXISTS `indf_comments_param_element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_comments_param_element` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `value` text COMMENT 'значение',
  `param_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор характеристики из таблицы `indf_comments_param`',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор комментария из таблицы `indf_comments`',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `element_id` (`element_id`),
  KEY `param_id` (`param_id`),
  KEY `value` (`value`(5))
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Значения дополнительных полей комментариев';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_comments_param_element`
--

LOCK TABLES `indf_comments_param_element` WRITE;
/*!40000 ALTER TABLE `indf_comments_param_element` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_comments_param_element` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_comments_param_select`
--

DROP TABLE IF EXISTS `indf_comments_param_select`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_comments_param_select` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `param_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор характеристики из таблицы `indf_comments_param`',
  `name1` varchar(50) NOT NULL DEFAULT '' COMMENT 'значение',
  `value` varchar(1) NOT NULL DEFAULT '' COMMENT 'значение для типа характеристики «галочка»: 0 - нет, 1 - да',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'подрядковый номер для сортировки',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `param_id` (`param_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Варианты значения дополнительных полей комментариев с типом ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_comments_param_select`
--

LOCK TABLES `indf_comments_param_select` WRITE;
/*!40000 ALTER TABLE `indf_comments_param_select` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_comments_param_select` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_comments_parents`
--

DROP TABLE IF EXISTS `indf_comments_parents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_comments_parents` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор комментария из таблицы `indf_comments`',
  `parent_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор родителя комментария из таблицы `indf_comments`',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Родительские связи комментариев';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_comments_parents`
--

LOCK TABLES `indf_comments_parents` WRITE;
/*!40000 ALTER TABLE `indf_comments_parents` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_comments_parents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_config`
--

DROP TABLE IF EXISTS `indf_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_config` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `module_name` varchar(50) NOT NULL DEFAULT '' COMMENT 'название модуля',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT 'название настройки',
  `lang_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор языка сайта из таблицы `indf_languages`',
  `value` text COMMENT 'значение',
  `site_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор страницы сайта из таблицы `indf_site`',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=209 DEFAULT CHARSET=utf8 COMMENT='Настройки модулей';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_config`
--

LOCK TABLES `indf_config` WRITE;
/*!40000 ALTER TABLE `indf_config` DISABLE KEYS */;
INSERT INTO `indf_config` VALUES (1,'route','method',0,'1',0),(2,'route','translit_array',0,' |а|б|в|г|д|е|ё|ж|з|и|й|к|л|м|н|о|п|р|с|т|у|ф|х|ц|ч|ш|щ|ы|э|ю|я|А|Б|В|Г|Д|Е|Ё|Ж|З|И|Й|К|Л|М|Н|О|П|Р|С|Т|У|Ф|Х|Ц|Ч|Ш|Щ|Ы|Э|Ю|Я````-|a|b|v|g|d|e|yo|zh|z|i|y|k|l|m|n|o|p|r|s|t|u|f|kh|ts|ch|sh|sch|y|e|yu|ya|A|B|V|G|D|E|YO|ZH|Z|I|Y|K|L|M|N|O|P|R|S|T|U|F|KH|TS|CH|SH|SCH|Y|E|YU|YA',0),(3,'editor','images_variations_element',0,'a:1:{i:0;a:1:{s:2:\"id\";s:1:\"2\";}}',0),(4,'site','use_animation',0,'1',0),(5,'site','images_variations',0,'a:2:{i:0;a:2:{s:4:\"name\";s:6:\"medium\";s:2:\"id\";i:1;}i:1;a:2:{s:4:\"name\";s:5:\"large\";s:2:\"id\";i:3;}}',0),(6,'core','trial',0,'1498556862',0),(7,'site','keywords',0,'1',0),(8,'htmleditor','hide_site_blocks_2',1,'text',0),(9,'htmleditor','hide_site_blocks_4',1,'text',0),(10,'htmleditor','hide_site_blocks_8',1,'text',0),(11,'htmleditor','hide_site_blocks_9',1,'text',0),(12,'htmleditor','hide_site_blocks_10',1,'text',0),(13,'htmleditor','hide_site_blocks_11',1,'text',0),(14,'htmleditor','hide_site_blocks_12',1,'text',0),(15,'htmleditor','hide_site_blocks_13',1,'text',0),(16,'htmleditor','hide_site_blocks_14',1,'text',0),(17,'htmleditor','hide_site_blocks_15',1,'text',0),(18,'htmleditor','hide_site_blocks_16',1,'text',0),(19,'consultant','redhelper_color',0,'#aacc66',0),(20,'consultant','redhelper_chatX',0,'30',0),(21,'consultant','redhelper_chatY',0,'50',0),(22,'consultant','redhelper_header',0,'Наша компания',0),(23,'consultant','redhelper_topText',0,'Лучшие товары',0),(24,'consultant','redhelper_welcome',0,'Вам чем-нибудь помочь?',0),(25,'consultant','redhelper_inviteTime',0,'20',0),(26,'consultant','redhelper_chatWidth',0,'200',0),(27,'consultant','redhelper_chatHeight',0,'300',0),(28,'update','hash',0,'13e5b7efb3d0c642bb8263bd8ee6aca343d93d98',0),(29,'shop','cat',0,'1',0),(30,'shop','images_element',0,'1',0),(31,'shop','images_brand',0,'1',0),(32,'shop','use_animation',0,'1',0),(33,'shop','list_img_element',0,'1',0),(36,'shop','counter',0,'1',0),(37,'shop','nastr',0,'6',0),(38,'shop','nastr_cat',0,'10',0),(39,'shop','search_price',0,'1',0),(40,'shop','search_article',0,'1',0),(41,'shop','format_price_3',0,' ',0),(42,'shop','tax_name',0,'НДС',0),(43,'shop','tax',0,'18',0),(44,'shop','currency',0,'руб.',0),(45,'shop','yandex',0,'1',0),(46,'shop','currencyyandex',0,'RUR',0),(84,'subscribtion','subject',0,'Рассылка сайта %title (%url). %subject',0),(48,'shop','bid',0,'15',0),(49,'shop','order_redirect',0,'33',0),(50,'shop','mes',0,'Оплата заказа №%id на сумму %summ руб.',0),(51,'shop','subject',0,'Вы оформили заказ %id на сайте %title (%url).',0),(52,'shop','message',0,'Здравствуйте!<br>Вы оформили заказ на сайте %title (%url):<br><br>Номер заказа: %id<br>%order<br>Способ оплаты: %payment<br><br>%message<br><br>Спасибо за Ваш заказ! В ближайшее время мы с Вами свяжемся для подтверждения заказа',0),(53,'shop','subject_admin',0,'%title (%url). Новый заказ %id',0),(54,'shop','message_admin',0,'Здравствуйте, администратор сайта %title (%url)!<br>На сайте появился новый заказ номер %id: %order<br>Способ оплаты: %payment<br><br>%message',0),(55,'shop','subject_change_status',0,'Статус заказа изменен',0),(56,'shop','message_change_status',0,'Здравствуйте!<br>Статус заказ №%order изменен на «%status».',0),(57,'shop','desc_payment',0,'Oplata zakaza #%id',0),(58,'shop','payment_success_text',0,'<p>Спасибо, платеж успешно принят. В ближайшее время мы с Вами свяжемся для уточнения деталей заказа.</p>',0),(59,'shop','payment_fail_text',0,'<p>Извините, платеж не прошел.</p>',0),(60,'shop','subject_file_sale_message',0,'Вы оформили заказ %id на сайте %title (%url).',0),(61,'shop','file_sale_message',0,'Здравствуйте!<br>Вы оформили заказ на сайте %title (%url):<br><br>Номер заказа: %id<br>Файлы можно скачать по ссылкам в течении часа: %files<br><br>Спасибо за Ваш заказ!',0),(62,'shop','attachment_extensions',0,'zip, rar',0),(63,'shop','rel_two_sided',0,'1',0),(64,'shop','subject_waitlist',0,'Товар поступил на склад.',0),(65,'shop','message_waitlist',0,'Здравствуйте!<br>Товар <a href=\"%link\">%good</a> поступил на склад.',0),(66,'shop','images_variations_element',0,'a:4:{i:0;a:2:{s:4:\"name\";s:5:\"large\";s:2:\"id\";s:1:\"3\";}i:1;a:2:{s:4:\"name\";s:6:\"medium\";s:2:\"id\";s:1:\"1\";}i:2;a:2:{s:4:\"name\";s:7:\"preview\";s:2:\"id\";s:1:\"4\";}i:3;a:2:{s:4:\"name\";s:4:\"item\";s:2:\"id\";s:1:\"5\";}}',0),(67,'shop','images_variations_brand',0,'a:3:{i:0;a:2:{s:4:\"name\";s:5:\"large\";s:2:\"id\";s:1:\"3\";}i:1;a:2:{s:4:\"name\";s:6:\"medium\";s:2:\"id\";s:1:\"1\";}i:2;a:2:{s:4:\"name\";s:7:\"preview\";s:2:\"id\";s:1:\"4\";}}',0),(68,'shop','one_click',0,'1',0),(69,'shop','nameshop',0,'fishing',0),(70,'shop','comments',0,'1',0),(71,'shop','keywords',0,'1',0),(72,'shop','rating',0,'1',0),(73,'shop','sort',0,'0',0),(74,'shop','theme_list',0,'catalog.php',0),(75,'shop','theme_first_page',0,'catalog.php',0),(76,'shop','theme_list_brand',0,'catalog.php',0),(77,'shop','theme_list_param',0,'catalog.php',0),(78,'shop','theme_list_search',0,'catalog.php',0),(79,'shop','images_variations_cat',0,'a:2:{i:0;a:2:{s:4:\"name\";s:5:\"large\";s:2:\"id\";s:1:\"4\";}i:1;a:2:{s:4:\"name\";s:6:\"medium\";s:2:\"id\";s:1:\"4\";}}',0),(80,'shop','show_yandex_category',0,'0',0),(81,'shop','show_yandex_element',0,'0',0),(82,'shop','sendsmsadmin',0,'0',0),(83,'shop','use_count_goods',0,'0',0),(85,'subscribtion','message',0,'Рассылка сайта %title (%url). %text Для изменения списка категорий рассылок пройдите <a href=\"%link\">по ссылке</a>.<br>Если Вы хотите отписаться от рассылки, пройдите <a href=\"%actlink\">по ссылке</a>.',0),(86,'subscribtion','add_mail',0,'E-mail успешно добавлен. Вам отправлено уведомление.',0),(87,'subscribtion','subject_user',0,'Подписка на рассылку с  сайта %title (%url)',0),(88,'subscribtion','message_user',0,'Здравствуйте! Вы подписались на рассылку с сайта %title (%url).<br>Для изменения списка категорий рассылок пройдите <a href=\"%link\">по ссылке</a>.<br>Если Вы хотите отписаться от рассылки, пройдите <a href=\"%actlink\">по ссылке</a>.',0),(89,'geomap','backend',0,'yandex',0),(90,'geomap','config',0,'a:1:{s:11:\"yandex_zoom\";i:13;}',0),(91,'ab','geomap_element',0,'1',0),(92,'captcha','type',0,'captcha',0),(93,'bs','cat',0,'1',0),(94,'htmleditor','hide_bs_1',1,'text',0),(95,'news','images_element',0,'1',0),(96,'news','count_list',0,'2',0),(97,'news','count_child_list',0,'2',0),(98,'news','children_elements',0,'1',0),(99,'news','list_img_element',0,'1',0),(100,'news','use_animation',0,'1',0),(101,'news','format_date',0,'3',0),(102,'news','nastr',0,'10',0),(103,'news','nastr_cat',0,'10',0),(104,'news','rel_two_sided',0,'1',0),(105,'news','counter',0,'1',0),(106,'news','title_tpl',0,'%name, %category',0),(107,'news','keywords_tpl',0,'%name %category',0),(108,'news','images_variations_element',0,'a:3:{i:0;a:2:{s:4:\"name\";s:5:\"large\";s:2:\"id\";s:1:\"3\";}i:1;a:2:{s:4:\"name\";s:6:\"medium\";s:2:\"id\";s:1:\"1\";}i:2;a:2:{s:4:\"name\";s:7:\"preview\";s:2:\"id\";s:1:\"4\";}}',0),(115,'search','nastr',0,'10',0),(110,'news','comments',0,'1',0),(111,'news','keywords',0,'1',0),(112,'news','tags',0,'1',0),(113,'news','images_variations_cat',0,'a:2:{i:0;a:2:{s:4:\"name\";s:5:\"large\";s:2:\"id\";s:1:\"4\";}i:1;a:2:{s:4:\"name\";s:6:\"medium\";s:2:\"id\";s:1:\"4\";}}',0),(114,'news','rating',0,'1',0),(116,'search','count_history',0,'10',0),(117,'search','all_current_index_module_table',0,'',0),(118,'search','all_current_index_module_element',0,'',0),(119,'search','all_current_index_site',0,'',0),(120,'search','full_index',0,'1',0),(121,'feedback','security',0,'2',0),(122,'feedback','sendmailadmin',0,'1',0),(123,'feedback','add_message',0,'<div align=\"center\"><b>Спасибо за ваше сообщение!</b></div>',0),(124,'feedback','subject',0,'%title (%url). Обратная связь',0),(125,'feedback','message',0,'Здравствуйте!<br>Вы оставили сообщение в форме обратной связи на сайте %title (%url).<br><b>Сообщение:</b> %message <br><b>Ответ:</b> %answer',0),(126,'feedback','subject_admin',0,'%title (%url). Новое сообщение в рубрике Обратная связь',0),(127,'feedback','message_admin',0,'Здравствуйте, администратор сайта %title (%url)!<br>В рубрике Обратная связь появилось новое сообщение:<br>%message',0),(128,'users','captcha',0,'a:1:{i:0;s:1:\"0\";}',0),(129,'users','sendmailadmin',0,'1',0),(130,'users','act',0,'1',0),(131,'users','subject_admin',0,'%title (%url). Новый пользователь',0),(132,'users','message_admin',0,'Здравствуйте, администратор сайта %title (%url)!<br>На сайте появился новый пользователь: %fio (%login), %email.',0),(133,'users','mes',0,'Вы удачно зарегистрированы. Для активации аккаунта пройдите по ссылке, высланной на ваш e-mail.',0),(134,'users','subject',0,'Вы зарегистрированы на сайте %title (%url)',0),(135,'users','message',0,'Здравствуйте, %fio!<br>Вы зарегистрированы на сайте %title (%url).<br>Логин: %login<br>Пароль: %password<br>Для активации аккаунта пройдите по <a href=\"%actlink\">ссылке</a>.<br>Ссылка действует в течении суток.',0),(136,'users','subject_act',0,'Ваш аккаунт на сайте %title (%url) активирован администратором',0),(137,'users','message_act',0,'Здравствуйте, %fio!<br>Ваш аккаунт на сайте %title (%url) активирован администратором.<br>Логин: %login',0),(138,'users','mes_reminding',0,'На ваш e-mail отправлена ссылка на форму изменения пароля.',0),(139,'users','subject_reminding',0,'Восстановление доступа к сайту %title (%url).',0),(140,'users','message_reminding',0,'Здравствуйте, %fio!<br>Вы запросили восстановление доступа к сайту %title (%url).<br>Для изменения пароля пройдите <a href=\"%actlink\">по ссылке</a>.',0),(141,'users','subject_reminding_new_pass',0,'Новый пароль на сайте %title (%url)',0),(142,'users','message_reminding_new_pass',0,'Здравствуйте, %fio!<br>Вы изменили пароль на сайте %title (%url).<br>Логин: %login<br>Пароль: %password',0),(143,'users','avatar',0,'1',0),(144,'users','avatar_width',0,'50',0),(145,'users','avatar_height',0,'50',0),(146,'users','avatar_quality',0,'80',0),(147,'users','avatar_none',0,'1',0),(148,'keywords','max',0,'2',0),(149,'ab','keywords',0,'1',0),(150,'clauses','keywords',0,'1',0),(151,'faq','keywords',0,'1',0),(152,'files','keywords',0,'1',0),(153,'photo','keywords',0,'1',0),(154,'rating','security',0,'4',0),(155,'ab','rating',0,'1',0),(156,'clauses','rating',0,'1',0),(157,'files','rating',0,'1',0),(158,'photo','rating',0,'1',0),(159,'comments','captcha',0,'a:1:{i:0;s:1:\"0\";}',0),(160,'comments','format_date',0,'5',0),(161,'comments','user_name',0,'1',0),(162,'comments','error_insert_message',0,'Ваше сообщение уже имеется в базе.',0),(163,'comments','add_message',0,'Спасибо! Ваш комментарий будет проверен в ближайшее время и появится на сайте.',0),(164,'comments','count_level',0,'7',0),(165,'comments','nastr',0,'10',0),(166,'comments','use_mail',0,'1',0),(167,'comments','subject',0,'Новый комментарий на сайте %title (%url)',0),(168,'comments','message',0,'Здравствуйте! Вы подписались на комментарии на сайте %title (%url).<br>На странице появился <a href=\"%link\">новый комментарий</a>:<br>%message<br><br>Отписаться можете по <a href=\"%actlink\">ссылке</a>.',0),(169,'comments','sendmailadmin',0,'1',0),(170,'comments','subject_admin',0,'%title (%url). Новый комментарий',0),(171,'comments','message_admin',0,'Здравствуйте, администратор сайта %title (%url)! На странице <a href=\"%urlpage\">%urlpage</a> появился новый комментарий: %message',0),(172,'ab','comments',0,'1',0),(173,'clauses','comments',0,'1',0),(174,'faq','comments',0,'1',0),(175,'files','comments',0,'1',0),(176,'photo','comments',0,'1',0),(177,'photo','comments_cat',0,'1',0),(178,'map','all_current_index_module_type',0,'',0),(179,'map','all_current_index_module_element',0,'',0),(180,'map','all_current_index_site',0,'',0),(181,'map','full_index',0,'0',0),(182,'map','module_news_current_index_module_type',0,'',0),(183,'map','module_news_current_index_module_element',0,'',0),(184,'map','module_news_current_index_site',0,'',0),(185,'search','all_current_index_module_table',1,'',0),(186,'search','all_current_index_module_element',1,'',0),(187,'search','all_current_index_site',1,'',0),(188,'search','full_index',1,'1',0),(189,'map','full_index',1,'0',0),(190,'editor','images_timeedit',1,'1496828890',0),(191,'editor','images_max_size',1,'71916',0),(192,'editor','images_count',1,'16',0),(193,'core','md5',1,'393c5606c566b3ea542635792ffc2157',0),(194,'update','hash',1,'c4e841d5d59150b09f613e487352b9bca51959aa',0),(195,'core','trial',1,'0',0),(196,'shop','sendsmsadmin',1,'0',0),(197,'clauses','images_element',0,'1',0),(198,'clauses','list_img_element',0,'1',0),(199,'clauses','use_animation',0,'1',0),(200,'clauses','format_date',0,'2',0),(201,'clauses','nastr',0,'10',0),(202,'clauses','nastr_cat',0,'10',0),(203,'clauses','count_list',0,'3',0),(204,'clauses','count_child_list',0,'2',0),(205,'clauses','children_elements',0,'1',0),(206,'clauses','counter',0,'1',0),(207,'clauses','images_variations_element',0,'a:2:{i:0;a:2:{s:4:\"name\";s:6:\"medium\";s:2:\"id\";i:1;}i:1;a:2:{s:4:\"name\";s:5:\"large\";s:2:\"id\";i:3;}}',0),(208,'clauses','cat',0,'1',0);
/*!40000 ALTER TABLE `indf_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_custom`
--

DROP TABLE IF EXISTS `indf_custom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_custom` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT 'название',
  `created` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата создания',
  `current` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'текущая тема: 0 - нет, 1 - да',
  `text` text COMMENT 'описание',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Темы';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_custom`
--

LOCK TABLES `indf_custom` WRITE;
/*!40000 ALTER TABLE `indf_custom` DISABLE KEYS */;
INSERT INTO `indf_custom` VALUES (1,'my',1496828869,'0',NULL);
/*!40000 ALTER TABLE `indf_custom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_feedback`
--

DROP TABLE IF EXISTS `indf_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_feedback` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `created` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата создания',
  `site_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор страницы сайта из таблицы `indf_site`',
  `lang_id` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор языка сайта из таблицы `indf_languages`',
  `text` text COMMENT 'ответ',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор пользователя из таблицы `indf_users`',
  `admin_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'пользователь из таблицы `indf_users`, добавивший или первый отредктировавший сообщение в административной части',
  `readed` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'сообщение прочитано: 0 - нет, 1 - да',
  `url` text COMMENT 'страница, с которой отправлено сообщение',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Сообщения из обратной связи';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_feedback`
--

LOCK TABLES `indf_feedback` WRITE;
/*!40000 ALTER TABLE `indf_feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_feedback_param`
--

DROP TABLE IF EXISTS `indf_feedback_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_feedback_param` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `name1` varchar(250) NOT NULL DEFAULT '' COMMENT 'название',
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT 'тип',
  `site_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор страницы сайта из таблицы `indf_site`',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'подрядковый номер для сортировки',
  `required` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'обязательно для заполнения: 0 - нет, 1 - да',
  `text1` text COMMENT 'описание',
  `config` text COMMENT 'дополнительные настройки поля',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Поля конструктора формы обратной связи';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_feedback_param`
--

LOCK TABLES `indf_feedback_param` WRITE;
/*!40000 ALTER TABLE `indf_feedback_param` DISABLE KEYS */;
INSERT INTO `indf_feedback_param` VALUES (1,'Ваше имя','text',5,2,'0',NULL,NULL,'0'),(2,'Ваш e-mail','email',5,6,'1',NULL,NULL,'0'),(3,'Ваше сообщение','textarea',5,8,'0',NULL,NULL,'0'),(6,'Ваш телефон','text',5,7,'0',NULL,NULL,'0');
/*!40000 ALTER TABLE `indf_feedback_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_feedback_param_element`
--

DROP TABLE IF EXISTS `indf_feedback_param_element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_feedback_param_element` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `value` text COMMENT 'значение',
  `param_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор характеристики из таблицы `indf_feedback_param`',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор сообщения из таблицы `indf_feedback`',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `element_id` (`element_id`),
  KEY `param_id` (`param_id`),
  KEY `value` (`value`(5))
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Значения полей конструктора формы обратной связи, заполненны';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_feedback_param_element`
--

LOCK TABLES `indf_feedback_param_element` WRITE;
/*!40000 ALTER TABLE `indf_feedback_param_element` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_feedback_param_element` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_feedback_param_select`
--

DROP TABLE IF EXISTS `indf_feedback_param_select`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_feedback_param_select` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `param_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор характеристики из таблицы `indf_feedback_param`',
  `value` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT 'значение для типа характеристики «галочка»: 0 - нет, 1 - да',
  `name1` varchar(50) NOT NULL DEFAULT '' COMMENT 'значение',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'подрядковый номер для сортировки',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `param_id` (`param_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Варианты значений полей конструктора с типом список';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_feedback_param_select`
--

LOCK TABLES `indf_feedback_param_select` WRITE;
/*!40000 ALTER TABLE `indf_feedback_param_select` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_feedback_param_select` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_geomap`
--

DROP TABLE IF EXISTS `indf_geomap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_geomap` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор элемента модуля',
  `module_name` varchar(50) NOT NULL DEFAULT '' COMMENT 'название модуля',
  `element_type` enum('element','cat') NOT NULL DEFAULT 'element' COMMENT 'тип элемента модуля',
  `point` text COMMENT 'координаты точки',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `element_id` (`element_id`),
  KEY `module_name` (`module_name`(2))
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Точки на карте';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_geomap`
--

LOCK TABLES `indf_geomap` WRITE;
/*!40000 ALTER TABLE `indf_geomap` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_geomap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_images`
--

DROP TABLE IF EXISTS `indf_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_images` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `image_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор изображения из таблицы `indf_images`, если запись является ссылкой на изображение',
  `name` varchar(250) NOT NULL DEFAULT '' COMMENT 'название файла',
  `module_name` varchar(50) NOT NULL DEFAULT '' COMMENT 'название модуля',
  `element_type` enum('element','cat','brand') NOT NULL DEFAULT 'element' COMMENT 'тип элемента модуля',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор элемента модуля',
  `alt1` varchar(250) NOT NULL DEFAULT '' COMMENT 'атрибут alt',
  `title1` varchar(250) NOT NULL DEFAULT '' COMMENT 'атрибут title',
  `param_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор поля или характеристики с типом «изображения»',
  `size` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'размер файла',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'подрядковый номер для сортировки',
  `tmpcode` varchar(32) NOT NULL DEFAULT '' COMMENT 'временный идентификатор, если изображение прикрепляется к еще не созданному элементу',
  `created` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата создания',
  `folder_num` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'номер папки',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `module_name` (`module_name`(2)),
  KEY `element_id` (`element_id`),
  KEY `element_type` (`element_type`)
) ENGINE=MyISAM AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 COMMENT='Прикрепленные изображения';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_images`
--

LOCK TABLES `indf_images` WRITE;
/*!40000 ALTER TABLE `indf_images` DISABLE KEYS */;
INSERT INTO `indf_images` VALUES (1,0,'1_mozaikaquotmilediquot.jpg','shop','element',1,'','',0,0,1,'',1496828862,0,'0'),(2,0,'2_mozaikaquotmilediquot.jpg','shop','element',1,'','',0,0,2,'',1496828862,0,'0'),(3,0,'3_mozaikaquotmilediquot.jpg','shop','element',1,'','',0,0,3,'',1496828863,0,'0'),(4,0,'4_mozaikaquotmilediquot.jpg','shop','element',1,'','',0,0,4,'',1496828863,0,'0'),(5,0,'5_keramogranitquotgiorgioquot.jpg','shop','element',2,'','',0,0,5,'',1496828863,0,'0'),(6,0,'6_keramogranitquotgiorgioquot.jpg','shop','element',2,'','',0,0,6,'',1496828863,0,'0'),(7,0,'7_keramogranitquotgiorgioquot.jpg','shop','element',2,'','',0,0,7,'',1496828863,0,'0'),(8,0,'8_keramogranitquotgiorgioquot.jpg','shop','element',2,'','',0,0,8,'',1496828864,0,'0'),(9,0,'9_keramicheskayaplitkaquotvale.jpg','shop','element',3,'','',0,0,9,'',1496828864,0,'0'),(10,0,'10_keramicheskayaplitkaquotvale.jpg','shop','element',3,'','',0,0,10,'',1496828864,0,'0'),(11,0,'11_keramicheskayaplitkaquotvale.jpg','shop','element',3,'','',0,0,11,'',1496828864,0,'0'),(12,0,'12_keramicheskayaplitkaquotkera.jpg','shop','element',4,'','',0,0,12,'',1496828864,0,'0'),(13,0,'13_keramicheskayaplitkaquotkera.jpg','shop','element',4,'','',0,0,13,'',1496828864,0,'0'),(14,0,'14_keramicheskayaplitkaquotkera.jpg','shop','element',4,'','',0,0,14,'',1496828864,0,'0'),(15,0,'15_keramogranitquotkaleoquot.jpg','shop','element',6,'','',0,0,15,'',1496828865,0,'0'),(16,0,'16_keramogranitquotkaleoquot.jpg','shop','element',6,'','',0,0,16,'',1496828865,0,'0'),(17,0,'17_keramogranitquotkaleoquot.jpg','shop','element',6,'','',0,0,17,'',1496828865,0,'0'),(18,0,'18_keramogranitquotkaleoquot.jpg','shop','element',6,'','',0,0,18,'',1496828865,0,'0'),(19,0,'19_keramicheskayaplitkaquotvali.jpg','shop','element',7,'','',0,0,19,'',1496828865,0,'0'),(20,0,'20_keramicheskayaplitkaquotvali.jpg','shop','element',7,'','',0,0,20,'',1496828865,0,'0'),(21,0,'21_keramicheskayaplitkaquotvali.jpg','shop','element',7,'','',0,0,21,'',1496828865,0,'0'),(22,0,'22_keramicheskayaplitkaquotflio.jpg','shop','element',10,'','',0,0,22,'',1496828866,0,'0'),(23,0,'23_keramicheskayaplitkaquotflio.jpg','shop','element',10,'','',0,0,23,'',1496828866,0,'0'),(24,0,'24_keramicheskayaplitkaquotflio.jpg','shop','element',10,'','',0,0,24,'',1496828866,0,'0'),(25,0,'25_keramicheskayaplitkaquotmila.jpg','shop','element',11,'','',0,0,25,'',1496828866,0,'0'),(26,0,'26_keramicheskayaplitkaquotmila.jpg','shop','element',11,'','',0,0,26,'',1496828866,0,'0'),(27,0,'27_keramicheskayaplitkaquotmila.jpg','shop','element',11,'','',0,0,27,'',1496828866,0,'0'),(28,0,'28_keramogranitquotmagnifikoquot.jpg','shop','element',12,'','',0,0,28,'',1496828866,0,'0'),(29,0,'29_keramogranitquotmagnifikoquot.jpg','shop','element',12,'','',0,0,29,'',1496828867,0,'0'),(30,0,'30_keramogranitquotmagnifikoquot.jpg','shop','element',12,'','',0,0,30,'',1496828867,0,'0'),(31,0,'31_mozaikaquotricocoquot.jpg','shop','element',13,'','',0,0,31,'',1496828867,0,'0'),(32,0,'32_mozaikaquotricocoquot.jpg','shop','element',13,'','',0,0,32,'',1496828867,0,'0'),(33,0,'33_mozaikaquotricocoquot.jpg','shop','element',13,'','',0,0,33,'',1496828867,0,'0'),(34,0,'34_novayakollektsiya.jpg','news','element',3,'','',0,0,34,'',1496828867,0,'1'),(35,0,'35_myasnoy-magazin-na-pervoy-li.png','shop','element',14,'','',0,0,35,'',1497350461,0,'0'),(36,0,'36_ooo.jpg','shop','element',15,'','',0,0,36,'',1497451729,0,'0'),(37,0,'37_proizvodstvo-plastikovykh-o.jpg','shop','element',16,'','',0,0,37,'',1497452824,0,'0'),(38,0,'38_proizvodstvo-plastikovykh-o.jpg','shop','element',16,'','',0,0,38,'',1497452824,0,'0'),(39,0,'39_proizvodstvo-plastikovykh-o.jpg','shop','element',16,'','',0,0,39,'',1497452824,0,'0'),(40,0,'40_proizvodstvo-profnastila-k.jpg','shop','element',17,'','',0,0,40,'',1497453612,0,'0'),(41,0,'41_nastroyka-sayta.jpg','news','element',4,'','',0,0,41,'',1497455940,0,'0'),(44,0,'44_rabota-v-invest82.jpg','news','element',5,'','',0,0,44,'',1497470184,0,'0'),(43,0,'43_otkrytie-novykh-i-razvivayusch.jpg','clauses','element',1,'','',0,0,43,'',1497468886,0,'0'),(45,0,'45_categories-of-buyers-800x300.jpg','editor','element',0,'','',0,0,45,'',1497470254,0,'0');
/*!40000 ALTER TABLE `indf_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_images_editor_folders`
--

DROP TABLE IF EXISTS `indf_images_editor_folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_images_editor_folders` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `parent_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор папки-родителя из таблицы `indf_images_editor_folders`',
  `name` varchar(250) NOT NULL DEFAULT '' COMMENT 'название',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Папки изображений в плагине для визуального редактора';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_images_editor_folders`
--

LOCK TABLES `indf_images_editor_folders` WRITE;
/*!40000 ALTER TABLE `indf_images_editor_folders` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_images_editor_folders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_images_variations`
--

DROP TABLE IF EXISTS `indf_images_variations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_images_variations` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `name` varchar(250) NOT NULL DEFAULT '' COMMENT 'название',
  `folder` varchar(20) NOT NULL DEFAULT '' COMMENT 'название папки',
  `quality` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT 'качество для изображений в формет JPEG',
  `param` text COMMENT 'информация о применяемых действиях',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Варианты загрузки изображений';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_images_variations`
--

LOCK TABLES `indf_images_variations` WRITE;
/*!40000 ALTER TABLE `indf_images_variations` DISABLE KEYS */;
INSERT INTO `indf_images_variations` VALUES (1,'Маленькое изображение (превью)','small',90,'a:1:{i:0;a:4:{s:4:\"name\";s:6:\"resize\";s:5:\"width\";s:3:\"200\";s:6:\"height\";s:3:\"200\";s:3:\"max\";i:0;}}','0'),(2,'Среднее изображение','medium',90,'a:2:{i:0;a:4:{s:4:\"name\";s:6:\"resize\";s:5:\"width\";s:3:\"460\";s:6:\"height\";s:3:\"460\";s:3:\"max\";i:1;}i:1;a:7:{s:4:\"name\";s:4:\"crop\";s:5:\"width\";s:3:\"460\";s:6:\"height\";s:3:\"460\";s:8:\"vertical\";s:3:\"top\";s:11:\"vertical_px\";s:0:\"\";s:10:\"horizontal\";s:4:\"left\";s:13:\"horizontal_px\";s:0:\"\";}}','0'),(3,'Большое изображение (полная версия)','large',90,'a:1:{i:0;a:4:{s:4:\"name\";s:6:\"resize\";s:5:\"width\";i:1200;s:6:\"height\";i:1200;s:3:\"max\";i:0;}}','0'),(4,'Превью товара','preview',90,'a:2:{i:0;a:4:{s:4:\"name\";s:6:\"resize\";s:5:\"width\";s:2:\"60\";s:6:\"height\";s:2:\"60\";s:3:\"max\";i:1;}i:1;a:7:{s:4:\"name\";s:4:\"crop\";s:5:\"width\";s:2:\"60\";s:6:\"height\";s:2:\"60\";s:8:\"vertical\";s:3:\"top\";s:11:\"vertical_px\";s:0:\"\";s:10:\"horizontal\";s:4:\"left\";s:13:\"horizontal_px\";s:0:\"\";}}','0'),(5,'Больше изображение в карточке','item',80,'a:2:{i:0;a:4:{s:4:\"name\";s:6:\"resize\";s:5:\"width\";s:3:\"460\";s:6:\"height\";s:3:\"460\";s:3:\"max\";i:1;}i:1;a:7:{s:4:\"name\";s:4:\"crop\";s:5:\"width\";s:3:\"460\";s:6:\"height\";s:3:\"460\";s:8:\"vertical\";s:3:\"top\";s:11:\"vertical_px\";s:0:\"\";s:10:\"horizontal\";s:4:\"left\";s:13:\"horizontal_px\";s:0:\"\";}}','0');
/*!40000 ALTER TABLE `indf_images_variations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_keywords`
--

DROP TABLE IF EXISTS `indf_keywords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_keywords` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `text` text COMMENT 'ключевое слово',
  `link` text COMMENT 'ссылка',
  `act1` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'показывать на сайте: 0 - нет, 1 - да',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Ключевые слова для перелинковки';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_keywords`
--

LOCK TABLES `indf_keywords` WRITE;
/*!40000 ALTER TABLE `indf_keywords` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_keywords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_languages`
--

DROP TABLE IF EXISTS `indf_languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_languages` (
  `id` tinyint(2) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT 'название',
  `shortname` varchar(10) NOT NULL DEFAULT '' COMMENT 'скоращенное название',
  `base_admin` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'язык является основным для административной части: 0 - нет, 1 - да',
  `base_site` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'язык является основным для пользовательской части: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Языки сайта';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_languages`
--

LOCK TABLES `indf_languages` WRITE;
/*!40000 ALTER TABLE `indf_languages` DISABLE KEYS */;
INSERT INTO `indf_languages` VALUES (1,'ru','ru','1','1');
/*!40000 ALTER TABLE `indf_languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_languages_translate`
--

DROP TABLE IF EXISTS `indf_languages_translate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_languages_translate` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `text` text COMMENT 'описание',
  `text_translate` text COMMENT 'перевод',
  `lang_id` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор языка из таблицы `indf_languages`',
  `module_name` varchar(50) NOT NULL DEFAULT '' COMMENT 'название модуля, для которого применим перевод',
  `type` enum('admin','site') NOT NULL DEFAULT 'admin' COMMENT 'часть сайта: admin - административная, site - пользовательская',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Перевод интерфейса';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_languages_translate`
--

LOCK TABLES `indf_languages_translate` WRITE;
/*!40000 ALTER TABLE `indf_languages_translate` DISABLE KEYS */;
INSERT INTO `indf_languages_translate` VALUES (1,'Акции','Акции (Продано)',1,'shop','site'),(2,'Хиты продаж','Хиты продаж - Конфиденциально',1,'shop','site');
/*!40000 ALTER TABLE `indf_languages_translate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_log`
--

DROP TABLE IF EXISTS `indf_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `ip` varchar(20) NOT NULL DEFAULT '' COMMENT 'IP-адрес пользователя',
  `created` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата в формате UNIXTIME',
  `count` int(11) unsigned NOT NULL DEFAULT '1' COMMENT 'количество неудачных попыток',
  `info` text COMMENT 'дополнительная информация',
  PRIMARY KEY (`id`),
  KEY `ip` (`ip`(4))
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Лог неудачных попыток авторизации';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_log`
--

LOCK TABLES `indf_log` WRITE;
/*!40000 ALTER TABLE `indf_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_log_note`
--

DROP TABLE IF EXISTS `indf_log_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_log_note` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `module_name` varchar(50) NOT NULL DEFAULT '' COMMENT 'название модуля',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор элемента модуля',
  `element_type` enum('element','cat') NOT NULL DEFAULT 'element' COMMENT 'тип элемента модуля',
  `note` int(7) unsigned NOT NULL DEFAULT '0' COMMENT 'оценка',
  `created` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата создания',
  `ip` varchar(62) NOT NULL DEFAULT '' COMMENT 'IP-адрес пользователя',
  `session_id` varchar(64) NOT NULL DEFAULT '' COMMENT 'идентификатор сессии из таблицы `indf_sessions`',
  `include_name` varchar(10) NOT NULL DEFAULT '' COMMENT 'подключенный модуль',
  PRIMARY KEY (`id`),
  KEY `element_id` (`element_id`),
  KEY `session_id` (`session_id`(2)),
  KEY `include_name` (`include_name`(2)),
  KEY `module_name` (`module_name`(2))
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Лог голосований и оценок';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_log_note`
--

LOCK TABLES `indf_log_note` WRITE;
/*!40000 ALTER TABLE `indf_log_note` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_log_note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_map_index`
--

DROP TABLE IF EXISTS `indf_map_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_map_index` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `url` text COMMENT 'ссылка',
  `module_name` varchar(50) NOT NULL DEFAULT '' COMMENT 'название модуля',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор элемента модуля',
  `element_type` enum('element','cat','param','brand') NOT NULL DEFAULT 'element' COMMENT 'тип элемента модуля',
  `timeedit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'время последнего редактирования',
  `changefreq` enum('always','hourly','daily','weekly','monthly','yearly','never') NOT NULL DEFAULT 'always' COMMENT 'Changefreq',
  `priority` varchar(3) NOT NULL DEFAULT '' COMMENT 'Priority',
  `date_start` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата начала показа',
  `date_finish` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата окончания показа',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COMMENT='Индекс для файла sitemap.xml';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_map_index`
--

LOCK TABLES `indf_map_index` WRITE;
/*!40000 ALTER TABLE `indf_map_index` DISABLE KEYS */;
INSERT INTO `indf_map_index` VALUES (4,'kontaktyROUTE_END','site',28,'element',1496831683,'always','',0,0,'0'),(5,'o-nasROUTE_END','site',4,'element',1496833027,'always','',0,0,'0'),(6,'shop/gotovyy-biznesROUTE_END','shop',25,'cat',1496908007,'monthly','',0,0,'0'),(9,'shop/kommercheskaya-nedvizhimostROUTE_END','shop',26,'cat',1496909908,'monthly','',0,0,'0'),(8,'shop/oborudovanieROUTE_END','shop',27,'cat',1496908393,'monthly','',0,0,'0'),(41,'clauses/stati/otkrytie-novykh-i-razvivayuschikhsya-rynkov-v-krymROUTE_END','clauses',1,'element',1497469140,'monthly','',0,0,'0'),(39,'clauses/statiROUTE_END','clauses',1,'cat',1497469060,'monthly','',0,0,'0'),(20,'shop/gotovyy-biznes/myasnoy-magazin-na-pervoy-liniiROUTE_END','shop',14,'element',1497451364,'monthly','',0,0,'0'),(16,'shop/gotovyy-biznes/torgovlya-i-magazinyROUTE_END','shop',31,'cat',1497351005,'monthly','',0,0,'0'),(22,'shop/gotovyy-biznes/oooROUTE_END','shop',32,'cat',1497451635,'monthly','',0,0,'0'),(23,'shop/gotovyy-biznes/ooo15ROUTE_END','shop',15,'element',1497451816,'monthly','',0,0,'0'),(24,'shop/gotovyy-biznes/proizvodstvoROUTE_END','shop',33,'cat',1497452489,'monthly','',0,0,'0'),(26,'shop/gotovyy-biznes/proizvodstvo-plastikovykh-okonROUTE_END','shop',16,'element',1497452868,'monthly','',0,0,'0'),(30,'shop/oborudovanie/proizvodstvo-profnastila-krysha-zaborROUTE_END','shop',17,'element',1497453779,'monthly','',0,0,'0'),(33,'news/nastroyka-saytaROUTE_END','news',4,'element',1497456129,'monthly','',0,0,'0'),(36,'','site',1,'element',1497456511,'always','',0,0,'0'),(42,'shop/ischuROUTE_END','shop',34,'cat',1497469408,'monthly','',0,0,'0'),(43,'shop/rabota-v-invest82ROUTE_END','shop',35,'cat',1497469762,'monthly','',0,0,'0'),(51,'news/rabota-v-invest82ROUTE_END','news',5,'element',1497472243,'monthly','',0,0,'0');
/*!40000 ALTER TABLE `indf_map_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_menu`
--

DROP TABLE IF EXISTS `indf_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_menu` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `name1` varchar(100) NOT NULL DEFAULT '' COMMENT 'название',
  `module_name` varchar(50) NOT NULL DEFAULT '' COMMENT 'название модуля',
  `element_type` enum('element','cat','brand','param') NOT NULL DEFAULT 'element' COMMENT 'тип элемента модуля',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор элемента модуля',
  `cat_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор меню из таблицы `indf_menu_category`',
  `parent_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор пункта меню - родителя из таблицы `indf_menu`',
  `count_children` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'количество вложенных пунтов',
  `othurl` varchar(250) NOT NULL DEFAULT '' COMMENT 'внешнаяя ссылка',
  `access` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'доступ ограничен: 0 - нет, 1 - да',
  `date_start` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата начала показа',
  `date_finish` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата окончания показа',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'подрядковый номер для сортировки',
  `act1` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'показывать на сайте: 0 - нет, 1 - да',
  `text1` varchar(255) NOT NULL DEFAULT '' COMMENT 'описание пункта меню',
  `attributes` varchar(250) NOT NULL DEFAULT '' COMMENT 'атрибуты ссылки',
  `target_blank` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'открывать в новом окне',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=MyISAM AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COMMENT='Пункты меню';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_menu`
--

LOCK TABLES `indf_menu` WRITE;
/*!40000 ALTER TABLE `indf_menu` DISABLE KEYS */;
INSERT INTO `indf_menu` VALUES (1,'О нас','site','element',4,1,0,1,'','0',0,0,2,'1','','','0','0'),(3,'Контакты','site','element',28,1,0,0,'','0',0,0,1,'1','','','0','0'),(4,'Керамическая плитка','shop','cat',1,2,0,3,'','0',0,0,2,'1','','','0','1'),(5,'Португалия','shop','cat',22,2,4,0,'','0',0,0,22,'1','','','0','1'),(6,'Турция','shop','cat',23,2,4,0,'','0',0,0,23,'1','','','0','1'),(7,'Беларусь','shop','cat',24,2,4,0,'','0',0,0,24,'1','','','0','1'),(8,'Керамогранит','shop','cat',2,2,0,0,'','0',0,0,1,'1','','','0','1'),(9,'Россия','shop','cat',12,2,8,0,'','0',0,0,12,'1','','','0','1'),(10,'Керамин','shop','cat',19,2,9,0,'','0',0,0,19,'1','','','0','1'),(11,'Belani','shop','cat',20,2,9,0,'','0',0,0,20,'1','','','0','1'),(12,'Китай','shop','cat',13,2,8,0,'','0',0,0,13,'1','','','0','1'),(13,'Del Conca','shop','cat',17,2,12,0,'','0',0,0,17,'1','','','0','1'),(31,'Статьи','site','element',37,0,0,1,'','0',0,0,25,'1','','','0','1'),(14,'Vitra','shop','cat',18,2,12,0,'','0',0,0,18,'1','','','0','1'),(15,'Италия','shop','cat',14,2,8,0,'','0',0,0,14,'1','','','0','1'),(16,'Сопутствующие товары','shop','cat',3,2,0,0,'','0',0,0,8,'1','','','0','1'),(17,'Мозаика','shop','cat',4,2,0,0,'','0',0,0,4,'1','','','0','1'),(18,'Тёплый пол','shop','cat',6,2,0,0,'','0',0,0,6,'1','','','0','1'),(19,'Зеркальная плитка','shop','cat',7,2,0,0,'','0',0,0,7,'1','','','0','1'),(20,'Новости','site','element',23,1,0,0,'','0',0,0,3,'1','','','0','0'),(21,'Обратная связь','site','element',5,1,1,0,'','0',0,0,13,'1','','','0','0'),(22,'Готовый бизнес','shop','cat',25,2,0,3,'','0',0,0,28,'1','','','0','0'),(23,'Ком. недвижимость','shop','cat',26,2,0,0,'','0',0,0,26,'1','','','0','1'),(24,'Оборудование','shop','cat',27,2,0,0,'','0',0,0,29,'1','','','0','0'),(25,'Франшизы','shop','cat',28,2,0,0,'','0',0,0,30,'0','','','0','0'),(26,'Услуги','shop','cat',29,2,0,0,'','0',0,0,31,'0','','','0','0'),(27,'Аренда','shop','cat',30,2,0,0,'','0',0,0,38,'0','','','0','0'),(28,'Торговля и магазины','shop','cat',31,2,22,0,'','0',0,0,31,'1','','','0','0'),(29,'ООО','shop','cat',32,2,22,0,'','0',0,0,32,'1','','','0','0'),(30,'Производство','shop','cat',33,2,22,0,'','0',0,0,33,'1','','','0','0'),(32,'Статьи','clauses','cat',1,1,31,0,'','0',0,0,1,'1','','','0','1'),(33,'Статьи','clauses','cat',1,1,0,0,'','0',0,0,19,'1','','','0','0'),(34,'Ищу','shop','cat',34,1,0,0,'','0',0,0,34,'1','','','0','0'),(35,'Ищу','shop','cat',34,2,0,0,'','0',0,0,34,'1','','','0','0'),(36,'Работа в Инвест82','news','element',5,1,0,0,'','0',0,0,35,'1','','','0','0');
/*!40000 ALTER TABLE `indf_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_menu_category`
--

DROP TABLE IF EXISTS `indf_menu_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_menu_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `name1` varchar(100) NOT NULL DEFAULT '' COMMENT 'название',
  `show_title` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'показывать заголовок: 0 - нет, 1 - да',
  `show_all_level` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'выводить сразу все уровни вложенности: 0 - нет, 1 - да',
  `hide_parent_link` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'не выводить ссылку, если есть вложенные пункты: 0 - нет, 1 - да',
  `act1` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'показывать на сайте: 0 - нет, 1 - да',
  `access` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'доступ ограничен: 0 - нет, 1 - да',
  `current_link` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'текущий пункт ссылкой: 0 - нет, 1 - да',
  `only_image` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'не отображать имя пункта меню, если используется изображние: 0 - нет, 1 - да',
  `menu_template` varchar(100) NOT NULL DEFAULT '' COMMENT 'шаблон вывода меню',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'подрядковый номер для сортировки',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Меню';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_menu_category`
--

LOCK TABLES `indf_menu_category` WRITE;
/*!40000 ALTER TABLE `indf_menu_category` DISABLE KEYS */;
INSERT INTO `indf_menu_category` VALUES (1,'Меню верхнее','0','1','0','1','0','1','0','',1,'0'),(2,'Меню интернет-магазин','0','1','0','1','0','1','0','',2,'0');
/*!40000 ALTER TABLE `indf_menu_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_menu_category_site_rel`
--

DROP TABLE IF EXISTS `indf_menu_category_site_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_menu_category_site_rel` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор пункта меню из таблицы `indf_menu`',
  `site_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор страницы сайта из таблицы `indf_site`',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Данные о том, на каких страницах сайта выводится меню';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_menu_category_site_rel`
--

LOCK TABLES `indf_menu_category_site_rel` WRITE;
/*!40000 ALTER TABLE `indf_menu_category_site_rel` DISABLE KEYS */;
INSERT INTO `indf_menu_category_site_rel` VALUES (3,1,0,'0'),(4,2,0,'0');
/*!40000 ALTER TABLE `indf_menu_category_site_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_menu_parents`
--

DROP TABLE IF EXISTS `indf_menu_parents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_menu_parents` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор пункта меню из таблицы `indf_menu`',
  `parent_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор пункта меню - родителя из таблицы `indf_menu`',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='Родительские связи пунктов меню';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_menu_parents`
--

LOCK TABLES `indf_menu_parents` WRITE;
/*!40000 ALTER TABLE `indf_menu_parents` DISABLE KEYS */;
INSERT INTO `indf_menu_parents` VALUES (1,5,4,'1'),(2,6,4,'1'),(3,7,4,'1'),(4,9,8,'1'),(5,10,9,'1'),(6,11,9,'1'),(7,12,8,'1'),(8,13,12,'1'),(9,14,12,'1'),(10,15,8,'1'),(11,21,1,'0'),(12,28,22,'0'),(13,29,22,'0'),(14,30,22,'0'),(15,32,31,'1');
/*!40000 ALTER TABLE `indf_menu_parents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_mistakes`
--

DROP TABLE IF EXISTS `indf_mistakes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_mistakes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT 'ссылка на сайте',
  `created` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата создания',
  `selected_text` text COMMENT 'выделенный текст с ошибкой',
  `comment` text COMMENT 'комментарий пользователя',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Ошибки на сайте, добавленные пользователями';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_mistakes`
--

LOCK TABLES `indf_mistakes` WRITE;
/*!40000 ALTER TABLE `indf_mistakes` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_mistakes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_modules`
--

DROP TABLE IF EXISTS `indf_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_modules` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT 'название',
  `module_name` varchar(50) NOT NULL DEFAULT '' COMMENT 'название основного модуля',
  `site` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'используется на сайте: 0 - нет, 1 - да',
  `site_page` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'подключается к странице сайта: 0 - нет, 1 - да',
  `admin` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'используется в административной части: 0 - нет, 1 - да',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT 'название для пользователей',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COMMENT='Модули';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_modules`
--

LOCK TABLES `indf_modules` WRITE;
/*!40000 ALTER TABLE `indf_modules` DISABLE KEYS */;
INSERT INTO `indf_modules` VALUES (1,'service','core','1','0','1','Модули и БД'),(2,'admin','core','0','0','1','Страницы админки'),(3,'config','core','0','0','1','Параметры сайта'),(4,'images','core','1','0','1','Изображения'),(5,'attachments','core','1','0','1','Прикрепленные файлы'),(6,'menu','core','1','0','1','Меню'),(7,'site','core','1','0','1','Страницы сайта'),(8,'consultant','consultant','1','0','1','On-line консультант'),(9,'bbcode','core','1','0','0','Bbcode'),(10,'update','core','1','0','1','Обновление DIAFAN.CMS'),(11,'payment','payment','1','0','1','Оплата'),(12,'languages','core','1','0','1','Языки сайта'),(13,'shop','shop','1','1','1','Интернет-магазин'),(14,'cart','shop','1','1','0','Корзина'),(15,'wishlist','shop','1','1','0','Отложенные'),(16,'delivery','shop','1','0','1','Служба доставки'),(17,'paginator','core','1','0','1','Постраничная навигация'),(18,'subscribtion','subscribtion','1','1','1','Рассылки'),(19,'geomap','geomap','1','1','1','Геокарта'),(20,'captcha','core','1','0','1','Captcha'),(21,'dashboard','core','0','0','1','События'),(22,'bs','bs','1','0','1','Баннеры'),(23,'trash','core','0','0','1','Корзина'),(24,'mistakes','mistakes','1','0','1','Ошибки на сайте'),(25,'news','news','1','1','1','Новости'),(26,'search','search','1','1','1','Поиск'),(27,'feedback','feedback','1','1','1','Обратная связь'),(28,'users','core','1','0','1','Пользователи'),(29,'userpage','core','1','1','0','Страница пользователя'),(30,'usersettings','core','1','1','0','Настройки аккаунта'),(31,'registration','core','1','1','0','Регистрация'),(32,'reminding','core','1','1','0','Восстановление доступа'),(33,'keywords','keywords','1','0','1','Перелинковка'),(34,'custom','core','1','0','1','Темы и дизайн'),(35,'rating','rating','1','0','1','Рейтинг'),(36,'comments','comments','1','0','1','Комментарии'),(37,'useradmin','core','1','0','1','Панель быстрого редактирования'),(38,'map','map','1','1','0','Карта сайта'),(39,'csseditor','csseditor','0','0','1','Цветовое оформление'),(40,'clauses','clauses','1','1','1','Статьи');
/*!40000 ALTER TABLE `indf_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_news`
--

DROP TABLE IF EXISTS `indf_news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_news` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `name1` text COMMENT 'название',
  `act1` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'показывать на сайте: 0 - нет, 1 - да',
  `map_no_show` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'не показывать на карте сайта: 0 - нет, 1 - да',
  `changefreq` enum('always','hourly','daily','weekly','monthly','yearly','never') NOT NULL DEFAULT 'always' COMMENT 'Changefreq для sitemap.xml',
  `priority` varchar(3) NOT NULL DEFAULT '' COMMENT 'Priority для sitemap.xml',
  `noindex` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'не индексировать: 0 - нет, 1 - да',
  `created` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата создания',
  `date_start` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата начала показа',
  `date_finish` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата окончания показа',
  `cat_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор основной категории из таблицы `indf_news_category`',
  `site_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор страницы сайта из таблицы `indf_site`',
  `keywords1` varchar(250) NOT NULL DEFAULT '' COMMENT 'ключевые слова, тег Keywords',
  `descr1` text COMMENT 'описание, тэг Description',
  `canonical1` varchar(100) NOT NULL DEFAULT '' COMMENT 'канонический тег',
  `title_meta1` varchar(250) NOT NULL DEFAULT '' COMMENT 'заголовок окна в браузере, тег Title',
  `anons1` text COMMENT 'анонс',
  `anons_plus1` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'добавлять анонс к описанию: 0 - нет, 1 - да',
  `text1` text COMMENT 'описание',
  `prior` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'важно, всегда сверху: 0 - нет, 1 - да',
  `timeedit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'время последнего изменения в формате UNIXTIME',
  `admin_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'пользователь из таблицы `indf_users`, добавивший или первый отредктировавший новость в административной части',
  `access` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'доступ ограничен: 0 - нет, 1 - да',
  `theme` varchar(50) NOT NULL DEFAULT '' COMMENT 'шаблон страницы сайта',
  `view` varchar(50) NOT NULL DEFAULT '' COMMENT 'шаблон модуля',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Новости';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_news`
--

LOCK TABLES `indf_news` WRITE;
/*!40000 ALTER TABLE `indf_news` DISABLE KEYS */;
INSERT INTO `indf_news` VALUES (2,'Скидка до 50% на серию &quot;Selino&quot;','1','0','always','','0',1493545667,0,0,0,23,'',NULL,'','','<p>Время действия акции ограничено.</p>','0','<p>Можно написать любой объем текста, но желательно уложиться в несколько абзацев, ведь пользователи интернета ценят краткость и предметность. Лучше&nbsp;<strong>выделить</strong>&nbsp;какие-то значимые участки, текст можно&nbsp;<em>отформатировать</em>, как в Word, разместить таблицы, изображения и&nbsp;<a href=\"http://theme.diafantest.ru/\">ссылки</a>&nbsp;на другие страницы.</p>\r\n<p>Чтобы отредактировать этот текст прямо на этой странице, нажмите &laquo;Быстрое редактирование&raquo; на панели вверху страницы. Или &laquo;Администрирование&raquo;, чтобы перейти на редактирование этой страницы в административной панели.</p>','0',1496828867,0,'0','','','1'),(3,'Новая коллекция','1','0','always','','0',1496601224,0,0,0,23,'',NULL,'','','<p>Уже во всех наших магазинах!</p>','0','<p>Можно написать любой объем текста, но желательно уложиться в несколько абзацев, ведь пользователи интернета ценят краткость и предметность. Лучше&nbsp;<strong>выделить</strong>&nbsp;какие-то значимые участки, текст можно&nbsp;<em>отформатировать</em>, как в Word, разместить таблицы, изображения и&nbsp;<a href=\"http://theme.diafantest.ru/\">ссылки</a>&nbsp;на другие страницы.</p>\r\n<p>Чтобы отредактировать этот текст прямо на этой странице, нажмите &laquo;Быстрое редактирование&raquo; на панели вверху страницы. Или &laquo;Администрирование&raquo;, чтобы перейти на редактирование этой страницы в административной панели.</p>','0',1496828867,0,'0','','','1'),(4,'Настройка сайта','1','0','monthly','0','0',1497455880,0,0,0,23,'','','','','<p>Началось</p>','0','<p>Идет процесс настройки сайта, надеюсь в ближайшие дни сайт будет выглядеть соответственно.&nbsp;</p>\r\n<p>Повысится юзабилити и постепенно наполнится контент.&nbsp;</p>\r\n<p>Если у кого то есть замечания или предложения, прошу звонить или писать email.&nbsp;</p>','0',1497456129,1,'0','','','0'),(5,'Работа в Инвест82','1','0','monthly','0','0',1497469980,0,0,0,23,'','','','','','0','<p><span>Люди &mdash; это главная ценность в &laquo;Инвест82&raquo;. Нам важно, чтобы каждый сотрудник имел перспективу роста и развития внутри компании и получал удовольствие от своей работы. Посмотри, какие возможности открываются перед работниками компании &laquo;Инвест82&raquo;.</span></p>\r\n<h2 class=\"restaurants__service-title\">Сердце &laquo;Инвест82&raquo;</h2>\r\n<div class=\"restaurants__service-overview\"><span style=\"font-size: 14pt;\">Команда Бизнес-брокеров в Симферополе. Офис</span></div>\r\n<div class=\"restaurants__service-desc\">\r\n<p><span style=\"font-size: 14pt;\">Команда бизнес-брокеров симферопольского офиса во главе с директором ежедневно создают гостеприимную атмосферу и комфорт, для того чтобы нашим клиентам и инвесторам хотелось приходить в офисы &laquo;Инвест82&raquo; снова и снова.&nbsp;</span><br><br><span style=\"font-size: 14pt;\">Сотрудники этого отдела напрямую задействованы в продажах готового бизнеса в Крыму, оптимизации и расширении услуг, чтобы офисы продолжали оставаться любимым местом для наших клиентов.</span></p>\r\n<p></p>\r\n<h2 class=\"restaurants__service-title\">Качество во всем</h2>\r\n<div class=\"restaurants__service-overview\"><span style=\"font-size: 14pt;\">Отдел работы с бизнесами в Симферополе.</span></div>\r\n<div class=\"restaurants__service-desc\">\r\n<p><span style=\"font-size: 14pt;\">Отдел контроля качества бизнесов внимательно следит за всеми процессами, происходящими в конкретном бизнесе. Прибыльность бизнеса зависит от используемой бизнес модели, а также качество выполнения задач и процессов напрямую зависит от сотрудников и руководителя</span><span style=\"font-size: 14pt;\">.&nbsp;</span><br><br><span style=\"font-size: 14pt;\">В &laquo;Инвест82&raquo; создана уникальная система работы с бизнесами, позволяющая отслеживать и гарантировать заявленную прибыль перед покупкой бизнеса в Крыму.</span></p>\r\n<p><span style=\"font-size: 14pt;\"></span></p>\r\n<h2 class=\"restaurants__service-title\">Расстояний не существует</h2>\r\n<div class=\"restaurants__service-overview\"><span style=\"font-size: 14pt;\">Информационные технологии</span></div>\r\n<div class=\"restaurants__service-desc\">\r\n<p><span style=\"font-size: 14pt;\">Успех любого бизнеса зависит от налаженной коммуникации всех его частей между собой.&nbsp;</span><br><br><span style=\"font-size: 14pt;\">Отдел информационных технологий обеспечивает эффективную поддержку связи всех Симферопольских офисов. &laquo;Инвест82&raquo; &mdash; современная технологичная компания, поэтому для нас очень важно иметь постоянный доступ по всему Крыму к самым удаленным точкам в любое время.</span></p>\r\n<p><span style=\"font-size: 14pt;\"></span></p>\r\n<h2 class=\"restaurants__service-title\">Только вперед</h2>\r\n<div class=\"restaurants__service-overview\"><span style=\"font-size: 14pt;\">Развитие компании</span></div>\r\n<div class=\"restaurants__service-desc\">\r\n<p><span style=\"font-size: 14pt;\">&laquo;Инвест82&raquo; &mdash; компания, которая находится в постоянном развитии. Мы все время расширяемся, и нам требуются новые площади для офисов в Симферополе. Именно отдел развития &mdash; наш двигатель роста в данном направлении. Его специалисты занимаются поиском, арендой и покупкой площадей по всему Крыму для открытия новых офисов.</span></p>\r\n<p><span style=\"font-size: 14pt;\"></span></p>\r\n<h2 class=\"restaurants__service-title\">Создавая позитивный имидж</h2>\r\n<div class=\"restaurants__service-overview\"><span style=\"font-size: 14pt;\">Маркетинг и PR</span></div>\r\n<div class=\"restaurants__service-desc\">\r\n<p><span style=\"font-size: 14pt;\">Специалисты этого отдела знают все о приоритетах компании и о существующих в обществе тенденциях. Они каждый день отвечают за продвижение и поддержание позитивного образа &laquo;Инвест82&raquo; в глазах наших клиентов и партнеров. Благодаря им все больше людей узнают о новых предложениях и услугах компании в Симферополе</span></p>\r\n<p><span style=\"font-size: 14pt;\"></span></p>\r\n<h2 class=\"restaurants__service-title\">Соблюдая этику бизнеса</h2>\r\n<div class=\"restaurants__service-overview\"><span style=\"font-size: 14pt;\">Финансовый отдел</span></div>\r\n<div class=\"restaurants__service-desc\">\r\n<p><span style=\"font-size: 14pt;\">Этот отдел отвечает за все финансовые операции внутри компании и за ее пределами.&nbsp;</span><br><br><span style=\"font-size: 14pt;\">&laquo;Инвест82&raquo; придерживается деловых этических норм в бизнесе и всегда стремится поддерживать репутацию надежного партнера. Мы ведем наш бизнес открыто, честно и справедливо, соблюдая самые высокие стандарты.</span></p>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>','0',1497472243,1,'0','','','0');
/*!40000 ALTER TABLE `indf_news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_news_category`
--

DROP TABLE IF EXISTS `indf_news_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_news_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `name1` text COMMENT 'название',
  `act1` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'показывать на сайте: 0 - нет, 1 - да',
  `map_no_show` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'не показывать на карте сайта: 0 - нет, 1 - да',
  `changefreq` enum('always','hourly','daily','weekly','monthly','yearly','never') NOT NULL DEFAULT 'always' COMMENT 'Changefreq для sitemap.xml',
  `priority` varchar(3) NOT NULL DEFAULT '' COMMENT 'Priority для sitemap.xml',
  `noindex` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'не индексировать: 0 - нет, 1 - да',
  `parent_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор родителя из таблицы `indf_news_category`',
  `count_children` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'количество вложенных категорий',
  `site_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор страницы сайта из таблицы `indf_site`',
  `keywords1` varchar(250) NOT NULL DEFAULT '' COMMENT 'ключевые слова, тег Keywords',
  `descr1` text COMMENT 'описание, тэг Description',
  `canonical1` varchar(100) NOT NULL DEFAULT '' COMMENT 'канонический тег',
  `title_meta1` varchar(250) NOT NULL DEFAULT '' COMMENT 'заголовок окна в браузере, тег Title',
  `anons1` text COMMENT 'анонс',
  `anons_plus1` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'добавлять анонс к описанию: 0 - нет, 1 - да',
  `text1` text COMMENT 'описание',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'подрядковый номер для сортировки',
  `timeedit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'время последнего изменения в формате UNIXTIME',
  `admin_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'пользователь из таблицы `indf_users`, добавивший или первый отредктировавший категорию в административной части',
  `access` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'доступ ограничен: 0 - нет, 1 - да',
  `theme` varchar(50) NOT NULL DEFAULT '' COMMENT 'шаблон страницы сайта',
  `view` varchar(50) NOT NULL DEFAULT '' COMMENT 'шаблон модуля',
  `view_element` varchar(50) NOT NULL DEFAULT '' COMMENT 'шаблон модуля для элементов в категории',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Категории новостей';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_news_category`
--

LOCK TABLES `indf_news_category` WRITE;
/*!40000 ALTER TABLE `indf_news_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_news_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_news_category_parents`
--

DROP TABLE IF EXISTS `indf_news_category_parents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_news_category_parents` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор категории из таблицы `indf_news_category`',
  `parent_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор категории-родителя из таблицы `indf_news_category`',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Родительские связи категорий новостей';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_news_category_parents`
--

LOCK TABLES `indf_news_category_parents` WRITE;
/*!40000 ALTER TABLE `indf_news_category_parents` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_news_category_parents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_news_category_rel`
--

DROP TABLE IF EXISTS `indf_news_category_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_news_category_rel` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор новости из таблицы `indf_news`',
  `cat_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор категории из таблицы `indf_news_category`',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `cat_id` (`cat_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Связи новостей и категорий';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_news_category_rel`
--

LOCK TABLES `indf_news_category_rel` WRITE;
/*!40000 ALTER TABLE `indf_news_category_rel` DISABLE KEYS */;
INSERT INTO `indf_news_category_rel` VALUES (1,2,0,'0'),(2,3,0,'0');
/*!40000 ALTER TABLE `indf_news_category_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_news_counter`
--

DROP TABLE IF EXISTS `indf_news_counter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_news_counter` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор новости из таблицы `indf_news`',
  `count_view` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'количество просмотров',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `element_id` (`element_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Счетчик просмотров новостей';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_news_counter`
--

LOCK TABLES `indf_news_counter` WRITE;
/*!40000 ALTER TABLE `indf_news_counter` DISABLE KEYS */;
INSERT INTO `indf_news_counter` VALUES (1,3,9,'1'),(2,2,4,'1'),(3,4,2,'0'),(4,5,3,'0');
/*!40000 ALTER TABLE `indf_news_counter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_news_rel`
--

DROP TABLE IF EXISTS `indf_news_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_news_rel` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор новости из таблицы `indf_news`',
  `rel_element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор связанной новости из таблицы `indf_news`',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Связи похожих новостей';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_news_rel`
--

LOCK TABLES `indf_news_rel` WRITE;
/*!40000 ALTER TABLE `indf_news_rel` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_news_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_payment`
--

DROP TABLE IF EXISTS `indf_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_payment` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `name1` varchar(50) NOT NULL DEFAULT '' COMMENT 'название',
  `text1` text COMMENT 'описание',
  `act1` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'показывать на сайте: 0 - нет, 1 - да',
  `payment` varchar(20) NOT NULL DEFAULT '' COMMENT 'платежная система',
  `params` text COMMENT 'серилизованные настройки платежной системы',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'подрядковый номер для сортировки',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Методы оплаты';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_payment`
--

LOCK TABLES `indf_payment` WRITE;
/*!40000 ALTER TABLE `indf_payment` DISABLE KEYS */;
INSERT INTO `indf_payment` VALUES (1,'Наличными курьеру','Заказ необходимо оплатить курьеру на руки наличными','1','',NULL,'0',1),(2,'Оплата счета балансом','Вы можете оплатить счет используя баланс','1','balance',NULL,'0',2);
/*!40000 ALTER TABLE `indf_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_payment_history`
--

DROP TABLE IF EXISTS `indf_payment_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_payment_history` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'элемент модуля, для которого производится платеж (номер заказа или идентификатор пользователя)',
  `status` enum('request_pay','pay') NOT NULL DEFAULT 'request_pay' COMMENT 'статус платежа: request_pay - запрошен, pay - оплачен',
  `created` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата создания',
  `summ` double NOT NULL DEFAULT '0' COMMENT 'сумма платежа',
  `payment_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор метода оплаты из таблицы `indf_payment`',
  `module_name` enum('cart','balance') NOT NULL DEFAULT 'cart' COMMENT 'модуль, в котором используются платежи',
  `code` varchar(32) NOT NULL DEFAULT '0' COMMENT 'код доступа к платежным документам',
  `payment_data` varchar(50) NOT NULL DEFAULT '0' COMMENT 'данные о платеже из платежной системы',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='История платежей';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_payment_history`
--

LOCK TABLES `indf_payment_history` WRITE;
/*!40000 ALTER TABLE `indf_payment_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_payment_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_rating`
--

DROP TABLE IF EXISTS `indf_rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_rating` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор элемента модуля',
  `module_name` varchar(50) NOT NULL DEFAULT '' COMMENT 'название модуля',
  `element_type` enum('element','cat') NOT NULL DEFAULT 'element' COMMENT 'тип элемента модуля',
  `rating` double NOT NULL DEFAULT '0' COMMENT 'средняя оценка',
  `count_votes` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'количество оценок',
  `created` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата последней оценки',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `element_id` (`element_id`),
  KEY `module_name` (`module_name`(2))
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Рейтинг элементов модулей';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_rating`
--

LOCK TABLES `indf_rating` WRITE;
/*!40000 ALTER TABLE `indf_rating` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_redirect`
--

DROP TABLE IF EXISTS `indf_redirect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_redirect` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `redirect` varchar(255) NOT NULL DEFAULT '' COMMENT 'исходная псевдоссылка, с которой иустановлен редирект',
  `code` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'код редиректа',
  `module_name` varchar(50) NOT NULL DEFAULT '' COMMENT 'название модуля',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор элемента модуля',
  `element_type` enum('element','cat','brand','param') NOT NULL DEFAULT 'element' COMMENT 'тип элемента модуля',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `module_name` (`module_name`(2)),
  KEY `element_id` (`element_id`),
  KEY `element_type` (`element_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Редиректы';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_redirect`
--

LOCK TABLES `indf_redirect` WRITE;
/*!40000 ALTER TABLE `indf_redirect` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_redirect` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_rewrite`
--

DROP TABLE IF EXISTS `indf_rewrite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_rewrite` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `rewrite` varchar(250) NOT NULL DEFAULT '' COMMENT 'псевдоссылка',
  `module_name` varchar(50) NOT NULL DEFAULT '' COMMENT 'название модуля',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор элемента модуля',
  `element_type` enum('element','cat','brand','param') NOT NULL DEFAULT 'element' COMMENT 'тип элемента модуля',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `module_name` (`module_name`(2)),
  KEY `element_id` (`element_id`)
) ENGINE=MyISAM AUTO_INCREMENT=72 DEFAULT CHARSET=utf8 COMMENT='Псевдоссылки';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_rewrite`
--

LOCK TABLES `indf_rewrite` WRITE;
/*!40000 ALTER TABLE `indf_rewrite` DISABLE KEYS */;
INSERT INTO `indf_rewrite` VALUES (1,'','site',1,'element','0'),(2,'o-nas','site',4,'element','0'),(3,'login','site',26,'element','1'),(4,'dostavka','site',27,'element','0'),(5,'kontakty','site',28,'element','0'),(6,'zakaz-oformlen','site',33,'element','0'),(7,'shop','site',6,'element','0'),(8,'shop/cart','site',7,'element','0'),(9,'shop/wishlist','site',9,'element','0'),(10,'shop/keramicheskaya-plitka','shop',1,'cat','1'),(11,'shop/keramicheskaya-plitka/portugaliya','shop',22,'cat','1'),(12,'shop/keramicheskaya-plitka/turtsiya','shop',23,'cat','1'),(13,'shop/keramicheskaya-plitka/belarus','shop',24,'cat','1'),(14,'shop/keramogranit','shop',2,'cat','1'),(15,'shop/keramogranit/rossiya','shop',12,'cat','1'),(16,'shop/keramogranit/rossiya/keramin','shop',19,'cat','1'),(17,'shop/keramogranit/rossiya/belani','shop',20,'cat','1'),(18,'shop/keramogranit/kitay','shop',13,'cat','1'),(19,'shop/keramogranit/kitay/del-conca','shop',17,'cat','1'),(20,'shop/keramogranit/kitay/vitra','shop',18,'cat','1'),(21,'shop/keramogranit/italiya','shop',14,'cat','1'),(22,'shop/soputstvuyuschie-tovary','shop',3,'cat','1'),(23,'shop/mozaika','shop',4,'cat','1'),(24,'shop/tyoplyy-pol','shop',6,'cat','1'),(25,'shop/zerkalnaya-plitka','shop',7,'cat','1'),(26,'shop/keramicheskaya-plitka/mozaika-miledi','shop',1,'element','1'),(27,'shop/keramogranit/rossiya/keramogranit-giorgio','shop',2,'element','1'),(28,'shop/soputstvuyuschie-tovary/keramicheskaya-plitka-valensia','shop',3,'element','1'),(29,'shop/mozaika/keramicheskaya-plitka-keramomarazzi','shop',4,'element','1'),(30,'shop/tyoplyy-pol/keramogranit-kaleo','shop',6,'element','1'),(31,'shop/zerkalnaya-plitka/keramicheskaya-plitka-valio','shop',7,'element','1'),(32,'shop/mozaika/keramicheskaya-plitka-fliomio','shop',10,'element','1'),(33,'shop/soputstvuyuschie-tovary/keramicheskaya-plitka-milana','shop',11,'element','1'),(34,'shop/dlya-loshadey/korma/korm-druzhba','shop',12,'element','1'),(35,'shop/keramicheskaya-plitka/mozaika-rico-co','shop',13,'element','1'),(36,'shop/argenta','shop',1,'brand','0'),(37,'shop/azuvi','shop',2,'brand','0'),(38,'shop/dual-gres','shop',3,'brand','0'),(39,'shop/mainzu','shop',4,'brand','0'),(40,'shop/saloni','shop',5,'brand','0'),(41,'subscribtion','site',22,'element','0'),(42,'news','site',23,'element','0'),(43,'news/skidka-do-50-na-seriyu-selino','news',2,'element','1'),(44,'news/novaya-kollektsiya','news',3,'element','1'),(45,'search','site',20,'element','0'),(46,'feedback','site',5,'element','0'),(47,'user','site',3,'element','0'),(48,'registration','site',34,'element','0'),(49,'reminding','site',35,'element','0'),(50,'settings','site',36,'element','0'),(51,'map','site',25,'element','0'),(52,'shop/gotovyy-biznes','shop',25,'cat','0'),(53,'shop/kommercheskaya-nedvizhimost','shop',26,'cat','1'),(54,'shop/oborudovanie','shop',27,'cat','0'),(55,'shop/franshizy','shop',28,'cat','0'),(56,'shop/uslugi','shop',29,'cat','0'),(57,'shop/arenda','shop',30,'cat','0'),(58,'shop/gotovyy-biznes/myasnoy-magazin-na-pervoy-linii','shop',14,'element','0'),(59,'shop/gotovyy-biznes/torgovlya-i-magaziny','shop',31,'cat','0'),(60,'shop/gotovyy-biznes/ooo','shop',32,'cat','0'),(61,'shop/gotovyy-biznes/ooo15','shop',15,'element','0'),(62,'shop/gotovyy-biznes/proizvodstvo','shop',33,'cat','0'),(63,'shop/gotovyy-biznes/proizvodstvo-plastikovykh-okon','shop',16,'element','0'),(64,'shop/oborudovanie/proizvodstvo-profnastila-krysha-zabor','shop',17,'element','0'),(65,'news/nastroyka-sayta','news',4,'element','0'),(66,'clauses','site',37,'element','0'),(67,'clauses/stati','clauses',1,'cat','0'),(68,'clauses/stati/otkrytie-novykh-i-razvivayuschikhsya-rynkov-v-krym','clauses',1,'element','0'),(69,'shop/ischu','shop',34,'cat','0'),(70,'shop/rabota-v-invest82','shop',35,'cat','0'),(71,'news/rabota-v-invest82','news',5,'element','0');
/*!40000 ALTER TABLE `indf_rewrite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_search_history`
--

DROP TABLE IF EXISTS `indf_search_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_search_history` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `created` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата создания',
  `name` text COMMENT 'поисковый запрос',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='История поисковых запросов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_search_history`
--

LOCK TABLES `indf_search_history` WRITE;
/*!40000 ALTER TABLE `indf_search_history` DISABLE KEYS */;
INSERT INTO `indf_search_history` VALUES (1,1496908696,'Готовый'),(2,1497457545,'бетон'),(3,1497457555,'прибыль'),(4,1497457568,'производство'),(5,1497457573,'производст'),(6,1497457576,'произв');
/*!40000 ALTER TABLE `indf_search_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_search_index`
--

DROP TABLE IF EXISTS `indf_search_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_search_index` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `keyword_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор слова из таблицы `indf_search_keywords`',
  `result_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор проиндексированного элемента из таблицы `indf_saerch_results`',
  `rating` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT 'рейтинг для сортировки результатов',
  PRIMARY KEY (`id`),
  KEY `keyword_id` (`keyword_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2998 DEFAULT CHARSET=utf8 COMMENT='Связи слов и проиндексированных для поиска элементов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_search_index`
--

LOCK TABLES `indf_search_index` WRITE;
/*!40000 ALTER TABLE `indf_search_index` DISABLE KEYS */;
INSERT INTO `indf_search_index` VALUES (1985,930,82,1),(1984,929,82,1),(1983,928,82,1),(1982,927,82,1),(1981,926,82,1),(1980,925,82,1),(1979,924,82,1),(1978,923,82,1),(1977,922,82,1),(1976,921,82,1),(1975,920,82,1),(1974,919,82,1),(1973,918,82,1),(1972,903,82,0),(1971,904,82,1),(1970,905,82,1),(1969,906,82,1),(1968,907,82,1),(1967,908,82,1),(1966,909,82,1),(1965,910,82,1),(1964,911,82,1),(1963,912,82,1),(1962,913,82,1),(1961,914,82,1),(1960,915,82,1),(1959,917,82,1),(1958,916,82,1),(1957,874,82,1),(1956,230,82,1),(1955,229,82,1),(1954,228,82,1),(1953,204,82,1),(1952,205,82,1),(1951,206,82,1),(1950,217,82,1),(1949,152,82,1),(1948,7,82,1),(2292,1100,86,0),(2291,1101,86,0),(1986,931,83,0),(1101,244,55,0),(1103,246,56,0),(1102,245,56,0),(1098,229,53,0),(1097,205,53,0),(1096,241,52,1),(1095,240,52,1),(1094,239,52,1),(1093,238,52,1),(1092,237,52,1),(1091,236,52,1),(1090,235,52,1),(1089,234,52,1),(1088,233,52,1),(1087,232,52,1),(1086,231,52,1),(1085,230,52,1),(1084,229,52,1),(1083,228,52,1),(1082,227,52,1),(1081,226,52,1),(1080,225,52,1),(1079,223,52,0),(1078,224,52,1),(1077,205,52,1),(1076,206,52,1),(1075,207,52,1),(1074,208,52,1),(1073,213,52,1),(1072,166,52,1),(1071,163,52,1),(1070,161,52,1),(1069,214,52,1),(97,51,3,0),(98,52,3,0),(99,21,4,0),(100,3,4,0),(2993,1718,96,2),(2992,1717,96,2),(2991,1716,96,2),(2990,1715,96,2),(2989,1714,96,2),(2988,1713,96,2),(2987,1712,96,2),(2986,1711,96,2),(2985,1710,96,2),(2984,1709,96,2),(2983,1708,96,2),(2982,1707,96,2),(2981,1706,96,2),(2980,1705,96,2),(2979,1704,96,2),(2295,655,88,0),(2294,225,88,0),(2293,1184,87,0),(2290,1102,86,0),(2289,1103,86,2),(2288,1104,86,2),(2287,1105,86,2),(2286,1106,86,2),(2285,1107,86,2),(2284,1108,86,2),(2283,1109,86,2),(2282,1110,86,2),(2281,1111,86,2),(2280,1112,86,2),(2279,1113,86,2),(2278,1114,86,2),(2277,1115,86,2),(2276,1116,86,2),(2275,1117,86,2),(2274,1118,86,2),(2273,1119,86,2),(2272,1120,86,2),(2271,1121,86,2),(2270,1122,86,2),(2269,1123,86,2),(2268,1124,86,2),(2267,1125,86,2),(2266,1126,86,2),(2265,1127,86,2),(2264,1128,86,2),(2263,1129,86,2),(2262,1130,86,2),(2261,1131,86,2),(2260,1132,86,2),(2259,1133,86,2),(2258,1134,86,2),(2257,1136,86,2),(2256,1142,86,2),(2255,1141,86,2),(1947,2,82,0),(1865,866,79,2),(1864,864,79,2),(1863,875,79,2),(1862,860,79,2),(1861,874,79,2),(1860,867,79,2),(1859,865,79,2),(1858,876,79,2),(1857,858,79,1),(1856,857,79,0),(1855,868,79,2),(1854,861,79,2),(1853,869,79,2),(1852,871,79,2),(1851,859,79,2),(1850,873,79,2),(1849,872,79,2),(1848,870,79,2),(1847,862,79,2),(1846,863,79,2),(1845,877,79,2),(1844,152,79,0),(1843,45,79,2),(1842,591,79,2),(1841,8,79,2),(1840,164,79,2),(2997,1722,96,2),(2996,1721,96,2),(2254,1140,86,2),(2253,1139,86,2),(2252,1138,86,2),(2251,1137,86,2),(2250,1143,86,2),(2249,1144,86,2),(2248,1145,86,2),(2247,1146,86,2),(2246,1147,86,2),(2245,1148,86,2),(2244,1149,86,2),(2243,1135,86,2),(2242,1150,86,2),(2241,1151,86,2),(2240,1152,86,2),(2239,1154,86,2),(2238,1153,86,2),(2237,1156,86,2),(2236,1155,86,2),(2235,1157,86,2),(2234,1158,86,2),(2233,1159,86,2),(2232,1161,86,2),(2231,1160,86,2),(2230,1162,86,2),(2229,1163,86,2),(2228,1164,86,2),(2227,1165,86,2),(2226,1166,86,2),(2225,1167,86,2),(2224,1168,86,2),(2223,1169,86,2),(2222,1170,86,2),(2221,1171,86,2),(2220,1172,86,2),(2219,1173,86,2),(2218,1175,86,2),(2217,1174,86,2),(2216,1176,86,2),(2215,1177,86,2),(2214,1178,86,2),(2213,1179,86,2),(2212,1180,86,2),(2211,1181,86,2),(2210,1182,86,2),(2209,1183,86,2),(2208,928,86,2),(2207,920,86,0),(2206,909,86,2),(2205,911,86,2),(2204,664,86,2),(2203,663,86,2),(2202,655,86,2),(2201,623,86,2),(2200,564,86,2),(2199,234,86,2),(2198,231,86,2),(2197,230,86,0),(2196,226,86,2),(2195,205,86,2),(2194,217,86,2),(2995,1720,96,2),(2994,1719,96,2),(2978,1703,96,2),(2977,1702,96,2),(2976,1701,96,2),(2975,1700,96,2),(2974,1579,96,2),(2973,1580,96,2),(2972,1581,96,2),(2971,1582,96,2),(2970,1583,96,2),(2969,1584,96,2),(2968,1585,96,2),(2967,1586,96,2),(2966,1587,96,2),(2965,1588,96,2),(2964,1589,96,2),(2963,1590,96,2),(2962,1591,96,2),(2961,1592,96,2),(2960,1593,96,2),(2959,1594,96,2),(2958,1595,96,2),(2957,1596,96,2),(2956,1597,96,2),(2955,1598,96,2),(2954,1599,96,2),(2953,1600,96,2),(2952,1601,96,2),(2951,1602,96,2),(2950,1603,96,2),(2949,1604,96,2),(2948,1605,96,2),(2947,1606,96,2),(2946,1607,96,2),(2945,1608,96,2),(2944,1609,96,2),(2943,1610,96,2),(2942,1611,96,2),(2941,1612,96,2),(2940,1613,96,2),(2939,1614,96,2),(2938,1615,96,2),(2937,1616,96,2),(2936,1617,96,2),(2935,1618,96,2),(2934,1619,96,2),(2933,1620,96,2),(2932,1621,96,2),(2931,1622,96,2),(2930,1623,96,2),(2929,1624,96,2),(2928,1625,96,2),(2927,1626,96,2),(2926,1627,96,2),(2925,1628,96,2),(2924,1629,96,2),(2923,1630,96,2),(2922,1631,96,2),(2921,1633,96,2),(2920,1634,96,2),(2919,1635,96,2),(2918,1636,96,2),(2917,1637,96,2),(2916,1638,96,2),(2915,1639,96,2),(2914,1640,96,2),(2913,1641,96,2),(2912,1642,96,2),(2911,1643,96,2),(2910,1644,96,2),(2909,1645,96,2),(2908,1646,96,2),(2907,1647,96,2),(2906,1648,96,2),(2905,1649,96,2),(2904,1650,96,2),(2903,1651,96,2),(2902,1652,96,2),(2901,1653,96,2),(2900,1655,96,2),(2899,1657,96,2),(2898,1656,96,2),(2897,1654,96,2),(2896,1658,96,2),(2895,1659,96,2),(2894,1660,96,2),(2893,1661,96,2),(2892,1662,96,2),(2891,1663,96,2),(2890,1664,96,2),(2889,1665,96,2),(2888,1666,96,2),(2887,1667,96,2),(2886,1668,96,2),(2885,1669,96,2),(2884,1670,96,2),(2883,1671,96,2),(2882,1672,96,2),(2881,1673,96,2),(2880,1674,96,2),(2879,1675,96,2),(2878,1676,96,2),(2877,1677,96,2),(2876,1678,96,2),(2875,1680,96,2),(2874,1681,96,2),(2873,1632,96,2),(2872,1682,96,2),(2871,1685,96,2),(2870,1684,96,2),(2869,1683,96,2),(2868,1687,96,2),(755,128,31,0),(756,129,32,0),(757,130,33,0),(758,131,33,0),(759,132,34,0),(760,133,35,0),(761,134,36,0),(762,135,37,0),(763,136,38,0),(764,137,39,0),(765,138,40,0),(861,151,43,0),(862,152,43,0),(2193,218,86,2),(2192,224,86,2),(2191,45,86,2),(2867,1686,96,2),(2866,1688,96,2),(2865,1689,96,2),(2864,1690,96,2),(2863,1691,96,2),(2862,1692,96,2),(2861,1693,96,2),(2860,1694,96,2),(2859,1695,96,2),(2858,1696,96,2),(2857,1697,96,2),(2856,1698,96,2),(2855,1679,96,2),(2854,1699,96,2),(2853,928,96,2),(2852,903,96,2),(2851,905,96,2),(2850,860,96,2),(2849,1100,96,2),(2848,1101,96,2),(2847,1114,96,2),(2846,1115,96,2),(2845,1116,96,2),(2844,1118,96,2),(2843,664,96,2),(2842,655,96,0),(2841,597,96,2),(2840,1133,96,2),(2839,545,96,2),(2838,564,96,2),(2837,569,96,2),(2836,248,96,2),(2835,237,96,2),(2834,235,96,2),(1068,222,51,1),(1067,221,51,1),(1066,220,51,1),(1065,219,51,1),(1064,204,51,0),(1063,205,51,1),(1062,206,51,1),(1061,207,51,1),(1060,208,51,1),(1059,209,51,1),(1058,210,51,1),(1057,211,51,1),(1056,212,51,1),(1055,213,51,1),(1054,215,51,1),(1053,216,51,1),(1052,217,51,1),(1051,218,51,1),(1050,214,51,1),(2833,231,96,2),(2832,230,96,2),(2831,229,96,2),(2830,225,96,0),(2829,222,96,2),(2828,205,96,2),(2827,206,96,2),(2826,218,96,2),(2825,148,96,2),(2824,146,96,2),(2823,136,96,2),(2822,1140,96,2),(2821,1137,96,2),(2820,1154,96,2),(2819,1162,96,2),(2818,52,96,2),(2817,223,96,2),(2816,224,96,2),(2815,1174,96,2),(1172,3,61,0),(1173,304,61,0),(1500,45,68,2),(1501,230,68,2),(1502,218,68,1),(1503,594,68,1),(1504,593,68,0),(1505,564,69,3),(1506,591,69,3),(1507,593,69,0),(1508,600,69,3),(1509,605,69,3),(1510,608,69,3),(1511,607,69,3),(1512,606,69,3),(1513,595,69,3),(1514,603,69,3),(1515,599,69,3),(1516,596,69,3),(1517,604,69,3),(1518,597,69,3),(1519,598,69,3),(1520,601,69,3),(1521,602,69,3),(1522,609,70,0),(1528,126,72,3),(1527,73,72,3),(1526,17,72,3),(1529,146,72,3),(1530,148,72,3),(1531,157,72,3),(1532,160,72,3),(1533,220,72,3),(1534,226,72,3),(1535,229,72,3),(1536,239,72,3),(1537,244,72,3),(1538,248,72,3),(1539,591,72,3),(1540,572,72,3),(1541,569,72,3),(1542,564,72,3),(1543,545,72,3),(1544,609,72,0),(1545,612,72,0),(1546,613,72,0),(1547,614,72,3),(1548,615,72,3),(1549,616,72,3),(1550,617,72,3),(1551,618,72,3),(1552,619,72,3),(1553,620,72,3),(1554,621,72,3),(1555,622,72,3),(1556,623,72,3),(1557,624,72,3),(1558,625,72,3),(1559,626,72,3),(1560,627,72,3),(1561,628,72,3),(1562,629,72,3),(1563,630,72,3),(1564,631,72,3),(1565,632,72,3),(1566,633,72,3),(1567,634,72,3),(1568,635,72,3),(1569,636,72,3),(1570,637,72,3),(1571,638,72,3),(1572,639,72,3),(1573,640,72,3),(1574,641,72,3),(1575,642,72,3),(1576,643,72,3),(1577,644,72,3),(1578,645,72,3),(1579,646,72,3),(1580,647,72,3),(1581,648,72,3),(1582,649,72,3),(1583,650,72,3),(1584,651,72,3),(1585,652,72,3),(1586,653,72,3),(1587,654,72,3),(1588,655,72,3),(1589,656,72,3),(1590,657,72,3),(1591,658,72,3),(1592,659,72,3),(1593,660,72,3),(1594,661,72,3),(1595,662,72,3),(1596,663,72,3),(1597,664,72,3),(1598,665,72,3),(1599,666,72,3),(1600,667,72,3),(1601,668,72,3),(1602,669,72,3),(1603,670,72,3),(1604,671,72,3),(1605,672,72,3),(1606,673,72,3),(1607,674,72,3),(1608,675,72,3),(1609,676,72,3),(1610,677,72,3),(1611,678,72,3),(1612,679,72,3),(1613,680,72,3),(1614,681,72,3),(1615,682,72,3);
/*!40000 ALTER TABLE `indf_search_index` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_search_keywords`
--

DROP TABLE IF EXISTS `indf_search_keywords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_search_keywords` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `keyword` varchar(255) NOT NULL DEFAULT '' COMMENT 'уникальное слово',
  PRIMARY KEY (`id`),
  KEY `keyword` (`keyword`(3))
) ENGINE=MyISAM AUTO_INCREMENT=1723 DEFAULT CHARSET=utf8 COMMENT='Индексированные для поиска слова';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_search_keywords`
--

LOCK TABLES `indf_search_keywords` WRITE;
/*!40000 ALTER TABLE `indf_search_keywords` DISABLE KEYS */;
INSERT INTO `indf_search_keywords` VALUES (2,'страниц'),(3,'магазин'),(916,'сегментах'),(1699,'больш'),(7,'информац'),(8,'будет'),(1679,'именно'),(1698,'благодар'),(1697,'партнер'),(1696,'глазах'),(17,'несколько'),(1695,'образ'),(1694,'поддержан'),(21,'интернет'),(1693,'продвижен'),(1692,'отвеча'),(1691,'ден'),(1184,'ищу'),(1183,'тренд'),(1182,'виден'),(1181,'облада'),(1180,'менталитет'),(1179,'здешн'),(1178,'крымчанин'),(1177,'креативн'),(1176,'потребует'),(1174,'как'),(1175,'вот'),(45,'ил'),(1173,'понима'),(1172,'стандартно'),(224,'компан'),(223,'нас'),(51,'обратн'),(52,'связ'),(1171,'мысля'),(1170,'рынок'),(1169,'крымск'),(1168,'знающ'),(1167,'маркетолог'),(1166,'требует'),(1165,'созданных'),(1164,'давно'),(1163,'вывод'),(1162,'прибыл'),(1160,'внов'),(1161,'свест'),(73,'основн'),(1159,'парализова'),(1158,'том'),(1157,'однобок'),(1155,'бед'),(81,'альф'),(1156,'так'),(1153,'ещ'),(1154,'существующих'),(1152,'создан'),(1151,'подготовлен'),(1150,'практическ'),(1135,'университетах'),(1149,'теоретическ'),(1148,'хот'),(1147,'них'),(1146,'кто'),(1145,'мало'),(1144,'потребител'),(1143,'мнен'),(1137,'очен'),(1138,'важн'),(1139,'навык'),(1140,'он'),(1141,'науч'),(1142,'прислушива'),(1690,'тенденциях'),(1689,'обществ'),(1688,'приоритетах'),(1686,'маркетинг'),(126,'турц'),(1687,'знают'),(128,'argenta'),(129,'azuvi'),(130,'dual'),(131,'gres'),(132,'mainzu'),(133,'saloni'),(134,'корзин'),(135,'отложен'),(136,'поиск'),(137,'рассылк'),(138,'новост'),(1683,'создав'),(1684,'позитивн'),(1685,'имидж'),(1682,'занима'),(146,'нов'),(1632,'конкретн'),(148,'всех'),(1681,'направлен'),(151,'карт'),(152,'сайт'),(1136,'приобрел'),(1134,'учеб'),(157,'оплат'),(214,'николаевн'),(160,'заказ'),(161,'оформлен'),(163,'ваш'),(164,'ближайш'),(1680,'двигател'),(166,'вам'),(218,'симферопол'),(217,'крым'),(216,'volkinaglabar'),(215,'789787060799'),(213,'окса'),(212,'com'),(211,'victor7brokergmail'),(210,'viber'),(209,'79780509995'),(208,'александрович'),(207,'виктор'),(206,'брокер'),(205,'бизнес'),(204,'контакт'),(219,'набережн'),(220,'лет'),(221,'ссср'),(222,'офис'),(225,'инвест82'),(226,'работа'),(227,'сфер'),(228,'продаж'),(229,'готов'),(230,'крыму'),(231,'это'),(232,'резюм'),(233,'предостав'),(234,'след'),(235,'услуг'),(236,'консультац'),(237,'покупк'),(238,'подбор'),(239,'персона'),(240,'реклам'),(241,'документ'),(246,'недвижимост'),(245,'ком'),(244,'оборудован'),(931,'стат'),(248,'аренд'),(594,'куп'),(591,'звон'),(593,'ооо'),(1678,'площад'),(1677,'требуют'),(1676,'расширя'),(1675,'находит'),(1674,'вперед'),(1673,'только'),(1672,'точкам'),(1671,'удален'),(1670,'всему'),(1669,'доступ'),(1668,'постоя'),(1667,'имет'),(1666,'поэтому'),(1665,'технологичн'),(1664,'современ'),(1663,'симферопольских'),(1662,'поддержку'),(1661,'эффективн'),(1660,'обеспечива'),(1659,'информационных'),(1658,'соб'),(1654,'коммуникац'),(572,'помещен'),(1656,'част'),(1657,'между'),(569,'сво'),(1655,'его'),(1653,'налажен'),(1652,'люб'),(1651,'успех'),(564,'все'),(304,'торговл'),(1650,'технолог'),(1649,'информацион'),(1648,'существует'),(1647,'расстоян'),(1646,'заявлен'),(1645,'гарантирова'),(1644,'отслежива'),(1643,'позволя'),(1642,'систем'),(1641,'уникальн'),(1640,'руководител'),(1639,'задач'),(1638,'выполнен'),(1637,'такж'),(1636,'модел'),(1635,'используем'),(1634,'зависит'),(545,'всем'),(1633,'прибыльност'),(1133,'врем'),(1132,'маркетингу'),(1131,'большинство'),(537,'лин'),(1130,'развива'),(595,'летн'),(596,'положительн'),(597,'репутац'),(598,'сро'),(599,'оплачено'),(600,'350'),(601,'тысстроительн'),(602,'фирм'),(603,'млн'),(604,'полн'),(605,'арх'),(606,'документац'),(607,'гот'),(608,'аудиту'),(609,'производство'),(612,'пластиковых'),(613,'окон'),(614,'металлоплавильных'),(615,'двер'),(616,'масс'),(617,'стройк'),(618,'сарафа'),(619,'радио'),(620,'постав'),(621,'окн'),(622,'родственник'),(623,'знаком'),(624,'знакомых'),(625,'станк'),(626,'резк'),(627,'арматур'),(628,'под'),(629,'диск'),(630,'350х25'),(631,'4резк'),(632,'профил'),(633,'ack'),(634,'420вырезк'),(635,'замк'),(636,'224паяльн'),(637,'станок'),(638,'hegsanвырезк'),(639,'импост'),(640,'дренажн'),(641,'кана'),(642,'263штапикорезкомпрессор'),(643,'1000'),(644,'литровбулерьянстол'),(645,'стойк'),(646,'стеллаж'),(647,'пневмоинструментручн'),(648,'инструментрасходникибулерья'),(649,'воздух'),(650,'месяц'),(651,'выходит'),(652,'500'),(653,'600'),(654,'рубл'),(655,'работ'),(656,'одн'),(657,'жалоб'),(658,'выгодн'),(659,'себестоимост'),(660,'человек'),(661,'нагрузк'),(662,'4универсал'),(663,'опыт'),(664,'сам'),(665,'дела'),(666,'монтаж'),(667,'wintech'),(668,'обслуж'),(669,'мастер'),(670,'меня'),(671,'масл'),(672,'фильтр'),(673,'обуч'),(674,'станках'),(675,'прот'),(676,'продолж'),(677,'работу'),(678,'собственник'),(679,'буду'),(680,'передава'),(681,'текущих'),(682,'строек'),(1129,'неопределенност'),(1128,'осозна'),(1127,'чем'),(1126,'инач'),(1125,'совс'),(1124,'инвестирует'),(1123,'план'),(1122,'строит'),(1121,'будущ'),(1120,'знает'),(1119,'дума'),(1118,'котор'),(1117,'менеджер'),(1116,'для'),(1115,'важно'),(1114,'созда'),(1113,'сформирова'),(1112,'мног'),(1111,'пор'),(1110,'сих'),(1109,'что'),(1108,'привлека'),(1107,'тем'),(1106,'невозможно'),(1105,'нет'),(1104,'которых'),(1103,'крымурынк'),(1102,'развивающих'),(1101,'новых'),(1100,'открыт'),(864,'соответственно'),(865,'повысит'),(866,'юзабилит'),(867,'постепенно'),(868,'наполнит'),(869,'контент'),(870,'есл'),(871,'кого'),(872,'ест'),(873,'замечан'),(874,'предложен'),(863,'выглядет'),(862,'дни'),(861,'над'),(860,'процесс'),(859,'идет'),(858,'нача'),(857,'настройк'),(875,'прошу'),(876,'писа'),(877,'email'),(917,'небольш'),(915,'ценовых'),(914,'разных'),(913,'разн'),(912,'сравн'),(911,'изуч'),(910,'посмотрет'),(909,'может'),(908,'зде'),(907,'актуальн'),(906,'представл'),(905,'дан'),(904,'каталогесервисересурс'),(903,'главн'),(918,'торгов'),(919,'точк'),(920,'рынк'),(921,'производств'),(922,'масштабах'),(923,'всего'),(924,'прям'),(925,'пожалуйст'),(926,'стесня'),(927,'связыва'),(928,'специалист'),(929,'владеют'),(930,'полезн'),(1631,'происходя'),(1630,'следит'),(1629,'внимательно'),(1628,'качеств'),(1627,'контрол'),(1626,'качество'),(1625,'клиент'),(1624,'наших'),(1623,'мест'),(1622,'любим'),(1621,'остава'),(1620,'продолжа'),(1619,'расширен'),(1618,'оптимизац'),(1617,'продажах'),(1616,'задействова'),(1615,'напрям'),(1614,'отдел'),(1613,'эт'),(1612,'снов'),(1611,'приход'),(1610,'хотело'),(1609,'инвесторам'),(1608,'клиентам'),(1607,'наш'),(1606,'того'),(1605,'комфорт'),(1604,'атмосферу'),(1603,'гостеприимн'),(1602,'ежедневно'),(1601,'директор'),(1600,'глав'),(1599,'симферопольск'),(1598,'команд'),(1597,'сердц'),(1596,'работник'),(1595,'перед'),(1594,'открыва'),(1593,'возможност'),(1592,'посмотр'),(1591,'удовольств'),(1590,'получа'),(1589,'внутр'),(1588,'развит'),(1587,'рост'),(1586,'перспективу'),(1585,'имел'),(1584,'сотрудник'),(1583,'кажд'),(1582,'чтоб'),(1581,'нам'),(1580,'ценност'),(1579,'люд'),(1700,'узна'),(1701,'предложениях'),(1702,'услугах'),(1703,'соблюд'),(1704,'этику'),(1705,'финансов'),(1706,'этот'),(1707,'операц'),(1708,'предел'),(1709,'придержива'),(1710,'деловых'),(1711,'этических'),(1712,'норм'),(1713,'всегд'),(1714,'стремит'),(1715,'поддержива'),(1716,'надежн'),(1717,'вед'),(1718,'открыто'),(1719,'честно'),(1720,'справедливо'),(1721,'высок'),(1722,'стандарт');
/*!40000 ALTER TABLE `indf_search_keywords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_search_results`
--

DROP TABLE IF EXISTS `indf_search_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_search_results` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор элемента',
  `table_name` varchar(50) NOT NULL DEFAULT '' COMMENT 'таблица элемента',
  `lang_id` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор языка сайта из таблицы `indf_languages`',
  `access` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'доступ к элементу ограничен',
  `rating` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT 'рейтинг для сортировки результатов',
  `date_start` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата начала показа',
  `date_finish` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата окончания показа',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=97 DEFAULT CHARSET=utf8 COMMENT='Индексированные для поиска элементы';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_search_results`
--

LOCK TABLES `indf_search_results` WRITE;
/*!40000 ALTER TABLE `indf_search_results` DISABLE KEYS */;
INSERT INTO `indf_search_results` VALUES (82,1,'site',1,'0',5,0,0),(52,4,'site',1,'0',5,0,0),(3,5,'site',1,'0',5,0,0),(4,6,'site',1,'0',5,0,0),(79,4,'news',1,'0',5,0,0),(96,5,'news',1,'0',5,0,0),(31,1,'shop_brand',1,'0',6,0,0),(32,2,'shop_brand',1,'0',6,0,0),(33,3,'shop_brand',1,'0',6,0,0),(34,4,'shop_brand',1,'0',6,0,0),(35,5,'shop_brand',1,'0',6,0,0),(36,7,'site',1,'0',5,0,0),(37,9,'site',1,'0',5,0,0),(38,20,'site',1,'0',5,0,0),(39,22,'site',1,'0',5,0,0),(40,23,'site',1,'0',5,0,0),(43,25,'site',1,'0',5,0,0),(88,35,'shop_category',1,'0',6,0,0),(51,28,'site',1,'0',5,0,0),(53,25,'shop_category',1,'0',6,0,0),(56,26,'shop_category',1,'0',6,0,0),(55,27,'shop_category',1,'0',6,0,0),(87,34,'shop_category',1,'0',6,0,0),(86,1,'clauses',1,'0',1,0,0),(83,1,'clauses_category',1,'0',1,0,0),(61,31,'shop_category',1,'0',6,0,0),(68,32,'shop_category',1,'0',6,0,0),(69,15,'shop',1,'0',6,0,0),(70,33,'shop_category',1,'0',6,0,0),(72,16,'shop',1,'0',6,0,0);
/*!40000 ALTER TABLE `indf_search_results` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_sessions`
--

DROP TABLE IF EXISTS `indf_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_sessions` (
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор пользователя из таблицы `indf_users`',
  `session_id` varchar(64) NOT NULL DEFAULT '' COMMENT 'уникальный идентификатор сессии',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'хост',
  `user_agent` varchar(255) NOT NULL DEFAULT '' COMMENT 'браузер пользователя',
  `timestamp` varchar(20) NOT NULL DEFAULT '0' COMMENT 'время, до которого сессия действует',
  `session` text COMMENT 'серилизованные данные сессии',
  PRIMARY KEY (`session_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Сессии';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_sessions`
--

LOCK TABLES `indf_sessions` WRITE;
/*!40000 ALTER TABLE `indf_sessions` DISABLE KEYS */;
INSERT INTO `indf_sessions` VALUES (0,'c66mfpojmi4j3kd9lcm88qp643','93.185.30.83','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36','1496828895',''),(1,'qcugc73l3djia5jfqbmibljhu1','93.185.30.83','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36','1496829007','group_action|a:1:{s:5:\"users\";s:5:\"trash\";}cart_summ|i:0;cart_count|i:0;'),(0,'gmna3gpnk5olgshj8a60njcue6','93.185.30.83','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) QtWebEngine/5.6.0 Chrome/45.0.2454.101 Safari/537.36','1496828976',''),(0,'jp9b445phlthffkv9gltfhsaj4','95.215.119.247','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.86 Safari/537.36','1496829568',''),(0,'9ofv3i5k81725f4vq9k3ucnmi1','127.0.0.1','Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) CriOS/59.0.3071.84 Mobile/14E304 Safari/602.1','1497559926','news_view|a:1:{i:5;i:1;}captcha|a:1:{s:9:\"comments0\";a:2:{i:9884;s:7:\"4631899\";i:8499;s:7:\"2117801\";}}'),(0,'deuobckr3gpd36nmjbc0rejft2','95.215.119.247','Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/58.0.3029.113 Mobile/14E304 Safari/602.1','1496833702',''),(0,'btvsbtu1troq692f7ms7rtvsk5','77.123.218.132','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.137 YaBrowser/17.4.1.919 Yowser/2.5 Safari/537.36','1496835868',''),(0,'pcast5o0bbnf1g7gm6g6lprpf4','95.153.128.100','Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/58.0.3029.113 Mobile/14E304 Safari/602.1','1496841968',''),(0,'8tgqm4gqnp4j09v8af051tr3a0','95.153.134.135','Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/58.0.3029.113 Mobile/14E304 Safari/602.1','1496856656',''),(0,'3h5pgrr33dcpqcdjh4sr4loag7','92.38.112.96','Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/58.0.3029.113 Mobile/14E304 Safari/602.1','1496908732','search|a:1:{i:0;s:14:\"Готовый\";}'),(0,'16ej3msqsnl2rme0rd7k91cdm2','95.153.128.2','Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/602.1.50 (KHTML, like Gecko) CriOS/58.0.3029.113 Mobile/14E304 Safari/602.1','1496913868',''),(0,'v9t8b3v0apkg5f9pthr7m357l6','195.154.214.162','python-requests/2.6.0 CPython/2.6.6 Linux/2.6.32-696.1.1.el6.x86_64','1496916827',''),(0,'95v939kauivto8eh0da3n6rkn3','66.249.64.211','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','1496918201','shop_view|a:1:{i:2;i:1;}'),(0,'e79jppbpef8ls9gdk05a7feu33','66.249.64.211','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','1496918246','news_view|a:1:{i:3;i:1;}'),(0,'nbf3h0hkjlb5cc5lkv5itjekb4','66.249.64.211','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','1496918256','news_view|a:1:{i:2;i:1;}'),(0,'bqef506r8lv2q6br68s2fhc7h3','66.249.64.211','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','1496918269','shop_view|a:1:{i:6;i:1;}'),(0,'5rj6dq9hvelkcnks765ggkfho2','66.249.64.211','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','1496918281','shop_view|a:1:{i:1;i:1;}'),(0,'afb53480eammejgr35kmp6q0o2','66.249.64.211','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','1496918284','shop_view|a:1:{i:10;i:1;}'),(0,'t32cmu240ho4qe218tps9nqgt3','66.249.64.211','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','1496918286','shop_view|a:1:{i:13;i:1;}'),(0,'np99571v7a3l3c3pr3esei9b30','66.249.64.211','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','1496918292','shop_view|a:1:{i:4;i:1;}'),(0,'jopnr3ivhto9ujhdinu3a2kkn3','66.249.64.211','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','1496918294','shop_view|a:1:{i:7;i:1;}'),(0,'md0r59t6joi56m0o7fq0o98v51','66.249.64.211','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','1496918297','shop_view|a:1:{i:11;i:1;}'),(0,'i2oaun69bt8uobckcq1t9ojjq0','66.249.64.211','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','1496918299','shop_view|a:1:{i:3;i:1;}'),(0,'q65msr1i41bitqjl9taupqn3t1','77.123.218.132','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.137 YaBrowser/17.4.1.919 Yowser/2.5 Safari/537.36','1496931617','shop_view|a:1:{i:7;i:1;}captcha|a:1:{s:9:\"comments0\";a:1:{i:4745;s:7:\"9304696\";}}'),(0,'29o5bp19li1tj3ocop8ofr1ui7','141.8.132.1','Mozilla/5.0 (compatible; YandexImages/3.0; +http://yandex.com/bots)','1496952098','captcha|a:1:{s:7:\"reviews\";a:1:{i:9629;s:7:\"5027186\";}}'),(0,'n3e7bf4or2j7t2umaqe89se3m2','66.249.64.213','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','1496969620','shop_view|a:1:{i:12;i:1;}'),(0,'9nkrjmdthubadvjbramtu5tsu1','35.157.239.160','Mozilla/5.0 (Windows 10; WOW64; rv:41.0) Gecko/20100101 Firefox/41.0','1496974524',''),(0,'mcsrtl532b2papvfspv1kkpkb4','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1496978590','shop_view|a:1:{i:12;i:1;}'),(0,'j2fjst4t0a3jdm1o41vmliqtl7','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1496978597','shop_view|a:1:{i:11;i:1;}'),(0,'b8vkie5ch5s2mhl7dhtqfj5707','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1496978600','shop_view|a:1:{i:3;i:1;}'),(0,'hj7aokha4840jpn30h9fl3bog3','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1496978613','shop_view|a:1:{i:2;i:1;}'),(0,'6qchjmlikst44im1eit78g6nn4','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1496978636','shop_view|a:1:{i:4;i:1;}'),(0,'p6akgulcns1vplh81et4b8fnt4','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1496978656','shop_view|a:1:{i:7;i:1;}'),(0,'2esaa525hl1sf3or19uscsjm81','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1496978676','shop_view|a:1:{i:13;i:1;}'),(0,'gt54cg4jq9b6vl05ifpdoeeug7','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1496978695','shop_view|a:1:{i:1;i:1;}'),(0,'cqut2ro7cbko1b9v7k05svj6a6','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1496978715','shop_view|a:1:{i:10;i:1;}'),(0,'uq1nu8lvnajd2h98j9077slo67','195.154.214.162','python-requests/2.6.0 CPython/2.6.6 Linux/2.6.32-696.1.1.el6.x86_64','1496980170',''),(0,'bj7sfgekrtfqjqq6iagg8rvp26','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497006464','shop_view|a:1:{i:6;i:1;}'),(0,'s1ksoolnq0vbjme1bbbu3gpf46','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497006468','news_view|a:1:{i:3;i:1;}'),(0,'saks8fcej6e1gsaht0vg9hfce3','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497006471','news_view|a:1:{i:2;i:1;}'),(0,'hh73cv47mtrf44dhvnerphgin2','95.153.135.153','Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) CriOS/59.0.3071.84 Mobile/14E304 Safari/602.1','1497006943',''),(0,'8ojepd4tiprec8ef796c8rmt93','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497010483','shop_view|a:1:{i:11;i:1;}'),(0,'grbeiicr43v22fqbp0heonks17','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497010487','shop_view|a:1:{i:3;i:1;}'),(0,'sr3gb5mdg1bebohmjgfd80ab47','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497010490','shop_view|a:1:{i:4;i:1;}'),(0,'lbsvkfnc9lqoi4953vsd4m7qc2','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497010494','shop_view|a:1:{i:13;i:1;}'),(0,'tu3vs2lsdvfg7f5nqu3k6l81d1','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497010497','shop_view|a:1:{i:10;i:1;}'),(0,'uke4krpp1qcess7ip0eb5ebnh7','95.153.129.132','Mozilla/5.0 (Android 5.0; Mobile; rv:53.0) Gecko/53.0 Firefox/53.0','1497017741',''),(0,'3ghq2j4ikcq7od0sca62jmcer5','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497018006','shop_view|a:1:{i:12;i:1;}'),(0,'8popkv0ph1t8v64off6gqjvu86','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497018010','shop_view|a:1:{i:1;i:1;}'),(0,'dkimih5i09bj441jdt4jta0al1','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497018013','shop_view|a:1:{i:2;i:1;}'),(0,'uce96cbnfd570m103ghemlktg2','91.242.191.69','Mozilla/5.0 (Windows NT 5.1; rv:9.0.1) Gecko/20100101 Firefox/9.0.1','1497035507',''),(0,'b2fmqrbije5p1434jmhhsoeee3','92.38.117.92','Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) CriOS/59.0.3071.84 Mobile/14E304 Safari/602.1','1497041843','news_view|a:1:{i:3;i:1;}captcha|a:1:{s:9:\"comments0\";a:11:{i:1292;s:6:\"487981\";i:8871;s:6:\"921884\";i:7255;s:5:\"07496\";i:9498;s:5:\"69879\";i:1223;s:7:\"8870352\";i:7805;s:7:\"5061093\";i:2540;s:5:\"46101\";i:7612;s:6:\"024783\";i:7257;s:5:\"54760\";i:7538;s:6:\"003417\";i:1407;s:7:\"3688857\";}}'),(0,'lrgkq7hvt9i6dsvj04rho5i577','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497044451','shop_view|a:1:{i:11;i:1;}'),(0,'gvq1scdot7uhpv2to6uejfakq5','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497044454','shop_view|a:1:{i:3;i:1;}'),(0,'09v894vatarnnq72enp4onf2s3','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497044458','shop_view|a:1:{i:4;i:1;}'),(0,'78n5pm4pp338lns231cej2t295','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497044462','shop_view|a:1:{i:10;i:1;}'),(0,'6nsqrc2dosse5ilitdt6050bb1','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497044465','shop_view|a:1:{i:13;i:1;}'),(0,'i6kvsossq05evqlr2rp0llbmj7','66.249.64.85','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','1497051447','news_view|a:1:{i:3;i:1;}'),(0,'j0vj9cg45jaofmrtgppltg5e51','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497053114','shop_view|a:1:{i:12;i:1;}'),(0,'l7qda8nmtvba16h4rpo908f864','66.249.64.83','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','1497058222','news_view|a:1:{i:2;i:1;}'),(0,'927hsq6hsplcofrcv28ml7a402','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497062120','shop_view|a:1:{i:6;i:1;}'),(0,'bbnlf0eb7kmcn45ohl0gk3chh2','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497062135','shop_view|a:1:{i:7;i:1;}'),(0,'e8ji2lsgkrh393olucfenrqu33','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497078673','shop_view|a:1:{i:4;i:1;}'),(0,'6qn88vnd9tabaikei4cg5tgqm3','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497078676','shop_view|a:1:{i:1;i:1;}'),(0,'8h6rr6i2nudljeaori5kkomd41','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497078683','shop_view|a:1:{i:10;i:1;}'),(0,'rcoatf5ftehlimh7tevor66fu3','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497078686','shop_view|a:1:{i:3;i:1;}'),(0,'rjvbvtbet3314gnejjqerct9h5','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497078689','shop_view|a:1:{i:13;i:1;}'),(0,'81rilqq1004v71kmg5v0h2tci4','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497078692','shop_view|a:1:{i:11;i:1;}'),(0,'t5fpf7aih1ohr33g62otltp6t6','66.249.64.83','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','1497084517','shop_view|a:1:{i:6;i:1;}'),(0,'uq6ogfsqo51cdu0mr4p7hd4816','95.215.115.116','Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) CriOS/59.0.3071.84 Mobile/14E304 Safari/602.1','1497090433','news_view|a:1:{i:3;i:1;}captcha|a:1:{s:9:\"comments0\";a:1:{i:9969;s:6:\"251480\";}}'),(0,'bevs1j4tn73uuqnjrnqso082q0','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497094570','shop_view|a:1:{i:6;i:1;}'),(0,'hrtntuj42vsh6gf471gkvk67p5','66.249.64.85','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','1497094624','shop_view|a:1:{i:1;i:1;}'),(0,'fm41pjusbagta1lpqtdb48k1t0','66.249.64.83','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','1497099146','shop_view|a:1:{i:10;i:1;}'),(0,'tbjk8glmmub3ei3ihgr3mshsl5','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497103176','shop_view|a:1:{i:2;i:1;}'),(0,'i40lotcduqgut8cna0i2km1s63','66.249.64.87','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','1497103693','shop_view|a:1:{i:13;i:1;}'),(0,'mvstqc2hi95c6jo64fnbh0ruo3','66.249.64.85','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','1497108741','shop_view|a:1:{i:4;i:1;}'),(0,'8lelq85lrugq9uun4fmokkraq0','178.34.158.145','Mozilla/5.0 (Windows NT 6.1; WOW64; rv:53.0) Gecko/20100101 Firefox/53.0','1497110266','cart_summ|i:0;cart_count|i:0;cart|a:0:{}cart_delivery|s:1:\"1\";'),(0,'dhba70pru26r9220l14pdr5mf5','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497111161','shop_view|a:1:{i:12;i:1;}'),(0,'smikl6g7aj59sdrlg21rggane1','66.249.64.87','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','1497112788','shop_view|a:1:{i:7;i:1;}'),(0,'1kd5cqgm49lubm12dpa79hcm85','66.249.64.83','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','1497117334','shop_view|a:1:{i:11;i:1;}'),(0,'qu73aithunfg33l0g8kvfisbn0','66.249.64.85','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','1497121881','shop_view|a:1:{i:3;i:1;}'),(0,'h63vmv328ppsa6e7nksp2h7op7','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497127351','shop_view|a:1:{i:3;i:1;}'),(0,'cdm4pimsqrm10md5qh69i647f2','66.249.64.85','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','1497145246','shop_view|a:1:{i:12;i:1;}'),(0,'mhcvp28br72nhp3bnohi0h8c73','66.249.64.83','Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)','1497149300','shop_view|a:1:{i:2;i:1;}'),(0,'gdslos8579gkiav8qacs1bac37','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497240358','shop_view|a:1:{i:10;i:1;}'),(0,'hfikqi2vt1g3n3c7jo91lsu5c7','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497247621','shop_view|a:1:{i:1;i:1;}'),(0,'3o8im2g0iummgajv82bpla1c14','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497259831','shop_view|a:1:{i:4;i:1;}'),(0,'msm514jrpvn5a5msiaa3fh51o1','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497275682','shop_view|a:1:{i:13;i:1;}'),(0,'hh4pfn3mqptccqsi9qf6t1qo54','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497283540','shop_view|a:1:{i:3;i:1;}'),(0,'joka87a6njlarnkj9vckpcam32','95.153.131.239','Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) CriOS/59.0.3071.84 Mobile/14E304 Safari/602.1','1497287833','news_view|a:1:{i:3;i:1;}captcha|a:1:{s:9:\"comments0\";a:1:{i:1976;s:6:\"026454\";}}'),(0,'ho3qn8dglu9977iu1vql0fcce4','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497288244','shop_view|a:1:{i:11;i:1;}'),(0,'91ml13j6tlabuoflni62lvaoe5','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497322269','shop_view|a:1:{i:2;i:1;}'),(0,'8dmn460qm13pmm8ofpq5o67kv6','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497323197','news_view|a:1:{i:2;i:1;}'),(0,'pn3g5p8773utqbqmeerq90hv36','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497324326','shop_view|a:1:{i:7;i:1;}'),(0,'834vip3bpq2h5np56glk7tjmf0','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497342518','news_view|a:1:{i:3;i:1;}'),(0,'uq6c507e0nqlgagbgds3tj2ru5','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497349010','shop_view|a:1:{i:12;i:1;}'),(0,'bnbbk73j9mnurr8qjuu85finp5','77.123.218.132','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.137 YaBrowser/17.4.1.919 Yowser/2.5 Safari/537.36','1497355955',''),(0,'8iock0gm5dujjmbotfqlm65mn1','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497358670','shop_view|a:1:{i:11;i:1;}'),(0,'dp6tj8sb772e1cr4q1ikg1joc6','95.153.131.228','Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) CriOS/59.0.3071.84 Mobile/14E304 Safari/602.1','1497359969','news_view|a:1:{i:3;i:1;}captcha|a:1:{s:9:\"comments0\";a:2:{i:5389;s:5:\"93743\";i:3736;s:5:\"25864\";}}shop_view|a:1:{i:7;i:1;}'),(0,'eqhm9qaa377i9kcot5ik55qbi6','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497366952','shop_view|a:1:{i:14;i:1;}'),(0,'bniu3v84v8l8a3bao81d2rh4j5','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497404554','shop_view|a:1:{i:10;i:1;}'),(0,'2uei7tau7dkpdv9vmgq0u7i4i0','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497407127','shop_view|a:1:{i:6;i:1;}'),(0,'iehbo9pl0mklkpe6unajllqdo1','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497412446','shop_view|a:1:{i:4;i:1;}'),(0,'l9f88dvg2t4hv2454qgsjastu2','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497422029','shop_view|a:1:{i:13;i:1;}'),(0,'hobgg7mctv1hpjompqrlk2daj1','141.8.132.1','Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)','1497433244','shop_view|a:1:{i:3;i:1;}'),(0,'mth3plajpf0vir25q2nfii5ek4','77.123.218.132','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.137 YaBrowser/17.4.1.919 Yowser/2.5 Safari/537.36','1497469799',''),(0,'ugdrne0rhman90p34jrk0fpg86','46.73.174.126','Mozilla/5.0 (Windows NT 5.1; rv:9.0.1) Gecko/20100101 Firefox/9.0.1','1497455827',''),(0,'r5rm2olvpbcglsn8h8lgj57bq7','95.215.118.223','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.86 Safari/537.36','1497457276',''),(0,'eedtmq3qklvdt4ockepa9hppj4','77.123.218.132','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.137 YaBrowser/17.4.1.919 Yowser/2.5 Safari/537.36','1497470378',''),(0,'nllb358fce43c78bo8bo61hdb0','95.215.118.223','Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) CriOS/59.0.3071.84 Mobile/14E304 Safari/602.1','1497461013',''),(0,'pma3uc86g2vq776brq1ah83sr5','77.123.218.132','Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.137 YaBrowser/17.4.1.919 Yowser/2.5 Safari/537.36','1497511006',''),(1,'5hptkjcc0aimneeq0ebd765ot2','127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.86 Safari/537.36','1497557356','cart_summ|i:2660000;cart_count|i:1;search|a:5:{i:0;s:10:\"бетон\";i:1;s:14:\"прибыль\";i:2;s:24:\"производство\";i:3;s:20:\"производст\";i:4;s:12:\"произв\";}group_action|a:3:{s:13:\"shop/category\";s:7:\"unblock\";s:4:\"site\";s:5:\"trash\";s:4:\"menu\";s:5:\"trash\";}shop_view|a:1:{i:17;i:1;}clauses_view|a:1:{i:1;i:1;}news_view|a:2:{i:4;i:1;i:5;i:1;}cart_delivery|s:1:\"1\";'),(0,'1hoei7nt6kt1cnglhholo08184','127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.86 Safari/537.36','1497621416','news_view|a:1:{i:5;i:1;}captcha|a:1:{s:9:\"comments0\";a:1:{i:4173;s:6:\"832685\";}}'),(0,'4pdsof1u1lg9dp2hqri570ma11','127.0.0.1','Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36','1497619172','');
/*!40000 ALTER TABLE `indf_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_sessions_hash`
--

DROP TABLE IF EXISTS `indf_sessions_hash`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_sessions_hash` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор пользователя из таблицы `indf_users`',
  `hash` char(32) NOT NULL DEFAULT '' COMMENT 'хеш',
  `created` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата создания',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=912 DEFAULT CHARSET=utf8 COMMENT='Контрольные хэши авторизованных пользователей';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_sessions_hash`
--

LOCK TABLES `indf_sessions_hash` WRITE;
/*!40000 ALTER TABLE `indf_sessions_hash` DISABLE KEYS */;
INSERT INTO `indf_sessions_hash` VALUES (911,1,'75c69b5b667ce895a05ad3398c3ed2c7',1497557354),(910,1,'4f7e99def37194414d22c982fa5e4fc7',1497551190),(909,1,'8f9a113c3d4649a634e4887904b1c389',1497550634);
/*!40000 ALTER TABLE `indf_sessions_hash` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop`
--

DROP TABLE IF EXISTS `indf_shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `name1` text COMMENT 'название',
  `act1` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'показывать на сайте: 0 - нет, 1 - да',
  `date_start` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата начала показа',
  `date_finish` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата окончания показа',
  `article` varchar(30) NOT NULL DEFAULT '' COMMENT 'артикул',
  `measure_unit1` varchar(50) NOT NULL DEFAULT '' COMMENT 'единица измерения',
  `weight` varchar(50) NOT NULL DEFAULT '' COMMENT 'вес',
  `length` varchar(50) NOT NULL DEFAULT '' COMMENT 'длина',
  `width` varchar(50) NOT NULL DEFAULT '' COMMENT 'ширина',
  `height` varchar(50) NOT NULL DEFAULT '' COMMENT 'высота',
  `map_no_show` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'не показывать на карте сайта: 0 - нет, 1 - да',
  `changefreq` enum('always','hourly','daily','weekly','monthly','yearly','never') NOT NULL DEFAULT 'always' COMMENT 'Changefreq для sitemap.xml',
  `priority` varchar(3) NOT NULL DEFAULT '' COMMENT 'Priority для sitemap.xml',
  `noindex` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'не индексировать: 0 - нет, 1 - да',
  `cat_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор основной категории из таблицы `indf_shop_category`',
  `site_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор страницы сайта из таблицы `indf_site`',
  `brand_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор производителя из таблицы `indf_shop_brand`',
  `keywords1` varchar(250) NOT NULL DEFAULT '' COMMENT 'ключевые слова, тег Keywords',
  `descr1` text COMMENT 'описание, тэг Description',
  `canonical1` varchar(100) NOT NULL DEFAULT '' COMMENT 'канонический тег',
  `title_meta1` varchar(250) NOT NULL DEFAULT '' COMMENT 'заголовок окна в браузере, тег Title',
  `anons1` text COMMENT 'анонс',
  `anons_plus1` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'добавлять анонс к описанию: 0 - нет, 1 - да',
  `text1` text COMMENT 'описание',
  `yandex` text COMMENT 'данные для выгрузки в Яндекс.Маркет',
  `show_yandex` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'выгружать в Яндекс.Маркет: 0 - нет, 1 - да (если в настройках выбрана выгрузка только выбранных товаров)',
  `no_buy` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'товар временно отсутствует: 0 - нет, 1 - да',
  `import` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'товар только что импортирован: 0 - нет, 1 - да',
  `import_id` varchar(100) NOT NULL DEFAULT '' COMMENT 'собственный идентификатор товара при импорте',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'подрядковый номер для сортировки',
  `timeedit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'время последнего изменения в формате UNIXTIME',
  `counter_buy` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'количество покупок',
  `hit` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'хит: 0 - нет, 1 - да',
  `new` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'новинка: 0 - нет, 1 - да',
  `action` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'акция: 0 - нет, 1 - да',
  `is_file` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'это товар-файл: 0 - нет, 1 - да',
  `access` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'доступ ограничен: 0 - нет, 1 - да',
  `admin_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'пользователь из таблицы `indf_users`, добавивший или первый отредктировавший товар в административной части',
  `theme` varchar(50) NOT NULL DEFAULT '' COMMENT 'шаблон страницы сайта',
  `view` varchar(50) NOT NULL DEFAULT '' COMMENT 'шаблон модуля',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`),
  KEY `brand_id` (`brand_id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='Товары';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop`
--

LOCK TABLES `indf_shop` WRITE;
/*!40000 ALTER TABLE `indf_shop` DISABLE KEYS */;
INSERT INTO `indf_shop` VALUES (1,'Мозаика &quot;Miledi&quot;','1',0,0,'12365478','','','','','','0','always','','0',1,6,4,'',NULL,'','',NULL,'0','<p>Как правило, описание товара включает основные характеристики, производителя, цену и несколько фотографий.<br> <br> Лучше&nbsp;<strong>выделить</strong>&nbsp;какие-то значимые участки, текст можно&nbsp;<em>отформатировать</em>, как в Word, разместить таблицы, изображения и&nbsp;<a href=\"http://theme.diafantest.ru/\">ссылки</a>&nbsp;на другие страницы.<br> Чтобы отредактировать этот текст прямо на этой странице, нажмите \"Быстрое редактирование\"&nbsp;на панели вверху страницы. Или \"Администрирование\", чтобы перейти на редактирование этой страницы в административной панели.</p>',NULL,'0','0','0','',1,1496828862,0,'1','0','1','0','0',0,'','','1'),(2,'Керамогранит &quot;Giorgio&quot;','1',0,0,'25879456','','','','','','0','always','','0',12,6,3,'',NULL,'','','<p>.</p>','0','<p>Как правило, описание товара включает основные характеристики, производителя, цену и несколько фотографий.<br> <br> Лучше&nbsp;<strong>выделить</strong>&nbsp;какие-то значимые участки, текст можно&nbsp;<em>отформатировать</em>, как в Word, разместить таблицы, изображения и&nbsp;<a href=\"http://theme.diafantest.ru/\">ссылки</a>&nbsp;на другие страницы.<br> Чтобы отредактировать этот текст прямо на этой странице, нажмите \"Быстрое редактирование\"&nbsp;на панели вверху страницы. Или \"Администрирование\", чтобы перейти на редактирование этой страницы в административной панели.</p>',NULL,'0','0','0','',2,1496828863,0,'0','1','1','0','0',0,'','','1'),(3,'Керамическая плитка &quot;Valensia&quot;','1',0,0,'89775482','','','','','','0','always','','0',3,6,5,'',NULL,'','',NULL,'0','<p>Как правило, описание товара включает основные характеристики, производителя, цену и несколько фотографий.<br> <br> Лучше&nbsp;<strong>выделить</strong>&nbsp;какие-то значимые участки, текст можно&nbsp;<em>отформатировать</em>, как в Word, разместить таблицы, изображения и&nbsp;<a href=\"http://theme.diafantest.ru/\">ссылки</a>&nbsp;на другие страницы.<br> Чтобы отредактировать этот текст прямо на этой странице, нажмите \"Быстрое редактирование\"&nbsp;на панели вверху страницы. Или \"Администрирование\", чтобы перейти на редактирование этой страницы в административной панели.</p>',NULL,'0','0','0','',3,1496828864,0,'1','1','0','0','0',0,'','','1'),(4,'Керамическая плитка &quot;Keramomarazzi&quot;','1',0,0,'89765412','','','','','','0','always','','0',4,6,4,'',NULL,'','',NULL,'0','<p>Как правило, описание товара включает основные характеристики, производителя, цену и несколько фотографий.<br> <br> Лучше&nbsp;<strong>выделить</strong>&nbsp;какие-то значимые участки, текст можно&nbsp;<em>отформатировать</em>, как в Word, разместить таблицы, изображения и&nbsp;<a href=\"http://theme.diafantest.ru/\">ссылки</a>&nbsp;на другие страницы.<br> Чтобы отредактировать этот текст прямо на этой странице, нажмите \"Быстрое редактирование\"&nbsp;на панели вверху страницы. Или \"Администрирование\", чтобы перейти на редактирование этой страницы в административной панели.</p>',NULL,'0','0','0','',4,1496828864,0,'0','1','0','0','0',0,'','','1'),(6,'Керамогранит &quot;Kaleo&quot;','1',0,0,'25874169','','','','','','0','always','','0',6,6,5,'',NULL,'','',NULL,'0','<p>Как правило, описание товара включает основные характеристики, производителя, цену и несколько фотографий.<br> <br> Лучше&nbsp;<strong>выделить</strong>&nbsp;какие-то значимые участки, текст можно&nbsp;<em>отформатировать</em>, как в Word, разместить таблицы, изображения и&nbsp;<a href=\"http://theme.diafantest.ru/\">ссылки</a>&nbsp;на другие страницы.<br> Чтобы отредактировать этот текст прямо на этой странице, нажмите \"Быстрое редактирование\"&nbsp;на панели вверху страницы. Или \"Администрирование\", чтобы перейти на редактирование этой страницы в административной панели.</p>',NULL,'0','0','0','',6,1496828865,0,'1','1','1','0','0',0,'','','1'),(7,'Керамическая плитка &quot;Valio&quot;','1',0,0,'78965412','','','','','','0','always','','0',7,6,1,'',NULL,'','',NULL,'0','<p>Как правило, описание товара включает основные характеристики, производителя, цену и несколько фотографий.<br> <br> Лучше&nbsp;<strong>выделить</strong>&nbsp;какие-то значимые участки, текст можно&nbsp;<em>отформатировать</em>, как в Word, разместить таблицы, изображения и&nbsp;<a href=\"http://theme.diafantest.ru/\">ссылки</a>&nbsp;на другие страницы.<br> Чтобы отредактировать этот текст прямо на этой странице, нажмите \"Быстрое редактирование\"&nbsp;на панели вверху страницы. Или \"Администрирование\", чтобы перейти на редактирование этой страницы в административной панели.</p>',NULL,'0','0','0','',7,1496828865,1,'1','1','1','0','0',0,'','','1'),(10,'Керамическая плитка &quot;Fliomio&quot;','1',0,0,'852349765','','','','','','0','always','','0',4,6,4,'',NULL,'','',NULL,'0','<p>Как правило, описание товара включает основные характеристики, производителя, цену и несколько фотографий.<br> <br> Лучше&nbsp;<strong>выделить</strong>&nbsp;какие-то значимые участки, текст можно&nbsp;<em>отформатировать</em>, как в Word, разместить таблицы, изображения и&nbsp;<a href=\"http://theme.diafantest.ru/\">ссылки</a>&nbsp;на другие страницы.<br> Чтобы отредактировать этот текст прямо на этой странице, нажмите \"Быстрое редактирование\"&nbsp;на панели вверху страницы. Или \"Администрирование\", чтобы перейти на редактирование этой страницы в административной панели.</p>',NULL,'0','0','0','',4,1496828866,0,'0','1','1','0','0',0,'','','1'),(11,'Керамическая плитка &quot;Milana&quot;','1',0,0,'1478564','','','','','','0','always','','0',3,6,5,'',NULL,'','',NULL,'0','<p>Как правило, описание товара включает основные характеристики, производителя, цену и несколько фотографий.<br> <br> Лучше&nbsp;<strong>выделить</strong>&nbsp;какие-то значимые участки, текст можно&nbsp;<em>отформатировать</em>, как в Word, разместить таблицы, изображения и&nbsp;<a href=\"http://theme.diafantest.ru/\">ссылки</a>&nbsp;на другие страницы.<br> Чтобы отредактировать этот текст прямо на этой странице, нажмите \"Быстрое редактирование\"&nbsp;на панели вверху страницы. Или \"Администрирование\", чтобы перейти на редактирование этой страницы в административной панели.</p>',NULL,'0','0','0','',3,1496828866,0,'1','1','0','0','0',0,'','','1'),(12,'Керамогранит &quot;Magnifiko&quot;','1',0,0,'8951375','','','','','','0','always','','0',12,6,3,'',NULL,'','',NULL,'0','<p>Как правило, описание товара включает основные характеристики, производителя, цену и несколько фотографий.<br> <br> Лучше&nbsp;<strong>выделить</strong>&nbsp;какие-то значимые участки, текст можно&nbsp;<em>отформатировать</em>, как в Word, разместить таблицы, изображения и&nbsp;<a href=\"http://theme.diafantest.ru/\">ссылки</a>&nbsp;на другие страницы.<br> Чтобы отредактировать этот текст прямо на этой странице, нажмите \"Быстрое редактирование\"&nbsp;на панели вверху страницы. Или \"Администрирование\", чтобы перейти на редактирование этой страницы в административной панели.</p>',NULL,'0','0','0','',2,1496828866,0,'0','1','1','0','0',0,'','','1'),(13,'Мозаика &quot;Rico-co&quot;','1',0,0,'79461382','','','','','','0','always','','0',1,6,4,'',NULL,'','',NULL,'0','<p>Как правило, описание товара включает основные характеристики, производителя, цену и несколько фотографий.<br> <br> Лучше&nbsp;<strong>выделить</strong>&nbsp;какие-то значимые участки, текст можно&nbsp;<em>отформатировать</em>, как в Word, разместить таблицы, изображения и&nbsp;<a href=\"http://theme.diafantest.ru/\">ссылки</a>&nbsp;на другие страницы.<br> Чтобы отредактировать этот текст прямо на этой странице, нажмите \"Быстрое редактирование\"&nbsp;на панели вверху страницы. Или \"Администрирование\", чтобы перейти на редактирование этой страницы в административной панели.</p>',NULL,'0','0','0','',1,1496828867,0,'1','0','0','0','0',0,'','','1'),(14,'Мясной магазин на первой линии','1',0,0,'','','0','0','0','0','0','monthly','0','0',25,6,0,'','','','','','0','<div class=\"item-view-block\">\r\n<div class=\"item-description\">\r\n<div class=\"item-description-text\" itemprop=\"description\">\r\n<p>Продам мясной магазин в Симферополе<br>Магазин работает более 10 лет, пользуется большим спросом.<br>Укомплектован всем необходимым:<br>Чистый, светлый. <br>Находится вдоль проезжей части. 1 линия. В хорошем районе.<br>Оборудован современными холодильниками, витринами, необходимым инвентарем.</p>\r\n<p>Из Ассортимента мясо в маринаде, свежее мясо, все для шашлыка, полуфабрикаты, специи и др.<br>Разруб свой.</p>\r\n<p>Общая площадь помещения 70м2<br>Торговая 20м2<br>2 продавца</p>\r\n<p>Окупаемость 12 мес.</p>\r\n<p>Бизнес автоматизирован, приносит стабильную прибыль.<br>Практически не отнимает времени.</p>\r\n<p>Грамотные продавцы, стабильные поставщики! Все просто!<br>Продажа в связи с переходом в Оптовую торговлю.</p>\r\n<p>Подробней звоните.</p>\r\n</div>\r\n</div>\r\n</div>','typePrefix=\nvendor=\nmodel=\nvendorCode=\nsales_notes=\nmanufacturer_warranty=\ncountry_of_origin=\nbid=\ncbid=','0','0','0','',14,1497451364,0,'0','1','0','0','0',1,'','','0'),(15,'ООО','1',0,0,'','','0','0','0','0','0','monthly','0','0',25,6,0,'','','','','','0','<p>10 летняя ООО, с положительной репутацией</p>\r\n<p>СРО оплачено 350 тыс<br>Строительная фирма (до 60 млн.)</p>\r\n<p>полный Архив со всей документацией готов к Аудиту.</p>\r\n<p>Звоните.</p>','typePrefix=\nvendor=\nmodel=\nvendorCode=\nsales_notes=\nmanufacturer_warranty=\ncountry_of_origin=\nbid=\ncbid=','0','0','0','',15,1497451816,0,'0','1','0','0','0',1,'','','0'),(16,'Производство пластиковых окон','1',0,0,'','','0','0','0','0','0','monthly','0','0',25,6,0,'','','','','','0','<p>Производство металлоплавильных окон и дверей</p>\r\n<p>Основная масса заказов свои стройки.<br>+ сарафанное радио, за несколько лет поставили окна и двери всем родственниками, их знакомым и знакомым их знакомых.</p>\r\n<p>Станки: (пр-во Турция)<br>Резка арматуры под диск 350х25.4<br>Резка профиля ACK 420<br>Вырезка замка FR 224<br>Паяльный станок HEGSAN<br>Вырезка импоста <br>Дренажный канал ST 263<br>Штапикорез<br>Компрессор 1000 литров<br>Булерьян<br>Столы 3 шт, стойки, стеллажи.<br>Пневмоинструмент<br>Ручной инструмент<br>Расходники<br>Булерьян</p>\r\n<p>Все оборудование работает на воздухе. <br>В месяц выходит до 80-90 КВ эл-ва 500-600 рублей к оплате.</p>\r\n<p>За 9 лет работы ни одной жалобы.</p>\r\n<p>Выгодная аренда помещения.<br>Выгодная себестоимость окна.</p>\r\n<p>Персонал 2 человека в нагрузке 4<br>Универсалы, опыт 9 лет.<br>+ сами делают монтаж</p>\r\n<p>Работаем с профилем WINTECH</p>\r\n<p>Станки обслужены, мастер сам меняет все масла фильтра <br>Готовы обучить работе на всех станках.</p>\r\n<p>Персонал не против продолжить работу с новым собственником + буду передавать заказы с текущих строек.</p>\r\n<p>Звоните.</p>','typePrefix=\nvendor=\nmodel=\nvendorCode=\nsales_notes=\nmanufacturer_warranty=\ncountry_of_origin=\nbid=\ncbid=','0','0','0','',16,1497452868,0,'0','0','1','0','0',1,'','','0'),(17,'Производство профнастила крыша забор','1',0,0,'','','0','0','0','0','0','monthly','0','0',27,6,0,'','','','','','0','<p>Оборудование находится в отличном состоянии</p>\r\n<p>Волна используется для кровли, потолка, стены, забора.</p>\r\n<p>Станок евпропейский, управляется одним оператором</p>\r\n<p>В стоимость входит погрузчик.</p>\r\n<p>Волна 18-я, с двойной копилярной канавкой (усиленная)</p>\r\n<p>Звоните</p>\r\n<p>2008 польская</p>\r\n<p>линия - в польше заказывали.<br>20 тыс. - чисто под хранение... , вложиться, электричество, подьездные пути <br>обучит</p>\r\n<p>2 800 000<br>12 метров сама станина - равномерно гнет, не ломается концы геометрия.<br>6 метров китай и россия</p>\r\n<p>конфигурация с 2 ребрами жесткости.</p>','typePrefix=\nvendor=\nmodel=\nvendorCode=\nsales_notes=\nmanufacturer_warranty=\ncountry_of_origin=\nbid=\ncbid=','0','0','0','',17,1497453779,1,'1','0','0','0','0',1,'','','0');
/*!40000 ALTER TABLE `indf_shop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_additional_cost`
--

DROP TABLE IF EXISTS `indf_shop_additional_cost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_additional_cost` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `name1` varchar(50) NOT NULL DEFAULT '' COMMENT 'название',
  `text1` text COMMENT 'описание',
  `act1` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'показывать на сайте: 0 - нет, 1 - да',
  `shop_rel` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'связана с товаром: 0 - нет, 1 - да',
  `percent` double NOT NULL DEFAULT '0' COMMENT 'процент от стоимости товаров в корзине',
  `price` double NOT NULL DEFAULT '0' COMMENT 'цена',
  `amount` double NOT NULL DEFAULT '0' COMMENT 'бесплатно от',
  `required` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'всегда включено в цену: 0 - нет, 1 - да',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'подрядковый номер для сортировки',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Сопутствующие услуги';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_additional_cost`
--

LOCK TABLES `indf_shop_additional_cost` WRITE;
/*!40000 ALTER TABLE `indf_shop_additional_cost` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_shop_additional_cost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_additional_cost_category_rel`
--

DROP TABLE IF EXISTS `indf_shop_additional_cost_category_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_additional_cost_category_rel` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `cat_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор категории из таблицы `indf_shop_category`',
  `element_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор сопутствующей услуги из таблицы `indf_shop_additional_cost`',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `cat_id` (`cat_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Связь сопутствующих услуг и категорий';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_additional_cost_category_rel`
--

LOCK TABLES `indf_shop_additional_cost_category_rel` WRITE;
/*!40000 ALTER TABLE `indf_shop_additional_cost_category_rel` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_shop_additional_cost_category_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_additional_cost_rel`
--

DROP TABLE IF EXISTS `indf_shop_additional_cost_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_additional_cost_rel` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор товара из таблицы `indf_shop`',
  `additional_cost_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор сопутствующей услуги из таблицы `indf_shop_additional_cost`',
  `summ` double NOT NULL DEFAULT '0' COMMENT 'сумма',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `element_id` (`element_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Связь сопутствующих услуг и товаров';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_additional_cost_rel`
--

LOCK TABLES `indf_shop_additional_cost_rel` WRITE;
/*!40000 ALTER TABLE `indf_shop_additional_cost_rel` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_shop_additional_cost_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_brand`
--

DROP TABLE IF EXISTS `indf_shop_brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_brand` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `name1` text COMMENT 'название',
  `act1` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'показывать на сайте: 0 - нет, 1 - да',
  `map_no_show` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'не показывать на карте сайта: 0 - нет, 1 - да',
  `changefreq` enum('always','hourly','daily','weekly','monthly','yearly','never') NOT NULL DEFAULT 'always' COMMENT 'Changefreq для sitemap.xml',
  `priority` varchar(3) NOT NULL DEFAULT '' COMMENT 'Priority для sitemap.xml',
  `noindex` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'не индексировать: 0 - нет, 1 - да',
  `site_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор страницы сайта из таблицы `indf_site`',
  `keywords1` varchar(250) NOT NULL DEFAULT '' COMMENT 'ключевые слова, тег Keywords',
  `descr1` text COMMENT 'описание, тэг Description',
  `canonical1` varchar(100) NOT NULL DEFAULT '' COMMENT 'канонический тег',
  `title_meta1` varchar(250) NOT NULL DEFAULT '' COMMENT 'заголовок окна в браузере, тег Title',
  `text1` text COMMENT 'описание',
  `import` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'производитель только что импортирован: 0 - нет, 1 - да',
  `import_id` varchar(100) NOT NULL DEFAULT '' COMMENT 'собственный идентификатор производителя при импорте',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'подрядковый номер для сортировки',
  `timeedit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'время последнего изменения в формате UNIXTIME',
  `admin_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'пользователь из таблицы `indf_users`, добавивший или первый отредктировавший производителя в административной части',
  `theme` varchar(50) NOT NULL DEFAULT '' COMMENT 'шаблон страницы сайта',
  `view` varchar(50) NOT NULL DEFAULT '' COMMENT 'шаблон модуля',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Бренды';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_brand`
--

LOCK TABLES `indf_shop_brand` WRITE;
/*!40000 ALTER TABLE `indf_shop_brand` DISABLE KEYS */;
INSERT INTO `indf_shop_brand` VALUES (1,'Argenta','1','0','always','','0',6,'',NULL,'','',NULL,'0','',1,1496828867,0,'','','0'),(2,'Azuvi','1','0','always','','0',6,'',NULL,'','',NULL,'0','',2,1496828867,0,'','','0'),(3,'Dual Gres','1','0','always','','0',6,'',NULL,'','',NULL,'0','',3,1496828867,0,'','','0'),(4,'Mainzu','1','0','always','','0',6,'',NULL,'','',NULL,'0','',4,1496828867,0,'','','0'),(5,'Saloni','1','0','always','','0',6,'',NULL,'','',NULL,'0','',5,1496828867,0,'','','0');
/*!40000 ALTER TABLE `indf_shop_brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_brand_category_rel`
--

DROP TABLE IF EXISTS `indf_shop_brand_category_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_brand_category_rel` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор производителя из таблицы `indf_shop_brand`',
  `cat_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор категории из таблицы `indf__category`',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `cat_id` (`cat_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Связи производителей и категорий';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_brand_category_rel`
--

LOCK TABLES `indf_shop_brand_category_rel` WRITE;
/*!40000 ALTER TABLE `indf_shop_brand_category_rel` DISABLE KEYS */;
INSERT INTO `indf_shop_brand_category_rel` VALUES (1,1,0,'0'),(2,2,0,'0'),(3,3,0,'0'),(4,4,0,'0'),(5,5,0,'0');
/*!40000 ALTER TABLE `indf_shop_brand_category_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_cart`
--

DROP TABLE IF EXISTS `indf_shop_cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_cart` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `good_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор товара из таблицы `indf_shop`',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор пользователя из таблицы `indf_users`',
  `price_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор цены товара - поле price_id из таблицы `indf_shop_price`',
  `created` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата создания',
  `count` double NOT NULL DEFAULT '0' COMMENT 'количество товара',
  `param` text COMMENT 'серилизованные данные о характеристиках товара (доступных к выбору при заказе)',
  `additional_cost` text COMMENT 'идентификаторы сопутствующих услугах, разделенные запятой',
  `is_file` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'товар-файл: 0 - нет, 1 - да',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Товары в корзине';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_cart`
--

LOCK TABLES `indf_shop_cart` WRITE;
/*!40000 ALTER TABLE `indf_shop_cart` DISABLE KEYS */;
INSERT INTO `indf_shop_cart` VALUES (1,17,1,52,1497510599,1,'a:0:{}','','0','0');
/*!40000 ALTER TABLE `indf_shop_cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_category`
--

DROP TABLE IF EXISTS `indf_shop_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `name1` text COMMENT 'название',
  `act1` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'показывать на сайте: 0 - нет, 1 - да',
  `map_no_show` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'не показывать на карте сайта: 0 - нет, 1 - да',
  `changefreq` enum('always','hourly','daily','weekly','monthly','yearly','never') NOT NULL DEFAULT 'always' COMMENT 'Changefreq для sitemap.xml',
  `priority` varchar(3) NOT NULL DEFAULT '' COMMENT 'Priority для sitemap.xml',
  `noindex` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'не индексировать: 0 - нет, 1 - да',
  `parent_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор родителя из таблицы `indf_shop_category`',
  `count_children` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'количество вложенных категорий',
  `site_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор страницы сайта из таблицы `indf_site`',
  `keywords1` varchar(250) NOT NULL DEFAULT '' COMMENT 'ключевые слова, тег Keywords',
  `descr1` text COMMENT 'описание, тэг Description',
  `canonical1` varchar(100) NOT NULL DEFAULT '' COMMENT 'канонический тег',
  `title_meta1` varchar(250) NOT NULL DEFAULT '' COMMENT 'заголовок окна в браузере, тег Title',
  `anons1` text COMMENT 'анонс',
  `anons_plus1` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'добавлять анонс к описанию: 0 - нет, 1 - да',
  `text1` text COMMENT 'описание',
  `show_yandex` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'выгружать в Яндекс.Маркет: 0 - нет, 1 - да (если в настройках выбрана выгрузка только выбранных категорий)',
  `import` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'категория только что импортирован: 0 - нет, 1 - да',
  `import_id` varchar(100) NOT NULL DEFAULT '' COMMENT 'собственный идентификатор категории при импорте',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'подрядковый номер для сортировки',
  `timeedit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'время последнего изменения в формате UNIXTIME',
  `access` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'доступ ограничен: 0 - нет, 1 - да',
  `admin_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'пользователь из таблицы `indf_users`, добавивший или первый отредктировавший категорию в административной части',
  `theme` varchar(50) NOT NULL DEFAULT '' COMMENT 'шаблон страницы сайта',
  `view` varchar(50) NOT NULL DEFAULT '' COMMENT 'шаблон модуля',
  `view_element` varchar(50) NOT NULL DEFAULT '' COMMENT 'шаблон модуля для элементов в категории',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COMMENT='Категории товаров';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_category`
--

LOCK TABLES `indf_shop_category` WRITE;
/*!40000 ALTER TABLE `indf_shop_category` DISABLE KEYS */;
INSERT INTO `indf_shop_category` VALUES (1,'Керамическая плитка','0','0','always','','0',0,3,6,'',NULL,'','','<p>Анонс должен быть кратким и завлекательным.&nbsp;Можно написать любой объем текста, но желательно уложиться в несколько абзацев.</p>','0','<p>Как правило, описание включает основные характеристики, цену и несколько фотографий.<br> Лучше&nbsp;выделить&nbsp;какие-то значимые участки, текст можно&nbsp;отформатировать, как в Word, разместить таблицы, изображения и&nbsp;<a href=\"http://theme.diafantest.ru/\">ссылки</a>&nbsp;на другие страницы.<o:p></o:p></p>\r\n<p>Чтобы отредактировать этот текст прямо на этой странице, нажмите &laquo;Быстрое редактирование&raquo; на панели вверху страницы. Или &laquo;Администрирование&raquo;, чтобы перейти на редактирование этой страницы в административной панели.</p>','0','0','',2,1496828862,'0',0,'','','','1'),(22,'Португалия','0','0','always','','0',1,0,6,'',NULL,'','',NULL,'0',NULL,'0','0','',22,1496828862,'0',0,'','','','1'),(23,'Турция','0','0','always','','0',1,0,6,'',NULL,'','',NULL,'0',NULL,'0','0','',23,1496828862,'0',0,'','','','1'),(24,'Беларусь','0','0','always','','0',1,0,6,'',NULL,'','',NULL,'0',NULL,'0','0','',24,1496828862,'0',0,'','','','1'),(2,'Керамогранит','0','0','always','','0',0,7,6,'',NULL,'','',NULL,'0',NULL,'0','0','',1,1496828862,'0',0,'','','','1'),(12,'Россия','0','0','always','','0',2,2,6,'',NULL,'','',NULL,'0',NULL,'0','0','',12,1496828862,'0',0,'','','','1'),(19,'Керамин','0','0','always','','0',12,0,6,'',NULL,'','',NULL,'0',NULL,'0','0','',19,1496828862,'0',0,'','','','1'),(20,'Belani','0','0','always','','0',12,0,6,'',NULL,'','',NULL,'0',NULL,'0','0','',20,1496828862,'0',0,'','','','1'),(13,'Китай','0','0','always','','0',2,2,6,'',NULL,'','',NULL,'0',NULL,'0','0','',13,1496828862,'0',0,'','','','1'),(17,'Del Conca','0','0','always','','0',13,0,6,'',NULL,'','',NULL,'0',NULL,'0','0','',17,1496828862,'0',0,'','','','1'),(18,'Vitra','0','0','always','','0',13,0,6,'',NULL,'','',NULL,'0',NULL,'0','0','',18,1496828862,'0',0,'','','','1'),(14,'Италия','0','0','always','','0',2,0,6,'',NULL,'','',NULL,'0',NULL,'0','0','',14,1496828862,'0',0,'','','','1'),(3,'Сопутствующие товары','0','0','always','','0',0,0,6,'',NULL,'','',NULL,'0',NULL,'0','0','',8,1496828862,'0',0,'','','','1'),(4,'Мозаика','0','0','always','','0',0,0,6,'',NULL,'','',NULL,'0',NULL,'0','0','',4,1496828862,'0',0,'','','','1'),(6,'Тёплый пол','0','0','always','','0',0,0,6,'',NULL,'','',NULL,'0',NULL,'0','0','',6,1496828862,'0',0,'','','','1'),(7,'Зеркальная плитка','0','0','always','','0',0,0,6,'',NULL,'','',NULL,'0',NULL,'0','0','',7,1496828862,'0',0,'','','','1'),(25,'Готовый бизнес','1','0','monthly','0','0',0,3,6,'','','','','','0','','0','0','',25,1496908007,'0',1,'','','','0'),(26,'Ком. недвижимость','1','0','monthly','0','0',0,0,6,'','','','','','0','','0','0','',26,1496909908,'0',1,'','','','1'),(27,'Оборудование','1','0','monthly','0','0',0,0,6,'','','','','','0','','0','0','',27,1496908393,'0',1,'','','','0'),(28,'Франшизы','0','0','monthly','0','0',0,0,6,'','','','','','0','','0','0','',29,1496909987,'0',1,'','','','0'),(29,'Услуги','0','0','monthly','0','0',0,0,6,'','','','','','0','','0','0','',30,1496910015,'0',1,'','','','0'),(30,'Аренда','0','0','monthly','0','0',0,0,6,'','','','','','0','','0','0','',28,1496910139,'0',1,'','','','0'),(31,'Торговля и магазины','1','0','monthly','0','0',25,0,6,'','','','','','0','','0','0','',31,1497351005,'0',1,'','','','0'),(32,'ООО','1','0','monthly','0','0',25,0,6,'','','','','<p>Купить ООО в Симферополе</p>','0','<p><span>Купить ООО в Симферополе или в Крыму</span></p>','0','0','',32,1497451635,'0',1,'','','','0'),(33,'Производство','1','0','monthly','0','0',25,0,6,'','','','','','0','','0','0','',33,1497452489,'0',1,'','','','0'),(34,'Ищу','1','0','monthly','0','0',0,0,6,'','','','','','0','','0','0','',34,1497469408,'0',1,'','','','0'),(35,'Работа в Инвест82','1','0','monthly','0','0',0,0,6,'','','','','','0','','0','0','',35,1497469762,'0',1,'','','','0');
/*!40000 ALTER TABLE `indf_shop_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_category_parents`
--

DROP TABLE IF EXISTS `indf_shop_category_parents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_category_parents` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор категории из таблицы `indf_shop_category`',
  `parent_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор категории-родителя из таблицы `indf_shop_category`',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='Родительские связи категорий товаров';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_category_parents`
--

LOCK TABLES `indf_shop_category_parents` WRITE;
/*!40000 ALTER TABLE `indf_shop_category_parents` DISABLE KEYS */;
INSERT INTO `indf_shop_category_parents` VALUES (1,22,1,'1'),(2,23,1,'1'),(3,24,1,'1'),(4,12,2,'1'),(5,19,12,'1'),(6,19,2,'1'),(7,20,12,'1'),(8,20,2,'1'),(9,13,2,'1'),(10,17,13,'1'),(11,17,2,'1'),(12,18,13,'1'),(13,18,2,'1'),(14,14,2,'1'),(15,31,25,'0'),(16,32,25,'0'),(17,33,25,'0');
/*!40000 ALTER TABLE `indf_shop_category_parents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_category_rel`
--

DROP TABLE IF EXISTS `indf_shop_category_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_category_rel` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор товара из таблицы `indf_shop`',
  `cat_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор категории из таблицы `indf_shop_category`',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `cat_id` (`cat_id`)
) ENGINE=MyISAM AUTO_INCREMENT=125 DEFAULT CHARSET=utf8 COMMENT='Связи товаров и категорий';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_category_rel`
--

LOCK TABLES `indf_shop_category_rel` WRITE;
/*!40000 ALTER TABLE `indf_shop_category_rel` DISABLE KEYS */;
INSERT INTO `indf_shop_category_rel` VALUES (1,1,1,'1'),(2,1,2,'1'),(3,1,12,'1'),(4,1,19,'1'),(5,1,20,'1'),(6,1,13,'1'),(7,1,18,'1'),(8,1,14,'1'),(9,1,22,'1'),(10,1,4,'1'),(11,1,7,'1'),(12,2,12,'1'),(13,2,2,'1'),(14,2,19,'1'),(15,2,20,'1'),(16,2,13,'1'),(17,2,17,'1'),(18,2,14,'1'),(19,2,1,'1'),(20,2,4,'1'),(21,2,6,'1'),(22,3,3,'1'),(23,3,2,'1'),(24,3,12,'1'),(25,3,19,'1'),(26,3,20,'1'),(27,3,1,'1'),(28,3,4,'1'),(29,3,6,'1'),(30,3,7,'1'),(31,4,4,'1'),(32,4,2,'1'),(33,4,12,'1'),(34,4,19,'1'),(35,4,20,'1'),(36,4,13,'1'),(37,4,14,'1'),(38,4,1,'1'),(39,4,24,'1'),(40,4,7,'1'),(41,4,3,'1'),(42,6,6,'1'),(43,6,2,'1'),(44,6,12,'1'),(45,6,19,'1'),(46,6,20,'1'),(47,6,1,'1'),(48,6,22,'1'),(49,6,24,'1'),(50,7,7,'1'),(51,7,2,'1'),(52,7,12,'1'),(53,7,19,'1'),(54,7,20,'1'),(55,7,1,'1'),(56,7,22,'1'),(57,7,23,'1'),(58,7,24,'1'),(59,10,4,'1'),(60,10,2,'1'),(61,10,12,'1'),(62,10,19,'1'),(63,10,20,'1'),(64,10,13,'1'),(65,10,14,'1'),(66,10,1,'1'),(67,10,24,'1'),(68,10,7,'1'),(69,10,3,'1'),(70,11,3,'1'),(71,11,2,'1'),(72,11,12,'1'),(73,11,19,'1'),(74,11,20,'1'),(75,11,1,'1'),(76,11,4,'1'),(77,11,6,'1'),(78,11,7,'1'),(79,12,12,'1'),(80,12,2,'1'),(81,12,19,'1'),(82,12,20,'1'),(83,12,13,'1'),(84,12,17,'1'),(85,12,14,'1'),(86,12,1,'1'),(87,12,4,'1'),(88,12,6,'1'),(89,13,1,'1'),(90,13,2,'1'),(91,13,12,'1'),(92,13,19,'1'),(93,13,20,'1'),(94,13,13,'1'),(95,13,18,'1'),(96,13,14,'1'),(97,13,22,'1'),(98,13,4,'1'),(99,13,7,'1'),(110,14,31,'0'),(109,14,25,'0'),(111,15,25,'0'),(112,15,32,'0'),(116,16,33,'0'),(115,16,25,'0'),(124,17,33,'0'),(123,17,27,'0');
/*!40000 ALTER TABLE `indf_shop_category_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_counter`
--

DROP TABLE IF EXISTS `indf_shop_counter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_counter` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор товара из таблицы `indf_shop`',
  `count_view` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'количество просмотров',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `element_id` (`element_id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='Счетчик просмотров товаров';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_counter`
--

LOCK TABLES `indf_shop_counter` WRITE;
/*!40000 ALTER TABLE `indf_shop_counter` DISABLE KEYS */;
INSERT INTO `indf_shop_counter` VALUES (1,2,6,'0'),(2,6,7,'0'),(3,1,6,'0'),(4,10,9,'0'),(5,13,8,'0'),(6,4,8,'0'),(7,7,7,'0'),(8,11,8,'0'),(9,3,9,'0'),(10,12,7,'0'),(11,14,2,'0'),(12,15,1,'0'),(13,16,1,'0'),(14,17,2,'0');
/*!40000 ALTER TABLE `indf_shop_counter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_currency`
--

DROP TABLE IF EXISTS `indf_shop_currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_currency` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `name` varchar(20) NOT NULL DEFAULT '' COMMENT 'название',
  `exchange_rate` double NOT NULL DEFAULT '0' COMMENT 'курс к основной валюте',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Дополнительные валюты магазина';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_currency`
--

LOCK TABLES `indf_shop_currency` WRITE;
/*!40000 ALTER TABLE `indf_shop_currency` DISABLE KEYS */;
INSERT INTO `indf_shop_currency` VALUES (1,'Euro',50,'0');
/*!40000 ALTER TABLE `indf_shop_currency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_delivery`
--

DROP TABLE IF EXISTS `indf_shop_delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_delivery` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `name1` varchar(50) NOT NULL DEFAULT '' COMMENT 'название',
  `text1` text COMMENT 'описание',
  `service` varchar(50) NOT NULL DEFAULT '' COMMENT 'служба доставки',
  `params` text COMMENT 'серилизованные настройки службы доставки',
  `act1` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'показывать на сайте: 0 - нет, 1 - да',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'подрядковый номер для сортировки',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Способы доставки';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_delivery`
--

LOCK TABLES `indf_shop_delivery` WRITE;
/*!40000 ALTER TABLE `indf_shop_delivery` DISABLE KEYS */;
INSERT INTO `indf_shop_delivery` VALUES (1,'Курьер','Товар доставляется курьером до двери Вашего дома.','',NULL,'1',1,'0'),(2,'Почта России','Доставка по всей России небольших посылок','',NULL,'1',2,'0'),(3,'EMS-доставка','Экспресс-доставка до дверей курьером в любую точку России','',NULL,'1',3,'0');
/*!40000 ALTER TABLE `indf_shop_delivery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_delivery_thresholds`
--

DROP TABLE IF EXISTS `indf_shop_delivery_thresholds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_delivery_thresholds` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `delivery_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор способа доставки из таблицы `indf_shop_delivery`',
  `price` double NOT NULL DEFAULT '0' COMMENT 'стоимость',
  `amount` double NOT NULL DEFAULT '0' COMMENT 'сумма, от которой действует стоимость',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Стоимость способов доставки';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_delivery_thresholds`
--

LOCK TABLES `indf_shop_delivery_thresholds` WRITE;
/*!40000 ALTER TABLE `indf_shop_delivery_thresholds` DISABLE KEYS */;
INSERT INTO `indf_shop_delivery_thresholds` VALUES (1,1,500,0,'0'),(2,1,0,6000,'0'),(3,2,650,0,'0'),(4,3,1200,0,'0');
/*!40000 ALTER TABLE `indf_shop_delivery_thresholds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_discount`
--

DROP TABLE IF EXISTS `indf_shop_discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_discount` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `date_start` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата начала действия',
  `date_finish` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата окночания действия',
  `discount` double NOT NULL DEFAULT '0' COMMENT 'процент скидки',
  `amount` double NOT NULL DEFAULT '0' COMMENT 'действует от цены товара',
  `deduction` double NOT NULL DEFAULT '0' COMMENT 'фиксированная сумма скидки',
  `threshold` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'действует от общей суммы заказа',
  `threshold_cumulative` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'действует от общей оплаченных заказов',
  `role_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '  тип пользователя из таблицы `indf_users_role`, для которого установлена скидка',
  `act` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'показывать на сайте: 0 - нет, 1 - да',
  `person` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'скидка действует только для определенных пользователей: 0 - нет, 1 - да',
  `text` text COMMENT 'описание скидки для администратора',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Скидки';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_discount`
--

LOCK TABLES `indf_shop_discount` WRITE;
/*!40000 ALTER TABLE `indf_shop_discount` DISABLE KEYS */;
INSERT INTO `indf_shop_discount` VALUES (1,0,0,5,0,0,0,0,0,'1','0',NULL,'0');
/*!40000 ALTER TABLE `indf_shop_discount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_discount_coupon`
--

DROP TABLE IF EXISTS `indf_shop_discount_coupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_discount_coupon` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `discount_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор скидки из таблицы `indf_shop_discount`',
  `coupon` varchar(10) NOT NULL DEFAULT '' COMMENT 'код купона',
  `count_use` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'cколько раз можно использовать купон',
  `used` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'сколько раз купон использован при оформлении заказа',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `discount_id` (`discount_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Купоны на скидку';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_discount_coupon`
--

LOCK TABLES `indf_shop_discount_coupon` WRITE;
/*!40000 ALTER TABLE `indf_shop_discount_coupon` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_shop_discount_coupon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_discount_object`
--

DROP TABLE IF EXISTS `indf_shop_discount_object`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_discount_object` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `discount_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор скидки из таблицы `indf_shop_discount`',
  `cat_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор категории из таблицы `indf_shop_category`',
  `good_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор товара из таблицы `indf_shop`',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `discount_id` (`discount_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Товары и категории, на которые действуют скидки';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_discount_object`
--

LOCK TABLES `indf_shop_discount_object` WRITE;
/*!40000 ALTER TABLE `indf_shop_discount_object` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_shop_discount_object` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_discount_person`
--

DROP TABLE IF EXISTS `indf_shop_discount_person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_discount_person` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `discount_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор скидки из таблицы `indf_shop_discount`',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор пользователя из таблицы `indf_users`',
  `session_id` varchar(64) NOT NULL DEFAULT '' COMMENT 'номер сессии пользователя из таблицы `indf_sessions`',
  `coupon_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор купона из таблицы `indf_shop_discount_coupon`',
  `used` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'скидка уже использована: 0 - нет, 1 - да',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `discount_id` (`discount_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Пользователи, для которых действуют скидки';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_discount_person`
--

LOCK TABLES `indf_shop_discount_person` WRITE;
/*!40000 ALTER TABLE `indf_shop_discount_person` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_shop_discount_person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_files_codes`
--

DROP TABLE IF EXISTS `indf_shop_files_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_files_codes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `shop_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор товара из таблицы `indf_shop`',
  `code` varchar(50) NOT NULL DEFAULT '' COMMENT 'код для скачивания товара-файла',
  `date_finish` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'дата и время окончания действия кода',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Коды для скачивания товаров-нематериальных активов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_files_codes`
--

LOCK TABLES `indf_shop_files_codes` WRITE;
/*!40000 ALTER TABLE `indf_shop_files_codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_shop_files_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_import`
--

DROP TABLE IF EXISTS `indf_shop_import`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_import` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `name` varchar(250) NOT NULL DEFAULT '' COMMENT 'название',
  `cat_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор описания файла из таблицы `indf_shop_import`',
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT 'тип',
  `params` text COMMENT 'серилизованные данные о поле',
  `required` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'серилизованные данные о поле',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'выдавать ошибку, если поле не заполнено: 0 - нет, 1 - да',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='Описание полей файлов импорта';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_import`
--

LOCK TABLES `indf_shop_import` WRITE;
/*!40000 ALTER TABLE `indf_shop_import` DISABLE KEYS */;
INSERT INTO `indf_shop_import` VALUES (1,'Идентификатор',1,'id','a:1:{s:4:\"type\";s:4:\"site\";}','0',1,'0'),(2,'Артикул товара',1,'article',NULL,'0',2,'0'),(3,'Название товара',1,'name',NULL,'0',3,'0'),(4,'Краткое описание',1,'anons',NULL,'0',4,'0'),(5,'Полное описание товара',1,'text',NULL,'0',5,'0'),(6,'Цена',1,'price','a:5:{s:9:\"delimitor\";s:1:\"&\";s:11:\"select_type\";s:3:\"key\";s:5:\"count\";i:0;s:8:\"currency\";i:0;s:15:\"select_currency\";s:3:\"key\";}','0',6,'0'),(7,'Количество',1,'count','a:2:{s:9:\"delimitor\";s:1:\"&\";s:11:\"select_type\";s:3:\"key\";}','0',7,'0'),(8,'Хит (1/0)',1,'hit',NULL,'0',8,'0'),(9,'Новинка (1/0)',1,'new',NULL,'0',9,'0'),(10,'Акция (1/0)',1,'action',NULL,'0',10,'0'),(11,'Идентификатор',2,'id','a:1:{s:4:\"type\";s:4:\"site\";}','0',11,'0'),(12,'Название категории',2,'name',NULL,'0',12,'0'),(13,'Краткое описание категории',2,'anons',NULL,'0',13,'0'),(14,'Полное описание категории',2,'text',NULL,'0',14,'0'),(15,'Идентификатор',3,'id','a:1:{s:4:\"type\";s:4:\"site\";}','0',15,'0'),(16,'Название производителя',3,'name',NULL,'0',16,'0'),(17,'Описание категории',3,'text',NULL,'0',17,'0');
/*!40000 ALTER TABLE `indf_shop_import` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_import_category`
--

DROP TABLE IF EXISTS `indf_shop_import_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_import_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `name` varchar(250) NOT NULL DEFAULT '' COMMENT 'название',
  `format` enum('csv','xls') NOT NULL DEFAULT 'csv' COMMENT 'формат файла',
  `type` enum('good','category','brand') NOT NULL DEFAULT 'good' COMMENT 'тип данных: good - товары, category - категории товаров',
  `delete_items` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'удалять не описанные в файле данные: 0 - нет, 1 - да',
  `site_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор страницы сайта из таблицы `indf_site`',
  `cat_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор категории из таблицы `indf_shop_category`',
  `count_part` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'количество строк, выгружаемых за один проход скрипта',
  `delimiter` varchar(20) NOT NULL DEFAULT '' COMMENT 'разделитель данных в строке',
  `end_string` varchar(20) NOT NULL DEFAULT '' COMMENT 'обозначать конец строки символом',
  `encoding` varchar(20) NOT NULL DEFAULT '' COMMENT 'кодировка',
  `sub_delimiter` varchar(20) NOT NULL DEFAULT '' COMMENT 'разделитель данных внутри поля',
  `header` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'первая строка - названия столбцов: 0 - нет, 1 - да',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'подрядковый номер для сортировки',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Описание файлов импорта';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_import_category`
--

LOCK TABLES `indf_shop_import_category` WRITE;
/*!40000 ALTER TABLE `indf_shop_import_category` DISABLE KEYS */;
INSERT INTO `indf_shop_import_category` VALUES (1,'Импорт товаров','csv','good','0',6,0,20,';','','cp1251','|','0',1,'0'),(2,'Импорт категорий','csv','category','0',6,0,20,';','','cp1251','|','0',2,'0'),(3,'Импорт производителей','csv','brand','0',6,0,20,';','','cp1251','|','0',3,'0');
/*!40000 ALTER TABLE `indf_shop_import_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_order`
--

DROP TABLE IF EXISTS `indf_shop_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_order` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор пользователя из таблицы `indf_users`',
  `created` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата создания',
  `status` enum('0','1','2','3','4') NOT NULL DEFAULT '0' COMMENT 'действие статуса заказа',
  `status_id` tinyint(3) NOT NULL DEFAULT '0' COMMENT 'идентификатор статуса заказа из таблицы `indf_shop_order_status`',
  `lang_id` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор языковой версии сайта, с которой был сделан заказ, из таблицы `indf_languages`',
  `summ` double NOT NULL DEFAULT '0' COMMENT 'общая сумма заказа',
  `delivery_id` varchar(10) NOT NULL DEFAULT '0' COMMENT 'способ доставки из таблицы `indf_shop_delivery`',
  `delivery_summ` double NOT NULL DEFAULT '0' COMMENT 'стоимость доставки',
  `delivery_info` text COMMENT 'данные службы доставки',
  `discount_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор скидки из таблицы `indf_shop_discount`',
  `discount_summ` double NOT NULL DEFAULT '0' COMMENT 'сумма скидки',
  `count_minus` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'товары списаны: 0 - нет, 1 - да',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Заказы';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_order`
--

LOCK TABLES `indf_shop_order` WRITE;
/*!40000 ALTER TABLE `indf_shop_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_shop_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_order_additional_cost`
--

DROP TABLE IF EXISTS `indf_shop_order_additional_cost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_order_additional_cost` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `order_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор заказа из таблицы `indf_shop_order`',
  `order_goods_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор записи о купленном товаре из таблицы `indf_shop_order_goods`',
  `additional_cost_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор сопутствующей услуги из таблицы `indf_shop_additional_cost`',
  `summ` double NOT NULL DEFAULT '0' COMMENT 'сумма',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Сопутствующие услуги, включенные в заказ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_order_additional_cost`
--

LOCK TABLES `indf_shop_order_additional_cost` WRITE;
/*!40000 ALTER TABLE `indf_shop_order_additional_cost` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_shop_order_additional_cost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_order_goods`
--

DROP TABLE IF EXISTS `indf_shop_order_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_order_goods` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `order_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор заказа из таблицы `indf_shop_order`',
  `good_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор товара из таблицы `indf_shop`',
  `discount_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор скидки из таблицы `indf_shop_discount`',
  `count_goods` double NOT NULL DEFAULT '0' COMMENT 'количество товаров',
  `price` double NOT NULL DEFAULT '0' COMMENT 'цена',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Товары в заказе';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_order_goods`
--

LOCK TABLES `indf_shop_order_goods` WRITE;
/*!40000 ALTER TABLE `indf_shop_order_goods` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_shop_order_goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_order_goods_param`
--

DROP TABLE IF EXISTS `indf_shop_order_goods_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_order_goods_param` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `value` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'значение характеристики',
  `param_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор характеристики из таблицы `indf_shop_param`',
  `order_goods_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор записи о купленном товаре из таблицы `indf_shop_order_goods`',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `order_goods_id` (`order_goods_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Дополнительных характеристики товаров в заказе';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_order_goods_param`
--

LOCK TABLES `indf_shop_order_goods_param` WRITE;
/*!40000 ALTER TABLE `indf_shop_order_goods_param` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_shop_order_goods_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_order_param`
--

DROP TABLE IF EXISTS `indf_shop_order_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_order_param` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `name1` varchar(250) NOT NULL DEFAULT '' COMMENT 'название',
  `text1` text COMMENT 'описание',
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT 'тип',
  `info` varchar(30) NOT NULL DEFAULT '' COMMENT 'смысловая нагрузка',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'подрядковый номер для сортировки',
  `required` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'обязательно для заполнения: 0 - нет, 1 - да',
  `show_in_form` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'использовать в стандатной форме оформления заказа: 0 - нет, 1 - да',
  `show_in_form_register` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'позволять редактировать из личного кабинета: 0 - нет, 1 - да',
  `show_in_form_one_click` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'использовать в форме быстрого заказа: 0 - нет, 1 - да',
  `config` text COMMENT 'дополнительные настройки поля',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='Поля конструктора формы оформления заказа';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_order_param`
--

LOCK TABLES `indf_shop_order_param` WRITE;
/*!40000 ALTER TABLE `indf_shop_order_param` DISABLE KEYS */;
INSERT INTO `indf_shop_order_param` VALUES (1,'ФИО или название компании',NULL,'text','name',1,'1','1','0','1',NULL,'0'),(2,'E-mail',NULL,'email','email',2,'1','1','0','0',NULL,'0'),(3,'Контактные телефоны (с кодом города)',NULL,'text','phone',3,'1','1','0','1',NULL,'0'),(4,'Индекс',NULL,'text','zip',4,'0','1','0','0',NULL,'0'),(5,'Город',NULL,'text','city',5,'0','1','0','0',NULL,'0'),(6,'Улица, проспект и пр.',NULL,'text','street',6,'0','1','0','0',NULL,'0'),(7,'Номер дома',NULL,'text','building',7,'0','1','0','0',NULL,'0'),(8,'Корпус',NULL,'text','suite',8,'0','1','0','0',NULL,'0'),(9,'Квартира, офис',NULL,'text','flat',9,'0','1','0','0',NULL,'0'),(10,'Комментарии',NULL,'textarea','comment',10,'0','1','0','0',NULL,'0');
/*!40000 ALTER TABLE `indf_shop_order_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_order_param_element`
--

DROP TABLE IF EXISTS `indf_shop_order_param_element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_order_param_element` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `value` text COMMENT 'значение',
  `param_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор поля из таблицы `indf_shop_order_param`',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор заказа из таблицы `indf_shop_order`',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Значения полей конструктора оформления заказа';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_order_param_element`
--

LOCK TABLES `indf_shop_order_param_element` WRITE;
/*!40000 ALTER TABLE `indf_shop_order_param_element` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_shop_order_param_element` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_order_param_select`
--

DROP TABLE IF EXISTS `indf_shop_order_param_select`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_order_param_select` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `param_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор поля из таблицы `indf_shop_order_param`',
  `value` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT 'значение для типа характеристики «галочка»: 0 - нет, 1 - да',
  `name1` varchar(50) NOT NULL DEFAULT '' COMMENT 'значение',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'подрядковый номер для сортировки',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `param_id` (`param_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Варианты значений полей конструктора оформления заказа типа ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_order_param_select`
--

LOCK TABLES `indf_shop_order_param_select` WRITE;
/*!40000 ALTER TABLE `indf_shop_order_param_select` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_shop_order_param_select` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_order_param_user`
--

DROP TABLE IF EXISTS `indf_shop_order_param_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_order_param_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `value` text COMMENT 'значение',
  `param_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор поля из таблицы `indf_shop_order_param`',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор пользователя из таблицы `indf_users`',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Значения полей конструктора оформления заказа, предзаполненн';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_order_param_user`
--

LOCK TABLES `indf_shop_order_param_user` WRITE;
/*!40000 ALTER TABLE `indf_shop_order_param_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_shop_order_param_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_order_status`
--

DROP TABLE IF EXISTS `indf_shop_order_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_order_status` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `name1` varchar(50) NOT NULL DEFAULT '' COMMENT 'название',
  `color` varchar(20) NOT NULL DEFAULT '' COMMENT 'цвет',
  `status` enum('0','1','2','3','4') NOT NULL DEFAULT '0' COMMENT 'действие статуса заказа',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'подрядковый номер для сортировки',
  `count_minus` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'списывать товары: 0 - нет, 1 - да',
  `send_mail` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'отправлять уведомление пользователю о смене статуса: 0 - нет, 1 - да',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Статусы заказов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_order_status`
--

LOCK TABLES `indf_shop_order_status` WRITE;
/*!40000 ALTER TABLE `indf_shop_order_status` DISABLE KEYS */;
INSERT INTO `indf_shop_order_status` VALUES (1,'Новый','','0',1,'0','0','0'),(2,'В обработке','','1',2,'0','0','0'),(3,'Отменен','','2',3,'0','0','0'),(4,'Выполнен','','3',4,'0','0','0');
/*!40000 ALTER TABLE `indf_shop_order_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_param`
--

DROP TABLE IF EXISTS `indf_shop_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_param` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `name1` varchar(250) NOT NULL DEFAULT '' COMMENT 'название',
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT 'тип',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'подрядковый номер для сортировки',
  `search` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'характеристика выводится в форме поиска: 0 - нет, 1 - да',
  `list` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'характеристика выводится в списке товаров: 0 - нет, 1 - да',
  `block` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'характеристика выводится в блоке товаров: 0 - нет, 1 - да',
  `id_page` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'характеристика выводится на странице товара: 0 - нет, 1 - да',
  `required` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'доступен к выбору при заказе: 0 - нет, 1 - да',
  `page` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'отдельная страница для значений: 0 - нет, 1 - да',
  `text1` text COMMENT 'описание',
  `config` text COMMENT 'дополнительные настройки поля',
  `display_in_sort` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'выводится в блоке для сортировки: 0 - нет, 1 - да',
  `yandex_use` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'выгружается в файл YML: 0 - нет, 1 - да',
  `yandex_name` varchar(100) NOT NULL DEFAULT '' COMMENT 'название в файле YML',
  `yandex_unit` varchar(50) NOT NULL DEFAULT '' COMMENT 'единица измерения в файле YML',
  `measure_unit1` varchar(50) NOT NULL DEFAULT '' COMMENT 'единица измерения',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='Дополнительные характеристики товаров';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_param`
--

LOCK TABLES `indf_shop_param` WRITE;
/*!40000 ALTER TABLE `indf_shop_param` DISABLE KEYS */;
INSERT INTO `indf_shop_param` VALUES (2,'Город','text',2,'1','1','1','1','0','0','',NULL,'1','0','','','','0'),(3,'Материал','select',3,'1','0','0','1','0','0',NULL,NULL,'0','0','','','','1'),(4,'Коллекция','select',4,'1','1','1','1','0','0',NULL,NULL,'0','0','','','','1'),(6,'Размер','select',6,'1','1','1','1','0','0',NULL,NULL,'0','0','','','','1'),(7,'Количество','multiple',7,'0','0','0','1','1','0',NULL,NULL,'0','0','','','','1'),(8,'Цвет','multiple',8,'0','0','0','1','1','0',NULL,NULL,'0','0','','','','1'),(10,'Назначение','select',10,'0','0','0','1','0','0',NULL,NULL,'0','0','','','','1'),(11,'Прибыль','numtext',11,'1','1','1','1','0','0','',NULL,'0','0','','','руб / мес','0'),(12,'Бизнес-брокер','select',12,'0','0','0','1','0','0','',NULL,'0','0','','','','0');
/*!40000 ALTER TABLE `indf_shop_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_param_category_rel`
--

DROP TABLE IF EXISTS `indf_shop_param_category_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_param_category_rel` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор характеристики из таблицы `indf_shop_param`',
  `cat_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор категории из таблицы `indf__category`',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `cat_id` (`cat_id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='Связи дополнительных харакеристик товаров и категорий';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_param_category_rel`
--

LOCK TABLES `indf_shop_param_category_rel` WRITE;
/*!40000 ALTER TABLE `indf_shop_param_category_rel` DISABLE KEYS */;
INSERT INTO `indf_shop_param_category_rel` VALUES (10,2,0,'0'),(2,3,0,'1'),(3,4,0,'1'),(4,6,0,'1'),(5,7,0,'1'),(6,8,0,'1'),(7,10,0,'1'),(13,11,0,'0'),(12,12,0,'0');
/*!40000 ALTER TABLE `indf_shop_param_category_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_param_element`
--

DROP TABLE IF EXISTS `indf_shop_param_element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_param_element` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `value1` text COMMENT 'значение',
  `param_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор характеристики из таблицы `indf_shop_param`',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор товара из таблицы `indf_shop`',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `element_id` (`element_id`),
  KEY `param_id` (`param_id`)
) ENGINE=MyISAM AUTO_INCREMENT=123 DEFAULT CHARSET=utf8 COMMENT='Значения дополнительных характеристик товаров';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_param_element`
--

LOCK TABLES `indf_shop_param_element` WRITE;
/*!40000 ALTER TABLE `indf_shop_param_element` DISABLE KEYS */;
INSERT INTO `indf_shop_param_element` VALUES (1,'1',2,1,'0'),(2,'4',3,1,'1'),(3,'6',4,1,'1'),(4,'9',6,1,'1'),(5,'14',7,1,'1'),(6,'15',7,1,'1'),(7,'29',10,1,'1'),(8,'5',3,2,'1'),(9,'7',4,2,'1'),(10,'1',2,2,'0'),(11,'9',6,2,'1'),(12,'23',8,2,'1'),(13,'24',8,2,'1'),(14,'25',8,2,'1'),(15,'26',8,2,'1'),(16,'30',10,2,'1'),(17,'14',7,2,'1'),(18,'15',7,2,'1'),(19,'2',2,3,'0'),(20,'3',3,3,'1'),(21,'6',4,3,'1'),(22,'9',6,3,'1'),(23,'23',8,3,'1'),(24,'24',8,3,'1'),(25,'25',8,3,'1'),(26,'26',8,3,'1'),(27,'27',8,3,'1'),(28,'28',8,3,'1'),(29,'29',10,3,'1'),(30,'14',7,3,'1'),(31,'15',7,3,'1'),(32,'1',2,4,'0'),(33,'3',3,4,'1'),(34,'6',4,4,'1'),(35,'9',6,4,'1'),(36,'23',8,4,'1'),(37,'24',8,4,'1'),(38,'25',8,4,'1'),(39,'26',8,4,'1'),(40,'27',8,4,'1'),(41,'29',10,4,'1'),(42,'14',7,4,'1'),(43,'15',7,4,'1'),(44,'1',2,6,'0'),(45,'4',3,6,'1'),(46,'6',4,6,'1'),(47,'9',6,6,'1'),(48,'23',8,6,'1'),(49,'24',8,6,'1'),(50,'25',8,6,'1'),(51,'26',8,6,'1'),(52,'30',10,6,'1'),(53,'14',7,6,'1'),(54,'15',7,6,'1'),(55,'5',3,7,'1'),(56,'7',4,7,'1'),(57,'2',2,7,'0'),(58,'10',6,7,'1'),(59,'23',8,7,'1'),(60,'24',8,7,'1'),(61,'25',8,7,'1'),(62,'26',8,7,'1'),(63,'27',8,7,'1'),(64,'28',8,7,'1'),(65,'29',10,7,'1'),(66,'14',7,7,'1'),(67,'19',2,10,'0'),(68,'5',3,10,'1'),(69,'6',4,10,'1'),(70,'9',6,10,'1'),(71,'23',8,10,'1'),(72,'24',8,10,'1'),(73,'25',8,10,'1'),(74,'26',8,10,'1'),(75,'27',8,10,'1'),(76,'29',10,10,'1'),(77,'14',7,10,'1'),(78,'15',7,10,'1'),(79,'17',2,11,'0'),(80,'3',3,11,'1'),(81,'6',4,11,'1'),(82,'9',6,11,'1'),(83,'23',8,11,'1'),(84,'24',8,11,'1'),(85,'25',8,11,'1'),(86,'26',8,11,'1'),(87,'27',8,11,'1'),(88,'28',8,11,'1'),(89,'30',10,11,'1'),(90,'14',7,11,'1'),(91,'15',7,11,'1'),(92,'5',3,12,'1'),(93,'7',4,12,'1'),(94,'1',2,12,'0'),(95,'9',6,12,'1'),(96,'23',8,12,'1'),(97,'24',8,12,'1'),(98,'25',8,12,'1'),(99,'26',8,12,'1'),(100,'27',8,12,'1'),(101,'29',10,12,'1'),(102,'14',7,12,'1'),(103,'15',7,12,'1'),(104,'1',2,13,'0'),(105,'4',3,13,'1'),(106,'6',4,13,'1'),(107,'9',6,13,'1'),(108,'14',7,13,'1'),(109,'15',7,13,'1'),(110,'29',10,13,'1'),(111,'Симферополь',2,14,'0'),(112,'150000',11,14,'0'),(113,'31',12,14,'0'),(114,'Краснодар',2,15,'0'),(115,'1',11,15,'0'),(116,'31',12,15,'0'),(117,'Симферополь',2,16,'0'),(118,'150000',11,16,'0'),(119,'31',12,16,'0'),(120,'Симферополь',2,17,'0'),(121,'1',11,17,'0'),(122,'31',12,17,'0');
/*!40000 ALTER TABLE `indf_shop_param_element` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_param_select`
--

DROP TABLE IF EXISTS `indf_shop_param_select`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_param_select` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `param_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор характеристики из таблицы `indf_shop_param`',
  `value` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT 'значение для типа характеристики «галочка»: 0 - нет, 1 - да',
  `name1` varchar(50) NOT NULL DEFAULT '' COMMENT 'значение',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'подрядковый номер для сортировки',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `param_id` (`param_id`)
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='Варианты значений дополнительных характеристик товаров типа ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_param_select`
--

LOCK TABLES `indf_shop_param_select` WRITE;
/*!40000 ALTER TABLE `indf_shop_param_select` DISABLE KEYS */;
INSERT INTO `indf_shop_param_select` VALUES (32,12,0,'Оксана Николаевна',2,'0'),(31,12,0,'Виктор Александрович',1,'0'),(3,3,0,'керамогранит',1,'1'),(4,3,0,'керамическая плитка',2,'1'),(5,3,0,'мозаика',3,'1'),(20,3,0,'зеркальная плитка',4,'1'),(6,4,0,'Аликанте',1,'1'),(7,4,0,'Альфа',2,'1'),(21,4,0,'Дуб',3,'1'),(22,4,0,'Форест',4,'1'),(9,6,0,'10Х20',1,'1'),(10,6,0,'15Х25',2,'1'),(11,6,0,'20Х25',3,'1'),(12,6,0,'20Х30',4,'1'),(13,6,0,'20Х40',5,'1'),(14,7,0,'шт.',1,'1'),(15,7,0,'упак.',2,'1'),(23,8,0,'бежевый',1,'1'),(24,8,0,'белый',2,'1'),(25,8,0,'венге',3,'1'),(26,8,0,'коричневый',4,'1'),(27,8,0,'разноцветный',5,'1'),(28,8,0,'розовый',6,'1'),(29,10,0,'для стены',1,'1'),(30,10,0,'для пола',2,'1');
/*!40000 ALTER TABLE `indf_shop_param_select` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_price`
--

DROP TABLE IF EXISTS `indf_shop_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_price` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `good_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор товара из таблицы `indf_shop`',
  `price` double unsigned NOT NULL DEFAULT '0' COMMENT 'цена',
  `old_price` double unsigned NOT NULL DEFAULT '0' COMMENT 'исходная цена',
  `count_goods` double NOT NULL DEFAULT '0' COMMENT 'количество товара',
  `price_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор исходной цены из таблицы `indf_shop_price`',
  `date_start` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата начала действия',
  `date_finish` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата окончания действия',
  `discount` double NOT NULL DEFAULT '0' COMMENT 'скидка',
  `discount_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор скидки из таблицы `indf_shop_discount`',
  `person` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'цена действует только для определенных пользователей: 0 - нет, 1 - да',
  `role_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор типа пользователя из таблицы `indf_users_role`, для которого действует скидка',
  `currency_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор валюты из таблицы `indf_shop_currency`',
  `import_id` varchar(100) NOT NULL DEFAULT '' COMMENT 'собственный идентификатор при импорте',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `good_id` (`good_id`),
  KEY `price_id` (`price_id`)
) ENGINE=MyISAM AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COMMENT='Цены товаров';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_price`
--

LOCK TABLES `indf_shop_price` WRITE;
/*!40000 ALTER TABLE `indf_shop_price` DISABLE KEYS */;
INSERT INTO `indf_shop_price` VALUES (1,1,5000,0,0,1,0,0,0,0,'0',0,0,'','0'),(2,2,2200,0,0,2,0,0,0,0,'0',0,0,'','0'),(3,2,25000,0,0,3,0,0,0,0,'0',0,0,'','0'),(4,3,3200,0,0,4,0,0,0,0,'0',0,0,'','0'),(5,3,12500,0,0,5,0,0,0,0,'0',0,0,'','0'),(6,4,1000,0,0,6,0,0,0,0,'0',0,0,'','0'),(7,4,35000,0,0,7,0,0,0,0,'0',0,0,'','0'),(8,6,2500,0,0,8,0,0,0,0,'0',0,0,'','0'),(9,6,4900,0,0,9,0,0,0,0,'0',0,0,'','0'),(10,7,1500,0,0,10,0,0,0,0,'0',0,0,'','0'),(11,10,2000,0,0,11,0,0,0,0,'0',0,0,'','0'),(12,10,30000,0,0,12,0,0,0,0,'0',0,0,'','0'),(13,11,4000,0,0,13,0,0,0,0,'0',0,0,'','0'),(14,11,16000,0,0,14,0,0,0,0,'0',0,0,'','0'),(15,12,4000,0,0,15,0,0,0,0,'0',0,0,'','0'),(16,12,9000,0,0,16,0,0,0,0,'0',0,0,'','0'),(17,13,2000,0,0,17,0,0,0,0,'0',0,0,'','0'),(18,1,4750,5000,0,1,0,0,5,1,'0',0,0,'','0'),(19,2,2090,2200,0,2,0,0,5,1,'0',0,0,'','0'),(20,2,23750,25000,0,3,0,0,5,1,'0',0,0,'','0'),(21,3,3040,3200,0,4,0,0,5,1,'0',0,0,'','0'),(22,3,11875,12500,0,5,0,0,5,1,'0',0,0,'','0'),(23,4,950,1000,0,6,0,0,5,1,'0',0,0,'','0'),(24,4,33250,35000,0,7,0,0,5,1,'0',0,0,'','0'),(25,6,2375,2500,0,8,0,0,5,1,'0',0,0,'','0'),(26,6,4655,4900,0,9,0,0,5,1,'0',0,0,'','0'),(27,7,1425,1500,0,10,0,0,5,1,'0',0,0,'','0'),(28,10,1900,2000,0,11,0,0,5,1,'0',0,0,'','0'),(29,10,28500,30000,0,12,0,0,5,1,'0',0,0,'','0'),(30,11,3800,4000,0,13,0,0,5,1,'0',0,0,'','0'),(31,11,15200,16000,0,14,0,0,5,1,'0',0,0,'','0'),(32,12,3800,4000,0,15,0,0,5,1,'0',0,0,'','0'),(33,12,8550,9000,0,16,0,0,5,1,'0',0,0,'','0'),(34,13,1900,2000,0,17,0,0,5,1,'0',0,0,'','0'),(46,15,250000,0,0,46,0,0,0,0,'0',0,0,'','0'),(45,14,1425000,1500000,0,44,0,0,5,1,'0',0,0,'','0'),(44,14,1500000,0,0,44,0,0,0,0,'0',0,0,'','0'),(47,15,237500,250000,0,46,0,0,5,1,'0',0,0,'','0'),(51,16,950000,1000000,0,50,0,0,5,1,'0',0,0,'','0'),(50,16,1000000,0,0,50,0,0,0,0,'0',0,0,'','0'),(52,17,2800000,0,0,52,0,0,0,0,'0',0,0,'','0'),(53,17,2660000,2800000,0,52,0,0,5,1,'0',0,0,'','0');
/*!40000 ALTER TABLE `indf_shop_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_price_image_rel`
--

DROP TABLE IF EXISTS `indf_shop_price_image_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_price_image_rel` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `price_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор исходной цены из таблицы `indf_shop_price`',
  `image_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор изображения из таблицы `indf_images`',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `price_id` (`price_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Изображения товаров, прикрепленные к цене';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_price_image_rel`
--

LOCK TABLES `indf_shop_price_image_rel` WRITE;
/*!40000 ALTER TABLE `indf_shop_price_image_rel` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_shop_price_image_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_price_param`
--

DROP TABLE IF EXISTS `indf_shop_price_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_price_param` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `price_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор исходной цены из таблицы `indf_shop_price`',
  `param_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор характеристики из таблицы `indf_shop_param`',
  `param_value` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'значение характеристики - идентификатор из таблицы `indf_shop_param_select`',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `price_id` (`price_id`),
  KEY `param_id` (`param_id`),
  KEY `param_value` (`param_value`)
) ENGINE=MyISAM AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COMMENT='Дополнительные характеристики, учитываемые в цене';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_price_param`
--

LOCK TABLES `indf_shop_price_param` WRITE;
/*!40000 ALTER TABLE `indf_shop_price_param` DISABLE KEYS */;
INSERT INTO `indf_shop_price_param` VALUES (1,1,7,0,'1'),(2,1,8,0,'1'),(3,2,7,14,'1'),(4,2,8,0,'1'),(5,3,7,15,'1'),(6,3,8,0,'1'),(7,4,7,14,'1'),(8,4,8,0,'1'),(9,5,7,15,'1'),(10,5,8,0,'1'),(11,6,7,14,'1'),(12,6,8,0,'1'),(13,7,7,15,'1'),(14,7,8,0,'1'),(15,8,7,14,'1'),(16,8,8,0,'1'),(17,9,7,15,'1'),(18,9,8,0,'1'),(19,10,7,14,'1'),(20,10,8,0,'1'),(21,11,7,14,'1'),(22,11,8,0,'1'),(23,12,7,15,'1'),(24,12,8,0,'1'),(25,13,7,14,'1'),(26,13,8,0,'1'),(27,14,7,15,'1'),(28,14,8,0,'1'),(29,15,7,14,'1'),(30,15,8,0,'1'),(31,16,7,15,'1'),(32,16,8,0,'1'),(33,17,7,0,'1'),(34,17,8,0,'1'),(46,44,8,0,'1'),(45,44,7,0,'1'),(47,46,7,0,'1'),(48,46,8,0,'1'),(52,50,8,0,'1'),(51,50,7,0,'1');
/*!40000 ALTER TABLE `indf_shop_price_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_rel`
--

DROP TABLE IF EXISTS `indf_shop_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_rel` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор товара из таблицы `indf_shop`',
  `rel_element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор похожего товара из таблицы `indf_shop`',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='Связи похожих товаров';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_rel`
--

LOCK TABLES `indf_shop_rel` WRITE;
/*!40000 ALTER TABLE `indf_shop_rel` DISABLE KEYS */;
INSERT INTO `indf_shop_rel` VALUES (1,2,1,'0'),(2,3,1,'0'),(3,3,2,'0'),(4,4,2,'0'),(5,4,3,'0'),(6,4,1,'0'),(7,6,5,'0'),(8,6,4,'0'),(9,6,3,'0'),(10,7,5,'0'),(11,7,4,'0'),(12,7,1,'0'),(13,10,6,'0'),(14,10,7,'0'),(15,10,3,'0'),(16,11,10,'0'),(17,11,4,'0'),(18,11,1,'0');
/*!40000 ALTER TABLE `indf_shop_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_waitlist`
--

DROP TABLE IF EXISTS `indf_shop_waitlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_waitlist` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `good_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор товара из таблицы `indf_shop`',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор пользователя из таблицы `indf_users`',
  `lang_id` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор языка сайта из таблицы `indf_languages`',
  `mail` varchar(64) NOT NULL DEFAULT '' COMMENT 'e-mail пользователя',
  `created` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата создания',
  `param` text COMMENT 'серилизованные данные о характеристиках товара (доступных к выбору при заказе)',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Товары в списке ожидания';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_waitlist`
--

LOCK TABLES `indf_shop_waitlist` WRITE;
/*!40000 ALTER TABLE `indf_shop_waitlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_shop_waitlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_shop_wishlist`
--

DROP TABLE IF EXISTS `indf_shop_wishlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_shop_wishlist` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `good_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор товара из таблицы `indf_shop`',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор пользователя из таблицы `indf_users`',
  `session_id` varchar(64) NOT NULL DEFAULT '' COMMENT 'номер сессии пользователя из таблицы `indf_sessions`',
  `created` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата создания',
  `count` double unsigned NOT NULL DEFAULT '0' COMMENT 'количество товара',
  `param` text COMMENT 'серилизованные данные о характеристиках товара (доступных к выбору при заказе)',
  `additional_cost` text COMMENT 'идентификаторы сопутствующих услугах, разделенные запятой',
  `is_file` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'товар-файл: 0 - нет, 1 - да',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Товары в списке пожеланий';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_shop_wishlist`
--

LOCK TABLES `indf_shop_wishlist` WRITE;
/*!40000 ALTER TABLE `indf_shop_wishlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_shop_wishlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_site`
--

DROP TABLE IF EXISTS `indf_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_site` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `parent_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор родителя из таблицы `indf_site`',
  `count_children` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'количество вложенных страниц',
  `name1` varchar(100) NOT NULL DEFAULT '' COMMENT 'название',
  `title_meta1` varchar(250) NOT NULL DEFAULT '' COMMENT 'заголовок окна в браузере, тег Title',
  `keywords1` varchar(250) NOT NULL DEFAULT '' COMMENT 'ключевые слова, тег Keywords',
  `descr1` text COMMENT 'описание, тэг Description',
  `canonical1` varchar(100) NOT NULL DEFAULT '' COMMENT 'канонический тег',
  `text1` longtext COMMENT 'контент',
  `act1` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'показывать на сайте: 0 - нет, 1 - да',
  `access` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'доступ ограничен: 0 - нет, 1 - да',
  `date_start` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата начала показа',
  `date_finish` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата окончания показа',
  `admin_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'пользователь из таблицы `indf_users`, добавивший или первый отредктировавший страницу в административной части',
  `title_no_show` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'не копировать заголовок в H1: 0 - нет, 1 - да',
  `map_no_show` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'не показывать на карте сайта: 0 - нет, 1 - да',
  `changefreq` enum('always','hourly','daily','weekly','monthly','yearly','never') NOT NULL DEFAULT 'always' COMMENT 'Changefreq для sitemap.xml',
  `priority` varchar(3) NOT NULL DEFAULT '' COMMENT 'Priority для sitemap.xml',
  `noindex` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'не индексировать: 0 - нет, 1 - да',
  `search_no_show` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'не участвует в поисковой выдаче: 0 - нет, 1 - да',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'подрядковый номер для сортировки',
  `timeedit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'время последнего изменения в формате UNIXTIME',
  `theme` varchar(50) NOT NULL DEFAULT '' COMMENT 'шаблон страницы сайта',
  `module_name` varchar(50) NOT NULL DEFAULT '' COMMENT 'прикрепленный модуль',
  `js` text COMMENT 'JS-код',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=MyISAM AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COMMENT='Страницы сайта';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_site`
--

LOCK TABLES `indf_site` WRITE;
/*!40000 ALTER TABLE `indf_site` DISABLE KEYS */;
INSERT INTO `indf_site` VALUES (1,0,0,'Главная страница','','','','','<h1>О КаталогеСервисеРесурсе</h1>\r\n<p>На данном сайте представлены актуальные предложения по продаже готового бизнеса в Крыму, здесь вы можете посмотреть, изучить, сравнить разные бизнесы в разных ценовых сегментах. От небольшой торговой точки на рынке до Производства в масштабах всего Крыма. На сайте представлены прямые контакты бизнес-брокеров. Пожалуйста не стесняйтесь, связывайтесь, специалисты владеют полезной информацией.</p>\r\n<p></p>','1','0',0,0,1,'1','0','always','0','0','0',1,1497456511,'site_start.php','','','0'),(37,0,0,'Статьи','','',NULL,'',NULL,'1','0',0,0,0,'0','0','always','','0','0',18,1497467340,'','clauses',NULL,'0'),(3,0,3,'Страница пользователя','','','','','','0','0',0,0,1,'0','1','always','0','1','1',5,1497457455,'','userpage','','0'),(4,0,1,'О нас','','','','','<p>О компании,</p>\r\n<p></p>\r\n<p>Компания \"Инвест82\" работает в сфере продажи готового бизнеса в Крыму.</p>\r\n<p>Бизнес-брокер - это....</p>\r\n<p>С вами работают&nbsp;</p>\r\n<p></p>\r\n<p>Виктор Александрович</p>\r\n<p>Резюме</p>\r\n<p></p>\r\n<p>Оксана Николаевна&nbsp;</p>\r\n<p>Резюме</p>\r\n<p>Мы предоставим следующие услуги и консультации</p>\r\n<p>Покупка готового бизнеса в Крыму</p>\r\n<p>Подбор персонала</p>\r\n<p>Реклама вашего бизнеса</p>\r\n<p>Оформление документов</p>\r\n<p>и др. услуги...</p>\r\n<p></p>','1','0',0,0,1,'0','0','always','0','0','0',1,1496833027,'','','','0'),(26,0,0,'Вход в личный кабинет','','',NULL,'','<insert name=\"show_login\" module=\"registration\">','1','0',0,0,0,'0','0','always','','0','0',29,1496828862,'','',NULL,'1'),(27,0,0,'Доставка','','','','','<p>Информация по доставке и оплате и прочая подобная информация будет написана на этой странице. Можно написать любой объем текста, но желательно уложиться в несколько абзацев, ведь пользователи интернета ценят краткость и предметность. Лучше&nbsp;<strong>выделить</strong>&nbsp;какие-то значимые участки, текст можно&nbsp;<em>отформатировать</em>, как в Word, разместить таблицы, изображения и&nbsp;<a href=\"http://theme.diafantest.ru/\">ссылки</a>&nbsp;на другие страницы.</p>\r\n<p>Чтобы отредактировать этот текст прямо на этой странице, нажмите \"Быстрое редактирование\"&nbsp;на панели вверху страницы. Или \"Администрирование\", чтобы перейти на редактирование этой страницы в административной панели.</p>','0','0',0,0,1,'0','0','always','0','0','0',4,1497457295,'','','','0'),(28,0,0,'Контакты','','','','','<p>Бизнес-брокеры:</p>\r\n<p>Виктор Александрович</p>\r\n<p>+79780509995 (Viber)</p>\r\n<p><span>victor7broker@gmail.com</span></p>\r\n<p></p>\r\n<p>Оксана Николаевна</p>\r\n<p>+789787060799 <span>(</span><span>Viber)</span></p>\r\n<p><span>o.volkina@glabar.ru</span></p>\r\n<p><span></span></p>\r\n<p><span>Крым, г. Симферополь, ул. Набережная им. 60 лет СССР, д. 28, офис 2</span></p>\r\n<p>\r\n<script type=\"text/javascript\" charset=\"utf-8\" async=\"\" src=\"https://api-maps.yandex.ru/services/constructor/1.0/js/?sid=s2ec46uboOHt8-uHEu856PRixoI0mGFS&amp;width=100%&amp;height=400&amp;lang=ru_RU&amp;sourceType=constructor&amp;scroll=true\"></script>\r\n</p>','1','0',0,0,1,'0','0','always','0','0','0',37,1496831683,'','','','0'),(33,0,0,'Заказ оформлен','','','','','<p><span>Спасибо за Ваш заказ! В ближайшее время мы свяжемся с Вами!</span></p>','0','0',0,0,1,'0','0','always','0','0','0',33,1497457789,'','','','0'),(6,0,2,'Интернет-магазин','','',NULL,'',NULL,'1','0',0,0,0,'0','0','always','','0','0',20,1496828862,'','shop',NULL,'0'),(7,6,0,'Корзина','','',NULL,'','<insert name=\"show_add_coupon\" module=\"shop\">','1','0',0,0,0,'0','0','always','','0','0',7,1496828862,'','cart',NULL,'0'),(9,6,0,'Отложенные','','',NULL,'',NULL,'1','0',0,0,0,'0','0','always','','0','0',9,1496828862,'','wishlist',NULL,'0'),(22,0,0,'Рассылки','','',NULL,'',NULL,'1','0',0,0,0,'0','0','always','','0','0',28,1496828867,'','subscribtion',NULL,'0'),(23,0,0,'Новости','','',NULL,'',NULL,'1','0',0,0,0,'0','0','always','','0','0',2,1496828867,'','news',NULL,'0'),(20,0,0,'Поиск','','',NULL,'',NULL,'1','0',0,0,0,'0','0','always','','0','0',26,1496828867,'','search',NULL,'0'),(5,4,0,'Обратная связь','','',NULL,'',NULL,'1','0',0,0,0,'0','0','always','','0','0',13,1496828867,'','feedback',NULL,'0'),(34,3,0,'Регистрация','','',NULL,'',NULL,'0','0',0,0,0,'0','1','always','','1','1',34,1496828867,'','registration',NULL,'0'),(35,3,0,'Восстановление доступа','','',NULL,'',NULL,'0','0',0,0,0,'0','1','always','','1','1',35,1496828867,'','reminding',NULL,'0'),(36,3,0,'Настройки аккаунта','','',NULL,'',NULL,'0','0',0,0,0,'0','1','always','','1','1',36,1496828867,'','usersettings',NULL,'0'),(25,0,0,'Карта сайта','','',NULL,'',NULL,'1','0',0,0,0,'0','0','always','','0','0',27,1496828867,'','map',NULL,'0');
/*!40000 ALTER TABLE `indf_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_site_blocks`
--

DROP TABLE IF EXISTS `indf_site_blocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_site_blocks` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `name1` varchar(100) NOT NULL DEFAULT '' COMMENT 'название',
  `text1` text COMMENT 'описание',
  `act1` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'показывать на сайте: 0 - нет, 1 - да',
  `access` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'доступ ограничен: 0 - нет, 1 - да',
  `title_no_show` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'не показывать заголовок: 0 - нет, 1 - да',
  `date_start` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата начала показа',
  `date_finish` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата окончания показа',
  `admin_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'пользователь из таблицы `indf_users`, добавивший или первый отредктировавший блок в административной части',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'подрядковый номер для сортировки',
  `timeedit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'время последнего изменения в формате UNIXTIME',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='Блоки на сайте';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_site_blocks`
--

LOCK TABLES `indf_site_blocks` WRITE;
/*!40000 ALTER TABLE `indf_site_blocks` DISABLE KEYS */;
INSERT INTO `indf_site_blocks` VALUES (1,'Телефон в шапке сайта','<p>8 978 050 999 5</p>\r\n<p>8 978 70 60 799</p>','1','0','1',0,0,1,1,1497545383,'0'),(2,'Ссылка с телефона в шапке','<!-- Установлена ссылка на набор номера при нажатии на иконку-->\r\n tel:89780509995','1','0','1',0,0,1,2,1496832052,'0'),(3,'E-mail в шапке','<p>victor7broker@gmail.com</p>\r\n<p></p>','0','0','1',0,0,1,3,1497545457,'0'),(4,'Ссылка с e-mail в шапке','<!-- Установлена ссылка на открытие почтовой программы при нажатии на e-mail-->\r\n mailto:victor7broker@gmail.com','1','0','1',0,0,1,4,1496832362,'0'),(5,'Лого','<p>invest82<span style=\"color: #2e2e2e;\">.ru</span></p>','1','0','1',0,0,1,5,1496831813,'0'),(6,'Информация в шапке','<p>Покупка и Продажа готового бизнеса в Крыму</p>','1','0','1',0,0,1,6,1496906638,'0'),(7,'Информация в подвале','<p>&copy; 2014-2017 Инвест82&nbsp;</p>','1','0','1',0,0,1,7,1497467305,'0'),(8,'Основной слайдер','<!--В этом блоке выводится слайдер. Для управления и редактирования отдельный слайдов перейдите в модуль \"Баннеры\" -->\r <insert name=\"show_block\" module=\"bs\" cat_id=\"1\" count=\"3\" template=\"cover\">','1','0','1',0,0,0,8,1496828862,'0'),(9,'Новинки','<!--В этом блоке выводятся товары, отмеченные как Хит, Акция или Новинка. Вы можете его только скрыть. Для управления и редактирования этого блока перейдите в модуль \"Интернет-магазин\" -->\r <insert name=\"show_block\" module=\"shop\" count=\"8\" images=\"1\" template=\"catalog_slider-new\" new_only=\"true\">','1','0','1',0,0,0,9,1496828862,'0'),(10,'Узкий баннер на главной','<!--В этом блоке выводится баннер. Для управления и редактирования отдельный слайдов перейдите в модуль \"Баннеры\" -->\r <insert name=\"show_block\" module=\"bs\" cat_id=\"2\" count=\"1\">','1','0','1',0,0,0,10,1496828862,'0'),(11,'Хиты','<!--В этом блоке выводятся товары, отмеченные как Хит, Акция или Новинка. Вы можете его только скрыть. Для управления и редактирования этого блока перейдите в модуль \"Интернет-магазин\" -->\r <insert name=\"show_block\" module=\"shop\" count=\"8\" images=\"1\" template=\"catalog_slider-hits\" hits_only=\"true\">','1','0','1',0,0,0,11,1496828862,'0'),(12,'Новости на главной','<!--В этом блоке выводится страница Новостей. Для управления и редактирования этого блока перейдите в модуль \"Новости\" -->\r <insert name=\"show_block\" module=\"news\" count=\"2\" images=\"1\" images_variation=\"preview\">','1','0','1',0,0,0,12,1496828862,'0'),(13,'Подписка на рассылку','<!-- Для управления и редактирования этого блока перейдите в модуль \"Рассылки\". Заголовок блока можно изменить в Режиме быстрого редактирования.  -->\r <insert name=\"show_form\" module=\"subscribtion\">','1','0','1',0,0,0,13,1496828862,'0'),(14,'Акции','<!--В этом блоке выводятся товары, отмеченные как Хит, Акция или Новинка. Вы можете его только скрыть. Для управления и редактирования этого блока перейдите в модуль \"Интернет-магазин\" -->\r\n <insert name=\"show_block\" module=\"shop\" count=\"8\" images=\"1\" template=\"catalog_slider-ac\" action_only=\"true\">','1','0','1',0,0,1,14,1497459628,'0'),(15,'4 маленьких Баннера на главной','<!--В этом блоке выводятся баннеры. Для управления и редактирования отдельный слайдов перейдите в модуль \"Баннеры\" -->\r <insert name=\"show_block\" module=\"bs\" cat_id=\"3\" count=\"4\" template=\"main\">','1','0','1',0,0,0,15,1496828862,'0'),(16,'Успей купить на внутренних','<!--В этом блоке выводятся товары, отмеченные как Акция. Вы можете его только скрыть. Для управления и редактирования этого блока перейдите в модуль \"Интернет-магазин\" -->\r <insert name=\"show_block\" module=\"shop\" action_only=\"true\" sort=\"rand\" count=\"1\" images=\"1\" template=\"uslei\">','1','0','1',0,0,0,16,1496828862,'0');
/*!40000 ALTER TABLE `indf_site_blocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_site_blocks_site_rel`
--

DROP TABLE IF EXISTS `indf_site_blocks_site_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_site_blocks_site_rel` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор блока из таблицы `indf_site_blocks`',
  `site_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор страницы сайта из таблицы `indf_site`',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `site_id` (`site_id`)
) ENGINE=MyISAM AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COMMENT='Данные о том, на каких страницах выводятся блоки на сайте';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_site_blocks_site_rel`
--

LOCK TABLES `indf_site_blocks_site_rel` WRITE;
/*!40000 ALTER TABLE `indf_site_blocks_site_rel` DISABLE KEYS */;
INSERT INTO `indf_site_blocks_site_rel` VALUES (46,1,0,'0'),(36,2,0,'0'),(47,3,0,'0'),(38,4,0,'0'),(33,5,0,'0'),(42,6,0,'0'),(45,7,0,'0'),(24,8,0,'0'),(25,9,0,'0'),(26,11,0,'0'),(44,14,0,'0'),(28,15,0,'0'),(29,10,0,'0'),(30,13,0,'0'),(31,12,0,'0'),(32,16,0,'0');
/*!40000 ALTER TABLE `indf_site_blocks_site_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_site_dynamic`
--

DROP TABLE IF EXISTS `indf_site_dynamic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_site_dynamic` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `name1` varchar(100) NOT NULL DEFAULT '' COMMENT 'название',
  `text` text COMMENT 'описание',
  `act1` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'показывать на сайте: 0 - нет, 1 - да',
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT 'тип',
  `access` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'доступ ограничен: 0 - нет, 1 - да',
  `title_no_show` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'не показывать заголовок: 0 - нет, 1 - да',
  `date_start` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата начала показа',
  `date_finish` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата окончания показа',
  `admin_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'пользователь из таблицы `indf_users`, добавивший или первый отредктировавший блок в административной части',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'подрядковый номер для сортировки',
  `timeedit` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'время последнего изменения в формате UNIXTIME',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Динамические блоки';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_site_dynamic`
--

LOCK TABLES `indf_site_dynamic` WRITE;
/*!40000 ALTER TABLE `indf_site_dynamic` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_site_dynamic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_site_dynamic_element`
--

DROP TABLE IF EXISTS `indf_site_dynamic_element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_site_dynamic_element` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `dynamic_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор динамического блока из таблицы `indf_site_dynamic`',
  `module_name` varchar(50) NOT NULL DEFAULT '' COMMENT 'название модуля',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор элемента модуля',
  `element_type` varchar(20) NOT NULL DEFAULT '' COMMENT 'тип элемента',
  `value1` text COMMENT 'значение',
  `parent` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'применить к элементам категории: 0 - нет, 1 - да',
  `category` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'применить к вложенным элементам: 0 - нет, 1 - да',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `dynamic_id` (`dynamic_id`),
  KEY `element_id` (`element_id`),
  KEY `element_type` (`element_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Контент динамических блоков, заполенный в элементах модулей';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_site_dynamic_element`
--

LOCK TABLES `indf_site_dynamic_element` WRITE;
/*!40000 ALTER TABLE `indf_site_dynamic_element` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_site_dynamic_element` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_site_dynamic_module`
--

DROP TABLE IF EXISTS `indf_site_dynamic_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_site_dynamic_module` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `dynamic_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор динамического блока из таблицы `indf_site_dynamic`',
  `module_name` varchar(50) NOT NULL DEFAULT '' COMMENT 'название модуля',
  `element_type` varchar(20) NOT NULL DEFAULT '' COMMENT 'тип элемента',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `dynamic_id` (`dynamic_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Данные о том, в каких модулях заполняются динамические блоки';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_site_dynamic_module`
--

LOCK TABLES `indf_site_dynamic_module` WRITE;
/*!40000 ALTER TABLE `indf_site_dynamic_module` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_site_dynamic_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_site_parents`
--

DROP TABLE IF EXISTS `indf_site_parents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_site_parents` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор страницы из таблицы `indf_site`',
  `parent_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор страницы-родителя из таблицы `indf_site`',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Родительские связи страниц сайта';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_site_parents`
--

LOCK TABLES `indf_site_parents` WRITE;
/*!40000 ALTER TABLE `indf_site_parents` DISABLE KEYS */;
INSERT INTO `indf_site_parents` VALUES (1,7,6,'0'),(2,9,6,'0'),(3,5,4,'0'),(4,34,3,'0'),(5,35,3,'0'),(6,36,3,'0');
/*!40000 ALTER TABLE `indf_site_parents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_subscribtion`
--

DROP TABLE IF EXISTS `indf_subscribtion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_subscribtion` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `created` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата создания',
  `send` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'рассылка отправлена: 0 - нет, 1 - да',
  `cat_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор категории из таблицы `indf_subscribtion_category`',
  `name` varchar(250) NOT NULL DEFAULT '' COMMENT 'название',
  `text` text COMMENT 'текст рассылки',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `cat_id` (`cat_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Рассылки';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_subscribtion`
--

LOCK TABLES `indf_subscribtion` WRITE;
/*!40000 ALTER TABLE `indf_subscribtion` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_subscribtion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_subscribtion_category`
--

DROP TABLE IF EXISTS `indf_subscribtion_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_subscribtion_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `name1` varchar(250) NOT NULL DEFAULT '' COMMENT 'название',
  `act` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'показывать на сайте: 0 - нет, 1 - да',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'подрядковый номер для сортировки',
  `text1` text COMMENT 'описание',
  `parent_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор родителя из таблицы `indf_subscribtion_category`',
  `count_children` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'количество вложенных категорий',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Категории рассылок';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_subscribtion_category`
--

LOCK TABLES `indf_subscribtion_category` WRITE;
/*!40000 ALTER TABLE `indf_subscribtion_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_subscribtion_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_subscribtion_category_parents`
--

DROP TABLE IF EXISTS `indf_subscribtion_category_parents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_subscribtion_category_parents` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор категории из таблицы `indf_subscribtion_category`',
  `parent_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор родителя категории из таблицы `indf_subscribtion_category`',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Родительские связи категорий рассылок';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_subscribtion_category_parents`
--

LOCK TABLES `indf_subscribtion_category_parents` WRITE;
/*!40000 ALTER TABLE `indf_subscribtion_category_parents` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_subscribtion_category_parents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_subscribtion_category_rel`
--

DROP TABLE IF EXISTS `indf_subscribtion_category_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_subscribtion_category_rel` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор рассылки из таблицы `indf_subscribtion`',
  `cat_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор категории из таблицы `indf_subscribtion_category`',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `cat_id` (`cat_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Связи рассылок и категорий';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_subscribtion_category_rel`
--

LOCK TABLES `indf_subscribtion_category_rel` WRITE;
/*!40000 ALTER TABLE `indf_subscribtion_category_rel` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_subscribtion_category_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_subscribtion_emails`
--

DROP TABLE IF EXISTS `indf_subscribtion_emails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_subscribtion_emails` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `created` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата добавления',
  `name` varchar(250) NOT NULL DEFAULT '' COMMENT 'имя',
  `mail` varchar(64) NOT NULL DEFAULT '' COMMENT 'e-mail',
  `code` varchar(32) NOT NULL DEFAULT '' COMMENT 'код доступа к управлению подпиской',
  `act` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'получает рассылку: 0 - нет, 1 - да',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Подписчики на рассылку';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_subscribtion_emails`
--

LOCK TABLES `indf_subscribtion_emails` WRITE;
/*!40000 ALTER TABLE `indf_subscribtion_emails` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_subscribtion_emails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_subscribtion_emails_cat_unrel`
--

DROP TABLE IF EXISTS `indf_subscribtion_emails_cat_unrel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_subscribtion_emails_cat_unrel` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор подписчика из таблицы `indf_subscribtion_emails`',
  `cat_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор категории из таблицы `indf_subscribtion_category`',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Отключенные категории рассылок у подписчиков';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_subscribtion_emails_cat_unrel`
--

LOCK TABLES `indf_subscribtion_emails_cat_unrel` WRITE;
/*!40000 ALTER TABLE `indf_subscribtion_emails_cat_unrel` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_subscribtion_emails_cat_unrel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_subscribtion_phones`
--

DROP TABLE IF EXISTS `indf_subscribtion_phones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_subscribtion_phones` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `created` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата добавления',
  `name` varchar(250) NOT NULL DEFAULT '' COMMENT 'имя',
  `phone` varchar(64) NOT NULL DEFAULT '' COMMENT 'телефон',
  `act` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'получает рассылку: 0 - нет, 1 - да',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Телефоны для рассылок';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_subscribtion_phones`
--

LOCK TABLES `indf_subscribtion_phones` WRITE;
/*!40000 ALTER TABLE `indf_subscribtion_phones` DISABLE KEYS */;
INSERT INTO `indf_subscribtion_phones` VALUES (1,0,'1496828962','','1','0');
/*!40000 ALTER TABLE `indf_subscribtion_phones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_subscribtion_sms`
--

DROP TABLE IF EXISTS `indf_subscribtion_sms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_subscribtion_sms` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `created` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата создания',
  `send` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'рассылка отправлена: 0 - нет, 1 - да',
  `name` varchar(250) NOT NULL DEFAULT '' COMMENT 'название',
  `text` text COMMENT 'текст',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='SMS-рассылки';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_subscribtion_sms`
--

LOCK TABLES `indf_subscribtion_sms` WRITE;
/*!40000 ALTER TABLE `indf_subscribtion_sms` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_subscribtion_sms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_trash`
--

DROP TABLE IF EXISTS `indf_trash`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_trash` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `table_name` varchar(50) NOT NULL DEFAULT '' COMMENT 'название таблицы удаленного элемента',
  `module_name` varchar(50) NOT NULL DEFAULT '' COMMENT 'название модуля удаленного элемента',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор удаленного элемента',
  `created` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата удаления',
  `parent_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор родителя из таблицы `indf_trash`',
  `count_children` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'количество удаленных вместе с текущей записей',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор пользователя из таблицы `indf_users`',
  PRIMARY KEY (`id`),
  KEY `module_name` (`module_name`(2)),
  KEY `parent_id` (`parent_id`),
  KEY `table_name` (`table_name`(2)),
  KEY `element_id` (`element_id`)
) ENGINE=MyISAM AUTO_INCREMENT=384 DEFAULT CHARSET=utf8 COMMENT='Корзина с удаленными элементами';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_trash`
--

LOCK TABLES `indf_trash` WRITE;
/*!40000 ALTER TABLE `indf_trash` DISABLE KEYS */;
INSERT INTO `indf_trash` VALUES (3,'shop_category','shop',26,1496934812,0,2,1),(4,'menu','menu',23,1496934812,3,0,1),(5,'rewrite','rewrite',53,1496934812,3,0,1),(6,'shop_param','shop',3,1497453389,0,15,1),(7,'shop_param_element','shop_param_element',2,1497453389,6,0,1),(8,'shop_param_element','shop_param_element',8,1497453389,6,0,1),(9,'shop_param_element','shop_param_element',20,1497453389,6,0,1),(10,'shop_param_element','shop_param_element',33,1497453389,6,0,1),(11,'shop_param_element','shop_param_element',45,1497453389,6,0,1),(12,'shop_param_element','shop_param_element',55,1497453389,6,0,1),(13,'shop_param_element','shop_param_element',68,1497453389,6,0,1),(14,'shop_param_element','shop_param_element',80,1497453389,6,0,1),(15,'shop_param_element','shop_param_element',92,1497453389,6,0,1),(16,'shop_param_element','shop_param_element',105,1497453389,6,0,1),(17,'shop_param_select','shop_param_select',3,1497453389,6,0,1),(18,'shop_param_select','shop_param_select',4,1497453389,6,0,1),(19,'shop_param_select','shop_param_select',5,1497453389,6,0,1),(20,'shop_param_select','shop_param_select',20,1497453389,6,0,1),(21,'shop_param_category_rel','shop_param_category_rel',2,1497453389,6,0,1),(22,'shop_param','shop',4,1497453389,0,15,1),(23,'shop_param_element','shop_param_element',3,1497453389,22,0,1),(24,'shop_param_element','shop_param_element',9,1497453389,22,0,1),(25,'shop_param_element','shop_param_element',21,1497453389,22,0,1),(26,'shop_param_element','shop_param_element',34,1497453389,22,0,1),(27,'shop_param_element','shop_param_element',46,1497453389,22,0,1),(28,'shop_param_element','shop_param_element',56,1497453389,22,0,1),(29,'shop_param_element','shop_param_element',69,1497453389,22,0,1),(30,'shop_param_element','shop_param_element',81,1497453389,22,0,1),(31,'shop_param_element','shop_param_element',93,1497453389,22,0,1),(32,'shop_param_element','shop_param_element',106,1497453389,22,0,1),(33,'shop_param_select','shop_param_select',6,1497453389,22,0,1),(34,'shop_param_select','shop_param_select',7,1497453389,22,0,1),(35,'shop_param_select','shop_param_select',21,1497453389,22,0,1),(36,'shop_param_select','shop_param_select',22,1497453389,22,0,1),(37,'shop_param_category_rel','shop_param_category_rel',3,1497453389,22,0,1),(38,'shop_param','shop',6,1497453389,0,16,1),(39,'shop_param_element','shop_param_element',4,1497453389,38,0,1),(40,'shop_param_element','shop_param_element',11,1497453389,38,0,1),(41,'shop_param_element','shop_param_element',22,1497453389,38,0,1),(42,'shop_param_element','shop_param_element',35,1497453389,38,0,1),(43,'shop_param_element','shop_param_element',47,1497453389,38,0,1),(44,'shop_param_element','shop_param_element',58,1497453389,38,0,1),(45,'shop_param_element','shop_param_element',70,1497453389,38,0,1),(46,'shop_param_element','shop_param_element',82,1497453389,38,0,1),(47,'shop_param_element','shop_param_element',95,1497453389,38,0,1),(48,'shop_param_element','shop_param_element',107,1497453389,38,0,1),(49,'shop_param_select','shop_param_select',9,1497453389,38,0,1),(50,'shop_param_select','shop_param_select',10,1497453389,38,0,1),(51,'shop_param_select','shop_param_select',11,1497453389,38,0,1),(52,'shop_param_select','shop_param_select',12,1497453389,38,0,1),(53,'shop_param_select','shop_param_select',13,1497453389,38,0,1),(54,'shop_param_category_rel','shop_param_category_rel',4,1497453389,38,0,1),(55,'shop_param','shop',7,1497453389,0,42,1),(56,'shop_price_param','shop_price_param',1,1497453389,55,0,1),(57,'shop_price_param','shop_price_param',3,1497453389,55,0,1),(58,'shop_price_param','shop_price_param',5,1497453389,55,0,1),(59,'shop_price_param','shop_price_param',7,1497453389,55,0,1),(60,'shop_price_param','shop_price_param',9,1497453389,55,0,1),(61,'shop_price_param','shop_price_param',11,1497453389,55,0,1),(62,'shop_price_param','shop_price_param',13,1497453389,55,0,1),(63,'shop_price_param','shop_price_param',15,1497453389,55,0,1),(64,'shop_price_param','shop_price_param',17,1497453389,55,0,1),(65,'shop_price_param','shop_price_param',19,1497453389,55,0,1),(66,'shop_price_param','shop_price_param',21,1497453389,55,0,1),(67,'shop_price_param','shop_price_param',23,1497453389,55,0,1),(68,'shop_price_param','shop_price_param',25,1497453389,55,0,1),(69,'shop_price_param','shop_price_param',27,1497453389,55,0,1),(70,'shop_price_param','shop_price_param',29,1497453389,55,0,1),(71,'shop_price_param','shop_price_param',31,1497453389,55,0,1),(72,'shop_price_param','shop_price_param',33,1497453389,55,0,1),(73,'shop_price_param','shop_price_param',45,1497453389,55,0,1),(74,'shop_price_param','shop_price_param',47,1497453389,55,0,1),(75,'shop_price_param','shop_price_param',51,1497453389,55,0,1),(76,'shop_param_element','shop_param_element',5,1497453389,55,0,1),(77,'shop_param_element','shop_param_element',6,1497453389,55,0,1),(78,'shop_param_element','shop_param_element',17,1497453389,55,0,1),(79,'shop_param_element','shop_param_element',18,1497453389,55,0,1),(80,'shop_param_element','shop_param_element',30,1497453389,55,0,1),(81,'shop_param_element','shop_param_element',31,1497453389,55,0,1),(82,'shop_param_element','shop_param_element',42,1497453389,55,0,1),(83,'shop_param_element','shop_param_element',43,1497453389,55,0,1),(84,'shop_param_element','shop_param_element',53,1497453389,55,0,1),(85,'shop_param_element','shop_param_element',54,1497453389,55,0,1),(86,'shop_param_element','shop_param_element',66,1497453389,55,0,1),(87,'shop_param_element','shop_param_element',77,1497453389,55,0,1),(88,'shop_param_element','shop_param_element',78,1497453389,55,0,1),(89,'shop_param_element','shop_param_element',90,1497453389,55,0,1),(90,'shop_param_element','shop_param_element',91,1497453389,55,0,1),(91,'shop_param_element','shop_param_element',102,1497453389,55,0,1),(92,'shop_param_element','shop_param_element',103,1497453389,55,0,1),(93,'shop_param_element','shop_param_element',108,1497453389,55,0,1),(94,'shop_param_element','shop_param_element',109,1497453389,55,0,1),(95,'shop_param_select','shop_param_select',14,1497453389,55,0,1),(96,'shop_param_select','shop_param_select',15,1497453389,55,0,1),(97,'shop_param_category_rel','shop_param_category_rel',5,1497453389,55,0,1),(98,'shop_param','shop',8,1497453389,0,68,1),(99,'shop_price_param','shop_price_param',2,1497453389,98,0,1),(100,'shop_price_param','shop_price_param',4,1497453389,98,0,1),(101,'shop_price_param','shop_price_param',6,1497453389,98,0,1),(102,'shop_price_param','shop_price_param',8,1497453389,98,0,1),(103,'shop_price_param','shop_price_param',10,1497453389,98,0,1),(104,'shop_price_param','shop_price_param',12,1497453389,98,0,1),(105,'shop_price_param','shop_price_param',14,1497453389,98,0,1),(106,'shop_price_param','shop_price_param',16,1497453389,98,0,1),(107,'shop_price_param','shop_price_param',18,1497453389,98,0,1),(108,'shop_price_param','shop_price_param',20,1497453389,98,0,1),(109,'shop_price_param','shop_price_param',22,1497453389,98,0,1),(110,'shop_price_param','shop_price_param',24,1497453389,98,0,1),(111,'shop_price_param','shop_price_param',26,1497453389,98,0,1),(112,'shop_price_param','shop_price_param',28,1497453389,98,0,1),(113,'shop_price_param','shop_price_param',30,1497453389,98,0,1),(114,'shop_price_param','shop_price_param',32,1497453389,98,0,1),(115,'shop_price_param','shop_price_param',34,1497453389,98,0,1),(116,'shop_price_param','shop_price_param',46,1497453389,98,0,1),(117,'shop_price_param','shop_price_param',48,1497453389,98,0,1),(118,'shop_price_param','shop_price_param',52,1497453389,98,0,1),(119,'shop_param_element','shop_param_element',12,1497453389,98,0,1),(120,'shop_param_element','shop_param_element',13,1497453389,98,0,1),(121,'shop_param_element','shop_param_element',14,1497453389,98,0,1),(122,'shop_param_element','shop_param_element',15,1497453389,98,0,1),(123,'shop_param_element','shop_param_element',23,1497453389,98,0,1),(124,'shop_param_element','shop_param_element',24,1497453389,98,0,1),(125,'shop_param_element','shop_param_element',25,1497453389,98,0,1),(126,'shop_param_element','shop_param_element',26,1497453389,98,0,1),(127,'shop_param_element','shop_param_element',27,1497453389,98,0,1),(128,'shop_param_element','shop_param_element',28,1497453389,98,0,1),(129,'shop_param_element','shop_param_element',36,1497453389,98,0,1),(130,'shop_param_element','shop_param_element',37,1497453389,98,0,1),(131,'shop_param_element','shop_param_element',38,1497453389,98,0,1),(132,'shop_param_element','shop_param_element',39,1497453389,98,0,1),(133,'shop_param_element','shop_param_element',40,1497453389,98,0,1),(134,'shop_param_element','shop_param_element',48,1497453389,98,0,1),(135,'shop_param_element','shop_param_element',49,1497453389,98,0,1),(136,'shop_param_element','shop_param_element',50,1497453389,98,0,1),(137,'shop_param_element','shop_param_element',51,1497453389,98,0,1),(138,'shop_param_element','shop_param_element',59,1497453389,98,0,1),(139,'shop_param_element','shop_param_element',60,1497453389,98,0,1),(140,'shop_param_element','shop_param_element',61,1497453389,98,0,1),(141,'shop_param_element','shop_param_element',62,1497453389,98,0,1),(142,'shop_param_element','shop_param_element',63,1497453389,98,0,1),(143,'shop_param_element','shop_param_element',64,1497453389,98,0,1),(144,'shop_param_element','shop_param_element',71,1497453389,98,0,1),(145,'shop_param_element','shop_param_element',72,1497453389,98,0,1),(146,'shop_param_element','shop_param_element',73,1497453389,98,0,1),(147,'shop_param_element','shop_param_element',74,1497453389,98,0,1),(148,'shop_param_element','shop_param_element',75,1497453389,98,0,1),(149,'shop_param_element','shop_param_element',83,1497453389,98,0,1),(150,'shop_param_element','shop_param_element',84,1497453389,98,0,1),(151,'shop_param_element','shop_param_element',85,1497453389,98,0,1),(152,'shop_param_element','shop_param_element',86,1497453389,98,0,1),(153,'shop_param_element','shop_param_element',87,1497453389,98,0,1),(154,'shop_param_element','shop_param_element',88,1497453389,98,0,1),(155,'shop_param_element','shop_param_element',96,1497453389,98,0,1),(156,'shop_param_element','shop_param_element',97,1497453389,98,0,1),(157,'shop_param_element','shop_param_element',98,1497453389,98,0,1),(158,'shop_param_element','shop_param_element',99,1497453389,98,0,1),(159,'shop_param_element','shop_param_element',100,1497453389,98,0,1),(160,'shop_param_select','shop_param_select',23,1497453389,98,0,1),(161,'shop_param_select','shop_param_select',24,1497453389,98,0,1),(162,'shop_param_select','shop_param_select',25,1497453389,98,0,1),(163,'shop_param_select','shop_param_select',26,1497453389,98,0,1),(164,'shop_param_select','shop_param_select',27,1497453389,98,0,1),(165,'shop_param_select','shop_param_select',28,1497453389,98,0,1),(166,'shop_param_category_rel','shop_param_category_rel',6,1497453389,98,0,1),(167,'shop_param','shop',10,1497453389,0,13,1),(168,'shop_param_element','shop_param_element',7,1497453389,167,0,1),(169,'shop_param_element','shop_param_element',16,1497453389,167,0,1),(170,'shop_param_element','shop_param_element',29,1497453389,167,0,1),(171,'shop_param_element','shop_param_element',41,1497453389,167,0,1),(172,'shop_param_element','shop_param_element',52,1497453389,167,0,1),(173,'shop_param_element','shop_param_element',65,1497453389,167,0,1),(174,'shop_param_element','shop_param_element',76,1497453389,167,0,1),(175,'shop_param_element','shop_param_element',89,1497453389,167,0,1),(176,'shop_param_element','shop_param_element',101,1497453389,167,0,1),(177,'shop_param_element','shop_param_element',110,1497453389,167,0,1),(178,'shop_param_select','shop_param_select',29,1497453389,167,0,1),(179,'shop_param_select','shop_param_select',30,1497453389,167,0,1),(180,'shop_param_category_rel','shop_param_category_rel',7,1497453389,167,0,1),(181,'news','news',3,1497456576,0,3,1),(182,'images','images',34,1497456576,181,0,1),(183,'rewrite','rewrite',44,1497456576,181,0,1),(184,'news_counter','news_counter',1,1497456576,181,0,1),(185,'news','news',2,1497456576,0,2,1),(186,'rewrite','rewrite',43,1497456576,185,0,1),(187,'news_counter','news_counter',2,1497456576,185,0,1),(188,'shop_category','shop',2,1497459221,0,65,1),(189,'shop_category','shop_category',12,1497459221,188,0,1),(190,'shop_category','shop_category',19,1497459221,188,0,1),(191,'shop_category','shop_category',20,1497459221,188,0,1),(192,'shop_category','shop_category',13,1497459221,188,0,1),(193,'shop_category','shop_category',17,1497459221,188,0,1),(194,'shop_category','shop_category',18,1497459221,188,0,1),(195,'shop_category','shop_category',14,1497459221,188,0,1),(196,'shop_category_parents','shop_category_parents',4,1497459221,188,0,1),(197,'shop_category_parents','shop_category_parents',5,1497459221,188,0,1),(198,'shop_category_parents','shop_category_parents',6,1497459221,188,0,1),(199,'shop_category_parents','shop_category_parents',7,1497459221,188,0,1),(200,'shop_category_parents','shop_category_parents',8,1497459221,188,0,1),(201,'shop_category_parents','shop_category_parents',9,1497459221,188,0,1),(202,'shop_category_parents','shop_category_parents',10,1497459221,188,0,1),(203,'shop_category_parents','shop_category_parents',11,1497459221,188,0,1),(204,'shop_category_parents','shop_category_parents',12,1497459221,188,0,1),(205,'shop_category_parents','shop_category_parents',13,1497459221,188,0,1),(206,'shop_category_parents','shop_category_parents',14,1497459221,188,0,1),(207,'menu_parents','menu_parents',4,1497459221,188,0,1),(208,'menu_parents','menu_parents',5,1497459221,188,0,1),(209,'menu_parents','menu_parents',6,1497459221,188,0,1),(210,'menu_parents','menu_parents',7,1497459221,188,0,1),(211,'menu_parents','menu_parents',8,1497459221,188,0,1),(212,'menu_parents','menu_parents',9,1497459221,188,0,1),(213,'menu_parents','menu_parents',10,1497459221,188,0,1),(214,'menu','menu',8,1497459221,188,0,1),(215,'menu','menu',9,1497459221,188,0,1),(216,'menu','menu',10,1497459221,188,0,1),(217,'menu','menu',11,1497459221,188,0,1),(218,'menu','menu',12,1497459221,188,0,1),(219,'menu','menu',13,1497459221,188,0,1),(220,'menu','menu',14,1497459221,188,0,1),(221,'menu','menu',15,1497459221,188,0,1),(222,'rewrite','rewrite',14,1497459221,188,0,1),(223,'rewrite','rewrite',15,1497459221,188,0,1),(224,'rewrite','rewrite',16,1497459221,188,0,1),(225,'rewrite','rewrite',17,1497459221,188,0,1),(226,'rewrite','rewrite',18,1497459221,188,0,1),(227,'rewrite','rewrite',19,1497459221,188,0,1),(228,'rewrite','rewrite',20,1497459221,188,0,1),(229,'rewrite','rewrite',21,1497459221,188,0,1),(230,'shop','shop',2,1497459221,188,0,1),(231,'shop','shop',12,1497459221,188,0,1),(232,'rewrite','rewrite',27,1497459221,188,0,1),(233,'rewrite','rewrite',34,1497459221,188,0,1),(234,'shop_category_rel','shop_category_rel',12,1497459221,188,0,1),(235,'shop_category_rel','shop_category_rel',13,1497459221,188,0,1),(236,'shop_category_rel','shop_category_rel',14,1497459221,188,0,1),(237,'shop_category_rel','shop_category_rel',15,1497459221,188,0,1),(238,'shop_category_rel','shop_category_rel',16,1497459221,188,0,1),(239,'shop_category_rel','shop_category_rel',17,1497459221,188,0,1),(240,'shop_category_rel','shop_category_rel',18,1497459221,188,0,1),(241,'shop_category_rel','shop_category_rel',19,1497459221,188,0,1),(242,'shop_category_rel','shop_category_rel',20,1497459221,188,0,1),(243,'shop_category_rel','shop_category_rel',21,1497459221,188,0,1),(244,'shop_category_rel','shop_category_rel',79,1497459221,188,0,1),(245,'shop_category_rel','shop_category_rel',80,1497459221,188,0,1),(246,'shop_category_rel','shop_category_rel',81,1497459221,188,0,1),(247,'shop_category_rel','shop_category_rel',82,1497459221,188,0,1),(248,'shop_category_rel','shop_category_rel',83,1497459221,188,0,1),(249,'shop_category_rel','shop_category_rel',84,1497459221,188,0,1),(250,'shop_category_rel','shop_category_rel',85,1497459221,188,0,1),(251,'shop_category_rel','shop_category_rel',86,1497459221,188,0,1),(252,'shop_category_rel','shop_category_rel',87,1497459221,188,0,1),(253,'shop_category_rel','shop_category_rel',88,1497459221,188,0,1),(254,'shop_category','shop',1,1497459221,0,36,1),(255,'shop_category','shop_category',22,1497459221,254,0,1),(256,'shop_category','shop_category',23,1497459221,254,0,1),(257,'shop_category','shop_category',24,1497459221,254,0,1),(258,'shop_category_parents','shop_category_parents',1,1497459221,254,0,1),(259,'shop_category_parents','shop_category_parents',2,1497459221,254,0,1),(260,'shop_category_parents','shop_category_parents',3,1497459221,254,0,1),(261,'rewrite','rewrite',10,1497459221,254,0,1),(262,'rewrite','rewrite',11,1497459221,254,0,1),(263,'rewrite','rewrite',12,1497459221,254,0,1),(264,'rewrite','rewrite',13,1497459221,254,0,1),(265,'shop','shop',1,1497459221,254,0,1),(266,'shop','shop',13,1497459221,254,0,1),(267,'rewrite','rewrite',26,1497459221,254,0,1),(268,'rewrite','rewrite',35,1497459221,254,0,1),(269,'shop_category_rel','shop_category_rel',1,1497459221,254,0,1),(270,'shop_category_rel','shop_category_rel',2,1497459221,254,0,1),(271,'shop_category_rel','shop_category_rel',3,1497459221,254,0,1),(272,'shop_category_rel','shop_category_rel',4,1497459221,254,0,1),(273,'shop_category_rel','shop_category_rel',5,1497459221,254,0,1),(274,'shop_category_rel','shop_category_rel',6,1497459221,254,0,1),(275,'shop_category_rel','shop_category_rel',7,1497459221,254,0,1),(276,'shop_category_rel','shop_category_rel',8,1497459221,254,0,1),(277,'shop_category_rel','shop_category_rel',9,1497459221,254,0,1),(278,'shop_category_rel','shop_category_rel',10,1497459221,254,0,1),(279,'shop_category_rel','shop_category_rel',11,1497459221,254,0,1),(280,'shop_category_rel','shop_category_rel',89,1497459221,254,0,1),(281,'shop_category_rel','shop_category_rel',90,1497459221,254,0,1),(282,'shop_category_rel','shop_category_rel',91,1497459221,254,0,1),(283,'shop_category_rel','shop_category_rel',92,1497459221,254,0,1),(284,'shop_category_rel','shop_category_rel',93,1497459221,254,0,1),(285,'shop_category_rel','shop_category_rel',94,1497459221,254,0,1),(286,'shop_category_rel','shop_category_rel',95,1497459221,254,0,1),(287,'shop_category_rel','shop_category_rel',96,1497459221,254,0,1),(288,'shop_category_rel','shop_category_rel',97,1497459221,254,0,1),(289,'shop_category_rel','shop_category_rel',98,1497459221,254,0,1),(290,'shop_category_rel','shop_category_rel',99,1497459221,254,0,1),(291,'shop_category','shop',4,1497459221,0,27,1),(292,'rewrite','rewrite',23,1497459221,291,0,1),(293,'shop','shop',4,1497459221,291,0,1),(294,'shop','shop',10,1497459221,291,0,1),(295,'rewrite','rewrite',29,1497459221,291,0,1),(296,'rewrite','rewrite',32,1497459221,291,0,1),(297,'shop_category_rel','shop_category_rel',31,1497459221,291,0,1),(298,'shop_category_rel','shop_category_rel',32,1497459221,291,0,1),(299,'shop_category_rel','shop_category_rel',33,1497459221,291,0,1),(300,'shop_category_rel','shop_category_rel',34,1497459221,291,0,1),(301,'shop_category_rel','shop_category_rel',35,1497459221,291,0,1),(302,'shop_category_rel','shop_category_rel',36,1497459221,291,0,1),(303,'shop_category_rel','shop_category_rel',37,1497459221,291,0,1),(304,'shop_category_rel','shop_category_rel',38,1497459221,291,0,1),(305,'shop_category_rel','shop_category_rel',39,1497459221,291,0,1),(306,'shop_category_rel','shop_category_rel',40,1497459221,291,0,1),(307,'shop_category_rel','shop_category_rel',41,1497459221,291,0,1),(308,'shop_category_rel','shop_category_rel',59,1497459221,291,0,1),(309,'shop_category_rel','shop_category_rel',60,1497459221,291,0,1),(310,'shop_category_rel','shop_category_rel',61,1497459221,291,0,1),(311,'shop_category_rel','shop_category_rel',62,1497459221,291,0,1),(312,'shop_category_rel','shop_category_rel',63,1497459221,291,0,1),(313,'shop_category_rel','shop_category_rel',64,1497459221,291,0,1),(314,'shop_category_rel','shop_category_rel',65,1497459221,291,0,1),(315,'shop_category_rel','shop_category_rel',66,1497459221,291,0,1),(316,'shop_category_rel','shop_category_rel',67,1497459221,291,0,1),(317,'shop_category_rel','shop_category_rel',68,1497459221,291,0,1),(318,'shop_category_rel','shop_category_rel',69,1497459221,291,0,1),(319,'shop_category','shop',6,1497459221,0,11,1),(320,'rewrite','rewrite',24,1497459221,319,0,1),(321,'shop','shop',6,1497459221,319,0,1),(322,'rewrite','rewrite',30,1497459221,319,0,1),(323,'shop_category_rel','shop_category_rel',42,1497459221,319,0,1),(324,'shop_category_rel','shop_category_rel',43,1497459221,319,0,1),(325,'shop_category_rel','shop_category_rel',44,1497459221,319,0,1),(326,'shop_category_rel','shop_category_rel',45,1497459221,319,0,1),(327,'shop_category_rel','shop_category_rel',46,1497459221,319,0,1),(328,'shop_category_rel','shop_category_rel',47,1497459221,319,0,1),(329,'shop_category_rel','shop_category_rel',48,1497459221,319,0,1),(330,'shop_category_rel','shop_category_rel',49,1497459221,319,0,1),(331,'shop_category','shop',7,1497459221,0,12,1),(332,'rewrite','rewrite',25,1497459221,331,0,1),(333,'shop','shop',7,1497459221,331,0,1),(334,'rewrite','rewrite',31,1497459221,331,0,1),(335,'shop_category_rel','shop_category_rel',50,1497459221,331,0,1),(336,'shop_category_rel','shop_category_rel',51,1497459221,331,0,1),(337,'shop_category_rel','shop_category_rel',52,1497459221,331,0,1),(338,'shop_category_rel','shop_category_rel',53,1497459221,331,0,1),(339,'shop_category_rel','shop_category_rel',54,1497459221,331,0,1),(340,'shop_category_rel','shop_category_rel',55,1497459221,331,0,1),(341,'shop_category_rel','shop_category_rel',56,1497459221,331,0,1),(342,'shop_category_rel','shop_category_rel',57,1497459221,331,0,1),(343,'shop_category_rel','shop_category_rel',58,1497459221,331,0,1),(344,'shop_category','shop',3,1497459221,0,23,1),(345,'rewrite','rewrite',22,1497459221,344,0,1),(346,'shop','shop',3,1497459221,344,0,1),(347,'shop','shop',11,1497459221,344,0,1),(348,'rewrite','rewrite',28,1497459221,344,0,1),(349,'rewrite','rewrite',33,1497459221,344,0,1),(350,'shop_category_rel','shop_category_rel',22,1497459221,344,0,1),(351,'shop_category_rel','shop_category_rel',23,1497459221,344,0,1),(352,'shop_category_rel','shop_category_rel',24,1497459221,344,0,1),(353,'shop_category_rel','shop_category_rel',25,1497459221,344,0,1),(354,'shop_category_rel','shop_category_rel',26,1497459221,344,0,1),(355,'shop_category_rel','shop_category_rel',27,1497459221,344,0,1),(356,'shop_category_rel','shop_category_rel',28,1497459221,344,0,1),(357,'shop_category_rel','shop_category_rel',29,1497459221,344,0,1),(358,'shop_category_rel','shop_category_rel',30,1497459221,344,0,1),(359,'shop_category_rel','shop_category_rel',70,1497459221,344,0,1),(360,'shop_category_rel','shop_category_rel',71,1497459221,344,0,1),(361,'shop_category_rel','shop_category_rel',72,1497459221,344,0,1),(362,'shop_category_rel','shop_category_rel',73,1497459221,344,0,1),(363,'shop_category_rel','shop_category_rel',74,1497459221,344,0,1),(364,'shop_category_rel','shop_category_rel',75,1497459221,344,0,1),(365,'shop_category_rel','shop_category_rel',76,1497459221,344,0,1),(366,'shop_category_rel','shop_category_rel',77,1497459221,344,0,1),(367,'shop_category_rel','shop_category_rel',78,1497459221,344,0,1),(368,'site','site',26,1497459296,0,1,1),(369,'rewrite','rewrite',3,1497459296,368,0,1),(370,'menu','menu',4,1497460541,0,6,1),(371,'menu','menu',5,1497460541,370,0,1),(372,'menu','menu',6,1497460541,370,0,1),(373,'menu','menu',7,1497460541,370,0,1),(374,'menu_parents','menu_parents',1,1497460541,370,0,1),(375,'menu_parents','menu_parents',2,1497460541,370,0,1),(376,'menu_parents','menu_parents',3,1497460541,370,0,1),(377,'menu','menu',17,1497460541,0,0,1),(378,'menu','menu',18,1497460541,0,0,1),(379,'menu','menu',19,1497460541,0,0,1),(380,'menu','menu',16,1497460541,0,0,1),(381,'menu','menu',31,1497469035,0,2,1),(382,'menu','menu',32,1497469035,381,0,1),(383,'menu_parents','menu_parents',15,1497469035,381,0,1);
/*!40000 ALTER TABLE `indf_trash` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_trash_parents`
--

DROP TABLE IF EXISTS `indf_trash_parents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_trash_parents` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор записи из таблицы `indf_trash` об удалении элемента',
  `parent_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор записи-родителя из таблицы `indf_trash` об удалении элемента',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=384 DEFAULT CHARSET=utf8 COMMENT='Родительские связи в корзине (какое удаление влечет за собой';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_trash_parents`
--

LOCK TABLES `indf_trash_parents` WRITE;
/*!40000 ALTER TABLE `indf_trash_parents` DISABLE KEYS */;
INSERT INTO `indf_trash_parents` VALUES (4,4,3),(3,3,0),(5,5,3),(6,6,0),(7,7,6),(8,8,6),(9,9,6),(10,10,6),(11,11,6),(12,12,6),(13,13,6),(14,14,6),(15,15,6),(16,16,6),(17,17,6),(18,18,6),(19,19,6),(20,20,6),(21,21,6),(22,22,0),(23,23,22),(24,24,22),(25,25,22),(26,26,22),(27,27,22),(28,28,22),(29,29,22),(30,30,22),(31,31,22),(32,32,22),(33,33,22),(34,34,22),(35,35,22),(36,36,22),(37,37,22),(38,38,0),(39,39,38),(40,40,38),(41,41,38),(42,42,38),(43,43,38),(44,44,38),(45,45,38),(46,46,38),(47,47,38),(48,48,38),(49,49,38),(50,50,38),(51,51,38),(52,52,38),(53,53,38),(54,54,38),(55,55,0),(56,56,55),(57,57,55),(58,58,55),(59,59,55),(60,60,55),(61,61,55),(62,62,55),(63,63,55),(64,64,55),(65,65,55),(66,66,55),(67,67,55),(68,68,55),(69,69,55),(70,70,55),(71,71,55),(72,72,55),(73,73,55),(74,74,55),(75,75,55),(76,76,55),(77,77,55),(78,78,55),(79,79,55),(80,80,55),(81,81,55),(82,82,55),(83,83,55),(84,84,55),(85,85,55),(86,86,55),(87,87,55),(88,88,55),(89,89,55),(90,90,55),(91,91,55),(92,92,55),(93,93,55),(94,94,55),(95,95,55),(96,96,55),(97,97,55),(98,98,0),(99,99,98),(100,100,98),(101,101,98),(102,102,98),(103,103,98),(104,104,98),(105,105,98),(106,106,98),(107,107,98),(108,108,98),(109,109,98),(110,110,98),(111,111,98),(112,112,98),(113,113,98),(114,114,98),(115,115,98),(116,116,98),(117,117,98),(118,118,98),(119,119,98),(120,120,98),(121,121,98),(122,122,98),(123,123,98),(124,124,98),(125,125,98),(126,126,98),(127,127,98),(128,128,98),(129,129,98),(130,130,98),(131,131,98),(132,132,98),(133,133,98),(134,134,98),(135,135,98),(136,136,98),(137,137,98),(138,138,98),(139,139,98),(140,140,98),(141,141,98),(142,142,98),(143,143,98),(144,144,98),(145,145,98),(146,146,98),(147,147,98),(148,148,98),(149,149,98),(150,150,98),(151,151,98),(152,152,98),(153,153,98),(154,154,98),(155,155,98),(156,156,98),(157,157,98),(158,158,98),(159,159,98),(160,160,98),(161,161,98),(162,162,98),(163,163,98),(164,164,98),(165,165,98),(166,166,98),(167,167,0),(168,168,167),(169,169,167),(170,170,167),(171,171,167),(172,172,167),(173,173,167),(174,174,167),(175,175,167),(176,176,167),(177,177,167),(178,178,167),(179,179,167),(180,180,167),(181,181,0),(182,182,181),(183,183,181),(184,184,181),(185,185,0),(186,186,185),(187,187,185),(188,188,0),(189,189,188),(190,190,188),(191,191,188),(192,192,188),(193,193,188),(194,194,188),(195,195,188),(196,196,188),(197,197,188),(198,198,188),(199,199,188),(200,200,188),(201,201,188),(202,202,188),(203,203,188),(204,204,188),(205,205,188),(206,206,188),(207,207,188),(208,208,188),(209,209,188),(210,210,188),(211,211,188),(212,212,188),(213,213,188),(214,214,188),(215,215,188),(216,216,188),(217,217,188),(218,218,188),(219,219,188),(220,220,188),(221,221,188),(222,222,188),(223,223,188),(224,224,188),(225,225,188),(226,226,188),(227,227,188),(228,228,188),(229,229,188),(230,230,188),(231,231,188),(232,232,188),(233,233,188),(234,234,188),(235,235,188),(236,236,188),(237,237,188),(238,238,188),(239,239,188),(240,240,188),(241,241,188),(242,242,188),(243,243,188),(244,244,188),(245,245,188),(246,246,188),(247,247,188),(248,248,188),(249,249,188),(250,250,188),(251,251,188),(252,252,188),(253,253,188),(254,254,0),(255,255,254),(256,256,254),(257,257,254),(258,258,254),(259,259,254),(260,260,254),(261,261,254),(262,262,254),(263,263,254),(264,264,254),(265,265,254),(266,266,254),(267,267,254),(268,268,254),(269,269,254),(270,270,254),(271,271,254),(272,272,254),(273,273,254),(274,274,254),(275,275,254),(276,276,254),(277,277,254),(278,278,254),(279,279,254),(280,280,254),(281,281,254),(282,282,254),(283,283,254),(284,284,254),(285,285,254),(286,286,254),(287,287,254),(288,288,254),(289,289,254),(290,290,254),(291,291,0),(292,292,291),(293,293,291),(294,294,291),(295,295,291),(296,296,291),(297,297,291),(298,298,291),(299,299,291),(300,300,291),(301,301,291),(302,302,291),(303,303,291),(304,304,291),(305,305,291),(306,306,291),(307,307,291),(308,308,291),(309,309,291),(310,310,291),(311,311,291),(312,312,291),(313,313,291),(314,314,291),(315,315,291),(316,316,291),(317,317,291),(318,318,291),(319,319,0),(320,320,319),(321,321,319),(322,322,319),(323,323,319),(324,324,319),(325,325,319),(326,326,319),(327,327,319),(328,328,319),(329,329,319),(330,330,319),(331,331,0),(332,332,331),(333,333,331),(334,334,331),(335,335,331),(336,336,331),(337,337,331),(338,338,331),(339,339,331),(340,340,331),(341,341,331),(342,342,331),(343,343,331),(344,344,0),(345,345,344),(346,346,344),(347,347,344),(348,348,344),(349,349,344),(350,350,344),(351,351,344),(352,352,344),(353,353,344),(354,354,344),(355,355,344),(356,356,344),(357,357,344),(358,358,344),(359,359,344),(360,360,344),(361,361,344),(362,362,344),(363,363,344),(364,364,344),(365,365,344),(366,366,344),(367,367,344),(368,368,0),(369,369,368),(370,370,0),(371,371,370),(372,372,370),(373,373,370),(374,374,370),(375,375,370),(376,376,370),(377,377,0),(378,378,0),(379,379,0),(380,380,0),(381,381,0),(382,382,381),(383,383,381);
/*!40000 ALTER TABLE `indf_trash_parents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_update_return`
--

DROP TABLE IF EXISTS `indf_update_return`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_update_return` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT 'название',
  `created` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата создания',
  `current` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'текущая точка: 0 - нет, 1 - да',
  `hash` varchar(100) NOT NULL DEFAULT '' COMMENT 'уникальный хэш',
  `text` text COMMENT 'описание',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2470 DEFAULT CHARSET=utf8 COMMENT='Точки возврата';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_update_return`
--

LOCK TABLES `indf_update_return` WRITE;
/*!40000 ALTER TABLE `indf_update_return` DISABLE KEYS */;
INSERT INTO `indf_update_return` VALUES (1,'Установка',1496828867,'0','',NULL),(2469,'Обновление',1496828998,'1','c4e841d5d59150b09f613e487352b9bca51959aa','Изменения в платежном модуле Яндекс.Касса в связи с 54-ФЗ, Ошибка на первой странице модуля Объявления, Добавлены все изображения в YML, Ширина, высота, длина, вес у товара');
/*!40000 ALTER TABLE `indf_update_return` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_users`
--

DROP TABLE IF EXISTS `indf_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `name` varchar(60) NOT NULL DEFAULT '' COMMENT 'логин',
  `password` varchar(32) NOT NULL DEFAULT '' COMMENT 'пароль в зашифрованном виде',
  `mail` varchar(64) NOT NULL DEFAULT '' COMMENT 'e-mail',
  `phone` varchar(64) NOT NULL DEFAULT '' COMMENT 'телефон',
  `created` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата регистрации',
  `fio` varchar(255) NOT NULL DEFAULT '' COMMENT 'ФИО',
  `role_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор типа пользователя из таблицы `indf_users_role`',
  `act` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'активен на сайте: 0 - нет, 1 - да',
  `htmleditor` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'использовать визуальный редактор: 0 - нет, 1 - да',
  `copy_files` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'cохранять картинки с внешних сайтов, при вставке контента в визуальный редактор: 0 - нет, 1 - да',
  `useradmin` enum('0','1','2') NOT NULL DEFAULT '0' COMMENT 'панель быстрого редактирования: 0 - отключена, 1 - включена, 2 - только панель без режима редактирования',
  `start_admin` varchar(30) NOT NULL DEFAULT '' COMMENT 'стартовая страница административной части',
  `lang_id` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор языка сайта из таблицы `indf_languages`',
  `admin_nastr` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'колечество элементов на странице в административной части',
  `identity` varchar(255) NOT NULL DEFAULT '' COMMENT 'URL на страницу в соц. сети',
  `config` text COMMENT 'Настройки пользователя',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `name` (`name`(1))
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Пользователи';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_users`
--

LOCK TABLES `indf_users` WRITE;
/*!40000 ALTER TABLE `indf_users` DISABLE KEYS */;
INSERT INTO `indf_users` VALUES (1,'admin','d14f9c867a6c54412188694c2ec69c54','victor7broker@gmail.com','',1493804820,'admin',3,'1','1','1','1','',0,0,'',NULL,'0');
/*!40000 ALTER TABLE `indf_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_users_actlink`
--

DROP TABLE IF EXISTS `indf_users_actlink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_users_actlink` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `link` varchar(255) NOT NULL DEFAULT '' COMMENT 'код активации',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор пользователя из таблицы `indf_users`',
  `created` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'дата создания',
  `count` int(11) unsigned NOT NULL DEFAULT '1' COMMENT 'количество неудачных попыток',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Код активации аккаунта';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_users_actlink`
--

LOCK TABLES `indf_users_actlink` WRITE;
/*!40000 ALTER TABLE `indf_users_actlink` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_users_actlink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_users_param`
--

DROP TABLE IF EXISTS `indf_users_param`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_users_param` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `name1` varchar(250) NOT NULL DEFAULT '' COMMENT 'название',
  `text1` text COMMENT 'описание',
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT 'тип',
  `show_in_page` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'выводить на странице пользователя: 0 - нет, 1 - да',
  `show_in_form_auth` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'выводить в форме редактирования данных для авторизованных пользователей: 0 - нет, 1 - да',
  `show_in_form_no_auth` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'выводить в форме регистрации: 0 - нет, 1 - да',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'подрядковый номер для сортировки',
  `required` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'обязательно для заполнения: 0 - нет, 1 - да',
  `config` text COMMENT 'серилизованные данные о настройках поля',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Дополнительные поля с данными о пользователях';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_users_param`
--

LOCK TABLES `indf_users_param` WRITE;
/*!40000 ALTER TABLE `indf_users_param` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_users_param` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_users_param_element`
--

DROP TABLE IF EXISTS `indf_users_param_element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_users_param_element` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `value` text COMMENT 'значение',
  `param_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор поля из таблицы `indf_users_param`',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор пользователя из таблицы `indf_users`',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Значения дополнительных полей с данными о пользователях';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_users_param_element`
--

LOCK TABLES `indf_users_param_element` WRITE;
/*!40000 ALTER TABLE `indf_users_param_element` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_users_param_element` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_users_param_role_rel`
--

DROP TABLE IF EXISTS `indf_users_param_role_rel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_users_param_role_rel` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `element_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор поля из таблицы `indf_users_param`',
  `role_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор типа пользователя из таблицы `indf_users_role`',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Связи дополнительных полей с данными о пользователях и типов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_users_param_role_rel`
--

LOCK TABLES `indf_users_param_role_rel` WRITE;
/*!40000 ALTER TABLE `indf_users_param_role_rel` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_users_param_role_rel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_users_param_select`
--

DROP TABLE IF EXISTS `indf_users_param_select`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_users_param_select` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `param_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор поля из таблицы `indf_users_param`',
  `value` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT 'значение для типа характеристики «галочка»: 0 - нет, 1 - да',
  `name1` varchar(50) NOT NULL DEFAULT '' COMMENT 'название',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'подрядковый номер для сортировки',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`),
  KEY `param_id` (`param_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Варианты значений дополнительных полей с данными о пользоват';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_users_param_select`
--

LOCK TABLES `indf_users_param_select` WRITE;
/*!40000 ALTER TABLE `indf_users_param_select` DISABLE KEYS */;
/*!40000 ALTER TABLE `indf_users_param_select` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_users_role`
--

DROP TABLE IF EXISTS `indf_users_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_users_role` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `name1` varchar(64) NOT NULL DEFAULT '' COMMENT 'название',
  `registration` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'задавать при регистрации: 0 - нет, 1 - да',
  `only_self` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'видеть только свои материалы: 0 - нет, 1 - да',
  `sort` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'подрядковый номер для сортировки',
  `trash` enum('0','1') NOT NULL DEFAULT '0' COMMENT 'запись удалена в корзину: 0 - нет, 1 - да',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Типы пользователей';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_users_role`
--

LOCK TABLES `indf_users_role` WRITE;
/*!40000 ALTER TABLE `indf_users_role` DISABLE KEYS */;
INSERT INTO `indf_users_role` VALUES (1,'Пользователь','1','0',1,'0'),(2,'Модератор','0','0',2,'0'),(3,'Администратор','0','0',3,'0');
/*!40000 ALTER TABLE `indf_users_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indf_users_role_perm`
--

DROP TABLE IF EXISTS `indf_users_role_perm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indf_users_role_perm` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'идентификатор',
  `role_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'идентификатор типа пользователя из таблицы `indf_users_role`',
  `perm` text COMMENT 'права на действия: all, init, edit, del',
  `rewrite` text COMMENT 'тег доступа (например, название модуля)',
  `type` enum('site','admin') NOT NULL DEFAULT 'admin' COMMENT 'часть сайта: site - пользовательская, admin - административная',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Права типов пользователей';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indf_users_role_perm`
--

LOCK TABLES `indf_users_role_perm` WRITE;
/*!40000 ALTER TABLE `indf_users_role_perm` DISABLE KEYS */;
INSERT INTO `indf_users_role_perm` VALUES (1,3,'all','all','admin'),(2,3,'edit','useradmin','site'),(3,3,'moderator','forum','site');
/*!40000 ALTER TABLE `indf_users_role_perm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parser_category`
--

DROP TABLE IF EXISTS `parser_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parser_category` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parser_category`
--

LOCK TABLES `parser_category` WRITE;
/*!40000 ALTER TABLE `parser_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `parser_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parser_clients`
--

DROP TABLE IF EXISTS `parser_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parser_clients` (
  `id` int(11) NOT NULL,
  `date` text NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parser_clients`
--

LOCK TABLES `parser_clients` WRITE;
/*!40000 ALTER TABLE `parser_clients` DISABLE KEYS */;
/*!40000 ALTER TABLE `parser_clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parser_data`
--

DROP TABLE IF EXISTS `parser_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parser_data` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `mini_description` text NOT NULL,
  `city` text NOT NULL,
  `price` int(11) NOT NULL,
  `profit` int(11) NOT NULL,
  `category` text NOT NULL,
  `images` text NOT NULL,
  `full_description` text NOT NULL,
  `type` text NOT NULL,
  `sticker` text NOT NULL,
  `clients` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_2` (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parser_data`
--

LOCK TABLES `parser_data` WRITE;
/*!40000 ALTER TABLE `parser_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `parser_data` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-06-16 17:34:43
