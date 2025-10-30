-- MySQL dump 10.13  Distrib 8.0.44, for macos15 (x86_64)
--
-- Host: localhost    Database: corp_hr
-- ------------------------------------------------------
-- Server version	8.4.7

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,'HR','Human Resources',NULL,'2025-10-30 11:08:24','2025-10-30 11:08:24'),(2,'IT','Information Technology',NULL,'2025-10-30 11:08:24','2025-10-30 11:08:24'),(3,'ACC','Accounting',NULL,'2025-10-30 11:08:24','2025-10-30 11:08:24'),(4,'SALES','Sales Department',NULL,'2025-10-30 11:08:24','2025-10-30 11:08:24');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `emp_code` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` enum('MALE','FEMALE','OTHER') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `hire_date` date NOT NULL DEFAULT (curdate()),
  `status` enum('ACTIVE','INACTIVE','RESIGNED') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ACTIVE',
  `department_id` bigint unsigned DEFAULT NULL,
  `position_id` bigint unsigned DEFAULT NULL,
  `salary_grade_id` bigint unsigned DEFAULT NULL,
  `basic_salary` decimal(15,2) DEFAULT '0.00',
  `allowance` decimal(15,2) DEFAULT '0.00',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `emp_code` (`emp_code`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_emp_position` (`position_id`),
  KEY `fk_emp_salary_grade` (`salary_grade_id`),
  KEY `idx_emp_name` (`first_name`,`last_name`),
  KEY `idx_emp_dept` (`department_id`),
  KEY `idx_emp_phone` (`phone`),
  KEY `idx_emp_status` (`status`),
  CONSTRAINT `fk_emp_department` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_emp_position` FOREIGN KEY (`position_id`) REFERENCES `positions` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_emp_salary_grade` FOREIGN KEY (`salary_grade_id`) REFERENCES `salary_grades` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (3,'EMP0003','Minh','Le','MALE','2000-11-05','minh.le@example.com','0988111222','Da Nang','2024-03-01','ACTIVE',3,NULL,1,8500000.00,0.00,'2025-10-30 11:08:24','2025-10-30 11:08:24'),(4,'EMP0004','Nguyễn','Nghĩa','MALE','2002-06-15','ntn8530@gmail.com','0862273012','Hà Nội','2025-10-30','ACTIVE',1,1,1,12000000.00,1500000.00,'2025-10-30 12:02:12','2025-10-30 12:06:09'),(9,'EMP0005','Nguyễn','Trọng','MALE','2002-06-15','nghia@gmail.com','0862273012','Hà Nội','2025-10-31','ACTIVE',2,2,2,12000000.00,1500000.00,'2025-10-30 12:13:01','2025-10-30 12:15:38');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `positions`
--

DROP TABLE IF EXISTS `positions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `positions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `base_coef` decimal(5,2) DEFAULT '1.00',
  `description` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `positions`
--

LOCK TABLES `positions` WRITE;
/*!40000 ALTER TABLE `positions` DISABLE KEYS */;
INSERT INTO `positions` VALUES (1,'DEV','Java Developer',1.20,NULL,'2025-10-30 11:08:24','2025-10-30 11:08:24'),(2,'QA','QA Engineer',1.10,NULL,'2025-10-30 11:08:24','2025-10-30 11:08:24'),(3,'PM','Project Manager',1.50,NULL,'2025-10-30 11:08:24','2025-10-30 11:08:24'),(4,'HRM','HR Executive',1.00,NULL,'2025-10-30 11:08:24','2025-10-30 11:08:24');
/*!40000 ALTER TABLE `positions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salary_grades`
--

DROP TABLE IF EXISTS `salary_grades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salary_grades` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `grade_code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `grade_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `base_salary` decimal(15,2) NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `grade_code` (`grade_code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salary_grades`
--

LOCK TABLES `salary_grades` WRITE;
/*!40000 ALTER TABLE `salary_grades` DISABLE KEYS */;
INSERT INTO `salary_grades` VALUES (1,'G1','Grade 1',8000000.00,NULL,'2025-10-30 11:08:24','2025-10-30 11:08:24'),(2,'G2','Grade 2',10000000.00,NULL,'2025-10-30 11:08:24','2025-10-30 11:08:24'),(3,'G3','Grade 3',13000000.00,NULL,'2025-10-30 11:08:24','2025-10-30 11:08:24');
/*!40000 ALTER TABLE `salary_grades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'corp_hr'
--

--
-- Dumping routines for database 'corp_hr'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-30 19:17:25
