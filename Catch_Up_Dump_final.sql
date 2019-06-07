-- MySQL dump 10.13  Distrib 8.0.15, for macos10.14 (x86_64)
--
-- Host: localhost    Database: CATCH_UP
-- ------------------------------------------------------
-- Server version	8.0.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ACC_POST`
--

DROP TABLE IF EXISTS `ACC_POST`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ACC_POST` (
  `ACC_POST_ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) NOT NULL,
  `ACC_TYPE` enum('LOOKING','RENTING') NOT NULL,
  `STREET_ADDRESS` varchar(100) DEFAULT NULL,
  `ACC_CITY` varchar(50) DEFAULT NULL,
  `ACC_STATE` varchar(45) DEFAULT NULL,
  `ACC_ZIP` bigint(20) DEFAULT NULL,
  `ACC_DESCRIPTION` varchar(5000) NOT NULL,
  `ACC_PRICE` float DEFAULT NULL,
  `BED` float DEFAULT NULL,
  `BATH` float DEFAULT NULL,
  `OCCUPANCY` enum('SINGLE','SHARED') NOT NULL,
  `HOME_TYPE` enum('TOWNHOUSE','APARTMENT','SINGLE FAMILY HOME','STUDIO','CONDO') NOT NULL,
  `ACC_DATE_POSTED` date DEFAULT NULL,
  `ACC_TIME_POSTED` time DEFAULT NULL,
  PRIMARY KEY (`ACC_POST_ID`),
  KEY `USER_ID` (`USER_ID`),
  CONSTRAINT `acc_post_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACC_POST`
--

LOCK TABLES `ACC_POST` WRITE;
/*!40000 ALTER TABLE `ACC_POST` DISABLE KEYS */;
INSERT INTO `ACC_POST` VALUES (1,10,'LOOKING',NULL,'SANTA CLARA','CALIFORNIA',95051,'Hello I am looking for a private room in Santa Clara/ Mountain view, looking to lease from April 20th or so (dates flexible) Please message me @4098384444 if you have a place!',510,NULL,NULL,'SINGLE','APARTMENT',NULL,NULL),(2,11,'RENTING','1240 Mansion Grove','SUNNYVALE','CALIFORNIA',94086,'I am looking for a female room mate at apartments from April 21st to December 2019. Dates are negotiable. Rent is $510 + utilities. Please contact 4448882121 if interested. ',510,1,1,'SHARED','STUDIO',NULL,NULL),(3,3,'RENTING',NULL,'SANTA CLARA','CALIFORNIA',95051,'Accommodation available for a girl in Master bedroom at Domicilio apartments, Santa Clara starting from 1st May to September end. In-house washer and dryer. Rent: $520+ utilities \nUtilities: wifi, electricity and water\nIn-house: Refrigerator, dishwasher, washer and dryer unit \nAmenities: swimming pool, Jacuzzi, gym, parking\nContact: 4443334123\nWalkable distance to Santa Clara University, Starbucks, Caltrain Station and have a VTA stop right outside.',520,2,2,'SINGLE','APARTMENT',NULL,NULL);
/*!40000 ALTER TABLE `ACC_POST` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ACC_RESPONSE`
--

DROP TABLE IF EXISTS `ACC_RESPONSE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ACC_RESPONSE` (
  `ACC_RESPONSE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `ACC_POST_ID` int(11) NOT NULL,
  `USER_ID` int(11) NOT NULL,
  `A_RESPONSE_MESSAGE` varchar(1000) NOT NULL,
  `A_R_DATE_POSTED` date DEFAULT NULL,
  `A_R_TIME_POSTED` time DEFAULT NULL,
  PRIMARY KEY (`ACC_RESPONSE_ID`),
  KEY `USER_ID` (`USER_ID`),
  KEY `ACC_POST_ID` (`ACC_POST_ID`),
  CONSTRAINT `acc_response_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`USER_ID`),
  CONSTRAINT `acc_response_ibfk_2` FOREIGN KEY (`ACC_POST_ID`) REFERENCES `acc_post` (`ACC_POST_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACC_RESPONSE`
--

LOCK TABLES `ACC_RESPONSE` WRITE;
/*!40000 ALTER TABLE `ACC_RESPONSE` DISABLE KEYS */;
INSERT INTO `ACC_RESPONSE` VALUES (1,3,10,'I am interested. Is it still available?',NULL,NULL),(2,2,10,'How many people stay with you?',NULL,NULL),(3,1,11,'I have a similar listing available. PM me!',NULL,NULL),(4,1,11,'I am looking for a roommate! check ur text!',NULL,NULL);
/*!40000 ALTER TABLE `ACC_RESPONSE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ALL_EVENTS`
--

DROP TABLE IF EXISTS `ALL_EVENTS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ALL_EVENTS` (
  `EVENT_ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) NOT NULL,
  `EVENT_TITLE` varchar(100) NOT NULL,
  `EVENT_TYPE` enum('SCU','OUTSIDE SCU') NOT NULL,
  `EVENT_ADDRESS` varchar(100) DEFAULT NULL,
  `EVENT_CITY` varchar(50) DEFAULT NULL,
  `EVENT_STATE` varchar(45) DEFAULT NULL,
  `EVENT_ZIP` bigint(20) DEFAULT NULL,
  `EVENT_DESCRIPTION` varchar(5000) NOT NULL,
  `EVENT_PRICE` float DEFAULT NULL,
  `EVENT_CATEGORY` varchar(100) DEFAULT NULL,
  `EVENT_URL` varchar(2000) NOT NULL,
  `EVENT_DATE` date NOT NULL,
  `EVENT_DATE_POSTED` date DEFAULT NULL,
  `EVENT_TIME_POSTED` time DEFAULT NULL,
  PRIMARY KEY (`EVENT_ID`),
  KEY `USER_ID` (`USER_ID`),
  CONSTRAINT `all_events_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ALL_EVENTS`
--

LOCK TABLES `ALL_EVENTS` WRITE;
/*!40000 ALTER TABLE `ALL_EVENTS` DISABLE KEYS */;
INSERT INTO `ALL_EVENTS` VALUES (1,1,'Coffee Chat with Graduate Business Admissions','SCU','Starbucks 1390 Pear Ave','Mountain View','CA',94043,'Stop by and have an informal conversation with our admissions team about our Evening MBA and our Specialized Master’s Degree programs in Business Analytics, Finance, Information Systems and online Marketing.',0,'Networking','https://www.scu.edu/events/#!view/event/event_id/85084','2019-04-16',NULL,NULL),(2,7,'Social Impact Fair','SCU','Williman Room, Benson Center ','Santa Clara','CA',95030,'Want to have an impact on the community and world around you? Wondering how to get started?  SCU students and alumni are invited to connect with a variety of social impact organizations to learn more about them and possible opportunities. 4:00 p.m. - 6:00 p.m. PDT ',10,'Networking','http://lwcal.scu.edu/careercenter/#!view/event/event_id/66589','2019-05-31',NULL,NULL),(3,2,'Accounting Research Seminar','SCU','Lucas Hall 201, 500 El Camino Real ','Santa Clara','CA',95030,'The Accounting department would like to invite you to a research seminar in May. ',20,'Seminar','http://lwcal.scu.edu/accounting/#!view/event/event_id/70022','2019-05-10',NULL,NULL),(4,2,'Internet of Things World','OUTSIDE SCU','Santa Clara Convention Center 5001 Great America Parkway','Santa Clara','CA',95040,'The 6th annual Internet of Things World, co-located with Connected & Autonomous Vehicles, is the global conference and exhibition where strategists, technologists, developers and implementers connect, putting IoT into action across industry verticals. Taking place May 13 – 16 in the heart of Silicon Valley, this year’s event will welcome 12,500+ attendees, 400+ speakers, and 300+ exhibitors with a focus on the intersection of industries and IoT innovation. Mon, May 13, 2019, 8:00 AM –\nThu, May 16, 2019, 5:00 PM PDT',10,'Seminar','https://www.eventbrite.com/e/iot-world-2019-registration-53877944382?aff=ebdssbcitybrowse','2019-05-16',NULL,NULL),(5,2,'Internet of Things World','OUTSIDE SCU','Santa Clara Convention Center\n5001 Great America Parkway','Santa Clara','CA',95040,'The 6th annual Internet of Things World, co-located with Connected & Autonomous Vehicles, is the global conference and exhibition where strategists, technologists, developers and implementers connect, putting IoT into action across industry verticals. Taking place May 13 – 16 in the heart of Silicon Valley, this year’s event will welcome 12,500+ attendees, 400+ speakers, and 300+ exhibitors with a focus on the intersection of industries and IoT innovation. Mon, May 13, 2019, 8:00 AM – Thu, May 16, 2019, 5:00 PM PDT',0,'Seminar','https://www.eventbrite.com/e/iot-world-2019-registration-53877944382?aff=ebdssbcitybrowse','2019-05-13',NULL,NULL),(6,11,'Philly All Day Equity Comp Event & Happy Hour','OUTSIDE SCU','Radnor Valley Country Club 555 Sproul Road ','Villanova','PA',19085,'Join us for the annual Philly All Day event! The event this year will be held at the Radnor Valley Country Club and will include four great sessions of equity copmensation content, lunch, networking, and happy hour. This is a great way to keep up with the latest and greatest developments in equity compensation, win great prizes, and network.\nThank you to our location sponsor, Plan Management, and our lead Sponsors Aon, Deloitte, and Fidelity!\nThank you also to the other sponsors making this awesome event possible:\nE*TRADE is hosting our end-of-day networking happy hour!\nAdditionally, we’ll have exciting door prizes thanks to Charles Schwab!',0,NULL,'https://www.scu.edu/events/#!view/event/date/20190606/event_id/99511','2019-06-06',NULL,NULL);
/*!40000 ALTER TABLE `ALL_EVENTS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ALUMNI`
--

DROP TABLE IF EXISTS `ALUMNI`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ALUMNI` (
  `ALUMNI_ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) NOT NULL,
  `YEAR_OF_GRAD` int(11) DEFAULT NULL,
  PRIMARY KEY (`ALUMNI_ID`),
  KEY `USER_ID` (`USER_ID`),
  CONSTRAINT `alumni_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ALUMNI`
--

LOCK TABLES `ALUMNI` WRITE;
/*!40000 ALTER TABLE `ALUMNI` DISABLE KEYS */;
INSERT INTO `ALUMNI` VALUES (1,3,2017),(2,5,2018);
/*!40000 ALTER TABLE `ALUMNI` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `COURSE`
--

DROP TABLE IF EXISTS `COURSE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `COURSE` (
  `COURSE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `COURSE_NAME` varchar(65) NOT NULL,
  `COURSE_TYPE` enum('CORE','ELECTIVE') NOT NULL,
  PRIMARY KEY (`COURSE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COURSE`
--

LOCK TABLES `COURSE` WRITE;
/*!40000 ALTER TABLE `COURSE` DISABLE KEYS */;
INSERT INTO `COURSE` VALUES (1,'Object-Oriented Analysis and Programming','CORE'),(2,'Information Systems Analysis & Design','CORE'),(3,'Database Management Systems','CORE'),(4,'Information Systems Analysis & Design','CORE'),(5,'Information Systems Policy and Strategy','CORE'),(6,'Telecommunication & Buisness Networks','CORE'),(7,'Software Project Management','CORE'),(8,'Business Intelligence & Data Warehousing','ELECTIVE'),(9,'E-Business Technologies: Virtualization & Cloud Computing','ELECTIVE'),(10,'Big Data Modeling and Analytics','ELECTIVE'),(11,'Dashboards, Scorecards & Visualization','ELECTIVE'),(12,'Web Programming','ELECTIVE'),(13,'Machine Leraning','ELECTIVE'),(14,'Information Technology: Ethics & Public Policy','CORE'),(15,'MSIS Master\'s Thesis','CORE'),(16,'Capstone Design Proposal','CORE'),(17,'Capstone Design Project 1','CORE'),(18,'Capstone Design Project 2','CORE'),(19,'Curricular Practicum Education','CORE'),(20,'Extended Curricular Practicum Education','ELECTIVE'),(21,'Data Science Analysis with Python','ELECTIVE'),(22,'The Internet of Things','ELECTIVE'),(23,'Reinforcement Learning','ELECTIVE'),(24,'Information Security Management','ELECTIVE'),(25,'Computer Forensics','ELECTIVE'),(26,'ERP Systems','ELECTIVE'),(27,'The Business of Cloud Computing','ELECTIVE'),(28,'Secure Systems Development and Evaluation','ELECTIVE'),(29,'Mobile Programming','ELECTIVE'),(30,'Information Security Management','ELECTIVE'),(31,'Innovation in the Valley and Beyond','ELECTIVE'),(32,'Management of High-Technology Firms Seminar','ELECTIVE'),(33,'Leading Teams and Projects','ELECTIVE'),(34,'New Product Development','ELECTIVE'),(35,'Supply Chain Outsourcing','ELECTIVE'),(36,'Supply Chain Management','ELECTIVE'),(37,'Operations Management','ELECTIVE'),(38,'Financial & Managerial Accounting','CORE'),(39,'Building Leading HI-Perf Teams/Orgs','CORE'),(40,'Computer Based Decision Models','CORE'),(41,'Principles of Marketing','CORE'),(42,'Principles of Finance','CORE'),(43,'Microeconomics for Business Decision with Econ','CORE'),(44,'Math for Finance & Analytics','CORE'),(45,'Econometrics','CORE'),(46,'Marketing Analytics','CORE'),(47,'Business Analytics Practicum/Capstone','CORE'),(48,'Machine Learning','CORE'),(49,'Data Analytics (with Python)','CORE'),(50,'R programming','CORE'),(51,'Database Management Systems - Fundamentals','CORE'),(52,'Analytics of Optimal Pricing & New Product Decisions','ELECTIVE'),(53,'Time-Series Analysis','ELECTIVE'),(54,'Analytics of Finance','ELECTIVE'),(55,'FinTech','ELECTIVE'),(56,'Marketing Analytics II','ELECTIVE'),(57,'DBMS - Design, Development & Administration','ELECTIVE'),(58,'Automated Software Build & Release Systems','ELECTIVE'),(59,'Big Data Modeling & Analytics','ELECTIVE'),(60,'Mobile Payment & Blockchain','ELECTIVE'),(61,'Deep Learning','ELECTIVE'),(62,'Social Network Analytics','ELECTIVE'),(63,'Financial Forecasting & Analysis','CORE'),(64,'Corporated Finance','CORE'),(65,'Investments','CORE'),(66,'Math for Finance & Analytics','CORE'),(67,'R Programming','CORE'),(68,'Data Analytics (with Python)','CORE'),(69,'Econometrics','CORE'),(70,'Time-Series Analysis','CORE'),(71,'Analytics for Finance','CORE'),(72,'Database Management Systems - Fundamentals of SQL','CORE'),(73,'International Financial Management','ELECTIVE'),(74,'Mergers, Acquisitions & Corporate Governance','ELECTIVE'),(75,'Real Estate Finance','ELECTIVE'),(76,'Risk Management','ELECTIVE'),(77,'Emerging Company Finance','ELECTIVE'),(78,'Business Valuation','ELECTIVE'),(79,'Financial Engineering','ELECTIVE'),(80,'Behavioral Corporate Finance','ELECTIVE'),(81,'Financial Markets & Instruments','ELECTIVE'),(82,'FinTech','ELECTIVE'),(83,'Social Network Analytics','ELECTIVE'),(84,'Machine Learning','ELECTIVE');
/*!40000 ALTER TABLE `COURSE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `COURSE_PROGRAM`
--

DROP TABLE IF EXISTS `COURSE_PROGRAM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `COURSE_PROGRAM` (
  `COURSE_PROG_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PROGRAM_ID` int(11) NOT NULL,
  `COURSE_ID` int(11) NOT NULL,
  PRIMARY KEY (`COURSE_PROG_ID`),
  KEY `COURSE_ID` (`COURSE_ID`),
  KEY `PROGRAM_ID` (`PROGRAM_ID`),
  CONSTRAINT `course_program_ibfk_1` FOREIGN KEY (`COURSE_ID`) REFERENCES `course` (`COURSE_ID`),
  CONSTRAINT `course_program_ibfk_2` FOREIGN KEY (`PROGRAM_ID`) REFERENCES `program` (`PROGRAM_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COURSE_PROGRAM`
--

LOCK TABLES `COURSE_PROGRAM` WRITE;
/*!40000 ALTER TABLE `COURSE_PROGRAM` DISABLE KEYS */;
INSERT INTO `COURSE_PROGRAM` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7),(8,1,8),(9,1,9),(10,1,10),(11,1,11),(12,1,12),(13,1,13),(14,1,14),(15,1,15),(16,1,16),(17,1,17),(18,1,18),(19,1,19),(20,1,20),(21,1,21),(22,1,22),(23,1,23),(24,1,24),(25,1,25),(26,1,26),(27,1,27),(28,1,28),(29,1,29),(30,1,30),(31,1,31),(32,1,32),(33,1,33),(34,1,34),(35,1,35),(36,1,36),(37,1,37),(38,1,38),(39,1,39),(40,1,40),(41,2,41),(42,2,42),(43,2,43),(44,2,44),(45,2,45),(46,2,46),(47,2,47),(48,2,48),(49,2,49),(50,2,50),(51,2,51),(52,2,52),(53,2,53),(54,2,54),(55,2,55),(56,2,56),(57,2,57),(58,2,58),(59,2,59),(60,2,60),(61,2,61),(62,2,62),(63,3,63),(64,3,64),(65,3,65),(66,3,66),(67,3,67),(68,3,68),(69,3,69),(70,3,70),(71,3,71),(72,3,72),(73,3,73),(74,3,74),(75,3,75),(76,3,76),(77,3,77),(78,3,78),(79,3,79),(80,3,80),(81,3,81),(82,3,82),(83,3,83),(84,3,84);
/*!40000 ALTER TABLE `COURSE_PROGRAM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `JOB_POST`
--

DROP TABLE IF EXISTS `JOB_POST`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `JOB_POST` (
  `JOB_POST_ID` int(11) NOT NULL AUTO_INCREMENT,
  `ALUMNI_ID` int(11) NOT NULL,
  `COMPANY_NAME` varchar(100) NOT NULL,
  `POSITION` varchar(100) NOT NULL,
  `JOB_DESCRIPTION` varchar(5000) NOT NULL,
  `LOCATION` varchar(100) DEFAULT NULL,
  `EXPERIENCE_REQ` int(11) DEFAULT NULL,
  `JOB_DATE_POSTED` date DEFAULT NULL,
  `JOB_TIME_POSTED` time DEFAULT NULL,
  `JOB_CATEGORY` enum('PART TIME','FULL TIME','INTERNSHIP') NOT NULL,
  PRIMARY KEY (`JOB_POST_ID`),
  KEY `ALUMNI_ID` (`ALUMNI_ID`),
  CONSTRAINT `job_post_ibfk_1` FOREIGN KEY (`ALUMNI_ID`) REFERENCES `alumni` (`ALUMNI_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `JOB_POST`
--

LOCK TABLES `JOB_POST` WRITE;
/*!40000 ALTER TABLE `JOB_POST` DISABLE KEYS */;
INSERT INTO `JOB_POST` VALUES (1,1,'Genentech','Data Analyst Intern','We are looking for a Data Rockstar! An ideal candidate will have end to end experience in retrieving data using a query language (SQL, Python, etc.) and developing an effective executive level analytics dashboard that clearly communicates the data story. The ideal candidate should have a background in analytics and statistics, the ability to foster relationships with staff across departments and be motivated to continuously achieve positive results. S/he should also be able to effectively handle ad hoc requests with little guidance.\n• Develop effective business intelligence strategies and analytics solutions.\n• Oversee analytics projects to extract, manage, and analyze data from multiple applications, ensuring that deadlines are met.\n• Apply statistics and data modeling to gain actionable business insights and boost productivity and revenue.\n• Enforce company policies and procedures to ensure quality and prevent discrepancies.\n• Communicate and track key performance metrics across departments.\n• Identify business opportunities and ensure customer satisfaction.\n• Generate reports of findings and present these to senior management.\n• Keep abreast of industry best practices and policies.\n• Generate insights and storylines through translation of metrics and a deep understanding of our internal processes, customers, and products\n• Present recommendations to senior leadership, and drive the “follow through” of those recommendations to ensure smooth execution with a diverse array of cross-functional partners\n• Define critical KPIs and build core operating dashboards to help teams drive operational rigor and manage performance\n• Solve and present complex problems in an understandable way to stakeholders, business leaders, and executives','South San Francisco',0,NULL,NULL,'INTERNSHIP'),(2,1,'NetApp','Business Intelligence Analyst','• Lead requirements gathering sessions, analyze requirements, design and develop analytical projects working together with users finding the best possible solution to a given business problem\n• Contribute to data aggregation strategy for reporting, dashboards, and self-service analytics\n• Build relationships with key business partners\n• Build highly customized reports and develop creative solutions to apply business logic\n• Document new and existing models, solutions, and implementations.\n• Ensure that collected data is within required quality standards\n• Advanced SQL skills and experience writing complex queries\n• Advanced data visualization skills, show the ability to tell stories and make dashboards actionable\n• Performance tuning and troubleshooting experience\n• Understanding of Tableau solution infrastructure and knowledge\n• Experience working directly with business users to build reports, dashboards and solving business questions with data ','Sunnyvale',1,NULL,NULL,'FULL TIME'),(3,2,'ServiceNow','Business Intelligence Analyst',' • Apply statistics and data modeling to gain actionable business insights and boost productivity and revenue.\n• Enforce company policies and procedures to ensure quality and prevent discrepancies.\n• Communicate and track key performance metrics across departments.\n• Identify business opportunities and ensure customer satisfaction.\n• Generate reports of findings and present these to senior management.\n• Expert knowledge of Tableau, MS Excel and other BI analytics tools.\n• Working knowledge of SQL (Impala), Python, SAP HANA, etc.\n• Working knowledge of big data instances: Cloudera, Azure, Snowflake, and the like.\n• Data Science and ServiceNow Performance Analytics experience preferred.','Santa Clara',1,NULL,NULL,'FULL TIME'),(4,2,'	Palo Alto Networks','Data Analyst',' Experience analyzing data - Strong Salesforce and Marketo experience - Detail Oriented.','Palo Alto',1,NULL,NULL,'FULL TIME');
/*!40000 ALTER TABLE `JOB_POST` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `JOB_RESPONSE`
--

DROP TABLE IF EXISTS `JOB_RESPONSE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `JOB_RESPONSE` (
  `JOB_RESPONSE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `JOB_POST_ID` int(11) NOT NULL,
  `STUDENT_ID` int(11) NOT NULL,
  `ATTACH_RESUME` varchar(5000) DEFAULT NULL,
  `ATTACH_COVER_LETTER` varchar(5000) DEFAULT NULL,
  `J_RESPONSE_MESSAGE` varchar(1000) NOT NULL,
  `J_R_DATE_POSTED` date DEFAULT NULL,
  `J_R_TIME_POSTED` time DEFAULT NULL,
  PRIMARY KEY (`JOB_RESPONSE_ID`),
  KEY `STUDENT_ID` (`STUDENT_ID`),
  KEY `JOB_POST_ID` (`JOB_POST_ID`),
  CONSTRAINT `job_response_ibfk_1` FOREIGN KEY (`STUDENT_ID`) REFERENCES `student` (`STUDENT_ID`),
  CONSTRAINT `job_response_ibfk_2` FOREIGN KEY (`JOB_POST_ID`) REFERENCES `job_post` (`JOB_POST_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `JOB_RESPONSE`
--

LOCK TABLES `JOB_RESPONSE` WRITE;
/*!40000 ALTER TABLE `JOB_RESPONSE` DISABLE KEYS */;
INSERT INTO `JOB_RESPONSE` VALUES (1,4,1,NULL,NULL,'Hi, I am a MSIS student at SCU. I am interested in this position. Please check the attached resume. Thanks.',NULL,NULL),(2,1,1,NULL,NULL,'Hi, I am interested in this position. Please see attached resume and covber letter. Thankyou.',NULL,NULL),(3,2,2,NULL,NULL,'Hello, I am a MSIS student at SCU. I am interested in this position. Please check the attached resume. Thanks.',NULL,NULL),(4,3,3,NULL,NULL,'Hi, I am a MSBA student at SCU. I am interested in this position. Please check the attached resume. Thankyou.',NULL,NULL),(5,2,2,NULL,NULL,'Hello, I am interested in this position. I have all skills required for this position. please have a look at the attached resume. Thanks and regards..',NULL,NULL),(6,1,1,NULL,NULL,'Hello, I am a MSIS student at SCU, graduatibng in June 2019. I am interested in this position. Please check the attached resume and cover letter. Thanks.',NULL,NULL),(7,2,8,NULL,NULL,'Hi, I am a MSBA student at SCU. I am interested in this position. It would be great if I could get a chance to talk to you to discuss my experiences.Thanks.',NULL,NULL),(8,4,9,NULL,NULL,'Hi, I am a MSIS student at SCU. I am interested in this position. Please check the attached resume. Thanks.',NULL,NULL),(9,4,3,NULL,NULL,'Hi, I am very much interested in this position. I have 1 yr of exp as well of data analyst and my academics also match with the job description. Let me know. Thankyou.',NULL,NULL);
/*!40000 ALTER TABLE `JOB_RESPONSE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MARKET_POST`
--

DROP TABLE IF EXISTS `MARKET_POST`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `MARKET_POST` (
  `MARKET_POST_ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) NOT NULL,
  `MARKET_POST_TITLE` varchar(100) NOT NULL,
  `MARKET_POST_TYPE` enum('BUYING','SELLING') NOT NULL,
  `MARKET_ADDRESS` varchar(100) DEFAULT NULL,
  `MARKET_CITY` varchar(50) DEFAULT NULL,
  `MARKET_STATE` varchar(45) DEFAULT NULL,
  `MARKET_ZIP` bigint(20) DEFAULT NULL,
  `OBJECT_DESCRIPTION` varchar(5000) NOT NULL,
  `OBJECT_PRICE` float DEFAULT NULL,
  `OBJECT_CONDITION` enum('FAIR','NEW','EXCELLENT','GOOD','LIKE NEW') NOT NULL,
  `MARKET_STATUS` enum('SOLD','NOT SOLD') NOT NULL,
  `OBJECT_CATEGORY` varchar(100) NOT NULL,
  `MARKET_DATE_POSTED` date DEFAULT NULL,
  `MARKET_TIME_POSTED` time DEFAULT NULL,
  PRIMARY KEY (`MARKET_POST_ID`),
  KEY `USER_ID` (`USER_ID`),
  CONSTRAINT `market_post_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MARKET_POST`
--

LOCK TABLES `MARKET_POST` WRITE;
/*!40000 ALTER TABLE `MARKET_POST` DISABLE KEYS */;
INSERT INTO `MARKET_POST` VALUES (1,1,'Selling a Sofa','SELLING','Frances St','Sunnyvale','CA',95050,'IKEA VIMLE loveseat in beige. Perfectly cared. Like new. Removable and machine washable cover.',150,'LIKE NEW','NOT SOLD','FURNITURE',NULL,NULL),(2,3,'2014 Apple MacBook Pro Retina 15\" i7 2.5Ghz 16GB 256GB','SELLING',NULL,'Redwood City','CA',NULL,'Macbook Pro Retina 15inch ,Core I7,16gigs RAM,256 SSD,Mojave OS installed\nNOTES:All of our MacBooks have been professionally inspected, cleaned, and tested.Guaranteed to work 100% perfectly. the screen has some of the anti-reflective coating that is worn off due to screen delamination, a common issue on these MacBooks. When the screen is powered on, the wear are less visible, The wear are more visible when the screen is powered off.\nHowever, this does not affect the performance and when turned on, the screen resolution is perfect.Otherwise, its in excellent condition overall.\ndo NOT contact me with unsolicited services or offers',499,'FAIR','SOLD','ELECTRONICS & COMPUTER',NULL,NULL),(3,8,'Chair Needed','BUYING',NULL,'Santa Clara','CA',95050,'Want a chair which is new. The color should not be faded.',50,'LIKE NEW','NOT SOLD','FURNITURE',NULL,NULL),(4,6,'Need a TV','BUYING',NULL,'Sunnyvale','CA',95050,'Should be in working condition. 47\" 1080p LED-LCD TV.',80,'LIKE NEW','NOT SOLD','ELECTRONICS & COMPUTER',NULL,NULL),(5,9,'Sony 46\" BRAVIA HX729 LED Smart TV incl remote','SELLING',NULL,'Los Gatos','CA',NULL,'There is a dim spot on the upper right.\nSony KDL-46HX729 46\" LED HX729 Internet TV \nMotionflow XR 480\nSee It All in 3D\nFull HD 1080p\nAmbient Sensor\nBuilt-in WiFi for Internet Streaming & Connectivity\nOriginally $1900.\nThere is a dim area on the top right as shown on the photos\nSpec https://docs.sony.com/release/specs/KDL46HX729_mksp.pdf',160,'FAIR','NOT SOLD','ELECTRONICS & COMPUTER',NULL,NULL),(6,5,'Set of 4 halogen floor lamps','SELLING',NULL,'Fremont','CA',NULL,'Works. Includes 3 halogen bulbs',30,'NEW','SOLD','HOUSEHOLD',NULL,NULL),(7,11,'Selling Samsung 55\" 4k UHD TV','SELLING','2147 Newhall Street','Santa Clara','CA',95050,'Selling Samsung 55\" 4k UHD TV',300,'NEW','NOT SOLD','FURNITURE',NULL,NULL);
/*!40000 ALTER TABLE `MARKET_POST` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MARKET_RESPONSE`
--

DROP TABLE IF EXISTS `MARKET_RESPONSE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `MARKET_RESPONSE` (
  `MARKET_RESPONSE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `MARKET_POST_ID` int(11) NOT NULL,
  `USER_ID` int(11) NOT NULL,
  `M_RESPONSE_MESSAGE` varchar(1000) NOT NULL,
  `M_R_DATE_POSTED` date DEFAULT NULL,
  `M_R_TIME_POSTED` time DEFAULT NULL,
  PRIMARY KEY (`MARKET_RESPONSE_ID`),
  KEY `USER_ID` (`USER_ID`),
  KEY `MARKET_POST_ID` (`MARKET_POST_ID`),
  CONSTRAINT `market_response_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`USER_ID`),
  CONSTRAINT `market_response_ibfk_2` FOREIGN KEY (`MARKET_POST_ID`) REFERENCES `market_post` (`MARKET_POST_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MARKET_RESPONSE`
--

LOCK TABLES `MARKET_RESPONSE` WRITE;
/*!40000 ALTER TABLE `MARKET_RESPONSE` DISABLE KEYS */;
INSERT INTO `MARKET_RESPONSE` VALUES (1,1,4,'Im interseted in buying the sofa. But i can pay $100 for it.',NULL,NULL),(2,6,3,'Im interseted. Please let me know if its still available',NULL,NULL),(3,1,8,'Im interseted. Please look at your messages.',NULL,NULL),(4,1,6,'Is it still available?',NULL,NULL),(5,2,10,'Interested. Please revert.',NULL,NULL),(6,2,11,'Im interested but can the price by negotiated.',NULL,NULL),(7,3,7,'Im selling a chair. It is like new. The price is $50',NULL,NULL),(8,3,9,'Please check your messages',NULL,NULL),(9,4,9,'Selling a tv. Can the price range be increased.',NULL,NULL),(10,5,4,'Im interseted. But i can pay $150 for it.',NULL,NULL),(11,5,8,'Interested.',NULL,NULL),(12,5,10,'Interested. Check your messages',NULL,NULL),(13,1,11,'Is it available? I\'m interested.',NULL,NULL),(14,1,11,'is it available?',NULL,NULL);
/*!40000 ALTER TABLE `MARKET_RESPONSE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PROGRAM`
--

DROP TABLE IF EXISTS `PROGRAM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `PROGRAM` (
  `PROGRAM_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PROGRAM_NAME` varchar(65) NOT NULL,
  PRIMARY KEY (`PROGRAM_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PROGRAM`
--

LOCK TABLES `PROGRAM` WRITE;
/*!40000 ALTER TABLE `PROGRAM` DISABLE KEYS */;
INSERT INTO `PROGRAM` VALUES (1,'Masters in Information Systems'),(2,'Masters in Finance'),(3,'Masters in Business Analytics');
/*!40000 ALTER TABLE `PROGRAM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Q_RESPONSE`
--

DROP TABLE IF EXISTS `Q_RESPONSE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `Q_RESPONSE` (
  `Q_RESPONSE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `QUESTION_ID` int(11) NOT NULL,
  `USER_ID` int(11) NOT NULL,
  `Q_R_DESCRIPTION` varchar(500) NOT NULL,
  `Q_R_DATE_POSTED` date DEFAULT NULL,
  `Q_R_TIME_POSTED` time DEFAULT NULL,
  PRIMARY KEY (`Q_RESPONSE_ID`),
  KEY `USER_ID` (`USER_ID`),
  KEY `QUESTION_ID` (`QUESTION_ID`),
  CONSTRAINT `q_response_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`USER_ID`),
  CONSTRAINT `q_response_ibfk_2` FOREIGN KEY (`QUESTION_ID`) REFERENCES `question` (`QUESTION_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=209 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Q_RESPONSE`
--

LOCK TABLES `Q_RESPONSE` WRITE;
/*!40000 ALTER TABLE `Q_RESPONSE` DISABLE KEYS */;
INSERT INTO `Q_RESPONSE` VALUES (1,1,1,'Go to Benson and talk to Bob',NULL,NULL),(2,1,3,'Meet Jessica in Adobe for catering job',NULL,NULL),(3,1,4,'Reach out to Charlie to work in library',NULL,NULL),(4,1,2,'Meet Bob to work in Bon Appetit',NULL,NULL),(5,2,11,'if you take under prof Robert Alvarez, then no.',NULL,NULL),(6,2,10,'Depends on the professor',NULL,NULL),(7,3,1,'Depends on what availability you give',NULL,NULL),(8,3,3,'Typically 12-16',NULL,NULL),(9,4,5,'Direct deposit',NULL,NULL),(10,4,2,'Check for first month and then direct deposit',NULL,NULL),(11,5,11,'It is compulsory to get an SSN. You will get the white-card from your supervisor.',NULL,NULL),(12,5,5,'White-card helps you get SSN and then you can start working',NULL,NULL),(13,6,1,'You will get your white card from the person under you will be working',NULL,NULL),(14,6,2,'Your manager will give a white card which you have to submit in HR office for getting an SSN',NULL,NULL),(15,7,4,'Passport, Bank Account details, White card',NULL,NULL),(16,7,10,'White card and passport',NULL,NULL),(17,8,11,'Yes.',NULL,NULL),(18,8,3,'Definitely ',NULL,NULL),(19,9,4,'Direct deposits',NULL,NULL),(20,10,3,'Yes you do',NULL,NULL),(21,10,5,'Once you get an oncampus job you can apply for SSN',NULL,NULL),(22,10,2,'Absolutely',NULL,NULL),(23,11,11,'You can work upto 19 hours a week on-campus',NULL,NULL),(24,11,10,'Maximum 19 hours per week',NULL,NULL),(25,11,1,'Depends on you, but less than 19',NULL,NULL),(26,12,1,'You will get a warning from HR office for the first time',NULL,NULL),(27,12,2,'You are not allowed to work more than 19 hours',NULL,NULL),(28,12,3,'Dont even try',NULL,NULL),(29,13,4,'Bon-Appetit',NULL,NULL),(30,13,11,'Adobe if you want to complete hours in 2-3 days',NULL,NULL),(31,13,3,'Lesser work at Bon-appetit',NULL,NULL),(32,14,5,'Contact Esther Cowles',NULL,NULL),(33,14,4,'Esther',NULL,NULL),(34,15,1,'Library, Media Services, Bon-Appetit, Adobe',NULL,NULL),(35,15,2,'Library, Church, Catering',NULL,NULL),(36,16,4,'Concessions',NULL,NULL),(37,16,3,'Go for Concessions',NULL,NULL),(38,17,1,'I can',NULL,NULL),(39,19,2,'No',NULL,NULL),(40,19,11,'Bi-weekly',NULL,NULL),(41,20,1,'I love this Italian place named Mio Vicino.',NULL,NULL),(42,20,2,'Try paradise biryani, if you like Indian food',NULL,NULL),(43,20,3,'Wrap this has good mediterranean options. Also, they have daily specials for $5.',NULL,NULL),(44,20,10,'pizza my heart, round table pizza, wicked chicken,Deedee',NULL,NULL),(45,21,11,'Go to the city to enjoy nightlife. SF has many places to visit during night like Pier, Bay Bridge, Ghirardelli square etc.',NULL,NULL),(46,22,3,'All the downtowns are good. SF is the best. You can go to san jose and palo alto too.',NULL,NULL),(47,22,10,'If you are looking for something near school, try santana row straits sino or rosie mcann or try San Jose downtown ',NULL,NULL),(48,22,4,'Try LOFT',NULL,NULL),(49,23,4,'Taco bell anytime..',NULL,NULL),(50,23,2,'7/11 if you want just some snacks',NULL,NULL),(51,23,4,'subway is best! momos',NULL,NULL),(52,23,5,'Chipotle, Taco bell, wicked chicken',NULL,NULL),(53,23,1,'Wrap this!',NULL,NULL),(54,23,3,'Deedee, 7/11',NULL,NULL),(55,24,11,'no place is safe in San Jose at night',NULL,NULL),(56,24,1,'If you want to go at safe place, try places in mountain view.',NULL,NULL),(57,24,4,'Anything in santana row',NULL,NULL),(58,25,1,'You can try Deedees. ',NULL,NULL),(59,26,2,'Kebab and Currys is the best! cheap too.',NULL,NULL),(60,27,3,'Paradise Biryani',NULL,NULL),(61,27,5,'Lunch @ Himalayan Kitchen. Best buffet ever.',NULL,NULL),(62,27,11,'kebab and curry, Zareens',NULL,NULL),(63,27,4,'If for lunch, try Mantra in mountain view. it has buffet. good food and various options available. per plate is somehwere around $18.',NULL,NULL),(64,28,5,'SP2 in San Jose, Mayuri Banquet hall, ',NULL,NULL),(65,28,4,'There was one networking event of scu in SP2, san jose. It went very well. You can try considering it as one option.',NULL,NULL),(66,29,1,'Crepes Bistro near timberleaf has vegan options',NULL,NULL),(67,29,2,'I think, most of the restaurants have few vegan items',NULL,NULL),(68,30,4,'Cheesecake factory, le jardin, yard house',NULL,NULL),(69,31,10,'It depends on what your budget is, what type of food you prefer and the distance you are willing to travel. So mention these things too.',NULL,NULL),(70,32,2,'Go Broncos!',NULL,NULL),(71,32,3,'chillis , best place for happy hours',NULL,NULL),(72,32,11,'chillis',NULL,NULL),(73,33,11,'Big data, Data science with python, Machine learning, DBMS',NULL,NULL),(74,33,2,'good communication skills along with database knowledge and viz skills',NULL,NULL),(75,33,3,'Python, Big data, ML, database design',NULL,NULL),(76,34,1,'Michael Sherman is better',NULL,NULL),(77,34,4,'Michael Sherman',NULL,NULL),(78,34,3,'Sudhir Wadhwa',NULL,NULL),(79,35,5,'Yes, it covers only tableau',NULL,NULL),(80,35,1,'No, the professor will teach you how to connect apis as well if you take under sudhir wadhwa',NULL,NULL),(81,35,4,'professor sudhir wadhwa teaches only tableau tool.',NULL,NULL),(82,35,2,'Yes it does',NULL,NULL),(83,36,4,'4 units',NULL,NULL),(84,36,2,'4 units',NULL,NULL),(85,36,1,'I think it is 4 units',NULL,NULL),(86,37,11,'No, its easier.',NULL,NULL),(87,37,5,'No its easier, plus the professor is better.',NULL,NULL),(88,37,2,'No its easy',NULL,NULL),(89,38,3,'DBMS',NULL,NULL),(90,38,10,'Database',NULL,NULL),(91,38,11,'OOPS may be, not sure',NULL,NULL),(92,39,1,'Ethics, anytime!',NULL,NULL),(93,39,3,'ISPS',NULL,NULL),(94,39,2,'it depends on what you are better in naturally.',NULL,NULL),(95,39,11,'ISPS FOR SURE',NULL,NULL),(96,45,4,'Java fundamentals',NULL,NULL),(97,46,3,'It will be easy if you are familiar with the accounting terms',NULL,NULL),(98,46,5,'Try to complete the courses which are pre-requisites',NULL,NULL),(99,47,11,'DW&BI because it covers data visualization along with ETL',NULL,NULL),(100,47,4,'Data warehousing and business intelligence anytime',NULL,NULL),(101,48,3,'Depends on your interest',NULL,NULL),(102,48,2,'I would suggest taking BI if you are looking for data analytics role',NULL,NULL),(103,50,10,'eight to ten',NULL,NULL),(104,50,1,'Mostly all courses are of 3 units, so you can take 9 per quarter',NULL,NULL),(105,77,2,'I dont think so',NULL,NULL),(106,77,4,'yes',NULL,NULL),(107,77,11,'Both are same and have equal demand',NULL,NULL),(108,76,1,'W3schools, lynda courses',NULL,NULL),(109,76,3,'LinkedIn courses',NULL,NULL),(110,75,2,'Python',NULL,NULL),(111,75,3,'Both',NULL,NULL),(112,75,11,'R is much more useful',NULL,NULL),(113,74,10,'Data analytics, big data',NULL,NULL),(114,74,5,'Business analysis too',NULL,NULL),(115,73,4,'Python, SQL, R',NULL,NULL),(116,73,1,'Python and SQL',NULL,NULL),(117,73,3,'SQL is the most important',NULL,NULL),(118,72,1,'w3schools is good for practice. You can go through the lynda courses as well.',NULL,NULL),(119,72,2,'Leetcode, w3schools, Lynda courses',NULL,NULL),(120,72,4,'You will see many blogs on internet on advanced SQL, step by step exercises.',NULL,NULL),(121,72,5,'W3SCHOOLS',NULL,NULL),(122,71,1,'Analytical, business strategies',NULL,NULL),(123,71,3,'Data reporting, modelling, processing',NULL,NULL),(124,71,4,'Data warehousing, BI tools, Data analysis',NULL,NULL),(125,71,10,'Designing/modifying data warehouses',NULL,NULL),(126,71,2,'ETL',NULL,NULL),(127,71,11,'Data analysis,Data architecture,Data collection,Data controls,Data development,Data management,Data modeling,Data processing,Data visualization,Database familiarity',NULL,NULL),(128,70,3,'Its good to have basic understanding of stats. ',NULL,NULL),(129,70,1,'For business analysis, you dont have to.',NULL,NULL),(130,70,2,'If your work is more into data analysis, you need to know the stats',NULL,NULL),(131,70,11,'Not important but good to learn the basics.',NULL,NULL),(132,69,1,'Very important. interviewers always try to see if you are a good fit culturally.',NULL,NULL),(133,69,2,'They are equally important as technical skills.',NULL,NULL),(134,69,5,'Extremely',NULL,NULL),(135,68,3,'It totally depends on company to company and what team you will be in.',NULL,NULL),(136,68,4,'My recommendation would be just focus and excel in any one.',NULL,NULL),(137,68,11,'Both is, but totally depends on the job and the company',NULL,NULL),(138,67,1,'Both are required if you are into heavy machine learning path',NULL,NULL),(139,67,3,'If you know Python better, thats enough.',NULL,NULL),(140,67,11,'If you want to do statistical modelling, R would be better.',NULL,NULL),(141,67,1,'Both',NULL,NULL),(142,66,2,'power BI, Qlikview, Looker',NULL,NULL),(143,66,11,'Power BI is mostly used',NULL,NULL),(144,66,4,'power bi, qlikview',NULL,NULL),(145,65,10,'Qlikview, most used other than tableau. But it depends on company to company.',NULL,NULL),(146,64,3,'big data, cloud, data analysis',NULL,NULL),(147,64,1,'Data Analytics',NULL,NULL),(148,64,11,'Business analysis',NULL,NULL),(149,64,2,'Good communication skills, python, team work, ML, R',NULL,NULL),(150,63,1,'any data analysis medium - python, tableau',NULL,NULL),(151,63,4,'Languages like python, r and viz tools like tableau, qlikview, looker',NULL,NULL),(152,63,5,'SQL!!!!!! Be a pro in it',NULL,NULL),(153,63,11,'python, sql, tableau',NULL,NULL),(154,62,1,'Yes, all assignments and exams will require you to write programs',NULL,NULL),(155,62,3,'Yes you will write many programs using all concepts of OOPS.',NULL,NULL),(156,62,5,'Yes but if you are from CS background it shouldnt be a problem',NULL,NULL),(157,62,1,'No not at all. More of theory is taught.',NULL,NULL),(158,61,11,'Yes, if they dont have prerequisites',NULL,NULL),(159,61,4,'If core prerequisites are completed, you can take electives',NULL,NULL),(160,61,1,'Dont keep too many core subjects for the end',NULL,NULL),(161,60,11,'Students who did not get an internship are preferred for Industry capstone',NULL,NULL),(162,60,10,'You will get a preference if you did not work part-time intern',NULL,NULL),(163,40,3,'Basics of Python like data cleaning, visualiztion using python with different libraries',NULL,NULL),(164,40,1,'Basics of data analysis using python',NULL,NULL),(165,40,2,'pandas, numpy, scikit-learn libraries are covered',NULL,NULL),(166,40,3,'If it is Prof Wadhwa, he teaches more about Machine learning basics rather than Python.',NULL,NULL),(167,40,4,'Just the basics if you take under sudhir wadhwa',NULL,NULL),(168,41,5,'Its better if you take data science with python first.',NULL,NULL),(169,41,2,'I dont think so',NULL,NULL),(170,41,3,'I think database management systems is a prereq for ML',NULL,NULL),(171,41,11,'OOPS might be a prereq',NULL,NULL),(172,41,10,'No idea',NULL,NULL),(173,55,3,'I dont think so',NULL,NULL),(174,55,11,'Connect with Minh or Remy',NULL,NULL),(175,56,10,'Contact ms programs',NULL,NULL),(176,56,2,'Connect with Minh or Remy',NULL,NULL),(177,57,1,'Sorry, I dont think you will get it',NULL,NULL),(178,57,2,'Try talking to Minh',NULL,NULL),(179,58,4,'It is not easy',NULL,NULL),(180,58,11,'If you are familiar with law terms, you might find it easy',NULL,NULL),(181,58,5,'No its difficult',NULL,NULL),(182,59,2,'Industry capstone if you did not work as an intern, or else design project',NULL,NULL),(183,59,1,'Design capstone',NULL,NULL),(184,54,1,'If somebody drops that course only then you can get it',NULL,NULL),(185,54,3,'Very few chances that number of seats are increased',NULL,NULL),(186,54,4,'Talk to Minh if the course is really important for you',NULL,NULL),(187,42,5,'You have to keep only 9 units each quarter. So say each course is 3 units. then you can take only 3 units.',NULL,NULL),(188,43,2,'Yes because it is a pre-requisitie for other courses',NULL,NULL),(189,43,1,'Try to finish all pre-requisities in first quarter itself.',NULL,NULL),(190,44,1,'It is easy if you know the basics',NULL,NULL),(191,51,1,'No, there are prerequisites for electives',NULL,NULL),(192,51,2,'Nope',NULL,NULL),(193,52,11,'Prof. Shailesh Agarwal',NULL,NULL),(194,52,10,'S Agarwal',NULL,NULL),(195,53,5,'Contact Minh',NULL,NULL),(196,53,4,'Email msprograms',NULL,NULL),(204,20,11,'Try Pizza Guys',NULL,NULL),(205,63,11,'Big data tech stack these days is basic',NULL,NULL);
/*!40000 ALTER TABLE `Q_RESPONSE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `QUESTION`
--

DROP TABLE IF EXISTS `QUESTION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `QUESTION` (
  `QUESTION_ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) NOT NULL,
  `Q_DESCRIPTION` varchar(500) NOT NULL,
  `Q_CATEGORY` enum('COURSEWORK','HOT SKILLS','FOOD AND NIGHTLIFE','ON_CAMPUS') NOT NULL,
  `DATE_POSTED` date DEFAULT NULL,
  `TIME_POSTED` time DEFAULT NULL,
  PRIMARY KEY (`QUESTION_ID`),
  KEY `USER_ID` (`USER_ID`),
  CONSTRAINT `question_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `QUESTION`
--

LOCK TABLES `QUESTION` WRITE;
/*!40000 ALTER TABLE `QUESTION` DISABLE KEYS */;
INSERT INTO `QUESTION` VALUES (1,2,'Who to reach out if we are interested in working on campus?','ON_CAMPUS',NULL,NULL),(2,1,'Does Machine Learning course include text mining?','COURSEWORK',NULL,NULL),(3,4,'How many hours do we generally get while working in library?','ON_CAMPUS',NULL,NULL),(4,4,'How do we get paid while working on-campus? Cash/check or direct deposit?','ON_CAMPUS',NULL,NULL),(5,2,'What is a white-card? How do I get it? Is it necessary for SSN?','ON_CAMPUS',NULL,NULL),(6,7,'SSN office asked me to get a white-card? What is it? Where will I get it from?','ON_CAMPUS',NULL,NULL),(7,8,'What documents are required to apply for SSN?','ON_CAMPUS',NULL,NULL),(8,9,'Do we need a back account before applying for SSN?','ON_CAMPUS',NULL,NULL),(9,10,'What is the mode of payment if we work on-campus?','ON_CAMPUS',NULL,NULL),(10,11,'Do we require SSN to work on campus?','ON_CAMPUS',NULL,NULL),(11,8,'Are there any required hours that we need to work on-campus?','ON_CAMPUS',NULL,NULL),(12,4,'What happens if I work more than 19 hours a week?','ON_CAMPUS',NULL,NULL),(13,2,'Which catering is better work-wise? Adobe or Bon-Appetit?','ON_CAMPUS',NULL,NULL),(14,7,'Whom should I contact if i have to work in concessions?','ON_CAMPUS',NULL,NULL),(15,4,'What all are the options to work on-campus? ','ON_CAMPUS',NULL,NULL),(16,11,'What should i choose? Concessions, Adobe or Bon-Appetit? Looking for an easy shift.','ON_CAMPUS',NULL,NULL),(17,8,'Can someone cover my shift at Poke today 1-5pm?','ON_CAMPUS',NULL,NULL),(18,2,'Anybody free today to cover my shift at Cafe 455 from 11-2pm?','ON_CAMPUS',NULL,NULL),(19,8,'Are we paid on a monthly basis?','ON_CAMPUS',NULL,NULL),(20,8,'What are good restaurants around the school?','FOOD AND NIGHTLIFE',NULL,NULL),(21,9,'Hows the nightlife at bay area?','FOOD AND NIGHTLIFE',NULL,NULL),(22,2,'Any suggestions for clubs in bay area?','FOOD AND NIGHTLIFE',NULL,NULL),(23,9,'Any cheap eating places?','FOOD AND NIGHTLIFE',NULL,NULL),(24,11,'WHich food/ drink places are safe at late night?','FOOD AND NIGHTLIFE',NULL,NULL),(25,10,'Best Indian Food?','FOOD AND NIGHTLIFE',NULL,NULL),(26,1,'Where can I get a good Biryani?','FOOD AND NIGHTLIFE',NULL,NULL),(27,1,'Where can I get a homestyle indian food?','FOOD AND NIGHTLIFE',NULL,NULL),(28,1,'We are conducting a networking event near school, any good places to host the event outside the school?','FOOD AND NIGHTLIFE',NULL,NULL),(29,7,'Is there any vegan place around?','FOOD AND NIGHTLIFE',NULL,NULL),(30,7,'I am new to bay area. What do you guys recommend for food?','FOOD AND NIGHTLIFE',NULL,NULL),(31,9,'Best happy hours place? suggest some cheap places.','FOOD AND NIGHTLIFE',NULL,NULL),(32,1,'What are the courses that are most important to become a data analyst?','COURSEWORK',NULL,NULL),(33,1,'Under which professor is the Dashboard & Vizualization course much better?','COURSEWORK',NULL,NULL),(34,2,'What is that one best course no one should skip here?','COURSEWORK',NULL,NULL),(35,2,'Does the dashboard and viz course teach only tableau tool?','COURSEWORK',NULL,NULL),(36,2,'How much units is Econometrics with R?','COURSEWORK',NULL,NULL),(37,4,'Is ISPS more difficult than Ethics?','COURSEWORK',NULL,NULL),(38,4,'What are the prerequisites for taking big data?','COURSEWORK',NULL,NULL),(39,1,'Which is more diffficult? ISPS or Ethics?','COURSEWORK',NULL,NULL),(40,9,'What do they cover in the Data Analysis with Python? ','COURSEWORK',NULL,NULL),(41,8,'is there any prereq for taking ML?','COURSEWORK',NULL,NULL),(42,8,'Can you take more than 3 courses in any quarter?','COURSEWORK',NULL,NULL),(43,8,'Should we take OOPS in 1st quarter?','COURSEWORK',NULL,NULL),(44,11,'Is OOPS class easy?','COURSEWORK',NULL,NULL),(45,10,'What is taught in OOPs class?','COURSEWORK',NULL,NULL),(46,11,'Is Accounting class easy? Should I take it in 1st quarter?','COURSEWORK',NULL,NULL),(47,7,'Which subject is more beneficial Data Warehousing and Business Intelligence or Dashboards and Vizualization?','COURSEWORK',NULL,NULL),(48,1,'Between Business intelligence and Cloud Computing, which one should i take?','COURSEWORK',NULL,NULL),(49,1,'Is Business Intelligence course better than Cloud Computing?','COURSEWORK',NULL,NULL),(50,2,'How many units can you take per quarter?','COURSEWORK',NULL,NULL),(51,4,'Can we take electives in the first quarter?','COURSEWORK',NULL,NULL),(52,9,'Which professor should i take DBMS under?','COURSEWORK',NULL,NULL),(53,11,'All courses are full and i could only take 1 course this quarter? What should i do?','COURSEWORK',NULL,NULL),(54,7,'I am waitlisted in 2 courses. what are the chances that i will get the course?','COURSEWORK',NULL,NULL),(55,8,'My waitlist position is 3. Is there a chance that it will get cleared','COURSEWORK',NULL,NULL),(56,9,'Its my last quarter and I am left with 1 core course. The course is not being offered. What shall i do?','COURSEWORK',NULL,NULL),(57,10,'My waitlist position is 5. What should i do to get the subject?','COURSEWORK',NULL,NULL),(58,10,'Is Ethics easy?','COURSEWORK',NULL,NULL),(59,11,'What type of Capstone project should i do?','COURSEWORK',NULL,NULL),(60,2,'How often do people get Industry Capstone?','COURSEWORK',NULL,NULL),(61,2,'Can I take electives before finishing core courses?','COURSEWORK',NULL,NULL),(62,2,'Is there going to be a lot of coding in the Java class? ','COURSEWORK',NULL,NULL),(63,2,'I am interested in the data analytics field. What are the skills required for the same?','HOT SKILLS',NULL,NULL),(64,4,'which are the most trending skills for a job in MSIS field?','HOT SKILLS',NULL,NULL),(65,2,'Recommend tools for developing data visualization skills other than Tableau','HOT SKILLS',NULL,NULL),(66,7,'other than tableau what are the tools used for viz in industry?','HOT SKILLS',NULL,NULL),(67,8,'Python or R?','HOT SKILLS',NULL,NULL),(68,9,'What is most preferred python or R?','HOT SKILLS',NULL,NULL),(69,9,'How important do you think interpersonal skills are?','HOT SKILLS',NULL,NULL),(70,8,'Is stats important for business analyst?','HOT SKILLS',NULL,NULL),(71,10,'what skills are needed for business intelligence?','HOT SKILLS',NULL,NULL),(72,11,'any good resources to learn advanced SQL apart from school courses?','HOT SKILLS',NULL,NULL),(73,11,'What are the skills required for Data Analytics?','HOT SKILLS',NULL,NULL),(74,1,'I am joining MSIS this fall, what skills are trending now?','HOT SKILLS',NULL,NULL),(75,10,'What is more useful R or python?','HOT SKILLS',NULL,NULL),(76,9,'Any recommendations for learning SQL online?','HOT SKILLS',NULL,NULL),(77,1,'Is tableau better than PowerBI?','HOT SKILLS',NULL,NULL),(87,2,'Which courses should I take in the First quarter?','COURSEWORK',NULL,NULL),(88,2,'Which Machine learning courses should I take in the First quarter?','COURSEWORK',NULL,NULL),(92,2,'Which courses are light to take in the third quarter so that focus can be on internships?','COURSEWORK',NULL,NULL),(101,2,'Which course is better Bi or Dashboards?','COURSEWORK',NULL,NULL),(125,11,'Do we need to take dashboards course if we have taken Bi course? which is better?','COURSEWORK',NULL,NULL);
/*!40000 ALTER TABLE `QUESTION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SKILL`
--

DROP TABLE IF EXISTS `SKILL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `SKILL` (
  `SKILL_ID` int(11) NOT NULL AUTO_INCREMENT,
  `SKILL_NAME` varchar(65) NOT NULL,
  PRIMARY KEY (`SKILL_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SKILL`
--

LOCK TABLES `SKILL` WRITE;
/*!40000 ALTER TABLE `SKILL` DISABLE KEYS */;
INSERT INTO `SKILL` VALUES (1,'Python'),(2,'SQL'),(3,'Tableau'),(4,'Analysis'),(5,'Visualization'),(6,'Statistics'),(7,'R'),(8,'SAS'),(9,'Excel'),(10,'MS Office'),(11,'Google Analytics'),(12,'Teamwork'),(13,'Presentation'),(14,'Databases'),(15,'Machine Learning'),(16,'Data Mining'),(17,'ETL'),(18,'Business Intelligence'),(19,'Datawarehousing'),(20,'Deep Learninh'),(21,'Probability'),(22,'Story Telling'),(23,'Writing'),(24,'Business Acumen'),(25,'Hadoop'),(26,'AWS'),(27,'Hive'),(28,'Java'),(29,'Matplotlib'),(30,'C/C++'),(31,'Pig'),(32,'Qlikview'),(33,'Apache Spark'),(34,'Pentaho'),(35,'Spotfire'),(36,'Talend'),(37,'Visio'),(38,'Powerpoint'),(39,'Leadership Skills'),(40,'Problem Solving'),(41,'Decision Making'),(42,'Critical Thinking'),(43,'Communication'),(44,'Report Genenration'),(45,'Use case Analysis'),(46,'Business Requirements'),(47,'Attention to Detail');
/*!40000 ALTER TABLE `SKILL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `STUDENT`
--

DROP TABLE IF EXISTS `STUDENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `STUDENT` (
  `STUDENT_ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) NOT NULL,
  `STUDENT_TYPE` enum('CURRENT','INCOMING') NOT NULL,
  `GPA` float DEFAULT NULL,
  `EXP_YEAR_OF_GRAD` int(11) DEFAULT NULL,
  PRIMARY KEY (`STUDENT_ID`),
  KEY `USER_ID` (`USER_ID`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `STUDENT`
--

LOCK TABLES `STUDENT` WRITE;
/*!40000 ALTER TABLE `STUDENT` DISABLE KEYS */;
INSERT INTO `STUDENT` VALUES (1,1,'CURRENT',3.8,2019),(2,2,'CURRENT',3.6,2020),(3,4,'CURRENT',3.7,2019),(4,6,'INCOMING',NULL,2021),(5,7,'INCOMING',NULL,2020),(6,8,'INCOMING',NULL,2021),(7,9,'INCOMING',NULL,2021),(8,10,'CURRENT',3.85,2020),(9,11,'CURRENT',3.75,2019);
/*!40000 ALTER TABLE `STUDENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USER_SKILL`
--

DROP TABLE IF EXISTS `USER_SKILL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `USER_SKILL` (
  `USER_SKILL_ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) NOT NULL,
  `SKILL_ID` int(11) NOT NULL,
  PRIMARY KEY (`USER_SKILL_ID`),
  KEY `USER_ID` (`USER_ID`),
  KEY `SKILL_ID` (`SKILL_ID`),
  CONSTRAINT `user_skill_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`USER_ID`),
  CONSTRAINT `user_skill_ibfk_2` FOREIGN KEY (`SKILL_ID`) REFERENCES `skill` (`SKILL_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USER_SKILL`
--

LOCK TABLES `USER_SKILL` WRITE;
/*!40000 ALTER TABLE `USER_SKILL` DISABLE KEYS */;
INSERT INTO `USER_SKILL` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,11,1),(7,11,2),(8,11,3),(9,11,12),(10,11,4),(11,11,5),(12,11,9),(13,11,17),(14,11,28),(15,6,12),(16,6,13),(17,6,14),(18,6,19),(19,6,30),(20,6,43),(21,6,42),(22,6,28),(23,8,43),(24,8,38),(25,8,39),(26,8,30),(27,8,10),(28,8,8),(29,8,28),(30,4,1),(31,4,2),(32,4,3),(33,4,4),(34,4,5),(35,4,9),(36,4,12),(37,4,18);
/*!40000 ALTER TABLE `USER_SKILL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USERS`
--

DROP TABLE IF EXISTS `USERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `USERS` (
  `USER_ID` int(11) NOT NULL AUTO_INCREMENT,
  `FIRST_NAME` varchar(45) NOT NULL,
  `LAST_NAME` varchar(45) DEFAULT NULL,
  `USER_TYPE` enum('ALUMNI','CURRENT_STUDENT','INCOMING_STUDENT') NOT NULL,
  `USER_ADDRESS` varchar(100) DEFAULT NULL,
  `CITY` varchar(50) DEFAULT NULL,
  `STATE` varchar(45) DEFAULT NULL,
  `ZIP` bigint(20) DEFAULT NULL,
  `PHONE_NO` bigint(20) NOT NULL,
  `EMAIL_ID` varchar(50) NOT NULL,
  `EMAIL_TYPE` enum('PERSONAL','SCU') NOT NULL,
  `USERNAME` varchar(20) NOT NULL,
  `USER_PASSWORD` varchar(45) NOT NULL,
  `PROGRAM_ID` int(11) NOT NULL,
  `UNDERGRAD` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`USER_ID`),
  UNIQUE KEY `PHONE_NO` (`PHONE_NO`),
  UNIQUE KEY `EMAIL_ID` (`EMAIL_ID`),
  UNIQUE KEY `USERNAME` (`USERNAME`),
  KEY `PROGRAM_ID` (`PROGRAM_ID`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`PROGRAM_ID`) REFERENCES `program` (`PROGRAM_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USERS`
--

LOCK TABLES `USERS` WRITE;
/*!40000 ALTER TABLE `USERS` DISABLE KEYS */;
INSERT INTO `USERS` VALUES (1,'Krutika','Ambavane','CURRENT_STUDENT','Ayala Dr','Sunnyvale','CA',94086,6504956454,'kambavane@scu.edu','SCU','krutika123','kambavane',1,'IT'),(2,'Sanya','Purwar','CURRENT_STUDENT','2147 Newhall St.','Santa Clara','CA',95050,5105132350,'spurwar@scu.edu','SCU','sanya08','sanyapurwar',1,'Computer Engineering'),(3,'Tanya','Purwar','ALUMNI','2125 Newhall St.','Santa Clara','CA',95050,4856789023,'tanyapurwar@gmail.com','PERSONAL','TANYA04','tanyap',2,'BFIA'),(4,'Yugal','Karamchandani','CURRENT_STUDENT','2147 Newhall St.','Santa Clara','CA',95050,8907652360,'ykaramchandani@scu.edu','SCU','yugal1234','yugalk',1,'Computer Engineering'),(5,'Genevieve','Boniface','ALUMNI','Domicilio','Santa Clara','CA',95050,6789074356,'gboniface@scu.edu','SCU','Gene23','Genevieve',3,'Electrical Engineering'),(6,'Saif','Ahmed','INCOMING_STUDENT','North Frances Street','Sunnyvale','CA',95050,4105437865,'sahmed@gmail.com','PERSONAL','Sahmed','Saifahmed',3,'Computer Engineering'),(7,'Harshada','Kulkarni','INCOMING_STUDENT','Juhu','Mumbai','Maharashtra',95050,9876543210,'HarshadaKul@gmail.com','PERSONAL','Harshada04','Harshada',2,'Mechanical Engineering'),(8,'Shraddha','Patodi','INCOMING_STUDENT','GK 2','Delhi','New Delhi',95050,9988776655,'shraddhapatodi@gmail.com','PERSONAL','Shraddhap23','Shraddha',3,'Mechanical Engineering'),(9,'Erali','Shah','INCOMING_STUDENT','411 Elm St','Dallas','TX',75202,6106789765,'Eralishah@gmail.com','PERSONAL','Eralishah78','Erali',1,'IT'),(10,'Dhanashree','Mane','CURRENT_STUDENT','Murphy St','Sunnyvale','CA',94086,5678123456,'dmane@scu.edu','SCU','Dhanashree45','DhanashreeMane',3,'IT'),(11,'Arzoo','Gangwal','CURRENT_STUDENT','2147 Newhall St','Santa Clara','CA',95050,5105234568,'agangwal@scu.edu','SCU','Agangwal82','Arzoo',1,'IT');
/*!40000 ALTER TABLE `USERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `WORK_EXP`
--

DROP TABLE IF EXISTS `WORK_EXP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `WORK_EXP` (
  `JOB_ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) NOT NULL,
  `JOB_TITLE` varchar(45) NOT NULL,
  `JOB_DURATION` float DEFAULT NULL,
  `JOB_LOCATION` varchar(50) DEFAULT NULL,
  `JOB_COMPANY` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`JOB_ID`),
  KEY `USER_ID` (`USER_ID`),
  CONSTRAINT `work_exp_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `WORK_EXP`
--

LOCK TABLES `WORK_EXP` WRITE;
/*!40000 ALTER TABLE `WORK_EXP` DISABLE KEYS */;
INSERT INTO `WORK_EXP` VALUES (1,1,'Data Analyst Intern',1,'San Francisco','Genentech'),(2,1,'Software Engineer',1,'India','Cap Gemini'),(3,4,'Software Engineer',2,'India','Accenture'),(4,6,'Consultant',2,'India','Deloitte'),(5,6,' Associate Product Manager',1,'US','Accenture'),(6,8,'Software Engineer',3,'India','Cognizant'),(7,11,'SDE',2,'India','Amazon');
/*!40000 ALTER TABLE `WORK_EXP` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-06-07  7:45:46
