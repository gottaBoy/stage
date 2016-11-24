drop table if exists t_app_ding;

create table t_app_ding (
`id`  int default null  auto_increment  ,
`userId`  int default null   ,
`dingUserId`  int default null   ,
`createTime`  datetime default null,
primary key (id)
);