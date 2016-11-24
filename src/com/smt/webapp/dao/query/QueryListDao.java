package com.smt.webapp.dao.query;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.xwork.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;
import org.springframework.util.CollectionUtils;

import com.mchange.v1.util.ArrayUtils;
import com.smt.entity.TAppTalentCategory;
import com.smt.entity.TBaseArea;
import com.smt.webapp.dao.BaseDao;
import com.smt.webapp.dao.SqlAppender;
import com.smt.webapp.util.HqlToSql;

@Repository
public class QueryListDao extends BaseDao {
	private Logger logger = Logger.getLogger("mylog");
	
	public List<TAppTalentCategory> getTalentCategory(){
		
		SqlAppender hql = new SqlAppender("from TAppTalentCategory t where 1=1 and t.parentId!=0");
//		if(level==1){
//			hql.append(" and t.parentId=0 ");
//		}else if(level==2){
//			hql.append(" and EXISTS(from TAppTalentCategory tt where tt.parentId=0 and t.parentId=tt.id) ");
//		}else if(level==3){
//			hql.append(" and EXISTS(from TAppTalentCategory tt where EXISTS(from TAppTalentCategory ttt ");
//			hql.append(" where ttt.parentId=0 and tt.parentId=ttt.id) and t.parentId=tt.id)");
//		}
		
		hql.append(" order by t.id");
 		List<TAppTalentCategory> talentCategory = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
		return talentCategory;
	}
	
	//获取列表显示的艺人相关信息（涉及到4个表t_ht_app_cost_info/t_app_talent_category/t_app_user/t_app_user_info)
	public List getYrInfo(String placeF,String place,int sort,
			int orderBySign,int orderByDesc,String filterValue,int  begin,int rowCount,int bprice,int eprice,String keywords,String headKeywords,String sex ,String keyType){
		SqlAppender hql = new SqlAppender(" ");
		if(StringUtils.isBlank(keyType)){
			hql.append(" select a,b,c,d ");
		}else{
			hql.append(" select a,b,c ");
		}
		
		hql.append(" from TAppUser a");
		hql.append(" inner join a.userList b");//TAppUserInfo
		hql.append(" left join a.costList c");//TAppCostInfo
		
		if(StringUtils.isBlank(keyType)){
			hql.append(" left join c.category d ");//TAppTalentCategory
		}
		
		hql.append(" where a.authority='0' and a.state='1' ");

		if(StringUtils.isNotBlank(keyType)){
			hql.append(" and c.profession is null ");
		}

		
		//按菜单条件过滤职业
		if(filterValue!=null&&!("").equals(filterValue)){
			//首页新人加入点击更多，查询所有职业，只显示艺人的第一职业
			if(filterValue.equals("newUserAdd")){
				hql.append(" and c.orderNo='1'");
			}else{
				if(StringUtils.isBlank(keyType)){
					hql.append(" and (d.alias=?",filterValue);
					hql.append(" or (d.parentId in (select e.id from TAppTalentCategory e where e.alias=?) )",filterValue);
					hql.append(" or (d.parentId in (select f.id from TAppTalentCategory f where f.parentId in(select g.id from TAppTalentCategory g where g.alias=?)) )) ",filterValue);
				}
			}
		}
		
		if(sex != null && !"".equals(sex)&& !"0".equals(sex)){
			hql.append(" and b.sex=?",sex);
		}
		if (placeF.equals("1")) {
			SqlAppender hql1 = new SqlAppender("from TBaseArea t where 1=1 ");
			hql1.append("and t.aid=?",Integer.parseInt(place));
			List<TBaseArea> bList = getHibernateTemplate().find(hql1.getPsSql(),hql1.getParamsValues());
			if (bList!=null&&bList.size()>0) {
				TBaseArea baseArea = bList.get(0);
				
				hql.append(" and (b.provice like ? ","%"+baseArea.getAreaname().substring(0,2)+"%");
				hql.append(" or b.city like ?) ","%"+baseArea.getAreaname().substring(0,2)+"%");
			}
		}else {
			if(place != null && !"".equals(place)){
				hql.append(" and (b.provice like ? ","%"+place.substring(0,2)+"%");
				hql.append(" or b.city like ?) ","%"+place.substring(0,2)+"%");
			}
		}
		
		//搜索功能——价格
		if(bprice!=0){
			hql.append(" and c.eprice+0>=?",bprice);
		}
		if(eprice!=0){
			hql.append(" and c.bprice+0<=?",eprice);
		}
		
		//头部页面搜索功能——关键字
		if(headKeywords!=null&&!("").equals(headKeywords)){
			if(StringUtils.isBlank(keyType)){
				hql.append(" and((c.keywords like ? )","%"+headKeywords+"%");
				hql.append(" or (b.name like ? )","%"+headKeywords+"%");
				hql.append(" or (b.nickName like ? ) ","%"+headKeywords+"%");
				//hql.append(" or (a.username like ? ) ","%"+headKeywords+"%");
				hql.append(" or (b.professionStr like ?","%"+headKeywords+"%");
				hql.append(" or d.typeName like ?)","%"+headKeywords+"%");
				hql.append(" or (d.typeName like ?","%"+headKeywords+"%");
				hql.append(" or (d.parentId in (select e.id from TAppTalentCategory e where e.typeName like ?) )","%"+headKeywords+"%");
				hql.append(" or (d.parentId in (select f.id from TAppTalentCategory f where f.parentId in(select g.id from TAppTalentCategory g where g.typeName like ?)) ))) ","%"+headKeywords+"%");
			}else{
				
				hql.append(" and((c.keywords like ? )","%"+headKeywords+"%");
				hql.append(" or (b.name like ? )","%"+headKeywords+"%");
				hql.append(" or (b.nickName like ? )) ","%"+headKeywords+"%");
			}
		}

		hql.append(" group by a.id");
		if(sort==1){
			hql.append(" order by b.grade desc");
		}else if (sort==2) {
			hql.append(" order by b.feedbackRate desc");
		}else if (sort==3) {
			hql.append(" order by b.popularityTotal desc");
		}else if (sort==5) {
			hql.append(" order by c.bprice desc");
		}else {
			hql.append(" order by a.creatTime desc ");
		}

		
		List yrInfoList = executeQuery(hql.getPsSql(),hql.getParamsValues(), begin, rowCount);
		return yrInfoList;
	}
	
