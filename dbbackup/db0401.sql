-- MySQL dump 10.13  Distrib 5.1.73, for redhat-linux-gnu (x86_64)
--
-- Host: localhost    Database: no1stage
-- ------------------------------------------------------
-- Server version	5.1.73

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES gbk */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `t_app_action`
--

DROP TABLE IF EXISTS `t_app_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_action` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `startdate` date DEFAULT NULL,
  `enddate` date DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_art_info`
--

DROP TABLE IF EXISTS `t_app_art_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_art_info` (
  `ID` int(32) NOT NULL AUTO_INCREMENT,
  `UserId` int(32) NOT NULL,
  `Type` varchar(100) DEFAULT NULL,
  `Title` varchar(100) DEFAULT NULL,
  `Intro` varchar(100) DEFAULT NULL,
  `Url` varchar(500) DEFAULT NULL,
  `Attachment` varchar(100) DEFAULT NULL,
  `CreatTime` varchar(100) DEFAULT NULL,
  `imgCount` int(11) DEFAULT '0',
  `ding` int(11) DEFAULT '0',
  `share` int(11) DEFAULT '0',
  `evaluate` int(11) DEFAULT '0',
  `img` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `UserId` (`UserId`)
) ENGINE=InnoDB AUTO_INCREMENT=10836 DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_business_cost`
--

DROP TABLE IF EXISTS `t_app_business_cost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_business_cost` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderId` int(11) DEFAULT NULL,
  `costId` int(11) DEFAULT NULL,
  `price` varchar(32) DEFAULT '',
  `days` int(11) DEFAULT NULL,
  `keywords` varchar(100) DEFAULT NULL,
  `bcostId` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `costId` (`orderId`,`costId`)
) ENGINE=InnoDB AUTO_INCREMENT=197 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_business_evaluate`
--

DROP TABLE IF EXISTS `t_app_business_evaluate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_business_evaluate` (
  `ID` int(32) NOT NULL AUTO_INCREMENT,
  `BusinessId` varchar(32) DEFAULT NULL,
  `CreatId` int(32) NOT NULL,
  `PjContent` varchar(500) DEFAULT NULL,
  `CreatTime` varchar(100) DEFAULT NULL,
  `PjGrade` varchar(32) DEFAULT NULL,
  `MsGrade` varchar(32) DEFAULT NULL,
  `TdGrade` varchar(32) DEFAULT NULL,
  `ZlGrade` varchar(32) DEFAULT NULL,
  `state` tinyint(1) DEFAULT '0',
  `pjcount` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `BusinessId` (`BusinessId`),
  KEY `CreatId` (`CreatId`)
) ENGINE=InnoDB AUTO_INCREMENT=216 DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_business_info`
--

DROP TABLE IF EXISTS `t_app_business_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_business_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderCode` varchar(50) DEFAULT '',
  `status` int(11) DEFAULT NULL,
  `buyer` int(11) DEFAULT NULL,
  `seller` int(11) DEFAULT NULL,
  `sellerCompany` int(11) DEFAULT NULL,
  `price` varchar(32) DEFAULT '',
  `choucheng` varchar(32) DEFAULT '',
  `provice` varchar(32) DEFAULT '',
  `city` varchar(32) DEFAULT '',
  `address` varchar(300) DEFAULT '',
  `content` varchar(500) DEFAULT '',
  `beginDate` varchar(32) DEFAULT '',
  `beginTime` varchar(32) DEFAULT '',
  `endTime` varchar(32) DEFAULT '',
  `endDate` varchar(32) DEFAULT '',
  `buyerRate` int(11) DEFAULT NULL,
  `sellerRate` int(11) DEFAULT NULL,
  `isByStages` int(11) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `otherCost1` varchar(32) DEFAULT '',
  `otherCost2` varchar(32) DEFAULT '',
  `otherCost3` varchar(32) DEFAULT NULL,
  `receipt` int(11) DEFAULT NULL,
  `createTime2` datetime DEFAULT NULL,
  `createTime3` datetime DEFAULT NULL,
  `createTime4` datetime DEFAULT NULL,
  `createTime5` datetime DEFAULT NULL,
  `createTime6` datetime DEFAULT NULL,
  `createTime7` datetime DEFAULT NULL,
  `createTime8` datetime DEFAULT NULL,
  `createTime9` datetime DEFAULT NULL,
  `drawbackStatus` int(11) DEFAULT NULL,
  `updatePayTimeCount` int(11) DEFAULT '0',
  `updatePayTimeStatus` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_business_pay`
