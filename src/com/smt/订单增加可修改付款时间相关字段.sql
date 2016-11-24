
alter table t_app_business_info add updatePayTimeCount int default 0 ;
alter table t_app_business_info add updatePayTimeStatus int default 0;


alter table t_app_business_pay add updatePayTime datetime default null;