	public String getPlace(String placeId){
		String placeNameString = "请选择";
		SqlAppender hql1 = new SqlAppender("from TBaseArea t where 1=1 ");
		hql1.append("and t.aid=?",Integer.parseInt(placeId));
		List<TBaseArea> bList = getHibernateTemplate().find(hql1.getPsSql(),hql1.getParamsValues());
		if (bList!=null&&bList.size()>0) {
			TBaseArea baseArea = bList.get(0);
			placeNameString = baseArea.getAreaname();
		}	
		return placeNameString;
	}
	
	public int getTotal(String placeF,String place,int sort,
			int orderBySign,int orderByDesc,String filterValue,int  begin,int rowCount,int bprice,int eprice,String keywords,String headKeywords,String sex,String keyType ){
		SqlAppender hql = new SqlAppender(" ");
		if(StringUtils.isBlank(keyType)){
			hql.append(" select a,b,c,d ");
		}else{
			hql.append(" select a,b,c ");
		}
		hql.append(" from TAppUser a");
		
		hql.append(" inner join a.userList b");//TAppUserInfo
		hql.append(" left join a.costList c");//TAppCostInfo
		
		if(StringUtils.isBlank(keyType)){
			hql.append(" left join c.category d ");//TAppTalentCategory
		}
		
		hql.append(" where a.authority='0' and a.state='1' ");

		if(StringUtils.isNotBlank(keyType)){
			hql.append(" and c.profession is null ");
		}
		
		
		//按菜单条件过滤职业
		if(filterValue!=null&&!("").equals(filterValue)){
			//首页新人加入点击更多，查询所有职业，只显示艺人的第一职业
			if(filterValue.equals("newUserAdd")){
				hql.append(" and c.orderNo='1'");
			}else{
				if(StringUtils.isBlank(keyType)){
					hql.append(" and (d.alias=?",filterValue);
					hql.append(" or (d.parentId in (select e.id from TAppTalentCategory e where e.alias=?) )",filterValue);
					hql.append(" or (d.parentId in (select f.id from TAppTalentCategory f where f.parentId in(select g.id from TAppTalentCategory g where g.alias=?)) )) ",filterValue);
				}
			}
		}
		
		if(sex != null && !"".equals(sex)&& !"0".equals(sex)){
			hql.append(" and b.sex=?",sex);
		}
		if (placeF.equals("1")) {
			SqlAppender hql1 = new SqlAppender("from TBaseArea t where 1=1 ");
			hql1.append("and t.aid=?",Integer.parseInt(place));
			List<TBaseArea> bList = getHibernateTemplate().find(hql1.getPsSql(),hql1.getParamsValues());
			if (bList!=null&&bList.size()>0) {
				TBaseArea baseArea = bList.get(0);
				hql.append(" and (b.provice like ? ","%"+baseArea.getAreaname().substring(0,1)+"%");
				hql.append(" or b.city like ?) ","%"+baseArea.getAreaname().substring(0,1)+"%");
			}
		}else {
			if(place != null && !"".equals(place)){
				hql.append(" and (b.provice like ? ","%"+place.substring(0,1)+"%");
				hql.append(" or b.city like ?) ","%"+place.substring(0,1)+"%");
			}
		}
		
		//搜索功能——价格
		if(bprice!=0){
			hql.append(" and c.eprice+0>=?",bprice);
		}
		if(eprice!=0){
			hql.append(" and c.bprice+0<=?",eprice);
		}
		
		//头部页面搜索功能——关键字
		if(headKeywords!=null&&!("").equals(headKeywords)){
			if(StringUtils.isBlank(keyType)){
				hql.append(" and((c.keywords like ? )","%"+headKeywords+"%");
				hql.append(" or (b.name like ? )","%"+headKeywords+"%");
				hql.append(" or (b.nickName like ? ) ","%"+headKeywords+"%");
				//hql.append(" or (a.username like ? ) ","%"+headKeywords+"%");
				hql.append(" or (b.professionStr like ?","%"+headKeywords+"%");
				hql.append(" or d.typeName like ?)","%"+headKeywords+"%");
				hql.append(" or (d.typeName like ?","%"+headKeywords+"%");
				hql.append(" or (d.parentId in (select e.id from TAppTalentCategory e where e.typeName like ?) )","%"+headKeywords+"%");
				hql.append(" or (d.parentId in (select f.id from TAppTalentCategory f where f.parentId in(select g.id from TAppTalentCategory g where g.typeName like ?)) ))) ","%"+headKeywords+"%");
			}else{
				
				hql.append(" and((c.keywords like ? )","%"+headKeywords+"%");
				hql.append(" or (b.name like ? )","%"+headKeywords+"%");
				hql.append(" or (b.nickName like ? )) ","%"+headKeywords+"%");
			}			
		}
		hql.append(" group by a.id");

		//int total = getRowCount(hql.getPsSql(),hql.getParamsValues());
		//total=total%rowCount==0?total/rowCount:total/rowCount+1;
		List yrInfoList = executeQuery(hql.getPsSql(),hql.getParamsValues());
		int total=yrInfoList.size();		
		total=total%rowCount==0?total/rowCount:total/rowCount+1;
		
		return total;
	}