--

DROP TABLE IF EXISTS `t_app_business_pay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_business_pay` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderId` int(11) DEFAULT NULL,
  `price` varchar(32) DEFAULT '',
  `price1` varchar(32) DEFAULT '',
  `payRatio` varchar(32) DEFAULT '',
  `paymentTime` datetime DEFAULT NULL,
  `actualPayTime` datetime DEFAULT NULL,
  `pos` int(11) DEFAULT NULL,
  `isPay` int(11) DEFAULT NULL,
  `payTime` datetime DEFAULT NULL,
  `isPayment` int(11) DEFAULT NULL,
  `confrimPay` int(11) DEFAULT NULL,
  `updatePayTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_capacity`
--

DROP TABLE IF EXISTS `t_app_capacity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_capacity` (
  `ID` int(32) NOT NULL AUTO_INCREMENT,
  `UserId` int(32) NOT NULL,
  `Pj_userId` int(32) NOT NULL,
  `Pj_type` varchar(100) DEFAULT NULL,
  `Point` varchar(100) DEFAULT NULL,
  `CreatTime` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_case`
--

DROP TABLE IF EXISTS `t_app_case`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_case` (
  `ID` int(32) NOT NULL AUTO_INCREMENT,
  `Title` varchar(100) DEFAULT NULL,
  `Content` varchar(100) DEFAULT NULL,
  `CreatId` int(32) DEFAULT NULL,
  `CreatTime` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_case_sub`
--

DROP TABLE IF EXISTS `t_app_case_sub`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_case_sub` (
  `ID` int(32) NOT NULL AUTO_INCREMENT,
  `Title` varchar(100) DEFAULT NULL,
  `Content` varchar(100) DEFAULT NULL,
  `userId` int(32) DEFAULT NULL,
  `orderNo` int(32) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_company_info`
--

DROP TABLE IF EXISTS `t_app_company_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_company_info` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `businessId` int(32) DEFAULT NULL,
  `yrUserId` int(32) DEFAULT NULL,
  `type` int(32) DEFAULT NULL,
  `starContent` varchar(1000) DEFAULT NULL,
  `contentOfPictrue2` varchar(200) DEFAULT NULL,
  `linkOfPictrue2` varchar(200) DEFAULT NULL,
  `contentOfPictrue3` varchar(200) DEFAULT NULL,
  `linkOfPictrue3` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=184 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_company_pay_record`
--

DROP TABLE IF EXISTS `t_app_company_pay_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_company_pay_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `creater` int(11) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `batchNo` varchar(50) DEFAULT '',
  `orderNo` varchar(50) DEFAULT '',
  `email` varchar(50) DEFAULT '',
  `name` varchar(50) DEFAULT '',
  `payDate` varchar(50) DEFAULT '',
  `payEmail` varchar(50) DEFAULT '',
  `payName` varchar(50) DEFAULT '',
  `payPrice` double DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=146 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_cost_info`
--

DROP TABLE IF EXISTS `t_app_cost_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_cost_info` (
  `ID` int(32) NOT NULL AUTO_INCREMENT,
  `UserId` int(32) DEFAULT NULL,
  `Profession` int(32) DEFAULT NULL,
  `ePrice` int(32) DEFAULT NULL,
  `bPrice` int(32) DEFAULT NULL,
  `CreatTime` varchar(100) DEFAULT NULL,
  `orderNo` int(32) DEFAULT NULL,
  `keywords` varchar(100) DEFAULT NULL,
  `unit` varchar(100) DEFAULT NULL,
  `isConsult` varchar(32) DEFAULT NULL,
  `detail` varchar(2000) DEFAULT NULL,
  `bigImage` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `UserId` (`UserId`)
) ENGINE=InnoDB AUTO_INCREMENT=2711 DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_ding`
--

