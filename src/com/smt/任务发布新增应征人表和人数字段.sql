
ALTER TABLE t_app_task ADD personCount INT DEFAULT 0;
ALTER TABLE t_app_user_info ADD age INT DEFAULT 0;
CREATE TABLE t_app_person_task(
`id` INT(32) NOT NULL AUTO_INCREMENT ,
`taskId` INT(32) ,
`personId` INT(32) ,
`createtime` VARCHAR(100) ,
`isReady` INT(32) default  0 ,
PRIMARY KEY (`id`)  );