	public List getFenLei(String place, int sort, String filterValue,int begin, int rowCount, int bprice,int eprice,String sex,String renZheng,String headKeywords2) {
		SqlAppender hql = new SqlAppender("select a,b,c,d ");
		hql.append(" from TAppUser a");
		hql.append(" inner join a.userList b");//TAppUserInfo
		hql.append(" left join a.costList c");//TAppCostInfo
		hql.append(" left join c.category d ");//TAppTalentCategory
		hql.append(" where a.authority='0' and a.state='1' and a.isOrg=0 ");
		
		//按菜单条件过滤职业
		if(StringUtils.isNotEmpty(filterValue)){
			//首页新人加入点击更多，查询所有职业，只显示艺人的第一职业
			if(filterValue.equals("newUserAdd")){
				hql.append(" and c.orderNo='1'");
			}else{
				hql.append(" and (d.alias=?",filterValue);
				hql.append(" or d.parentId in (select e.id from TAppTalentCategory e where e.alias=?) ",filterValue);
				hql.append(" or d.parentId in (select f.id from TAppTalentCategory f where f.parentId in(select g.id from TAppTalentCategory g where g.alias=?)) ",filterValue);
				hql.append(" or d.parentId in (select f.id from TAppTalentCategory f where f.parentId in(select g.id from TAppTalentCategory g where g.parentId in(select h.id from TAppTalentCategory h where h.alias=?)) ) ",filterValue);
				hql.append(" ) ");
			}
		}
		
		if(StringUtils.isNotEmpty(sex)){
			hql.append(" and b.sex=?",sex);
		}
		if(StringUtils.isNotEmpty(renZheng)){
			hql.append(" and b.idCard is not null ");
		}
		 
		if(StringUtils.isNotEmpty(place)){
			hql.append(" and (b.provice like ? ","%"+place+"%");
			hql.append(" or b.city like ?) ","%"+place+"%");
		}
 
		
		//搜索功能——价格
		hql.append(" and c.bprice>=?",bprice);
		hql.append(" and c.bprice<=?",eprice);
		
		if(StringUtils.isNotBlank(headKeywords2)){
			hql.append(" and((c.keywords like ? )","%"+headKeywords2+"%");
			hql.append(" or (b.name like ? )","%"+headKeywords2+"%");
			hql.append(" or (b.nickName like ? ) ","%"+headKeywords2+"%");
			
			//added 2015-01-11
			hql.append(" or b.professionStr like ?","%"+headKeywords2+"%");
			hql.append(" or d.typeName like ? ","%"+headKeywords2+"%");
			hql.append(" or (d.parentId in (select e.id from TAppTalentCategory e where e.typeName like ?) )","%"+headKeywords2+"%");
			hql.append(" or (d.parentId in (select f.id from TAppTalentCategory f where f.parentId in(select g.id from TAppTalentCategory g where g.typeName like ?)) ) ","%"+headKeywords2+"%");
			hql.append(" or (d.parentId in (select f.id from TAppTalentCategory f where f.parentId in(select g.id from TAppTalentCategory g where g.parentId in(select h.id from TAppTalentCategory h where h.alias like ?)))) ","%"+headKeywords2+"%");
			hql.append(")");
		}		
		
		
		hql.append(" group by a.id");
		
		//0=人气最旺 1=价格最低 2=好评最多 3=最新加入
		switch (sort) {
			case 0:
				hql.append(" order by b.popularityTotal desc");
				break;
			case 1:
				hql.append(" order by c.bprice ");
				break;
			case 2:
				hql.append(" order by b.feedbackRate desc");			
				break;
			case 3:
				hql.append(" order by a.creatTime desc ");
				break;
			default:
				//hql.append(" order by b.grade desc");		
				break;
		}

		logger.info(".....getFenLei.sql="+hql.getPsSql());
		logger.info(".....getFenLei.getParamsValues="+ArrayUtils.toString(hql.getParamsValues()));
		
		//String tSql = HqlToSql.formatHqlToSql(super.getSession(),hql.getPsSql(), CollectionUtils.arrayToList(hql.getParamsValues()));
		//logger.info(".....getFenLei.tSql="+tSql);
		
		List yrInfoList = executeQuery(hql.getPsSql(),hql.getParamsValues(), begin, rowCount);
		return yrInfoList;
	}

