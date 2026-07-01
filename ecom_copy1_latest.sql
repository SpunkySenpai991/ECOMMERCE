/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-12.3.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: ecom_copy1
-- ------------------------------------------------------
-- Server version	12.3.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `Admin`
--

DROP TABLE IF EXISTS `Admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Admin` (
  `AdminID` int(11) NOT NULL AUTO_INCREMENT,
  `CreatedBySuperUserID` int(11) DEFAULT NULL,
  `LoginName` varchar(100) NOT NULL,
  `PasswordHash` varchar(255) NOT NULL,
  `FullName` varchar(150) NOT NULL,
  `Email` varchar(150) DEFAULT NULL,
  `MobileNo` varchar(20) DEFAULT NULL,
  `IsActive` tinyint(1) NOT NULL DEFAULT 0,
  `IsSuspended` tinyint(1) NOT NULL DEFAULT 0,
  `IsBlacklisted` tinyint(1) NOT NULL DEFAULT 0,
  `IsDead` tinyint(1) NOT NULL DEFAULT 0,
  `IsDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `RecordCreationTimeStamp` datetime NOT NULL DEFAULT current_timestamp(),
  `RecordCreationLogin` varchar(100) DEFAULT NULL,
  `LastUpdationTimeStamp` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `LastUpdationLogin` varchar(100) DEFAULT NULL,
  `Gender` enum('M','F','O') DEFAULT NULL,
  `DoB` date DEFAULT NULL,
  `Rank` int(11) NOT NULL DEFAULT 0,
  `VerificationTimeStamp` datetime DEFAULT NULL,
  `ActivationTimeStamp` datetime DEFAULT NULL,
  `SuspensionTimeStamp` datetime DEFAULT NULL,
  `BlacklistTimeStamp` datetime DEFAULT NULL,
  `DeadTimeStamp` datetime DEFAULT NULL,
  PRIMARY KEY (`AdminID`),
  UNIQUE KEY `LoginName` (`LoginName`),
  KEY `FK_Admin_SuperUser` (`CreatedBySuperUserID`),
  CONSTRAINT `FK_Admin_SuperUser` FOREIGN KEY (`CreatedBySuperUserID`) REFERENCES `superuser` (`SuperUserID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Admin`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `Admin` WRITE;
/*!40000 ALTER TABLE `Admin` DISABLE KEYS */;
INSERT INTO `Admin` VALUES
(1,1,'aadi','1234','Aditya Jha','aditya7400jha@gmail.com','8090279212',1,0,0,0,0,'2026-06-29 21:40:18','System Admin','2026-06-29 21:40:29',NULL,'M','2004-12-22',0,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `Admin` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `Brand`
--

DROP TABLE IF EXISTS `Brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Brand` (
  `BrandID` int(11) NOT NULL AUTO_INCREMENT,
  `CompanyID` int(11) NOT NULL,
  `BrandName` varchar(150) NOT NULL,
  `IsDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `RecordCreationTimeStamp` datetime NOT NULL DEFAULT current_timestamp(),
  `RecordCreationLogin` varchar(100) DEFAULT NULL,
  `LastUpdationTimeStamp` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `LastUpdationLogin` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`BrandID`),
  UNIQUE KEY `UQ_Brand` (`CompanyID`,`BrandName`),
  CONSTRAINT `FK_Brand_Company` FOREIGN KEY (`CompanyID`) REFERENCES `company` (`CompanyID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Brand`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `Brand` WRITE;
/*!40000 ALTER TABLE `Brand` DISABLE KEYS */;
INSERT INTO `Brand` VALUES
(1,1,'Apple',0,'2026-07-01 00:13:18',NULL,NULL,NULL),
(2,2,'Samsung',0,'2026-07-01 00:13:18',NULL,NULL,NULL),
(3,3,'Nike',0,'2026-07-01 00:13:18',NULL,NULL,NULL),
(4,4,'Tata Sampann',0,'2026-07-01 00:13:18',NULL,NULL,NULL),
(5,5,'Sony',0,'2026-07-01 00:37:40',NULL,NULL,NULL),
(6,6,'HP',0,'2026-07-01 00:37:40',NULL,NULL,NULL),
(7,7,'Levis',0,'2026-07-01 00:37:40',NULL,NULL,NULL),
(8,8,'LG',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(9,9,'Dell',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(10,10,'Adidas',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(11,11,'L\'Oreal Paris',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(12,12,'Dyson',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(13,13,'Asus ROG',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(14,14,'Puma',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(15,15,'Xbox',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(16,9,'Alienware',0,'2026-07-01 02:27:05',NULL,NULL,NULL);
/*!40000 ALTER TABLE `Brand` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `Color`
--

DROP TABLE IF EXISTS `Color`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Color` (
  `ColorID` int(11) NOT NULL AUTO_INCREMENT,
  `ColorName` varchar(100) NOT NULL,
  `IsDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `RecordCreationTimeStamp` datetime NOT NULL DEFAULT current_timestamp(),
  `RecordCreationLogin` varchar(100) DEFAULT NULL,
  `LastUpdationTimeStamp` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `LastUpdationLogin` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ColorID`),
  UNIQUE KEY `ColorName` (`ColorName`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Color`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `Color` WRITE;
/*!40000 ALTER TABLE `Color` DISABLE KEYS */;
INSERT INTO `Color` VALUES
(1,'Black',0,'2026-07-01 00:13:17',NULL,NULL,NULL),
(2,'White',0,'2026-07-01 00:13:17',NULL,NULL,NULL),
(3,'Blue',0,'2026-07-01 00:13:17',NULL,NULL,NULL),
(4,'Red',0,'2026-07-01 00:13:17',NULL,NULL,NULL),
(5,'Silver',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(6,'Space Grey',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(7,'Midnight',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(8,'Starlight',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(9,'Titanium',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(10,'Pink',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(11,'Green',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(12,'Yellow',0,'2026-07-01 02:27:05',NULL,NULL,NULL);
/*!40000 ALTER TABLE `Color` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `Company`
--

DROP TABLE IF EXISTS `Company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Company` (
  `CompanyID` int(11) NOT NULL AUTO_INCREMENT,
  `CompanyName` varchar(150) NOT NULL,
  `IsDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `RecordCreationTimeStamp` datetime NOT NULL DEFAULT current_timestamp(),
  `RecordCreationLogin` varchar(100) DEFAULT NULL,
  `LastUpdationTimeStamp` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `LastUpdationLogin` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`CompanyID`),
  UNIQUE KEY `CompanyName` (`CompanyName`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Company`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `Company` WRITE;
/*!40000 ALTER TABLE `Company` DISABLE KEYS */;
INSERT INTO `Company` VALUES
(1,'Apple Inc',0,'2026-07-01 00:13:18',NULL,NULL,NULL),
(2,'Samsung Electronics',0,'2026-07-01 00:13:18',NULL,NULL,NULL),
(3,'Nike',0,'2026-07-01 00:13:18',NULL,NULL,NULL),
(4,'Tata Consumer Products',0,'2026-07-01 00:13:18',NULL,NULL,NULL),
(5,'Sony',0,'2026-07-01 00:37:40',NULL,NULL,NULL),
(6,'HP',0,'2026-07-01 00:37:40',NULL,NULL,NULL),
(7,'Levi Strauss',0,'2026-07-01 00:37:40',NULL,NULL,NULL),
(8,'LG Electronics',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(9,'Dell Technologies',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(10,'Adidas AG',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(11,'L\'Oreal S.A.',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(12,'Dyson Ltd',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(13,'AsusTek Computer Inc',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(14,'Puma SE',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(15,'Microsoft Corporation',0,'2026-07-01 02:27:05',NULL,NULL,NULL);
/*!40000 ALTER TABLE `Company` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `Continent`
--

DROP TABLE IF EXISTS `Continent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Continent` (
  `ContinentID` int(11) NOT NULL AUTO_INCREMENT,
  `ContinentName` varchar(100) NOT NULL,
  `IsDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `RecordCreationTimeStamp` datetime NOT NULL DEFAULT current_timestamp(),
  `RecordCreationLogin` varchar(100) DEFAULT NULL,
  `LastUpdationTimeStamp` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `LastUpdationLogin` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ContinentID`),
  UNIQUE KEY `ContinentName` (`ContinentName`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Continent`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `Continent` WRITE;
/*!40000 ALTER TABLE `Continent` DISABLE KEYS */;
INSERT INTO `Continent` VALUES
(1,'Asia',0,'2026-06-29 22:17:03','Aditya Jha',NULL,NULL),
(2,'Australia',0,'2026-06-29 22:17:32','Aditya Jha','2026-06-29 22:43:53',NULL),
(3,'North America',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(4,'Europe',0,'2026-07-01 02:27:05',NULL,NULL,NULL);
/*!40000 ALTER TABLE `Continent` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `Country`
--

DROP TABLE IF EXISTS `Country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Country` (
  `CountryID` int(11) NOT NULL AUTO_INCREMENT,
  `ContinentID` int(11) NOT NULL,
  `CountryName` varchar(100) NOT NULL,
  `IsDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `RecordCreationTimeStamp` datetime NOT NULL DEFAULT current_timestamp(),
  `RecordCreationLogin` varchar(100) DEFAULT NULL,
  `LastUpdationTimeStamp` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `LastUpdationLogin` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`CountryID`),
  UNIQUE KEY `UQ_Country` (`ContinentID`,`CountryName`),
  CONSTRAINT `FK_Country_Continent` FOREIGN KEY (`ContinentID`) REFERENCES `continent` (`ContinentID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Country`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `Country` WRITE;
/*!40000 ALTER TABLE `Country` DISABLE KEYS */;
INSERT INTO `Country` VALUES
(1,1,'India',0,'2026-06-29 22:17:49','Aditya Jha',NULL,NULL),
(2,3,'United States',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(3,4,'United Kingdom',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(4,4,'Germany',0,'2026-07-01 02:27:05',NULL,NULL,NULL);
/*!40000 ALTER TABLE `Country` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `Currency`
--

DROP TABLE IF EXISTS `Currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Currency` (
  `CurrencyID` int(11) NOT NULL AUTO_INCREMENT,
  `CurrencyName` varchar(100) NOT NULL,
  `CurrencyCode` varchar(10) NOT NULL,
  `CurrencySymbol` varchar(10) DEFAULT NULL,
  `IsDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `RecordCreationTimeStamp` datetime NOT NULL DEFAULT current_timestamp(),
  `RecordCreationLogin` varchar(100) DEFAULT NULL,
  `LastUpdationTimeStamp` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `LastUpdationLogin` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`CurrencyID`),
  UNIQUE KEY `CurrencyCode` (`CurrencyCode`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Currency`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `Currency` WRITE;
/*!40000 ALTER TABLE `Currency` DISABLE KEYS */;
INSERT INTO `Currency` VALUES
(1,'Indian Rupee','INR','₹',0,'2026-07-01 00:13:17',NULL,NULL,NULL),
(2,'US Dollar','USD','$',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(3,'Euro','EUR','€',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(4,'British Pound','GBP','£',0,'2026-07-01 02:27:05',NULL,NULL,NULL);
/*!40000 ALTER TABLE `Currency` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `Customer`
--

DROP TABLE IF EXISTS `Customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Customer` (
  `CustomerID` int(11) NOT NULL AUTO_INCREMENT,
  `LoginName` varchar(100) NOT NULL,
  `PasswordHash` varchar(255) NOT NULL,
  `FullName` varchar(150) NOT NULL,
  `Email` varchar(150) DEFAULT NULL,
  `MobileNo` varchar(20) DEFAULT NULL,
  `AddressLine` varchar(255) DEFAULT NULL,
  `LocalityID` int(11) DEFAULT NULL,
  `IsActive` tinyint(1) NOT NULL DEFAULT 1,
  `IsSuspended` tinyint(1) NOT NULL DEFAULT 0,
  `IsBlacklisted` tinyint(1) NOT NULL DEFAULT 0,
  `IsDead` tinyint(1) NOT NULL DEFAULT 0,
  `IsDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `RecordCreationTimeStamp` datetime NOT NULL DEFAULT current_timestamp(),
  `RecordCreationLogin` varchar(100) DEFAULT NULL,
  `LastUpdationTimeStamp` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `LastUpdationLogin` varchar(100) DEFAULT NULL,
  `Gender` enum('M','F','O') DEFAULT NULL,
  `DoB` date DEFAULT NULL,
  `Rank` int(11) NOT NULL DEFAULT 0,
  `VerificationTimeStamp` datetime DEFAULT NULL,
  `ActivationTimeStamp` datetime DEFAULT NULL,
  `SuspensionTimeStamp` datetime DEFAULT NULL,
  `BlacklistTimeStamp` datetime DEFAULT NULL,
  `DeadTimeStamp` datetime DEFAULT NULL,
  PRIMARY KEY (`CustomerID`),
  UNIQUE KEY `LoginName` (`LoginName`),
  KEY `IX_Customer_LocalityID` (`LocalityID`),
  CONSTRAINT `FK_Customer_Locality` FOREIGN KEY (`LocalityID`) REFERENCES `locality` (`LocalityID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customer`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `Customer` WRITE;
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
INSERT INTO `Customer` VALUES
(1,'customer0','cust1','jake paul','qwerty1234@gmail.com',NULL,NULL,NULL,1,0,0,0,0,'2026-06-30 23:53:24',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `District`
--

DROP TABLE IF EXISTS `District`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `District` (
  `DistrictID` int(11) NOT NULL AUTO_INCREMENT,
  `StateID` int(11) NOT NULL,
  `DistrictName` varchar(100) NOT NULL,
  `IsDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `RecordCreationTimeStamp` datetime NOT NULL DEFAULT current_timestamp(),
  `RecordCreationLogin` varchar(100) DEFAULT NULL,
  `LastUpdationTimeStamp` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `LastUpdationLogin` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`DistrictID`),
  UNIQUE KEY `UQ_District` (`StateID`,`DistrictName`),
  CONSTRAINT `FK_District_State` FOREIGN KEY (`StateID`) REFERENCES `state` (`StateID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `District`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `District` WRITE;
/*!40000 ALTER TABLE `District` DISABLE KEYS */;
INSERT INTO `District` VALUES
(1,1,'Kanpur Nagar',0,'2026-07-01 00:13:17',NULL,NULL,NULL),
(2,1,'Lucknow',0,'2026-07-01 00:13:17',NULL,NULL,NULL),
(3,4,'Los Angeles County',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(4,5,'Manhattan',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(5,6,'Greater London',0,'2026-07-01 02:27:05',NULL,NULL,NULL);
/*!40000 ALTER TABLE `District` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `Feedback`
--

DROP TABLE IF EXISTS `Feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Feedback` (
  `FeedbackID` int(11) NOT NULL AUTO_INCREMENT,
  `PurchaseID` int(11) NOT NULL,
  `CustomerID` int(11) NOT NULL,
  `ProductRating` tinyint(4) DEFAULT NULL,
  `SellerRating` tinyint(4) DEFAULT NULL,
  `CourierRating` tinyint(4) DEFAULT NULL,
  `FeedbackText` text DEFAULT NULL,
  `IsDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `RecordCreationTimeStamp` datetime NOT NULL DEFAULT current_timestamp(),
  `RecordCreationLogin` varchar(100) DEFAULT NULL,
  `LastUpdationTimeStamp` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `LastUpdationLogin` varchar(100) DEFAULT NULL,
  `Image1` varchar(255) DEFAULT NULL,
  `Image2` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`FeedbackID`),
  UNIQUE KEY `UQ_Feedback_Purchase` (`PurchaseID`),
  KEY `FK_Feedback_Purchase` (`PurchaseID`),
  KEY `FK_Feedback_Customer` (`CustomerID`),
  CONSTRAINT `FK_Feedback_Customer` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`),
  CONSTRAINT `FK_Feedback_Purchase` FOREIGN KEY (`PurchaseID`) REFERENCES `purchase` (`PurchaseID`),
  CONSTRAINT `CK_Feedback_ProductRating` CHECK (`ProductRating` is null or `ProductRating` between 1 and 5),
  CONSTRAINT `CK_Feedback_SellerRating` CHECK (`SellerRating` is null or `SellerRating` between 1 and 5),
  CONSTRAINT `CK_Feedback_CourierRating` CHECK (`CourierRating` is null or `CourierRating` between 1 and 5)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Feedback`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `Feedback` WRITE;
/*!40000 ALTER TABLE `Feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `Feedback` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `Locality`
--

DROP TABLE IF EXISTS `Locality`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Locality` (
  `LocalityID` int(11) NOT NULL AUTO_INCREMENT,
  `DistrictID` int(11) NOT NULL,
  `LocalityName` varchar(150) NOT NULL,
  `PinCode` varchar(20) NOT NULL,
  `IsDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `RecordCreationTimeStamp` datetime NOT NULL DEFAULT current_timestamp(),
  `RecordCreationLogin` varchar(100) DEFAULT NULL,
  `LastUpdationTimeStamp` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `LastUpdationLogin` varchar(100) DEFAULT NULL,
  `IsCity` tinyint(1) NOT NULL DEFAULT 0,
  `IsTown` tinyint(1) NOT NULL DEFAULT 0,
  `IsVillage` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`LocalityID`),
  UNIQUE KEY `UQ_Locality` (`DistrictID`,`LocalityName`,`PinCode`),
  CONSTRAINT `FK_Locality_District` FOREIGN KEY (`DistrictID`) REFERENCES `district` (`DistrictID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Locality`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `Locality` WRITE;
/*!40000 ALTER TABLE `Locality` DISABLE KEYS */;
INSERT INTO `Locality` VALUES
(1,1,'Kakadeo','208025',0,'2026-07-01 00:13:17',NULL,'2026-07-01 12:08:02',NULL,0,0,0),
(2,1,'Kalyanpur','208017',0,'2026-07-01 00:13:17',NULL,NULL,NULL,0,0,0),
(3,1,'Swaroop Nagar','208002',0,'2026-07-01 00:13:17',NULL,NULL,NULL,0,0,0),
(4,1,'Kidwai Nagar','208011',0,'2026-07-01 00:13:17',NULL,NULL,NULL,0,0,0),
(5,3,'Beverly Hills','90210',0,'2026-07-01 02:27:05',NULL,NULL,NULL,1,0,0),
(6,4,'Times Square','10036',0,'2026-07-01 02:27:05',NULL,NULL,NULL,1,0,0),
(7,5,'Westminster','SW1A',0,'2026-07-01 02:27:05',NULL,NULL,NULL,1,0,0);
/*!40000 ALTER TABLE `Locality` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `Material`
--

DROP TABLE IF EXISTS `Material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Material` (
  `MaterialID` int(11) NOT NULL AUTO_INCREMENT,
  `MaterialName` varchar(100) NOT NULL,
  `IsDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `RecordCreationTimeStamp` datetime NOT NULL DEFAULT current_timestamp(),
  `RecordCreationLogin` varchar(100) DEFAULT NULL,
  `LastUpdationTimeStamp` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `LastUpdationLogin` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`MaterialID`),
  UNIQUE KEY `MaterialName` (`MaterialName`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Material`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `Material` WRITE;
/*!40000 ALTER TABLE `Material` DISABLE KEYS */;
INSERT INTO `Material` VALUES
(1,'Cotton',0,'2026-07-01 00:13:17',NULL,NULL,NULL),
(2,'Leather',0,'2026-07-01 00:13:17',NULL,NULL,NULL),
(3,'Plastic',0,'2026-07-01 00:13:17',NULL,NULL,NULL),
(4,'Metal',0,'2026-07-01 00:13:17',NULL,NULL,NULL),
(5,'Denim',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(6,'Polyester',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(7,'Aluminum',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(8,'Titanium',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(9,'Glass',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(10,'Ceramic',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(11,'Nylon',0,'2026-07-01 02:27:05',NULL,NULL,NULL);
/*!40000 ALTER TABLE `Material` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `Model`
--

DROP TABLE IF EXISTS `Model`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Model` (
  `ModelID` int(11) NOT NULL AUTO_INCREMENT,
  `BrandID` int(11) NOT NULL,
  `ModelName` varchar(150) NOT NULL,
  `IsDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `RecordCreationTimeStamp` datetime NOT NULL DEFAULT current_timestamp(),
  `RecordCreationLogin` varchar(100) DEFAULT NULL,
  `LastUpdationTimeStamp` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `LastUpdationLogin` varchar(100) DEFAULT NULL,
  `Dimensions` varchar(50) DEFAULT NULL,
  `Weight` varchar(50) DEFAULT NULL,
  `IsWaterResistant` tinyint(1) NOT NULL DEFAULT 0,
  `IsFireProof` tinyint(1) NOT NULL DEFAULT 0,
  `IsEcoFriendly` tinyint(1) NOT NULL DEFAULT 0,
  `IsRecyclable` tinyint(1) NOT NULL DEFAULT 0,
  `IsHazardous` tinyint(1) NOT NULL DEFAULT 0,
  `IsFlammable` tinyint(1) NOT NULL DEFAULT 0,
  `Warranty` varchar(50) DEFAULT NULL,
  `Guarantee` varchar(50) DEFAULT NULL,
  `SpecsJSON` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`SpecsJSON`)),
  `OtherSpecs` text DEFAULT NULL,
  `UserManual` varchar(255) DEFAULT NULL,
  `TechnicalManual` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ModelID`),
  UNIQUE KEY `UQ_Model` (`BrandID`,`ModelName`),
  CONSTRAINT `FK_Model_Brand` FOREIGN KEY (`BrandID`) REFERENCES `brand` (`BrandID`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Model`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `Model` WRITE;
/*!40000 ALTER TABLE `Model` DISABLE KEYS */;
INSERT INTO `Model` VALUES
(1,1,'iPhone 15 Pro',0,'2026-07-01 00:13:18',NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL),
(2,1,'MacBook Air M2',0,'2026-07-01 00:13:18',NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL),
(3,2,'Galaxy S24 Ultra',0,'2026-07-01 00:13:18',NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL),
(4,2,'Galaxy Watch 6',0,'2026-07-01 00:13:18',NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL),
(5,3,'Air Force 1',0,'2026-07-01 00:13:18',NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL),
(6,3,'Air Max 90',0,'2026-07-01 00:13:18',NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL),
(7,4,'Premium Basmati Rice',0,'2026-07-01 00:13:18',NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL),
(8,4,'Unpolished Dal',0,'2026-07-01 00:13:18',NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL),
(9,5,'PlayStation 5',0,'2026-07-01 00:37:40',NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL),
(10,5,'WH-1000XM5',0,'2026-07-01 00:37:40',NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL),
(11,6,'Pavilion 15',0,'2026-07-01 00:37:40',NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL),
(12,7,'501 Original Fit',0,'2026-07-01 00:37:40',NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL),
(13,8,'OLED C3 Series',0,'2026-07-01 02:27:05',NULL,NULL,NULL,'144.1 x 82.6 x 4.5 cm','16.6 kg',0,0,0,0,0,0,'1 Year',NULL,'{\"Resolution\": \"4K UHD\", \"RefreshRate\": \"120Hz\", \"SmartTV\": \"WebOS 23\"}',NULL,NULL,NULL),
(14,9,'XPS 15',0,'2026-07-01 02:27:05',NULL,NULL,NULL,'34.4 x 23.0 x 1.8 cm','1.92 kg',0,0,0,0,0,0,'1 Year',NULL,'{\"Processor\": \"Intel Core i7 13th Gen\", \"Display\": \"15.6 inch FHD+\", \"Graphics\": \"NVIDIA RTX 4050\"}',NULL,NULL,NULL),
(15,16,'Alienware m18',0,'2026-07-01 02:27:05',NULL,NULL,NULL,'41.0 x 31.9 x 2.6 cm','4.04 kg',0,0,0,0,0,0,'1 Year Premium',NULL,'{\"Processor\": \"Intel Core i9 13980HX\", \"Display\": \"18 inch QHD+ 165Hz\", \"Graphics\": \"NVIDIA RTX 4090\"}',NULL,NULL,NULL),
(16,10,'Ultraboost Light',0,'2026-07-01 02:27:05',NULL,NULL,NULL,NULL,'299 g',0,0,0,0,0,0,NULL,NULL,'{\"Drop\": \"10mm\", \"Midsole\": \"Light BOOST\", \"Upper\": \"Primeknit+\"}',NULL,NULL,NULL),
(17,10,'Stan Smith',0,'2026-07-01 02:27:05',NULL,NULL,NULL,NULL,'350 g',0,0,0,0,0,0,NULL,NULL,'{\"Upper\": \"Synthetic Vegan Leather\", \"Outsole\": \"Rubber\"}',NULL,NULL,NULL),
(18,11,'Revitalift Hyaluronic Acid',0,'2026-07-01 02:27:05',NULL,NULL,NULL,'4 x 4 x 10 cm','30 ml',0,0,0,0,0,0,NULL,NULL,'{\"ActiveIngredient\": \"1.5% Hyaluronic Acid\", \"SkinType\": \"All Skin Types\"}',NULL,NULL,NULL),
(19,12,'V15 Detect Absolute',0,'2026-07-01 02:27:05',NULL,NULL,NULL,'126 x 25 x 26 cm','3.1 kg',0,0,0,0,0,0,'2 Years',NULL,'{\"SuctionPower\": \"240 AW\", \"BinVolume\": \"0.77L\", \"RunTime\": \"60 mins\", \"Filtration\": \"Whole-machine HEPA\"}',NULL,NULL,NULL),
(20,12,'Airwrap Multi-styler',0,'2026-07-01 02:27:05',NULL,NULL,NULL,'4.1 x 4.8 x 27.2 cm','660 g',0,0,0,0,0,0,'2 Years',NULL,'{\"Airflow\": \"13.5 l/s\", \"Wattage\": \"1300W\", \"Settings\": \"3 Heat, 3 Speed\"}',NULL,NULL,NULL),
(21,15,'PlayStation 5 Console',0,'2026-07-01 02:27:05',NULL,NULL,NULL,'39 x 10.4 x 26 cm','4.5 kg',0,0,0,0,0,0,'1 Year',NULL,'{\"CPU\": \"AMD Ryzen Zen 2\", \"GPU\": \"RDNA 2\", \"Storage\": \"825GB Custom SSD\", \"MaxResolution\": \"8K\"}',NULL,NULL,NULL),
(22,1,'AirPods Pro (2nd Gen)',0,'2026-07-01 02:27:05',NULL,NULL,NULL,'4.5 x 6.0 x 2.1 cm','50.8 g',0,0,0,0,0,0,'1 Year',NULL,'{\"Chip\": \"H2 Headphone Chip\", \"Battery\": \"Up to 30 hours with case\", \"Features\": \"Active Noise Cancellation, Transparency Mode\"}',NULL,NULL,NULL),
(23,1,'Apple Watch Ultra 2',0,'2026-07-01 02:27:05',NULL,NULL,NULL,'49 x 44 x 14.4 mm','61.4 g',0,0,0,0,0,0,'1 Year',NULL,'{\"Case\": \"Aerospace-grade Titanium\", \"Display\": \"Always-On Retina up to 3000 nits\", \"WaterResistance\": \"100m\"}',NULL,NULL,NULL),
(24,13,'ROG Zephyrus G14',0,'2026-07-01 02:27:05',NULL,NULL,NULL,'31.2 x 22.7 x 1.9 cm','1.65 kg',0,0,0,0,0,0,'1 Year',NULL,'{\"Processor\": \"AMD Ryzen 9 7940HS\", \"Display\": \"14 inch ROG Nebula HDR\", \"Graphics\": \"NVIDIA RTX 4060\"}',NULL,NULL,NULL),
(25,2,'Galaxy Z Flip 5',0,'2026-07-01 02:27:05',NULL,NULL,NULL,'16.5 x 7.1 x 0.6 cm','187 g',0,0,0,0,0,0,'1 Year',NULL,'{\"MainDisplay\": \"6.7 inch Dynamic AMOLED 2X\", \"CoverDisplay\": \"3.4 inch Super AMOLED\", \"Processor\": \"Snapdragon 8 Gen 2\"}',NULL,NULL,NULL),
(26,14,'Suede Classic XXI',0,'2026-07-01 02:27:05',NULL,NULL,NULL,NULL,'320 g',0,0,0,0,0,0,NULL,NULL,'{\"Upper\": \"Suede\", \"Outsole\": \"Rubber\", \"Style\": \"Streetwear\"}',NULL,NULL,NULL);
/*!40000 ALTER TABLE `Model` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `Product`
--

DROP TABLE IF EXISTS `Product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Product` (
  `ProductID` int(11) NOT NULL AUTO_INCREMENT,
  `ProductSubSubCategoryID` int(11) NOT NULL,
  `ModelID` int(11) NOT NULL,
  `ProductName` varchar(200) NOT NULL,
  `ProductDescription` text DEFAULT NULL,
  `ColorID` int(11) DEFAULT NULL,
  `ShapeID` int(11) DEFAULT NULL,
  `SizeID` int(11) DEFAULT NULL,
  `UnitID` int(11) DEFAULT NULL,
  `MaterialID` int(11) DEFAULT NULL,
  `Attributes_JSON` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`Attributes_JSON`)),
  `ProductDisplayName_Gen` varchar(300) DEFAULT NULL,
  `IsDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `RecordCreationTimeStamp` datetime NOT NULL DEFAULT current_timestamp(),
  `RecordCreationLogin` varchar(100) DEFAULT NULL,
  `LastUpdationTimeStamp` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `LastUpdationLogin` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ProductID`),
  KEY `FK_Product_Color` (`ColorID`),
  KEY `FK_Product_Shape` (`ShapeID`),
  KEY `FK_Product_Size` (`SizeID`),
  KEY `FK_Product_Unit` (`UnitID`),
  KEY `FK_Product_Material` (`MaterialID`),
  KEY `IX_Product_Category` (`ProductSubSubCategoryID`),
  KEY `IX_Product_Model` (`ModelID`),
  CONSTRAINT `FK_Product_Color` FOREIGN KEY (`ColorID`) REFERENCES `color` (`ColorID`),
  CONSTRAINT `FK_Product_Material` FOREIGN KEY (`MaterialID`) REFERENCES `material` (`MaterialID`),
  CONSTRAINT `FK_Product_Model` FOREIGN KEY (`ModelID`) REFERENCES `model` (`ModelID`),
  CONSTRAINT `FK_Product_Shape` FOREIGN KEY (`ShapeID`) REFERENCES `shape` (`ShapeID`),
  CONSTRAINT `FK_Product_Size` FOREIGN KEY (`SizeID`) REFERENCES `size` (`SizeID`),
  CONSTRAINT `FK_Product_SubSubCategory` FOREIGN KEY (`ProductSubSubCategoryID`) REFERENCES `productsubsubcategory` (`ProductSubSubCategoryID`),
  CONSTRAINT `FK_Product_Unit` FOREIGN KEY (`UnitID`) REFERENCES `unit` (`UnitID`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Product`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `Product` WRITE;
/*!40000 ALTER TABLE `Product` DISABLE KEYS */;
INSERT INTO `Product` VALUES
(1,1,1,'Apple iPhone 15 Pro (256GB)','The latest titanium iPhone with A17 Pro chip and incredible camera system.',1,NULL,NULL,1,NULL,'{\"Storage\": \"256GB\", \"RAM\": \"8GB\"}',NULL,0,'2026-07-01 00:13:18',NULL,'2026-07-01 12:09:12',NULL),
(2,2,2,'MacBook Air M2 (8GB/512GB)','Supercharged by M2. Strikingly thin and fast laptop for everyday use.',2,NULL,NULL,1,NULL,'{\"Screen\": \"13.6 inch\", \"Battery\": \"18 Hours\"}',NULL,0,'2026-07-01 00:13:18',NULL,NULL,NULL),
(3,1,3,'Samsung Galaxy S24 Ultra','AI-powered smartphone with S-Pen, massive battery, and 200MP camera.',1,NULL,NULL,1,NULL,'{\"Storage\": \"512GB\"}',NULL,0,'2026-07-01 00:13:18',NULL,NULL,NULL),
(4,3,5,'Nike Air Force 1 07','Classic white sneakers for men. Durable and timeless style.',2,NULL,NULL,2,NULL,'{\"Style\": \"Casual\"}',NULL,0,'2026-07-01 00:13:18',NULL,NULL,NULL),
(5,3,6,'Nike Air Max 90','Running shoes with maximum cushioning and iconic waffle outsole.',1,NULL,NULL,2,NULL,'{\"Style\": \"Sport\"}',NULL,0,'2026-07-01 00:13:18',NULL,NULL,NULL),
(6,4,7,'Tata Sampann Basmati Rice','Long grain, highly aromatic Basmati rice straight from the farms.',NULL,NULL,NULL,3,NULL,'{\"Weight\": \"5kg\"}',NULL,0,'2026-07-01 00:13:18',NULL,NULL,NULL),
(7,5,8,'Tata Sampann Toor Dal','Unpolished, rich in protein, pure Toor Dal.',NULL,NULL,NULL,3,NULL,'{\"Weight\": \"1kg\"}',NULL,0,'2026-07-01 00:13:18',NULL,NULL,NULL),
(8,2,11,'HP Pavilion 15 Laptop','Intel Core i5, 16GB RAM, 512GB SSD. Great for students.',2,NULL,NULL,1,NULL,NULL,NULL,0,'2026-07-01 00:37:40',NULL,NULL,NULL),
(9,1,3,'Samsung Galaxy S23','Compact flagship with amazing cameras.',3,NULL,NULL,1,NULL,NULL,NULL,0,'2026-07-01 00:37:40',NULL,NULL,NULL),
(10,3,5,'Nike Air Zoom Pegasus','Responsive running shoe for everyday training.',1,NULL,NULL,2,NULL,NULL,NULL,0,'2026-07-01 00:37:40',NULL,NULL,NULL),
(11,4,7,'India Gate Basmati Rice','Classic long grain rice.',NULL,NULL,NULL,3,NULL,NULL,NULL,0,'2026-07-01 00:37:40',NULL,NULL,NULL),
(12,5,8,'Aashirvaad Atta','100% whole wheat chakki atta.',NULL,NULL,NULL,3,NULL,NULL,NULL,0,'2026-07-01 00:37:40',NULL,NULL,NULL),
(13,2,2,'MacBook Pro 14-inch','M3 Pro chip, 18GB RAM. For professionals.',1,NULL,NULL,1,NULL,NULL,NULL,0,'2026-07-01 00:37:40',NULL,NULL,NULL),
(14,1,1,'Apple iPhone 14','Previous generation, still blazing fast.',4,NULL,NULL,1,NULL,NULL,NULL,0,'2026-07-01 00:37:40',NULL,NULL,NULL),
(15,3,6,'Nike Jordan 1 Retro','Classic basketball sneakers.',4,NULL,NULL,2,NULL,NULL,NULL,0,'2026-07-01 00:37:40',NULL,NULL,NULL),
(16,4,7,'Fortune Soya Chunks','High protein diet staples.',NULL,NULL,NULL,3,NULL,NULL,NULL,0,'2026-07-01 00:37:40',NULL,NULL,NULL),
(17,5,8,'Tata Salt','Vacuum evaporated iodized salt.',NULL,NULL,NULL,3,NULL,NULL,NULL,0,'2026-07-01 00:37:40',NULL,NULL,NULL),
(18,1,1,'Apple iPhone 15 (128GB)','Base model with Dynamic Island.',3,NULL,NULL,1,NULL,NULL,NULL,0,'2026-07-01 00:37:40',NULL,NULL,NULL),
(19,1,3,'Samsung Galaxy Z Fold 5','Premium foldable smartphone experience.',1,NULL,NULL,1,NULL,NULL,NULL,0,'2026-07-01 00:37:40',NULL,NULL,NULL),
(20,1,1,'Apple iPhone 13','Best value Apple phone right now.',2,NULL,NULL,1,NULL,NULL,NULL,0,'2026-07-01 00:37:40',NULL,NULL,NULL),
(21,2,11,'HP Envy x360','Touchscreen 2-in-1 laptop.',2,NULL,NULL,1,NULL,NULL,NULL,0,'2026-07-01 00:37:40',NULL,NULL,NULL),
(22,3,5,'Nike Court Vision','Retro hoops inspired sneakers.',2,NULL,NULL,2,NULL,NULL,NULL,0,'2026-07-01 00:37:40',NULL,NULL,NULL),
(23,4,7,'Daawat Brown Rice','Healthy whole grain brown rice.',NULL,NULL,NULL,3,NULL,NULL,NULL,0,'2026-07-01 00:37:40',NULL,NULL,NULL),
(24,5,8,'Catch Turmeric Powder','Pure haldi for everyday cooking.',NULL,NULL,NULL,4,NULL,NULL,NULL,0,'2026-07-01 00:37:40',NULL,NULL,NULL),
(25,5,8,'Everest Garam Masala','Aromatic spice blend.',NULL,NULL,NULL,4,NULL,NULL,NULL,0,'2026-07-01 00:37:40',NULL,NULL,NULL),
(26,3,5,'Nike Revolution 6','Affordable running and gym wear.',1,NULL,NULL,2,NULL,NULL,NULL,0,'2026-07-01 00:37:40',NULL,NULL,NULL),
(27,2,2,'MacBook Air M1','The laptop that changed the industry.',2,NULL,NULL,1,NULL,NULL,NULL,0,'2026-07-01 00:37:40',NULL,NULL,NULL),
(28,2,14,'Dell XPS 15 9530 Creator Laptop','A perfect balance of power and portability for creators, featuring a stunning InfinityEdge display.',5,1,11,1,7,'{\"RAM\": \"16GB DDR5\", \"Storage\": \"1TB PCIe NVMe SSD\", \"OS\": \"Windows 11 Home\"}',NULL,0,'2026-07-01 02:36:30',NULL,NULL,NULL),
(29,2,15,'Alienware m18 Gaming Beast','Uncompromising gaming performance with desktop-class cooling and graphics.',7,1,11,1,7,'{\"RAM\": \"32GB DDR5\", \"Storage\": \"2TB NVMe SSD\", \"Keyboard\": \"CherryMX Mechanical\"}',NULL,0,'2026-07-01 02:36:30',NULL,NULL,NULL),
(30,2,24,'Asus ROG Zephyrus G14 (White)','The world\'s most powerful 14-inch gaming laptop, now featuring the AniMe Matrix display.',2,1,10,1,7,'{\"RAM\": \"16GB\", \"Storage\": \"1TB NVMe SSD\", \"RefreshRate\": \"165Hz\"}',NULL,0,'2026-07-01 02:36:30',NULL,NULL,NULL),
(31,9,13,'LG 65-inch OLED C3 4K Smart TV','Experience brilliant OLED picture quality with self-lit pixels and the advanced a9 AI Processor Gen6.',1,1,12,1,9,'{\"ScreenSize\": \"65 inches\", \"Audio\": \"Dolby Atmos 40W\", \"Connectivity\": \"4 HDMI 2.1, 3 USB\"}',NULL,0,'2026-07-01 02:36:30',NULL,NULL,NULL),
(32,9,13,'LG 55-inch OLED C3 4K Smart TV','Perfectly sized OLED for your living room, featuring gaming optimization and WebOS.',1,1,13,1,9,'{\"ScreenSize\": \"55 inches\", \"Audio\": \"Dolby Atmos 40W\"}',NULL,0,'2026-07-01 02:36:30',NULL,NULL,NULL),
(33,8,23,'Apple Watch Ultra 2 (Titanium/Blue Alpine)','The most rugged and capable Apple Watch ever, designed for exploration, adventure, and endurance.',3,4,1,1,8,'{\"Band\": \"Blue Alpine Loop\", \"Connectivity\": \"GPS + Cellular\"}',NULL,0,'2026-07-01 02:36:30',NULL,NULL,NULL),
(34,6,22,'Apple AirPods Pro (2nd Generation)','Re-engineered for even richer audio, next-level Active Noise Cancellation, and Adaptive Transparency.',2,NULL,NULL,2,3,'{\"ChargingCase\": \"MagSafe (USB-C)\", \"SweatAndWaterResistant\": \"IP54\"}',NULL,0,'2026-07-01 02:36:30',NULL,NULL,NULL),
(35,1,25,'Samsung Galaxy Z Flip 5 (Mint)','The ultimate pocketable self-expression tool. Flex window allows you to reply to messages without opening the phone.',11,1,NULL,1,9,'{\"Storage\": \"256GB\", \"RAM\": \"8GB\"}',NULL,0,'2026-07-01 02:36:30',NULL,NULL,NULL),
(36,1,25,'Samsung Galaxy Z Flip 5 (Graphite)','The ultimate pocketable self-expression tool. Flex window allows you to reply to messages without opening the phone.',6,1,NULL,1,9,'{\"Storage\": \"512GB\", \"RAM\": \"8GB\"}',NULL,0,'2026-07-01 02:36:30',NULL,NULL,NULL),
(37,16,21,'Sony PlayStation 5 Console (Disc Edition)','Experience lightning-fast loading with an ultra-high speed SSD, deeper immersion with haptic feedback, and an all-new generation of incredible PlayStation games.',2,1,NULL,1,3,'{\"Included\": \"1 DualSense Wireless Controller\", \"Edition\": \"Disc\"}',NULL,0,'2026-07-01 02:36:30',NULL,NULL,NULL),
(38,11,19,'Dyson V15 Detect Absolute Vacuum','Dyson’s most powerful, intelligent cordless vacuum. Reveals invisible dust and counts particles.',12,3,NULL,1,3,'{\"Attachments\": \"Laser Slim Fluffy cleaner head, Digital Motorbar\", \"Filter\": \"Washable\"}',NULL,0,'2026-07-01 02:36:30',NULL,NULL,NULL),
(39,11,20,'Dyson Airwrap Multi-styler (Prussian Blue)','Curl, shape, smooth, and hide flyaways with no extreme heat.',3,3,NULL,1,3,'{\"Included\": \"6 styling attachments, presentation case\"}',NULL,0,'2026-07-01 02:36:30',NULL,NULL,NULL),
(40,12,18,'L\'Oreal Paris Revitalift 1.5% Hyaluronic Acid Serum','Intensely hydrates skin, leaving it feeling plump and reducing fine lines.',NULL,3,NULL,6,9,'{\"Volume\": \"30ml\", \"KeyIngredient\": \"Hyaluronic Acid\"}',NULL,0,'2026-07-01 02:36:30',NULL,NULL,NULL),
(41,3,16,'Adidas Ultraboost Light Running Shoes (Black)','Experience epic energy with the new Ultraboost Light, our lightest Ultraboost ever.',1,NULL,8,2,11,'{\"Activity\": \"Running\", \"Closure\": \"Lace-up\"}',NULL,0,'2026-07-01 02:36:30',NULL,NULL,NULL),
(42,3,16,'Adidas Ultraboost Light Running Shoes (White)','Experience epic energy with the new Ultraboost Light, our lightest Ultraboost ever.',2,NULL,9,2,11,'{\"Activity\": \"Running\", \"Closure\": \"Lace-up\"}',NULL,0,'2026-07-01 02:36:30',NULL,NULL,NULL),
(43,3,17,'Adidas Stan Smith Sneakers (White/Green)','Timeless appeal. Effortless style. Everyday versatility. For over 50 years and counting.',2,NULL,8,2,6,'{\"Activity\": \"Casual\", \"HeelTab\": \"Green\"}',NULL,0,'2026-07-01 02:36:30',NULL,NULL,NULL),
(44,3,26,'Puma Suede Classic XXI (Red)','The Suede hit the scene in 1968 and has been changing the game ever since.',4,NULL,9,2,6,'{\"Activity\": \"Streetwear\", \"Laces\": \"White\"}',NULL,0,'2026-07-01 02:36:30',NULL,NULL,NULL),
(45,15,1,'AmazonBasics Neoprene Dumbbells (Pair)','Neoprene-coated dumbbells for indoor fitness and strength training.',4,3,NULL,2,4,'{\"Weight\": \"5kg per dumbbell\", \"Grip\": \"Non-slip\"}',NULL,0,'2026-07-01 02:36:30',NULL,NULL,NULL),
(46,1,1,'Apple iPhone 15 Pro Max (Natural Titanium)','Forged in titanium and featuring the groundbreaking A17 Pro chip and 5x optical zoom.',9,1,NULL,1,8,'{\"Storage\": \"512GB\", \"RAM\": \"8GB\"}',NULL,0,'2026-07-01 02:36:30',NULL,NULL,NULL),
(47,1,1,'Apple iPhone 15 Pro Max (Blue Titanium)','Forged in titanium and featuring the groundbreaking A17 Pro chip and 5x optical zoom.',3,1,NULL,1,8,'{\"Storage\": \"1TB\", \"RAM\": \"8GB\"}',NULL,0,'2026-07-01 02:36:30',NULL,NULL,NULL);
/*!40000 ALTER TABLE `Product` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `ProductCategory`
--

DROP TABLE IF EXISTS `ProductCategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ProductCategory` (
  `ProductCategoryID` int(11) NOT NULL AUTO_INCREMENT,
  `ProductCategoryName` varchar(150) NOT NULL,
  `IsDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `RecordCreationTimeStamp` datetime NOT NULL DEFAULT current_timestamp(),
  `RecordCreationLogin` varchar(100) DEFAULT NULL,
  `LastUpdationTimeStamp` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `LastUpdationLogin` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ProductCategoryID`),
  UNIQUE KEY `ProductCategoryName` (`ProductCategoryName`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProductCategory`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `ProductCategory` WRITE;
/*!40000 ALTER TABLE `ProductCategory` DISABLE KEYS */;
INSERT INTO `ProductCategory` VALUES
(1,'Electronics',0,'2026-07-01 00:13:18',NULL,NULL,NULL),
(2,'Apparel & Fashion',0,'2026-07-01 00:13:18',NULL,NULL,NULL),
(3,'Groceries & Foods',0,'2026-07-01 00:13:18',NULL,NULL,NULL),
(4,'Home Appliances',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(5,'Beauty & Personal Care',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(6,'Sports & Fitness',0,'2026-07-01 02:27:05',NULL,NULL,NULL);
/*!40000 ALTER TABLE `ProductCategory` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `ProductImages`
--

DROP TABLE IF EXISTS `ProductImages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ProductImages` (
  `ImageID` int(11) NOT NULL AUTO_INCREMENT,
  `ProductID` int(11) NOT NULL,
  `ImageType` enum('thumbnail','main','gallery') NOT NULL DEFAULT 'gallery',
  `ImagePath` varchar(255) NOT NULL,
  `ImageOrder` int(11) DEFAULT 0,
  `IsActive` tinyint(1) NOT NULL DEFAULT 1,
  `IsDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `RecordCreationTimeStamp` datetime NOT NULL DEFAULT current_timestamp(),
  `RecordCreationLogin` varchar(100) DEFAULT NULL,
  `LastUpdationTimeStamp` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `LastUpdationLogin` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ImageID`),
  KEY `FK_ProductImages_Product` (`ProductID`),
  CONSTRAINT `FK_ProductImages_Product` FOREIGN KEY (`ProductID`) REFERENCES `product` (`ProductID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProductImages`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `ProductImages` WRITE;
/*!40000 ALTER TABLE `ProductImages` DISABLE KEYS */;
INSERT INTO `ProductImages` VALUES
(1,1,'main','https://m.media-amazon.com/images/I/81sigmT26lL._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(2,2,'main','https://m.media-amazon.com/images/I/71f5Eu5lJzL._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(3,3,'main','https://m.media-amazon.com/images/I/71CXhVhpM0L._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(4,4,'main','https://m.media-amazon.com/images/I/61G73XF7C+L._SY695_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(5,5,'main','https://m.media-amazon.com/images/I/71yLPIcI8UL._SY695_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(6,6,'main','https://m.media-amazon.com/images/I/61t-XfV2RCL._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(7,7,'main','https://m.media-amazon.com/images/I/61XF8Q12E1L._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(8,8,'main','https://m.media-amazon.com/images/I/71W8LzNGBML._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(9,9,'main','https://m.media-amazon.com/images/I/61RZDb2mQxL._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(10,10,'main','https://m.media-amazon.com/images/I/71tKndbZ3OL._SY695_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(11,11,'main','https://m.media-amazon.com/images/I/815zMiv2oPL._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(12,12,'main','https://m.media-amazon.com/images/I/81dG7L8u64L._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(13,13,'main','https://m.media-amazon.com/images/I/618d5bS2lUL._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(14,14,'main','https://m.media-amazon.com/images/I/61cwywLZR-L._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(15,15,'main','https://m.media-amazon.com/images/I/71G1Pj8kP3L._SY695_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(16,16,'main','https://m.media-amazon.com/images/I/81oPndf0QDL._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(17,17,'main','https://m.media-amazon.com/images/I/61I2aEqd13L._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(18,18,'main','https://m.media-amazon.com/images/I/71d7rfSl0wL._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(19,19,'main','https://m.media-amazon.com/images/I/716pi7sqs3L._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(20,20,'main','https://m.media-amazon.com/images/I/71xb2xkN5qL._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(21,21,'main','https://m.media-amazon.com/images/I/71uK-GZ25yL._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(22,22,'main','https://m.media-amazon.com/images/I/51w1x1m+-GL._SY695_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(23,23,'main','https://m.media-amazon.com/images/I/6168J4k7J2L._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(24,24,'main','https://m.media-amazon.com/images/I/61O27hXyW8L._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(25,25,'main','https://m.media-amazon.com/images/I/711T6y-vKQL._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(26,26,'main','https://m.media-amazon.com/images/I/716jX-r-e0L._SY695_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(27,27,'main','https://m.media-amazon.com/images/I/71jG+e7roXL._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(28,28,'main','https://m.media-amazon.com/images/I/71+D7L9o+4L._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(29,29,'main','https://m.media-amazon.com/images/I/71I32O1B3+L._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(30,30,'main','https://m.media-amazon.com/images/I/71B9Kx6G1fL._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(31,31,'main','https://m.media-amazon.com/images/I/81xU210x3OL._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(32,32,'main','https://m.media-amazon.com/images/I/81xU210x3OL._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(33,33,'main','https://m.media-amazon.com/images/I/81878iE1fML._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(34,34,'main','https://m.media-amazon.com/images/I/61SUj2aKoEL._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(35,35,'main','https://m.media-amazon.com/images/I/61m1hID7qGL._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(36,36,'main','https://m.media-amazon.com/images/I/61k8n5JpQxL._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(37,37,'main','https://m.media-amazon.com/images/I/51wAlcwG3yL._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(38,38,'main','https://m.media-amazon.com/images/I/610zOIfuA8L._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(39,39,'main','https://m.media-amazon.com/images/I/51G8K+BvGBL._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(40,40,'main','https://m.media-amazon.com/images/I/61x0xG-4eIL._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(41,41,'main','https://m.media-amazon.com/images/I/71L5I6G8wML._SY695_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(42,42,'main','https://m.media-amazon.com/images/I/71t-u65G7XL._SY695_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(43,43,'main','https://m.media-amazon.com/images/I/71aK4DqD5aL._SY695_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(44,44,'main','https://m.media-amazon.com/images/I/71T1T0x1+JL._SY695_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(45,45,'main','https://m.media-amazon.com/images/I/71+pOdBL7TL._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(46,46,'main','https://m.media-amazon.com/images/I/81c50PU+lpL._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL),
(47,47,'main','https://m.media-amazon.com/images/I/81fxjeu8fdL._SX679_.jpg',1,1,0,'2026-07-01 04:34:25','System',NULL,NULL);
/*!40000 ALTER TABLE `ProductImages` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `ProductSubCategory`
--

DROP TABLE IF EXISTS `ProductSubCategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ProductSubCategory` (
  `ProductSubCategoryID` int(11) NOT NULL AUTO_INCREMENT,
  `ProductCategoryID` int(11) NOT NULL,
  `ProductSubCategoryName` varchar(150) NOT NULL,
  `IsDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `RecordCreationTimeStamp` datetime NOT NULL DEFAULT current_timestamp(),
  `RecordCreationLogin` varchar(100) DEFAULT NULL,
  `LastUpdationTimeStamp` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `LastUpdationLogin` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ProductSubCategoryID`),
  UNIQUE KEY `UQ_ProductSubCategory` (`ProductCategoryID`,`ProductSubCategoryName`),
  CONSTRAINT `FK_ProductSubCategory_Category` FOREIGN KEY (`ProductCategoryID`) REFERENCES `productcategory` (`ProductCategoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProductSubCategory`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `ProductSubCategory` WRITE;
/*!40000 ALTER TABLE `ProductSubCategory` DISABLE KEYS */;
INSERT INTO `ProductSubCategory` VALUES
(1,1,'Mobile Phones',0,'2026-07-01 00:13:18',NULL,NULL,NULL),
(2,1,'Computers',0,'2026-07-01 00:13:18',NULL,NULL,NULL),
(3,2,'Men Clothing',0,'2026-07-01 00:13:18',NULL,NULL,NULL),
(4,2,'Footwear',0,'2026-07-01 00:13:18',NULL,NULL,NULL),
(5,3,'Kitchen Staples',0,'2026-07-01 00:13:18',NULL,NULL,NULL),
(6,1,'Audio & Headphones',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(7,1,'Wearables',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(8,4,'Televisions',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(9,4,'Vacuum Cleaners',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(10,5,'Skincare',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(11,5,'Haircare',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(12,6,'Gym Equipment',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(13,1,'Gaming Consoles',0,'2026-07-01 02:27:05',NULL,NULL,NULL);
/*!40000 ALTER TABLE `ProductSubCategory` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `ProductSubSubCategory`
--

DROP TABLE IF EXISTS `ProductSubSubCategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ProductSubSubCategory` (
  `ProductSubSubCategoryID` int(11) NOT NULL AUTO_INCREMENT,
  `ProductSubCategoryID` int(11) NOT NULL,
  `ProductSubSubCategoryName` varchar(150) NOT NULL,
  `IsDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `RecordCreationTimeStamp` datetime NOT NULL DEFAULT current_timestamp(),
  `RecordCreationLogin` varchar(100) DEFAULT NULL,
  `LastUpdationTimeStamp` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `LastUpdationLogin` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ProductSubSubCategoryID`),
  UNIQUE KEY `UQ_ProductSubSubCategory` (`ProductSubCategoryID`,`ProductSubSubCategoryName`),
  CONSTRAINT `FK_ProductSubSubCategory_SubCategory` FOREIGN KEY (`ProductSubCategoryID`) REFERENCES `productsubcategory` (`ProductSubCategoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ProductSubSubCategory`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `ProductSubSubCategory` WRITE;
/*!40000 ALTER TABLE `ProductSubSubCategory` DISABLE KEYS */;
INSERT INTO `ProductSubSubCategory` VALUES
(1,1,'Smartphones',0,'2026-07-01 00:13:18',NULL,NULL,NULL),
(2,2,'Laptops',0,'2026-07-01 00:13:18',NULL,NULL,NULL),
(3,4,'Sneakers',0,'2026-07-01 00:13:18',NULL,NULL,NULL),
(4,5,'Rice & Grains',0,'2026-07-01 00:13:18',NULL,NULL,NULL),
(5,5,'Pulses',0,'2026-07-01 00:13:18',NULL,NULL,NULL),
(6,6,'Earbuds',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(7,6,'Over-Ear Headphones',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(8,7,'Smartwatches',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(9,8,'OLED TVs',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(10,8,'QLED TVs',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(11,9,'Cordless Vacuums',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(12,10,'Face Serums',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(13,10,'Moisturizers',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(14,11,'Shampoos',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(15,12,'Dumbbells',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(16,13,'Next-Gen Consoles',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(17,13,'Gaming Accessories',0,'2026-07-01 02:27:05',NULL,NULL,NULL);
/*!40000 ALTER TABLE `ProductSubSubCategory` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `Purchase`
--

DROP TABLE IF EXISTS `Purchase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Purchase` (
  `PurchaseID` int(11) NOT NULL AUTO_INCREMENT,
  `OrderGroupID` varchar(50) DEFAULT NULL,
  `CustomerID` int(11) NOT NULL,
  `VendorProductID` int(11) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `CurrencyCode_SS` varchar(10) NOT NULL,
  `ProductName_SS` varchar(200) NOT NULL,
  `VendorName_SS` varchar(150) NOT NULL,
  `Price_SS` decimal(12,2) NOT NULL,
  `TaxPercent_SS` decimal(5,2) NOT NULL DEFAULT 0.00,
  `TotalAmount_SS` decimal(12,2) NOT NULL,
  `CustomerAddressLine_SS` varchar(255) DEFAULT NULL,
  `CustomerLocality_SS` varchar(150) DEFAULT NULL,
  `CustomerPinCode_SS` varchar(20) DEFAULT NULL,
  `CustomerDistrict_SS` varchar(100) DEFAULT NULL,
  `CustomerState_SS` varchar(100) DEFAULT NULL,
  `CustomerCountry_SS` varchar(100) DEFAULT NULL,
  `PurchaseStatus_Gen` varchar(100) DEFAULT NULL,
  `IsDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `RecordCreationTimeStamp` datetime NOT NULL DEFAULT current_timestamp(),
  `RecordCreationLogin` varchar(100) DEFAULT NULL,
  `LastUpdationTimeStamp` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `LastUpdationLogin` varchar(100) DEFAULT NULL,
  `PaymentStatus` enum('Pending','Completed','Failed') NOT NULL DEFAULT 'Pending',
  `PaymentMode` enum('Credit Card','UPI','Net Banking','Debit Card','EMI','COD') NOT NULL DEFAULT 'Credit Card',
  `DiscountAmount_SS` decimal(12,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`PurchaseID`),
  KEY `FK_Purchase_VendorProduct` (`VendorProductID`),
  KEY `IX_Purchase_Customer` (`CustomerID`),
  CONSTRAINT `FK_Purchase_Customer` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`),
  CONSTRAINT `FK_Purchase_VendorProduct` FOREIGN KEY (`VendorProductID`) REFERENCES `vendorproduct` (`VendorProductID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Purchase`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `Purchase` WRITE;
/*!40000 ALTER TABLE `Purchase` DISABLE KEYS */;
/*!40000 ALTER TABLE `Purchase` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `Purchase_Arch`
--

DROP TABLE IF EXISTS `Purchase_Arch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Purchase_Arch` (
  `PurchaseID` int(11) NOT NULL AUTO_INCREMENT,
  `OrderGroupID` varchar(50) DEFAULT NULL,
  `CustomerID` int(11) NOT NULL,
  `VendorProductID` int(11) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `CurrencyCode_SS` varchar(10) NOT NULL,
  `ProductName_SS` varchar(200) NOT NULL,
  `VendorName_SS` varchar(150) NOT NULL,
  `Price_SS` decimal(12,2) NOT NULL,
  `TaxPercent_SS` decimal(5,2) NOT NULL DEFAULT 0.00,
  `TotalAmount_SS` decimal(12,2) NOT NULL,
  `CustomerAddressLine_SS` varchar(255) DEFAULT NULL,
  `CustomerLocality_SS` varchar(150) DEFAULT NULL,
  `CustomerPinCode_SS` varchar(20) DEFAULT NULL,
  `CustomerDistrict_SS` varchar(100) DEFAULT NULL,
  `CustomerState_SS` varchar(100) DEFAULT NULL,
  `CustomerCountry_SS` varchar(100) DEFAULT NULL,
  `PurchaseStatus_Gen` varchar(100) DEFAULT NULL,
  `IsDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `RecordCreationTimeStamp` datetime NOT NULL DEFAULT current_timestamp(),
  `RecordCreationLogin` varchar(100) DEFAULT NULL,
  `LastUpdationTimeStamp` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `LastUpdationLogin` varchar(100) DEFAULT NULL,
  `PaymentStatus` enum('Pending','Completed','Failed') NOT NULL DEFAULT 'Pending',
  `PaymentMode` enum('Credit Card','UPI','Net Banking','Debit Card','EMI','COD') NOT NULL DEFAULT 'Credit Card',
  `DiscountAmount_SS` decimal(12,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`PurchaseID`),
  KEY `FK_Purchase_Customer` (`CustomerID`),
  KEY `FK_Purchase_VendorProduct` (`VendorProductID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Purchase_Arch`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `Purchase_Arch` WRITE;
/*!40000 ALTER TABLE `Purchase_Arch` DISABLE KEYS */;
/*!40000 ALTER TABLE `Purchase_Arch` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `Shape`
--

DROP TABLE IF EXISTS `Shape`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Shape` (
  `ShapeID` int(11) NOT NULL AUTO_INCREMENT,
  `ShapeName` varchar(100) NOT NULL,
  `IsDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `RecordCreationTimeStamp` datetime NOT NULL DEFAULT current_timestamp(),
  `RecordCreationLogin` varchar(100) DEFAULT NULL,
  `LastUpdationTimeStamp` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `LastUpdationLogin` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ShapeID`),
  UNIQUE KEY `ShapeName` (`ShapeName`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Shape`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `Shape` WRITE;
/*!40000 ALTER TABLE `Shape` DISABLE KEYS */;
INSERT INTO `Shape` VALUES
(1,'Rectangular',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(2,'Round',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(3,'Cylindrical',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(4,'Square',0,'2026-07-01 02:27:05',NULL,NULL,NULL);
/*!40000 ALTER TABLE `Shape` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `ShoppingCart`
--

DROP TABLE IF EXISTS `ShoppingCart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ShoppingCart` (
  `ShoppingCartID` int(11) NOT NULL AUTO_INCREMENT,
  `CustomerID` int(11) NOT NULL,
  `VendorProductID` int(11) NOT NULL,
  `Quantity` int(11) NOT NULL DEFAULT 1,
  `DeliveryChoice` enum('NORMAL','FAST') NOT NULL DEFAULT 'NORMAL',
  `IsSelectedForPurchase` tinyint(1) NOT NULL DEFAULT 1,
  `IsDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `RecordCreationTimeStamp` datetime NOT NULL DEFAULT current_timestamp(),
  `RecordCreationLogin` varchar(100) DEFAULT NULL,
  `LastUpdationTimeStamp` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `LastUpdationLogin` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ShoppingCartID`),
  UNIQUE KEY `UQ_Cart_Unique` (`CustomerID`,`VendorProductID`),
  KEY `FK_ShoppingCart_VendorProduct` (`VendorProductID`),
  KEY `IX_ShoppingCart_Customer` (`CustomerID`),
  CONSTRAINT `FK_ShoppingCart_Customer` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`),
  CONSTRAINT `FK_ShoppingCart_VendorProduct` FOREIGN KEY (`VendorProductID`) REFERENCES `vendorproduct` (`VendorProductID`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ShoppingCart`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `ShoppingCart` WRITE;
/*!40000 ALTER TABLE `ShoppingCart` DISABLE KEYS */;
INSERT INTO `ShoppingCart` VALUES
(7,1,65,1,'NORMAL',1,0,'2026-07-01 02:37:38',NULL,NULL,NULL),
(8,1,63,1,'NORMAL',1,0,'2026-07-01 12:19:18',NULL,NULL,NULL);
/*!40000 ALTER TABLE `ShoppingCart` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `Size`
--

DROP TABLE IF EXISTS `Size`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Size` (
  `SizeID` int(11) NOT NULL AUTO_INCREMENT,
  `SizeName` varchar(100) NOT NULL,
  `IsDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `RecordCreationTimeStamp` datetime NOT NULL DEFAULT current_timestamp(),
  `RecordCreationLogin` varchar(100) DEFAULT NULL,
  `LastUpdationTimeStamp` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `LastUpdationLogin` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`SizeID`),
  UNIQUE KEY `SizeName` (`SizeName`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Size`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `Size` WRITE;
/*!40000 ALTER TABLE `Size` DISABLE KEYS */;
INSERT INTO `Size` VALUES
(1,'Small',0,'2026-07-01 00:13:17',NULL,NULL,NULL),
(2,'Medium',0,'2026-07-01 00:13:17',NULL,NULL,NULL),
(3,'Large',0,'2026-07-01 00:13:17',NULL,NULL,NULL),
(4,'9 UK',0,'2026-07-01 00:13:17',NULL,NULL,NULL),
(5,'10 UK',0,'2026-07-01 00:13:17',NULL,NULL,NULL),
(6,'XL',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(7,'XXL',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(8,'8 UK',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(9,'11 UK',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(10,'13-inch',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(11,'15-inch',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(12,'65-inch',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(13,'55-inch',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(14,'1TB',0,'2026-07-01 02:27:05',NULL,NULL,NULL);
/*!40000 ALTER TABLE `Size` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `State`
--

DROP TABLE IF EXISTS `State`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `State` (
  `StateID` int(11) NOT NULL AUTO_INCREMENT,
  `CountryID` int(11) NOT NULL,
  `StateName` varchar(100) NOT NULL,
  `IsDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `RecordCreationTimeStamp` datetime NOT NULL DEFAULT current_timestamp(),
  `RecordCreationLogin` varchar(100) DEFAULT NULL,
  `LastUpdationTimeStamp` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `LastUpdationLogin` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`StateID`),
  UNIQUE KEY `UQ_State` (`CountryID`,`StateName`),
  CONSTRAINT `FK_State_Country` FOREIGN KEY (`CountryID`) REFERENCES `country` (`CountryID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `State`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `State` WRITE;
/*!40000 ALTER TABLE `State` DISABLE KEYS */;
INSERT INTO `State` VALUES
(1,1,'Uttar Pradesh',0,'2026-07-01 00:13:17',NULL,NULL,NULL),
(2,1,'Maharashtra',0,'2026-07-01 00:13:17',NULL,NULL,NULL),
(3,1,'Delhi',0,'2026-07-01 00:13:17',NULL,NULL,NULL),
(4,2,'California',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(5,2,'New York',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(6,3,'England',0,'2026-07-01 02:27:05',NULL,NULL,NULL);
/*!40000 ALTER TABLE `State` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `SuperUser`
--

DROP TABLE IF EXISTS `SuperUser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `SuperUser` (
  `SuperUserID` int(11) NOT NULL AUTO_INCREMENT,
  `LoginName` varchar(100) NOT NULL,
  `PasswordHash` varchar(255) NOT NULL,
  `FullName` varchar(150) NOT NULL,
  `Email` varchar(150) DEFAULT NULL,
  `MobileNo` varchar(20) DEFAULT NULL,
  `IsActive` tinyint(1) NOT NULL DEFAULT 1,
  `IsSuspended` tinyint(1) NOT NULL DEFAULT 0,
  `IsBlacklisted` tinyint(1) NOT NULL DEFAULT 0,
  `IsDead` tinyint(1) NOT NULL DEFAULT 0,
  `IsDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `RecordCreationTimeStamp` datetime NOT NULL DEFAULT current_timestamp(),
  `RecordCreationLogin` varchar(100) DEFAULT NULL,
  `LastUpdationTimeStamp` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `LastUpdationLogin` varchar(100) DEFAULT NULL,
  `Gender` enum('M','F','O') DEFAULT NULL,
  `DoB` date DEFAULT NULL,
  `Rank` int(11) NOT NULL DEFAULT 0,
  `VerificationTimeStamp` datetime DEFAULT NULL,
  `ActivationTimeStamp` datetime DEFAULT NULL,
  `SuspensionTimeStamp` datetime DEFAULT NULL,
  `BlacklistTimeStamp` datetime DEFAULT NULL,
  `DeadTimeStamp` datetime DEFAULT NULL,
  PRIMARY KEY (`SuperUserID`),
  UNIQUE KEY `LoginName` (`LoginName`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SuperUser`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `SuperUser` WRITE;
/*!40000 ALTER TABLE `SuperUser` DISABLE KEYS */;
INSERT INTO `SuperUser` VALUES
(1,'admin','password123','System Admin',NULL,NULL,1,0,0,0,0,'2026-06-29 20:24:10',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `SuperUser` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `Unit`
--

DROP TABLE IF EXISTS `Unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Unit` (
  `UnitID` int(11) NOT NULL AUTO_INCREMENT,
  `UnitName` varchar(100) NOT NULL,
  `IsDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `RecordCreationTimeStamp` datetime NOT NULL DEFAULT current_timestamp(),
  `RecordCreationLogin` varchar(100) DEFAULT NULL,
  `LastUpdationTimeStamp` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `LastUpdationLogin` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`UnitID`),
  UNIQUE KEY `UnitName` (`UnitName`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Unit`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `Unit` WRITE;
/*!40000 ALTER TABLE `Unit` DISABLE KEYS */;
INSERT INTO `Unit` VALUES
(1,'Piece',0,'2026-07-01 00:13:18',NULL,NULL,NULL),
(2,'Pair',0,'2026-07-01 00:13:18',NULL,NULL,NULL),
(3,'Kg',0,'2026-07-01 00:13:18',NULL,NULL,NULL),
(4,'Gram',0,'2026-07-01 00:13:18',NULL,NULL,NULL),
(5,'Liter',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(6,'Milliliter',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(7,'Pack',0,'2026-07-01 02:27:05',NULL,NULL,NULL),
(8,'Box',0,'2026-07-01 02:27:05',NULL,NULL,NULL);
/*!40000 ALTER TABLE `Unit` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
  `UserID` int(11) NOT NULL AUTO_INCREMENT,
  `UserRole` enum('Manager','Operator','Vendor','Courier') NOT NULL,
  `CreatedByAdminID` int(11) DEFAULT NULL,
  `LoginName` varchar(100) NOT NULL,
  `PasswordHash` varchar(255) NOT NULL,
  `FullName` varchar(150) NOT NULL,
  `Email` varchar(150) DEFAULT NULL,
  `MobileNo` varchar(20) DEFAULT NULL,
  `AddressLine` varchar(255) DEFAULT NULL,
  `LocalityID` int(11) DEFAULT NULL,
  `IsVerified` tinyint(1) NOT NULL DEFAULT 0,
  `IsActive` tinyint(1) NOT NULL DEFAULT 0,
  `IsSuspended` tinyint(1) NOT NULL DEFAULT 0,
  `IsBlacklisted` tinyint(1) NOT NULL DEFAULT 0,
  `IsDead` tinyint(1) NOT NULL DEFAULT 0,
  `IsDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `RecordCreationTimeStamp` datetime NOT NULL DEFAULT current_timestamp(),
  `RecordCreationLogin` varchar(100) DEFAULT NULL,
  `LastUpdationTimeStamp` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `LastUpdationLogin` varchar(100) DEFAULT NULL,
  `Gender` enum('M','F','O') DEFAULT NULL,
  `DoB` date DEFAULT NULL,
  `Rank` int(11) NOT NULL DEFAULT 0,
  `VerificationTimeStamp` datetime DEFAULT NULL,
  `ActivationTimeStamp` datetime DEFAULT NULL,
  `SuspensionTimeStamp` datetime DEFAULT NULL,
  `BlacklistTimeStamp` datetime DEFAULT NULL,
  `DeadTimeStamp` datetime DEFAULT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `LoginName` (`LoginName`),
  KEY `FK_User_Admin` (`CreatedByAdminID`),
  KEY `IX_User_LocalityID` (`LocalityID`),
  KEY `IX_User_UserRole` (`UserRole`),
  CONSTRAINT `FK_User_Admin` FOREIGN KEY (`CreatedByAdminID`) REFERENCES `admin` (`AdminID`),
  CONSTRAINT `FK_User_Locality` FOREIGN KEY (`LocalityID`) REFERENCES `locality` (`LocalityID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES
(1,'Vendor',1,'vendor0','ven0','Ashwin',NULL,'NULL','NULL',NULL,0,1,0,0,0,0,'2026-06-29 22:47:39','Aditya Jha',NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `VendorProduct`
--

DROP TABLE IF EXISTS `VendorProduct`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `VendorProduct` (
  `VendorProductID` int(11) NOT NULL AUTO_INCREMENT,
  `VendorUserID` int(11) NOT NULL,
  `ProductID` int(11) NOT NULL,
  `CurrencyID` int(11) NOT NULL,
  `Price` decimal(12,2) NOT NULL,
  `TaxPercent` decimal(5,2) NOT NULL DEFAULT 0.00,
  `StockQuantity` int(11) NOT NULL DEFAULT 0,
  `DefaultCourierUserID` int(11) DEFAULT NULL,
  `SupportsNormalDelivery` tinyint(1) NOT NULL DEFAULT 1,
  `SupportsFastDelivery` tinyint(1) NOT NULL DEFAULT 0,
  `IsActive` tinyint(1) NOT NULL DEFAULT 1,
  `IsDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `RecordCreationTimeStamp` datetime NOT NULL DEFAULT current_timestamp(),
  `RecordCreationLogin` varchar(100) DEFAULT NULL,
  `LastUpdationTimeStamp` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `LastUpdationLogin` varchar(100) DEFAULT NULL,
  `MaxStockQty` int(11) NOT NULL DEFAULT 0,
  `DiscountPercent` decimal(5,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`VendorProductID`),
  KEY `FK_VendorProduct_Currency` (`CurrencyID`),
  KEY `FK_VendorProduct_Courier` (`DefaultCourierUserID`),
  KEY `IX_VendorProduct_Vendor` (`VendorUserID`),
  KEY `IX_VendorProduct_Product` (`ProductID`),
  CONSTRAINT `FK_VendorProduct_Courier` FOREIGN KEY (`DefaultCourierUserID`) REFERENCES `user` (`UserID`),
  CONSTRAINT `FK_VendorProduct_Currency` FOREIGN KEY (`CurrencyID`) REFERENCES `currency` (`CurrencyID`),
  CONSTRAINT `FK_VendorProduct_Product` FOREIGN KEY (`ProductID`) REFERENCES `product` (`ProductID`),
  CONSTRAINT `FK_VendorProduct_Vendor` FOREIGN KEY (`VendorUserID`) REFERENCES `user` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VendorProduct`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `VendorProduct` WRITE;
/*!40000 ALTER TABLE `VendorProduct` DISABLE KEYS */;
INSERT INTO `VendorProduct` VALUES
(1,1,1,1,134900.00,0.00,25,NULL,1,0,1,0,'2026-07-01 00:13:18',NULL,NULL,NULL,0,0.00),
(2,1,2,1,114900.00,0.00,10,NULL,1,0,1,0,'2026-07-01 00:13:18',NULL,NULL,NULL,0,0.00),
(3,1,3,1,129999.00,0.00,15,NULL,1,0,1,0,'2026-07-01 00:13:18',NULL,NULL,NULL,0,0.00),
(4,1,4,1,7495.00,0.00,50,NULL,1,0,1,0,'2026-07-01 00:13:18',NULL,NULL,NULL,0,0.00),
(5,1,5,1,9500.00,0.00,30,NULL,1,0,1,0,'2026-07-01 00:13:18',NULL,NULL,NULL,0,0.00),
(6,1,6,1,450.00,0.00,100,NULL,1,0,1,0,'2026-07-01 00:13:18',NULL,NULL,NULL,0,0.00),
(7,1,7,1,185.00,0.00,200,NULL,1,0,1,0,'2026-07-01 00:13:18',NULL,NULL,NULL,0,0.00),
(8,1,8,1,55000.00,0.00,12,NULL,1,0,1,0,'2026-07-01 00:37:40',NULL,NULL,NULL,0,0.00),
(9,1,9,1,65000.00,0.00,8,NULL,1,0,1,0,'2026-07-01 00:37:40',NULL,NULL,NULL,0,0.00),
(10,1,10,1,8500.00,0.00,22,NULL,1,0,1,0,'2026-07-01 00:37:40',NULL,NULL,NULL,0,0.00),
(11,1,11,1,850.00,0.00,150,NULL,1,0,1,0,'2026-07-01 00:37:40',NULL,NULL,NULL,0,0.00),
(12,1,12,1,350.00,0.00,80,NULL,1,0,1,0,'2026-07-01 00:37:40',NULL,NULL,NULL,0,0.00),
(13,1,13,1,199000.00,0.00,5,NULL,1,0,1,0,'2026-07-01 00:37:40',NULL,NULL,NULL,0,0.00),
(14,1,14,1,58000.00,0.00,30,NULL,1,0,1,0,'2026-07-01 00:37:40',NULL,NULL,NULL,0,0.00),
(15,1,15,1,15000.00,0.00,10,NULL,1,0,1,0,'2026-07-01 00:37:40',NULL,NULL,NULL,0,0.00),
(16,1,16,1,120.00,0.00,200,NULL,1,0,1,0,'2026-07-01 00:37:40',NULL,NULL,NULL,0,0.00),
(17,1,17,1,25.00,0.00,500,NULL,1,0,1,0,'2026-07-01 00:37:40',NULL,NULL,NULL,0,0.00),
(18,1,18,1,74900.00,0.00,45,NULL,1,0,1,0,'2026-07-01 00:37:40',NULL,NULL,NULL,0,0.00),
(19,1,19,1,154000.00,0.00,3,NULL,1,0,1,0,'2026-07-01 00:37:40',NULL,NULL,NULL,0,0.00),
(20,1,20,1,48000.00,0.00,60,NULL,1,0,1,0,'2026-07-01 00:37:40',NULL,NULL,NULL,0,0.00),
(21,1,21,1,72000.00,0.00,15,NULL,1,0,1,0,'2026-07-01 00:37:40',NULL,NULL,NULL,0,0.00),
(22,1,22,1,4500.00,0.00,40,NULL,1,0,1,0,'2026-07-01 00:37:40',NULL,NULL,NULL,0,0.00),
(23,1,23,1,140.00,0.00,90,NULL,1,0,1,0,'2026-07-01 00:37:40',NULL,NULL,NULL,0,0.00),
(24,1,24,1,45.00,0.00,300,NULL,1,0,1,0,'2026-07-01 00:37:40',NULL,NULL,NULL,0,0.00),
(25,1,25,1,65.00,0.00,250,NULL,1,0,1,0,'2026-07-01 00:37:40',NULL,NULL,NULL,0,0.00),
(26,1,26,1,3500.00,0.00,55,NULL,1,0,1,0,'2026-07-01 00:37:40',NULL,NULL,NULL,0,0.00),
(27,1,27,1,69000.00,0.00,20,NULL,1,0,1,0,'2026-07-01 00:37:40',NULL,NULL,NULL,0,0.00),
(48,1,28,1,185000.00,18.00,15,NULL,1,1,1,0,'2026-07-01 02:36:47',NULL,NULL,NULL,50,5.00),
(49,1,29,1,320000.00,18.00,5,NULL,1,0,1,0,'2026-07-01 02:36:47',NULL,NULL,NULL,10,0.00),
(50,1,30,1,145000.00,18.00,25,NULL,1,1,1,0,'2026-07-01 02:36:47',NULL,NULL,NULL,40,10.00),
(51,1,31,1,199990.00,18.00,8,NULL,1,0,1,0,'2026-07-01 02:36:47',NULL,NULL,NULL,20,12.00),
(52,1,32,1,129990.00,18.00,12,NULL,1,1,1,0,'2026-07-01 02:36:47',NULL,NULL,NULL,30,8.00),
(53,1,33,1,89900.00,18.00,40,NULL,1,1,1,0,'2026-07-01 02:36:47',NULL,NULL,NULL,100,0.00),
(54,1,34,1,24900.00,18.00,150,NULL,1,1,1,0,'2026-07-01 02:36:47',NULL,NULL,NULL,300,5.00),
(55,1,35,1,99999.00,18.00,30,NULL,1,1,1,0,'2026-07-01 02:36:47',NULL,NULL,NULL,80,0.00),
(56,1,36,1,109999.00,18.00,20,NULL,1,1,1,0,'2026-07-01 02:36:47',NULL,NULL,NULL,80,0.00),
(57,1,37,1,54990.00,18.00,60,NULL,1,1,1,0,'2026-07-01 02:36:47',NULL,NULL,NULL,150,0.00),
(58,1,38,1,74900.00,18.00,18,NULL,1,0,1,0,'2026-07-01 02:36:47',NULL,NULL,NULL,40,5.00),
(59,1,39,1,49900.00,18.00,25,NULL,1,1,1,0,'2026-07-01 02:36:47',NULL,NULL,NULL,60,0.00),
(60,1,40,1,999.00,18.00,200,NULL,1,1,1,0,'2026-07-01 02:36:47',NULL,NULL,NULL,500,15.00),
(61,1,41,1,15999.00,18.00,45,NULL,1,1,1,0,'2026-07-01 02:36:47',NULL,NULL,NULL,100,20.00),
(62,1,42,1,15999.00,18.00,35,NULL,1,1,1,0,'2026-07-01 02:36:47',NULL,NULL,NULL,100,20.00),
(63,1,43,1,8999.00,18.00,80,NULL,1,1,1,0,'2026-07-01 02:36:47',NULL,NULL,NULL,200,10.00),
(64,1,44,1,6999.00,18.00,55,NULL,1,1,1,0,'2026-07-01 02:36:47',NULL,NULL,NULL,150,15.00),
(65,1,45,1,2499.00,18.00,120,NULL,1,0,1,0,'2026-07-01 02:36:47',NULL,NULL,NULL,400,5.00),
(66,1,46,1,159900.00,18.00,15,NULL,1,1,1,0,'2026-07-01 02:36:47',NULL,NULL,NULL,50,0.00),
(67,1,47,1,199900.00,18.00,10,NULL,1,1,1,0,'2026-07-01 02:36:47',NULL,NULL,NULL,30,0.00);
/*!40000 ALTER TABLE `VendorProduct` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `VendorProductCustomerCourier`
--

DROP TABLE IF EXISTS `VendorProductCustomerCourier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `VendorProductCustomerCourier` (
  `VendorProductCustomerCourierID` int(11) NOT NULL AUTO_INCREMENT,
  `PurchaseID` int(11) NOT NULL,
  `VendorProductID` int(11) NOT NULL,
  `CustomerID` int(11) NOT NULL,
  `VendorUserID` int(11) NOT NULL,
  `CourierUserID` int(11) DEFAULT NULL,
  `CustomerAddressLine_SS` varchar(255) DEFAULT NULL,
  `CustomerLocality_SS` varchar(150) DEFAULT NULL,
  `CustomerPinCode_SS` varchar(20) DEFAULT NULL,
  `CustomerDistrict_SS` varchar(100) DEFAULT NULL,
  `CustomerState_SS` varchar(100) DEFAULT NULL,
  `CustomerCountry_SS` varchar(100) DEFAULT NULL,
  `IsReadyForPickup` tinyint(1) NOT NULL DEFAULT 0,
  `IsPickedByCourier` tinyint(1) NOT NULL DEFAULT 0,
  `IsDispatched` tinyint(1) NOT NULL DEFAULT 0,
  `IsOutForDelivery` tinyint(1) NOT NULL DEFAULT 0,
  `IsDelivered` tinyint(1) NOT NULL DEFAULT 0,
  `IsPartialDelivery` tinyint(1) NOT NULL DEFAULT 0,
  `IsReturned` tinyint(1) NOT NULL DEFAULT 0,
  `TrackingNo` varchar(100) DEFAULT NULL,
  `CurrentStatus_Gen` varchar(100) DEFAULT NULL,
  `IsDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `RecordCreationTimeStamp` datetime NOT NULL DEFAULT current_timestamp(),
  `RecordCreationLogin` varchar(100) DEFAULT NULL,
  `LastUpdationTimeStamp` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `LastUpdationLogin` varchar(100) DEFAULT NULL,
  `ReadyForPickupTimeStamp` datetime DEFAULT NULL,
  `PickedByCourierTimeStamp` datetime DEFAULT NULL,
  `DispatchedTimeStamp` datetime DEFAULT NULL,
  `OutForDeliveryTimeStamp` datetime DEFAULT NULL,
  `DeliveryTimeStamp` datetime DEFAULT NULL,
  `ReturnTimeStamp` datetime DEFAULT NULL,
  PRIMARY KEY (`VendorProductCustomerCourierID`),
  KEY `FK_VPCC_Purchase` (`PurchaseID`),
  KEY `FK_VPCC_VendorProduct` (`VendorProductID`),
  KEY `FK_VPCC_Customer` (`CustomerID`),
  KEY `FK_VPCC_Vendor` (`VendorUserID`),
  KEY `IX_VPCC_Courier` (`CourierUserID`),
  KEY `IX_VPCC_Status` (`IsDelivered`,`IsReturned`),
  CONSTRAINT `FK_VPCC_Courier` FOREIGN KEY (`CourierUserID`) REFERENCES `user` (`UserID`),
  CONSTRAINT `FK_VPCC_Customer` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`),
  CONSTRAINT `FK_VPCC_Purchase` FOREIGN KEY (`PurchaseID`) REFERENCES `purchase` (`PurchaseID`),
  CONSTRAINT `FK_VPCC_Vendor` FOREIGN KEY (`VendorUserID`) REFERENCES `user` (`UserID`),
  CONSTRAINT `FK_VPCC_VendorProduct` FOREIGN KEY (`VendorProductID`) REFERENCES `vendorproduct` (`VendorProductID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VendorProductCustomerCourier`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `VendorProductCustomerCourier` WRITE;
/*!40000 ALTER TABLE `VendorProductCustomerCourier` DISABLE KEYS */;
/*!40000 ALTER TABLE `VendorProductCustomerCourier` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `VendorProductCustomerCourier_Arch`
--

DROP TABLE IF EXISTS `VendorProductCustomerCourier_Arch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `VendorProductCustomerCourier_Arch` (
  `VendorProductCustomerCourierID` int(11) NOT NULL AUTO_INCREMENT,
  `PurchaseID` int(11) NOT NULL,
  `VendorProductID` int(11) NOT NULL,
  `CustomerID` int(11) NOT NULL,
  `VendorUserID` int(11) NOT NULL,
  `CourierUserID` int(11) DEFAULT NULL,
  `CustomerAddressLine_SS` varchar(255) DEFAULT NULL,
  `CustomerLocality_SS` varchar(150) DEFAULT NULL,
  `CustomerPinCode_SS` varchar(20) DEFAULT NULL,
  `CustomerDistrict_SS` varchar(100) DEFAULT NULL,
  `CustomerState_SS` varchar(100) DEFAULT NULL,
  `CustomerCountry_SS` varchar(100) DEFAULT NULL,
  `IsReadyForPickup` tinyint(1) NOT NULL DEFAULT 0,
  `IsPickedByCourier` tinyint(1) NOT NULL DEFAULT 0,
  `IsDispatched` tinyint(1) NOT NULL DEFAULT 0,
  `IsOutForDelivery` tinyint(1) NOT NULL DEFAULT 0,
  `IsDelivered` tinyint(1) NOT NULL DEFAULT 0,
  `IsPartialDelivery` tinyint(1) NOT NULL DEFAULT 0,
  `IsReturned` tinyint(1) NOT NULL DEFAULT 0,
  `TrackingNo` varchar(100) DEFAULT NULL,
  `CurrentStatus_Gen` varchar(100) DEFAULT NULL,
  `IsDeleted` tinyint(1) NOT NULL DEFAULT 0,
  `RecordCreationTimeStamp` datetime NOT NULL DEFAULT current_timestamp(),
  `RecordCreationLogin` varchar(100) DEFAULT NULL,
  `LastUpdationTimeStamp` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `LastUpdationLogin` varchar(100) DEFAULT NULL,
  `ReadyForPickupTimeStamp` datetime DEFAULT NULL,
  `PickedByCourierTimeStamp` datetime DEFAULT NULL,
  `DispatchedTimeStamp` datetime DEFAULT NULL,
  `OutForDeliveryTimeStamp` datetime DEFAULT NULL,
  `DeliveryTimeStamp` datetime DEFAULT NULL,
  `ReturnTimeStamp` datetime DEFAULT NULL,
  PRIMARY KEY (`VendorProductCustomerCourierID`),
  KEY `FK_VPCC_Purchase` (`PurchaseID`),
  KEY `FK_VPCC_VendorProduct` (`VendorProductID`),
  KEY `FK_VPCC_Customer` (`CustomerID`),
  KEY `FK_VPCC_Vendor` (`VendorUserID`),
  KEY `FK_VPCC_Courier` (`CourierUserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VendorProductCustomerCourier_Arch`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `VendorProductCustomerCourier_Arch` WRITE;
/*!40000 ALTER TABLE `VendorProductCustomerCourier_Arch` DISABLE KEYS */;
/*!40000 ALTER TABLE `VendorProductCustomerCourier_Arch` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-07-01 14:44:53
