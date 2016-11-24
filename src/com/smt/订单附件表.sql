drop table if exists t_app_upload_file;

create table t_app_upload_file (
   `id` int(11) not null auto_increment,
   `attachName` varchar(200) default '',
   `suffix` varchar(30) default '',
   `size` bigint(20) default null,
   `orderId` int(11) default null,
   `uploadDate` datetime default null,
primary key (id)
);