	public int getFenLeiTotal(String place, int sort, String filterValue,int begin, int rowCount, int bprice,int eprice,String sex,String renZheng,String headKeywords2) {

		SqlAppender hql = new SqlAppender("select a,b,c,d from TAppUser a");
		
		hql.append(" inner join a.userList b");//TAppUserInfo
		hql.append(" left join a.costList c");//TAppCostInfo
		hql.append(" left join c.category d ");//TAppTalentCategory
		hql.append(" where a.authority='0' and a.state='1'  and a.isOrg=0 ");
		//按菜单条件过滤职业
		if(StringUtils.isNotEmpty(filterValue)){
			//首页新人加入点击更多，查询所有职业，只显示艺人的第一职业
			if(filterValue.equals("newUserAdd")){
				hql.append(" and c.orderNo='1'");
			}else{
				hql.append(" and (d.alias=?",filterValue);
				hql.append(" or d.parentId in (select e.id from TAppTalentCategory e where e.alias=?) ",filterValue);
				hql.append(" or d.parentId in (select f.id from TAppTalentCategory f where f.parentId in(select g.id from TAppTalentCategory g where g.alias=?)) ",filterValue);
				hql.append(" or d.parentId in (select f.id from TAppTalentCategory f where f.parentId in(select g.id from TAppTalentCategory g where g.parentId in(select h.id from TAppTalentCategory h where h.alias=?)) ) ",filterValue);
				hql.append(" ) ");
			}
		}
		
		if(StringUtils.isNotEmpty(sex)){
			hql.append(" and b.sex=?",sex);
		}
		
		if(StringUtils.isNotEmpty(renZheng)){
			hql.append(" and b.idCard is not null ");
		}
		
		if(StringUtils.isNotEmpty(place)){
			hql.append(" and (b.provice like ? ","%"+place+"%");
			hql.append(" or b.city like ?) ","%"+place+"%");
		}
		//搜索功能——价格
		hql.append(" and c.bprice+0>=?",bprice);
		hql.append(" and c.bprice+0<=?",eprice);
		
		if(StringUtils.isNotBlank(headKeywords2)){
			hql.append(" and((c.keywords like ? )","%"+headKeywords2+"%");
			hql.append(" or (b.name like ? )","%"+headKeywords2+"%");
			hql.append(" or (b.nickName like ? ) ","%"+headKeywords2+"%");
			
			//added 2015-01-11
			hql.append(" or b.professionStr like ?","%"+headKeywords2+"%");
			hql.append(" or d.typeName like ? ","%"+headKeywords2+"%");
			hql.append(" or (d.parentId in (select e.id from TAppTalentCategory e where e.typeName like ?) )","%"+headKeywords2+"%");
			hql.append(" or (d.parentId in (select f.id from TAppTalentCategory f where f.parentId in(select g.id from TAppTalentCategory g where g.typeName like ?)) ) ","%"+headKeywords2+"%");
			hql.append(" or (d.parentId in (select f.id from TAppTalentCategory f where f.parentId in(select g.id from TAppTalentCategory g where g.parentId in(select h.id from TAppTalentCategory h where h.alias like ?)))) ","%"+headKeywords2+"%");
			hql.append(")");
		}
		
		hql.append(" group by a.id");

		List list = executeQuery(hql.getPsSql(),hql.getParamsValues());
		//int total = getRowCount(hql.getPsSql(),hql.getParamsValues());
		
		logger.info(".....getFenLeiTotal.sql="+hql.getPsSql());
		logger.info(".....getFenLeiTotal.getParamsValues="+ArrayUtils.toString(hql.getParamsValues()));
		
		if(!CollectionUtils.isEmpty(list)){
			return list.size();
		}else{
			return 0;	
		}
		
	}

