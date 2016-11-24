alter table t_app_business_info add finishTime  datetime default null   ;
alter table t_app_business_info add isPay  int default 1   ;

drop table if exists t_app_company_pay_record;

create table t_app_company_pay_record (
`id`  int default null  auto_increment  ,
`creater`  int default null   ,
`createDate`  datetime default null,
`batchNo`  varchar(50) default  '',
`orderNo`  varchar(50) default  '',
`email`  varchar(50) default  '',
`name`  varchar(50) default  '',
`payDate`  varchar(50) default  '',
`payEmail`  varchar(50) default  '',
`payName`  varchar(50) default  '',
`payPrice`  double default null,
`status`  int default null   ,
primary key (id)
);

insert  into `t_app_menu`(`id`,`menuNo`,`menuName`,`menuLevel`,`active`,`link`) values (26,18,'付款管理',3,'1','member/business!payList.htm');