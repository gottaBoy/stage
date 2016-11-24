
CREATE TABLE `t_app_user_evaluation` (
   `ID` int(32) NOT NULL AUTO_INCREMENT,
   `userId` int(32) DEFAULT NULL,
   `evaluation` int(32) DEFAULT  '0',
   `msGradeValue` double DEFAULT '0',
   `tdGradeValue` double DEFAULT '0',
   `zlGradeValue` double DEFAULT '0',
   PRIMARY KEY (`ID`)
 ) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=gbk
 /**遍历用户表 将所有的用户都插入一条评价总分的数据到用户评价表中**/
 INSERT INTO t_app_user_evaluation
(userId)
SELECT id
FROM t_app_user
WHERE NOT EXISTS (SELECT * FROM t_app_user_evaluation
WHERE t_app_user_evaluation.userId = t_app_user.id);

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
 ) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8
 ALTER TABLE t_app_cost_info MODIFY COLUMN Profession int(32);
  INSERT INTO t_app_menu(menuNo,menuName,menuLevel,active,link) VALUES (33,'企业之星',4,'1','member/starInfo.htm')
  INSERT INTO t_app_menu(menuNo,menuName,menuLevel,active,link) VALUES (34,'新人推荐',4,'1','member/newManInfo.htm')
  INSERT INTO t_app_menu(menuNo,menuName,menuLevel,active,link) VALUES (35,'最活跃艺人',4,'1','member/activeStarInfo.htm')
  ALTER TABLE t_app_user_info ADD collect  INT(32) DEFAULT 0   ;
ALTER TABLE t_app_user_info ADD attention  INT(32) DEFAULT 0   ;