	public TAppTalentCategory getTalentCategory(String filterValue) {
		
		SqlAppender hql = new SqlAppender("from TAppTalentCategory t where 1=1 ");
		hql.append(" and t.alias=?",filterValue);
		
 		List<TAppTalentCategory> talentCategoryList = getHibernateTemplate().find(hql.getPsSql(),hql.getParamsValues());
 		if(!CollectionUtils.isEmpty(talentCategoryList)){
 			return talentCategoryList.get(0);	
 		}else{
 			return null;
 		}
		
	}

	public List getOrg(String orgType, String place, int sort, int begin, int length, String renZheng,String headKeywords2) {
		SqlAppender hql = new SqlAppender("select a,b from TAppUser a");
		
		hql.append(" inner join a.userList b");//TAppUserInfo
		hql.append(" left join a.costList c");//TAppCostInfo
		hql.append(" where a.authority='0' and a.state='1' and a.isOrg = 1 ");
		
		if(StringUtils.equals(renZheng, "不限")){ 
			hql.append("  ");
		}else if(StringUtils.equals(renZheng, "企业认证")){ 
			hql.append(" and b.orgCard is not null ");
		}else if(StringUtils.equals(renZheng, "个人认证")){ 
			hql.append(" and b.idCard is not null ");
		}
		
		if(StringUtils.isNotEmpty(place)){
			hql.append(" and (b.provice like ? ","%"+place+"%");
			hql.append(" or b.city like ?) ","%"+place+"%");
		}
		
		if(StringUtils.isNotEmpty(orgType)){
			hql.append(" and b.companyTags like ? ", "%"+orgType+"%");
		}
		
		if(StringUtils.isNotBlank(headKeywords2)){
			hql.append(" and((c.keywords like ? )","%"+headKeywords2+"%");
			
			hql.append(" or b.companyTags like ? ", "%"+headKeywords2+"%");
			hql.append(" or b.seviceScope like ? ", "%"+headKeywords2+"%");
			
			hql.append(" or (b.name like ? )","%"+headKeywords2+"%");
			hql.append(" or (b.nickName like ? )) ","%"+headKeywords2+"%");
		}
		
		
		hql.append(" group by a.id");
		//0:人气最旺 1:好评最多 2:签约最多
		switch (sort) {
			case 0:
				hql.append(" order by b.popularityTotal desc");
				break;
			case 1:
				hql.append(" order by b.feedbackRate desc");			
				break;
			case 2:
				hql.append(" order by b.signAmount desc ");
				break;
			default:
				break;
		}

		logger.info(".....getOrg.sql="+hql.getPsSql());
		logger.info(".....getOrg.getParamsValues="+ArrayUtils.toString(hql.getParamsValues()));
		
		List yrInfoList = executeQuery(hql.getPsSql(),hql.getParamsValues(), begin, length);
		return yrInfoList;
		
	}

