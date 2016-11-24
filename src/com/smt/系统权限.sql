DROP TABLE IF EXISTS t_app_role;

CREATE TABLE t_app_role (
   `id` INT(11) NOT NULL AUTO_INCREMENT,
   `roleName` VARCHAR(100) DEFAULT '',
   `roleDescribe` VARCHAR(200) DEFAULT '',
   `creater` INT(11) DEFAULT NULL,
   `createTime` DATETIME DEFAULT NULL,
PRIMARY KEY (id)
);

DROP TABLE IF EXISTS t_app_role_authority;

CREATE TABLE t_app_role_authority (
   `id` INT(11) NOT NULL AUTO_INCREMENT,
   `roleId` INT(11) DEFAULT NULL,
   `menuId` INT(11) DEFAULT NULL,
PRIMARY KEY (id)
);

ALTER TABLE t_app_user ADD roleId INT DEFAULT -1;

insert into t_app_menu(menuNo,menuName,menuLevel,active,link) values (37,'权限管理',3,'1','member/role!getRoleList.htm');