alter table t_app_drawback_info modify column DrawbackNo varchar(32);

alter table t_app_drawback_info add price varchar(30) default '' ;
alter table t_app_drawback_info add choucheng varchar(30) default '' ;



alter table t_app_business_info add drawbackStatus int default null ;