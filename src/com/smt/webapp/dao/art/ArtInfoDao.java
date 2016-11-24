package com.smt.webapp.dao.art;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.hql.ast.tree.FromClause;
import org.springframework.stereotype.Repository;

import com.smt.entity.TAppArtInfo;
import com.smt.entity.TAppImagesInfo;
import com.smt.entity.TAppMessage;
import com.smt.webapp.dao.BaseDao;
import com.smt.webapp.dao.SqlAppender;
@Repository
public class ArtInfoDao extends BaseDao{

	public List<TAppArtInfo> getMyArtInfoList(int id, int type) {
		String signStr=Integer.toString(type);
		SqlAppender hql = new SqlAppender("");
		//相册
		hql.append("from TAppArtInfo t where 1=1");
		hql.append(" and t.userId=?",id);
		hql.append(" and t.type =?",signStr);
		hql.append(" order by t.creatTime desc");
		 
		List<TAppArtInfo> artInfoList = executeQuery(hql.getPsSql(),hql.getParamsValues());
		
 		return artInfoList;
	}
	
	
	//相册sign=1，视频sign=2，音频sign=3
	public List<TAppArtInfo> getArtInfoList(int userId,int  begin,int rowCount,int sign){
		String signStr=Integer.toString(sign);
		SqlAppender hql = new SqlAppender("");
		if(sign==1){	//相册
			hql.append("from TAppArtInfo t where 1=1");
			hql.append(" and t.userId=?",userId);
			hql.append(" and t.type =?)",signStr);
			hql.append(" order by t.creatTime desc");
		}else if(sign==2){ //视频
			hql.append("from TAppArtInfo t where 1=1");
			hql.append(" and t.userId=?",userId);
			hql.append(" and t.type =?)",signStr);
			hql.append(" order by t.creatTime desc");
		}else if(sign==3){	//音频
			hql.append("from TAppArtInfo t where 1=1");
			hql.append(" and t.userId=?",userId);
			hql.append(" and t.type =?)",signStr);
			hql.append(" order by t.creatTime desc");
		}else if(sign==4){	//广告
			hql.append("from TAppArtInfo t where 1=1");
			hql.append(" and t.userId=?",userId);
			hql.append(" and t.type =?)",signStr);
			hql.append(" order by t.creatTime desc");
		}else if(sign==5){	//相关作品
			hql.append("from TAppArtInfo t where 1=1");
			hql.append(" and t.userId=?",userId);
			hql.append(" and t.type =1)");
			hql.append(" order by t.creatTime desc");
		}
		List<TAppArtInfo> artInfoList = executeQuery(hql.getPsSql(),hql.getParamsValues(), begin, rowCount);
		
 		return artInfoList;
	}

	//相册sign=1，视频sign=2，音频sign=3
	public List<TAppArtInfo> getArtInfoList(int userId,int  begin,int rowCount,int sign,int artId){
		String signStr=Integer.toString(sign);
		SqlAppender hql = new SqlAppender("");
		if(sign==1){	//相册
			hql.append("from TAppArtInfo t where 1=1");
			hql.append(" and t.userId=?",userId);
			hql.append(" and t.id=?",artId);
			
			hql.append(" and t.type =?)",signStr);
			hql.append(" order by t.creatTime desc");
		}else if(sign==2){ //视频
			hql.append("from TAppArtInfo t where 1=1");
			hql.append(" and t.userId=?",userId);
			hql.append(" and t.id=?",artId);
			hql.append(" and t.type =?)",signStr);
			hql.append(" order by t.creatTime desc");
		}else if(sign==3){	//音频
			hql.append("from TAppArtInfo t where 1=1");
			hql.append(" and t.userId=?",userId);
			hql.append(" and t.id=?",artId);
			hql.append(" and t.type =?)",signStr);
			hql.append(" order by t.creatTime desc");
		}else if(sign==4){	//广告
			hql.append("from TAppArtInfo t where 1=1");
			hql.append(" and t.userId=?",userId);
			hql.append(" and t.id=?",artId);
			hql.append(" and t.type =?)",signStr);
			hql.append(" order by t.creatTime desc");
		}else if(sign==5){	//相关作品
			hql.append("from TAppArtInfo t where 1=1");
			hql.append(" and t.userId=?",userId);
			hql.append(" and t.id=?",artId);
			hql.append(" and t.type =1)");
			hql.append(" order by t.creatTime desc");
		}
		List<TAppArtInfo> artInfoList = executeQuery(hql.getPsSql(),hql.getParamsValues(), begin, rowCount);
		
 		return artInfoList;
	}	
	public int getArtInfoList1(int userId,int  begin,int rowCount,int sign){
		String signStr=Integer.toString(sign);
		SqlAppender hql = new SqlAppender("");
		if(sign==1){	//相册
			hql.append("from TAppArtInfo t where 1=1");
			hql.append(" and t.userId=?",userId);
			hql.append(" and t.type =?)",signStr);
			hql.append(" order by t.creatTime desc");
		}else if(sign==2){ //视频
			hql.append("from TAppArtInfo t where 1=1");
			hql.append(" and t.userId=?",userId);
			hql.append(" and t.type =?)",signStr);
			hql.append(" order by t.creatTime desc");
		}else if(sign==3){	//音频
			hql.append("from TAppArtInfo t where 1=1");
			hql.append(" and t.userId=?",userId);
			hql.append(" and t.type =?)",signStr);
			hql.append(" order by t.creatTime desc");
		}else if(sign==4){	//广告
			hql.append("from TAppArtInfo t where 1=1");
			hql.append(" and t.userId=?",userId);
			hql.append(" and t.type =?)",signStr);
			hql.append(" order by t.creatTime desc");
		}
		List<TAppArtInfo> artInfoList = executeQuery(hql.getPsSql(),hql.getParamsValues());
		
 		return artInfoList.size();
	}
	