DROP TABLE IF EXISTS `t_app_ding`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_ding` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `dingUserId` int(11) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `type` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `dingUserId` (`dingUserId`)
) ENGINE=InnoDB AUTO_INCREMENT=813 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_drawback_info`
--

DROP TABLE IF EXISTS `t_app_drawback_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_drawback_info` (
  `Id` int(32) NOT NULL AUTO_INCREMENT,
  `DrawbackNo` varchar(32) DEFAULT NULL,
  `BusinessId` int(32) NOT NULL COMMENT '交易id',
  `DrawbackAmount` varchar(32) NOT NULL COMMENT '退款金额',
  `DrawbackCause` varchar(1000) DEFAULT NULL COMMENT '退款原因',
  `DrawbackDate` varchar(100) DEFAULT NULL COMMENT '退款时间',
  `CreatTime` varchar(100) DEFAULT NULL COMMENT '创建时间（申请退款时间）',
  `Status` int(1) DEFAULT NULL COMMENT '状态（0-等待退款，1-拒绝退款，2-再次退款，3-退款成功，4-退款关闭',
  `price` varchar(30) DEFAULT '',
  `choucheng` varchar(30) DEFAULT '',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_friend_info`
--

DROP TABLE IF EXISTS `t_app_friend_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_friend_info` (
  `ID` int(32) NOT NULL AUTO_INCREMENT,
  `UserId` int(32) NOT NULL,
  `FriendId` int(32) NOT NULL,
  `CreatTime` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `UserId` (`UserId`),
  KEY `FriendId` (`FriendId`)
) ENGINE=InnoDB AUTO_INCREMENT=220 DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_growth`
--

DROP TABLE IF EXISTS `t_app_growth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_growth` (
  `ID` int(32) NOT NULL AUTO_INCREMENT,
  `UserId` int(32) DEFAULT NULL,
  `endDate` varchar(100) DEFAULT NULL,
  `startDate` varchar(100) DEFAULT NULL,
  `Title` varchar(100) DEFAULT NULL,
  `Content` varchar(2000) DEFAULT NULL,
  `CreatTime` varchar(100) DEFAULT NULL,
  `bulletinImg` varchar(200) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `unit` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `UserId` (`UserId`)
) ENGINE=InnoDB AUTO_INCREMENT=1324 DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_images_info`
--

DROP TABLE IF EXISTS `t_app_images_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_images_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentID` int(11) NOT NULL,
  `remark` varchar(2000) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parentID` (`parentID`)
) ENGINE=InnoDB AUTO_INCREMENT=7687 DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_information`
--

DROP TABLE IF EXISTS `t_app_information`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_information` (
  `content` text,
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `menuCode` varchar(100) DEFAULT NULL,
  `menuName` varchar(200) DEFAULT NULL,
  `parentId` int(32) DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `orderNo` int(32) DEFAULT NULL,
  `userId` int(32) DEFAULT NULL,
  `status` varchar(32) DEFAULT '0',
  `CreatTime` varchar(50) DEFAULT NULL,
  `daiyu` varchar(200) DEFAULT NULL,
  `xueli` varchar(200) DEFAULT NULL,
  `workYears` varchar(100) DEFAULT NULL,
  `workAddress` varchar(200) DEFAULT NULL,
  `zige` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parentId` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=144 DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_menu`
--

DROP TABLE IF EXISTS `t_app_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_menu` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `menuNo` int(32) NOT NULL,
  `menuName` varchar(100) NOT NULL,
  `menuLevel` int(10) NOT NULL,
  `active` varchar(1) DEFAULT NULL,
  `link` varchar(500) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_message`
--

DROP TABLE IF EXISTS `t_app_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_message` (
  `Status` varchar(32) DEFAULT NULL,
  `ID` int(32) NOT NULL AUTO_INCREMENT,
  `ToUserId` int(32) DEFAULT NULL,
  `FromUserId` int(32) DEFAULT NULL,
  `Title` varchar(100) DEFAULT NULL,
  `Content` varchar(500) DEFAULT NULL,
  `CreatTime` varchar(100) DEFAULT NULL,
  `type` int(11) DEFAULT '1',
  `sendType` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `ToUserId` (`ToUserId`),
  KEY `FromUserId` (`FromUserId`)
) ENGINE=InnoDB AUTO_INCREMENT=11064 DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_person_task`
--

DROP TABLE IF EXISTS `t_app_person_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_person_task` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `taskId` int(32) DEFAULT NULL,
  `personId` int(32) DEFAULT NULL,
  `createtime` varchar(100) DEFAULT NULL,
  `isReady` int(32) DEFAULT '0',
  `taskRoleId` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `taskId` (`taskId`),
  KEY `personId` (`personId`)
) ENGINE=InnoDB AUTO_INCREMENT=544 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_poster`
--

DROP TABLE IF EXISTS `t_app_poster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_poster` (
  `PID` int(11) NOT NULL AUTO_INCREMENT,
  `TITLE` varchar(100) DEFAULT NULL,
  `CONTENT` varchar(500) DEFAULT NULL,
  `PDATE` date DEFAULT NULL,
  `PTYPE` char(1) DEFAULT NULL,
  `PSORT` int(11) DEFAULT NULL,
  `PIS` int(11) DEFAULT NULL,
  `PURL` varchar(100) DEFAULT NULL,
  `PLINK` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`PID`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_role`