	public int getOrgTotal(String orgType, String place, int sort, int begin, int length, String renZheng,String headKeywords2) {

		SqlAppender hql = new SqlAppender("select a,b from TAppUser a");
		
		hql.append(" inner join a.userList b");//TAppUserInfo
		hql.append(" left join a.costList c");//TAppCostInfo
		hql.append(" where a.authority='0' and a.state='1'  and a.isOrg = 1 ");
		
		if(StringUtils.equals(renZheng, "不限")){ 
			hql.append("  ");
		}else if(StringUtils.equals(renZheng, "企业认证")){ 
			hql.append(" and b.orgCard is not null ");
		}else if(StringUtils.equals(renZheng, "个人认证")){ 
			hql.append(" and b.idCard is not null ");
		}
		
		if(StringUtils.isNotEmpty(place)){
			hql.append(" and (b.provice like ? ","%"+place+"%");
			hql.append(" or b.city like ?) ","%"+place+"%");
		}
		
		if(StringUtils.isNotEmpty(orgType)){
			hql.append(" and b.companyTags like ? ", "%"+orgType+"%");
		}
		
		if(StringUtils.isNotBlank(headKeywords2)){
			hql.append(" and((c.keywords like ? )","%"+headKeywords2+"%");
			hql.append(" or (b.name like ? )","%"+headKeywords2+"%");

			hql.append(" and b.companyTags like ? ", "%"+headKeywords2+"%");
			hql.append(" and b.seviceScope like ? ", "%"+headKeywords2+"%");
			
			hql.append(" or (b.nickName like ? )) ","%"+headKeywords2+"%");
		}
		
		
		hql.append(" group by a.id");

		logger.info(".....getOrgTotal.sql="+hql.getPsSql());
		logger.info(".....getOrgTotal.getParamsValues="+ArrayUtils.toString(hql.getParamsValues()));
		
		List list = executeQuery(hql.getPsSql(),hql.getParamsValues());
		
		if(!CollectionUtils.isEmpty(list)){
			return list.size();
		}else{
			return 0;	
		}
	}

	public List getOrgInfo(int begin, int rowCount, String searchContent) {
		SqlAppender hql = new SqlAppender("select a,b,c ");
		hql.append(" from TAppUser a");
		hql.append(" inner join a.userList b");//TAppUserInfo
		hql.append(" left join a.costList c");//TAppCostInfo
		hql.append(" where a.authority='0' and a.state='1' ");
		
		hql.append(" and c.profession is null ");
		
		//头部页面搜索功能——关键字
		if(searchContent!=null&&!("").equals(searchContent)){
			hql.append(" and c.keywords like ? ","%"+searchContent+"%");
		}

		hql.append(" group by a.id");
		hql.append(" order by b.popularityTotal desc");
		
		List yrInfoList = executeQuery(hql.getPsSql(),hql.getParamsValues(), begin, rowCount);
		return yrInfoList;
	}

	public int getOrgTotal(String searchContent) {
		SqlAppender hql = new SqlAppender("select a,b,c ");
		hql.append(" from TAppUser a");
		hql.append(" inner join a.userList b");//TAppUserInfo
		hql.append(" left join a.costList c");//TAppCostInfo
		hql.append(" where a.authority='0' and a.state='1' ");
		
		hql.append(" and c.profession is null ");
		
		
		//头部页面搜索功能——关键字
		if(searchContent!=null&&!("").equals(searchContent)){
			hql.append(" and c.keywords like ? ","%"+searchContent+"%");
		}

		hql.append(" group by a.id");
		hql.append(" order by b.popularityTotal desc");
		
		List yrInfoList = executeQuery(hql.getPsSql(),hql.getParamsValues());
		if(CollectionUtils.isEmpty(yrInfoList)){
			return 0;
		}else{
			return yrInfoList.size();
		}
	}
}