	public int getTotal(int userId,int rowCount,int sign){
		String signStr=Integer.toString(sign);
		SqlAppender hql = new SqlAppender("");
		if(sign==1){
			hql.append("from TAppArtInfo t where 1=1");
			hql.append(" and t.userId=?",userId);
			hql.append(" and t.type =?)",signStr);
		}
		else if(sign==2){	//相册
			hql.append("from TAppArtInfo t where 1=1");
			hql.append(" and t.userId=?",userId);
			hql.append(" and t.type =?)",signStr);
		}else if(sign==3){ //视频
			hql.append("from TAppArtInfo t where 1=1");
			hql.append(" and t.userId=?",userId);
			hql.append(" and t.type =?)",signStr);
		}else if(sign==4){	//音频
			hql.append("from TAppArtInfo t where 1=1");
			hql.append(" and t.userId=?",userId);
			hql.append(" and t.type =?)",signStr);
		}else if(sign==5){	//相关作品
			hql.append("from TAppArtInfo t where 1=1");
			hql.append(" and t.userId=?",userId);
			hql.append(" and t.type =?)",signStr);
		}
		int total=getRowCount(hql.getPsSql(),hql.getParamsValues());		
		total=total%rowCount==0?total/rowCount:total/rowCount+1;
		return total;
	}
	
	public List<TAppArtInfo> getArtInfoByID(int id){
		SqlAppender hql = new SqlAppender("from TAppArtInfo t where 1=1 ");
		hql.append(" and t.id=?",id);
		List<TAppArtInfo> artInfo = executeQuery(hql.getPsSql(),hql.getParamsValues());
		
 		return artInfo;
	}
	
	public TAppArtInfo getAppArtInfoByID(int id){
		return (TAppArtInfo)getHibernateTemplate().load(TAppArtInfo.class, id);
	}
	
	public void saveOrUpdateArtInfo(TAppArtInfo item){
		saveOrUpdate(item);
	}
	

	public void delArtInfo(TAppArtInfo item){
		delete(item);
	}
	
	public void updateImgCountByid(int id){
		TAppArtInfo info = (TAppArtInfo)load(TAppArtInfo.class, id);
		if(info !=null){
			info.setImgCount((info.getImgCount()==null?0:info.getImgCount())+1);
			update(info);
		}
	}
	public void updateImgCount_1Byid(int id){
		TAppArtInfo info = (TAppArtInfo)load(TAppArtInfo.class, id);
		info.setImgCount(info.getImgCount()-1);
		update(info);
	}

	public int getTotalsArt(int id, String sign) {
		// TODO Auto-generated method stub
		SqlAppender hql = new SqlAppender("from TAppArtInfo t where 1=1 ");
		hql.append(" and t.userId = ?",id);
		hql.append(" and t.type = ?",sign);
		int count = getRowCount(hql.getPsSql(),hql.getParamsValues());
		return count;
	}


	public List<TAppArtInfo> getMyZuoPinList(int id, int type) {
		StringBuilder hql = new StringBuilder(" select t.id, t.title, t.url, (select count(1) from t_app_images_info i where i.parentId = t.id) as imgCount  ");
		hql.append(" from t_app_art_info t  ");
		hql.append(" where t.userId="+id);
		hql.append(" and t.type ="+type);
		hql.append(" order by t.creatTime desc");
		
		return getSession().createSQLQuery(hql.toString()).list();
	}

}
