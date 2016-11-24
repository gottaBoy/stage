package com.smt.webapp.dao.art;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.smt.entity.TAppImagesInfo;
import com.smt.webapp.dao.BaseDao;
import com.smt.webapp.dao.SqlAppender;

@Repository
public class ImgInfoDao extends BaseDao{
	
	public List<TAppImagesInfo> getImgInfoByID(int id,int begin,int length){
		SqlAppender hql = new SqlAppender("from TAppImagesInfo t where 1=1 ");
		hql.append(" and t.parentId=?",id);
		List<TAppImagesInfo> imgInfo = executeQuery(hql.getPsSql(),hql.getParamsValues(),begin,length);
 		return imgInfo;
	}
	
	
	public void saveImgInfo(TAppImagesInfo img){
		save(img);
	}
	
	
	public int getCountByparentId(int parentId){
		SqlAppender hql = new SqlAppender("from TAppImagesInfo t where 1=1 ");
		hql.append(" and t.parentId=?",parentId);
		return getRowCount(hql.getPsSql(),hql.getParamsValues());
	}
	
	public TAppImagesInfo getAppImagesInfo(int id){
		return (TAppImagesInfo)load(TAppImagesInfo.class, id);
	}
	public void delImgInfo(TAppImagesInfo item) {
		// TODO Auto-generated method stub
		delete(item);
	}


	public void updateImgInfo(TAppImagesInfo img) {
		update(img);
		
	}


	public int countAppImagesInfos(int artId) {
		SqlAppender hql = new SqlAppender("from TAppImagesInfo t where 1=1 ");
		hql.append(" and t.parentId=?",artId);
		int count = getRowCount(hql.getPsSql(),hql.getParamsValues());
		return count;
	}
}