--

DROP TABLE IF EXISTS `t_app_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleName` varchar(100) DEFAULT '',
  `roleDescribe` varchar(200) DEFAULT '',
  `creater` int(11) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_role_authority`
--

DROP TABLE IF EXISTS `t_app_role_authority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_role_authority` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleId` int(11) DEFAULT NULL,
  `menuId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_schedule_info`
--

DROP TABLE IF EXISTS `t_app_schedule_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_schedule_info` (
  `ID` int(32) NOT NULL AUTO_INCREMENT,
  `UserId` int(32) NOT NULL,
  `StartDate` varchar(100) DEFAULT NULL,
  `EndDate` varchar(100) DEFAULT NULL,
  `Address` varchar(100) DEFAULT NULL,
  `Title` varchar(100) DEFAULT NULL,
  `Content` varchar(100) DEFAULT NULL,
  `CreatTime` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=185 DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_seq_table`
--

DROP TABLE IF EXISTS `t_app_seq_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_seq_table` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `sequence_id` int(32) DEFAULT NULL,
  `table_name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_skill_evaluate`
--

DROP TABLE IF EXISTS `t_app_skill_evaluate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_skill_evaluate` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `skillId` int(32) DEFAULT NULL,
  `createtime` varchar(100) DEFAULT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `createId` int(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `createId` (`createId`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_talent_category`
--

DROP TABLE IF EXISTS `t_app_talent_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_talent_category` (
  `ID` int(32) NOT NULL AUTO_INCREMENT,
  `ParentId` int(32) NOT NULL,
  `TypeName` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `Remark` varchar(500) CHARACTER SET utf8 DEFAULT NULL,
  `CreatTime` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `flag` varchar(2) CHARACTER SET utf8 DEFAULT NULL COMMENT '几级目录',
  `SUBID` varchar(5) CHARACTER SET utf8 DEFAULT NULL,
  `alias` varchar(100) DEFAULT NULL,
  `layer` int(11) DEFAULT NULL,
  `searchTime` int(32) DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `ParentId` (`ParentId`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_task`
--

DROP TABLE IF EXISTS `t_app_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_task` (
  `Mobile` varchar(100) DEFAULT NULL,
  `Price` varchar(32) DEFAULT NULL,
  `UserId` int(32) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `Place` varchar(100) DEFAULT NULL,
  `CreatTime` varchar(100) DEFAULT NULL,
  `content` varchar(2000) DEFAULT NULL,
  `active` varchar(32) DEFAULT NULL COMMENT '0-屏蔽，\r\n1-激活，\r\n2-置顶',
  `status` varchar(32) DEFAULT NULL,
  `StartDate` varchar(100) DEFAULT NULL,
  `EndDate` varchar(100) DEFAULT NULL,
  `personCount` int(11) DEFAULT '0',
  `applyStartDate` datetime DEFAULT NULL,
  `applyEndDate` datetime DEFAULT NULL,
  `provice` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `fromWeb` varchar(50) DEFAULT NULL COMMENT '来源：1:抓取',
  `qq` varchar(100) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `UserId` (`UserId`)
) ENGINE=InnoDB AUTO_INCREMENT=486 DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_task_role`
--

DROP TABLE IF EXISTS `t_app_task_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_task_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `taskId` int(11) DEFAULT NULL,
  `roleName` varchar(32) DEFAULT '',
  `roleDesc` varchar(200) DEFAULT '',
  `roleNum` int(11) DEFAULT NULL,
  `priceLow` int(11) DEFAULT NULL,
  `priceHigh` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `taskId` (`taskId`),
  CONSTRAINT `t_app_task_role_ibfk_1` FOREIGN KEY (`taskId`) REFERENCES `t_app_task` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_top`
--

DROP TABLE IF EXISTS `t_app_top`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_top` (
  `tid` int(32) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `status` varchar(1) DEFAULT NULL,
  `userid` int(32) DEFAULT NULL,
  `comment` varchar(200) DEFAULT NULL,
  `tdate` date DEFAULT NULL,
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_top_img`
--

DROP TABLE IF EXISTS `t_app_top_img`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_top_img` (
  `tid` int(32) NOT NULL AUTO_INCREMENT,
  `turl` varchar(100) DEFAULT NULL,
  `tmemo` varchar(200) DEFAULT NULL,
  `tlink` varchar(200) DEFAULT NULL,
  `tpid` int(32) NOT NULL,
  PRIMARY KEY (`tid`),
  KEY `FK_T_APP_TO_REFERENCE_T_APP_TO` (`tpid`),
  CONSTRAINT `FK_T_APP_TO_REFERENCE_T_APP_TO` FOREIGN KEY (`tpid`) REFERENCES `t_app_top` (`tid`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_upload_file`
--

DROP TABLE IF EXISTS `t_app_upload_file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_upload_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `attachName` varchar(200) DEFAULT '',
  `suffix` varchar(30) DEFAULT '',
  `size` bigint(20) DEFAULT NULL,
  `orderId` int(11) DEFAULT NULL,
  `uploadDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_user`
--

DROP TABLE IF EXISTS `t_app_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_user` (
  `ID` int(32) NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) CHARACTER SET utf8 NOT NULL,
  `UserPsd` varchar(50) CHARACTER SET utf8 NOT NULL,
  `Email` varchar(100) CHARACTER SET utf8 NOT NULL,
  `RzState` varchar(1) DEFAULT '1' COMMENT '1未认证',
  `State` varchar(1) DEFAULT '1' COMMENT '1启用0停用',
  `OnlineDate` varchar(50) DEFAULT NULL,
  `CreatTime` varchar(50) NOT NULL,
  `isORG` int(1) DEFAULT '0' COMMENT '0个人1机构',
  `authority` int(32) DEFAULT NULL,
  `parentID` int(32) DEFAULT NULL,
  `roleId` int(11) DEFAULT '-1',
  `applicate` int(1) DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10653 DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_user_evaluation`
--

DROP TABLE IF EXISTS `t_app_user_evaluation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_user_evaluation` (
  `ID` int(32) NOT NULL AUTO_INCREMENT,
  `userId` int(32) DEFAULT NULL,
  `evaluation` int(32) DEFAULT '0',
  `msGradeValue` double DEFAULT '0',
  `tdGradeValue` double DEFAULT '0',
  `zlGradeValue` double DEFAULT '0',
  `sellerEvaluation` int(11) DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1758 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_app_user_info`
--

DROP TABLE IF EXISTS `t_app_user_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_app_user_info` (
  `ID` int(32) NOT NULL AUTO_INCREMENT,
  `UserId` int(32) NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Sex` varchar(100) DEFAULT NULL COMMENT '0保密1男2女',
  `Heart_size` varchar(100) DEFAULT NULL COMMENT '胸围',
  `Waist_size` varchar(100) DEFAULT NULL COMMENT '腰围',
  `Bottocks_size` varchar(100) DEFAULT NULL COMMENT '臀围',
  `Birthday` varchar(100) DEFAULT NULL,
  `Height` varchar(100) DEFAULT NULL,
  `Mobile` varchar(100) DEFAULT NULL,
  `provice` varchar(32) CHARACTER SET utf8 DEFAULT NULL,
  `Company` varchar(200) DEFAULT NULL,
  `Education` varchar(200) DEFAULT NULL,
  `School` varchar(200) DEFAULT NULL,
  `Major` varchar(100) DEFAULT NULL,
  `SignNumber` int(32) DEFAULT '0',
  `SignAmount` varchar(100) DEFAULT '保密',
  `Introduction` varchar(500) DEFAULT NULL,
  `PopularityTotal` int(100) DEFAULT NULL,
  `IdCard` varchar(100) DEFAULT NULL,
  `IdCardCopy` varchar(100) DEFAULT NULL,
  `IdCardCopy2` varchar(100) DEFAULT NULL,
  `orgCard` varchar(100) DEFAULT NULL,
  `orgCardCopy` varchar(100) DEFAULT NULL,
  `HeadPortrait` varchar(100) DEFAULT NULL,
  `Grade` varchar(100) DEFAULT NULL,
  `FeedbackRate` int(100) DEFAULT NULL,
  `TalentsType` varchar(100) DEFAULT NULL,
  `ModifyTime` varchar(100) DEFAULT NULL,
  `CreatTime` varchar(100) DEFAULT NULL,
  `nickName` varchar(100) DEFAULT NULL,
  `booldType` varchar(2) DEFAULT NULL COMMENT '血型',
  `city` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `weight` varchar(32) DEFAULT NULL COMMENT '体重',
  `telPhone` varchar(32) DEFAULT NULL COMMENT '电话',
  `qq` varchar(32) DEFAULT NULL COMMENT 'qq号码',
  `profession` varchar(100) DEFAULT NULL,
  `isRecommend` varchar(32) DEFAULT '0',
  `recommendTime` varchar(32) DEFAULT NULL,
  `alipay` varchar(200) DEFAULT NULL,
  `recommendUrl` varchar(100) DEFAULT NULL,
  `professionStr` varchar(500) DEFAULT NULL,
  `comRecommend` varchar(32) DEFAULT NULL,
  `comRecommendTime` varchar(100) DEFAULT NULL,
  `collect` int(32) DEFAULT '0',
  `attention` int(32) DEFAULT '0',
  `mobileRadio` int(11) DEFAULT '1',
  `qqRadio` int(11) DEFAULT '1',
  `alipayName` varchar(100) DEFAULT '',
  `sellerGrade` varchar(100) DEFAULT '1',
  `age` int(11) DEFAULT '0',
  `jcxxIsFinish` int(11) DEFAULT '2',
  `zyjnIsFinish` int(11) DEFAULT '2',
  `czjlIsFinish` int(11) DEFAULT '2',
  `xcIsFinish` int(11) DEFAULT '2',
  `spIsFinish` int(11) DEFAULT '2',
  `ypIsFinish` int(11) DEFAULT '2',
  `sytjIsFinish` int(11) DEFAULT '2',
  `isShare` int(11) DEFAULT '2',
  `place` varchar(500) DEFAULT NULL,
  `companyTags` varchar(500) DEFAULT NULL,
  `seviceScope` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `UserId` (`UserId`)
) ENGINE=InnoDB AUTO_INCREMENT=10653 DEFAULT CHARSET=gbk;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `t_base_area`
--

DROP TABLE IF EXISTS `t_base_area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_base_area` (
  `aid` int(11) NOT NULL,
  `areaname` varchar(20) NOT NULL,
  `rootid` int(11) NOT NULL,
  `childcount` int(11) DEFAULT NULL,
  `isdept` int(11) DEFAULT NULL,
  `sortid` int(11) DEFAULT NULL,
  `astatus` int(11) NOT NULL,
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-04-01 10:22:58
