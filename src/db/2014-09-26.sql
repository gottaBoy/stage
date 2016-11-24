alter table `no1stage`.`t_app_user_info` 
   add column `orgCard` varchar(100) NULL after `IdCardCopy2`, 
   add column `orgCardCopy` varchar(100) NULL after `orgCard`;
