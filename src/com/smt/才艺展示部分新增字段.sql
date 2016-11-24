alter table t_app_ding add type int default 0;
ALTER TABLE t_app_art_info ADD ding INT DEFAULT 0;
ALTER TABLE t_app_art_info ADD share INT DEFAULT 0;
ALTER TABLE t_app_art_info ADD evaluate INT DEFAULT 0;
CREATE TABLE t_app_skill_evaluate(
`id` INT(32) NOT NULL AUTO_INCREMENT ,
`skillId` INT(32) ,
`createtime` VARCHAR(100) ,
`content` VARCHAR(1000) ,
`createId` INT(32) ,
PRIMARY KEY (`id`)  );