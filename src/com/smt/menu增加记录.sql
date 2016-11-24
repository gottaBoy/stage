INSERT INTO t_app_menu(menuNo,menuName,menuLevel,active,link) VALUES (36,'退款管理',3,'1','member/drawback!drawbackList.htm')；


---------------2013-11-07------------------
insert into t_app_menu(menuNo,menuName,menuLevel,active,link) values (6,'我是艺人',2,'1','member/business!mySellerList.htm');
update t_app_menu set link='member/business!myBuyerList.htm',menuName='我是老板' where id=5;
update t_app_menu set menuNo=7 where id=20;
update t_app_menu set menuNo=8 where id=21;