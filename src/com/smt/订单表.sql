drop table if exists t_app_business_info;

create table t_app_business_info (
`id`  int default null  auto_increment  ,
`orderCode`  varchar(50) default  '',
`status`  int default null   ,
`buyer`  int default null   ,
`seller`  int default null   ,
`sellerCompany`  int default null   ,
`price`  varchar(32) default  '',
`choucheng`  varchar(32) default  '',
`provice`  varchar(32) default  '',
`city`  varchar(32) default  '',
`address`  varchar(300) default  '',
`content`  varchar(500) default  '',
`beginDate`  varchar(32) default  '',
`beginTime`  varchar(32) default  '',
`endTime`  varchar(32) default  '',
`endDate`  varchar(32) default  '',
`buyerRate`  int default null   ,
`sellerRate`  int default null   ,
`isByStages`  int default null   ,
`createTime`  datetime default null,
`otherCost1`  varchar(32) default  '',
`otherCost2`  varchar(32) default  '',
`receipt`  int default null   ,
`createTime2`  datetime default null,
`createTime3`  datetime default null,
`createTime4`  datetime default null,
`createTime5`  datetime default null,
`createTime6`  datetime default null,
`createTime7`  datetime default null,
`createTime8`  datetime default null,
`createTime9`  datetime default null,
primary key (id)
);

drop table if exists t_app_business_pay;

create table t_app_business_pay (
`id`  int default null  auto_increment  ,
`orderId`  int default null   ,
`price`  varchar(32) default  '',
`price1`  varchar(32) default  '',
`payRatio`  varchar(32) default  '',
`paymentTime`  datetime default null,
`actualPayTime`  datetime default null,
`pos`  int default null   ,
`isPay`  int default null   ,
`payTime`  datetime default null,
`isPayment`  int default null   ,
`confrimPay`  int default null   ,
primary key (id)
);

drop table if exists t_app_business_cost;

create table t_app_business_cost (
`id`  int default null  auto_increment  ,
`orderId`  int default null   ,
`costId`  int default null   ,
`price`  varchar(32) default  '',
`days`  int default null   ,
primary key (id)
);

