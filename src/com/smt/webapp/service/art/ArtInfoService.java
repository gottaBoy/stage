package com.smt.webapp.service.art;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.smt.entity.TAppArtInfo;
import com.smt.entity.TAppImagesInfo;
import com.smt.webapp.dao.art.ArtInfoDao;
import com.smt.webapp.dao.art.ImgInfoDao;

@Controller
public class ArtInfoService {

	@Autowired
	private ArtInfoDao artInfoDao;
	@Autowired
	private ImgInfoDao imgInfoDao;
	public List<TAppArtInfo> getArtInfoList(int userId,int  begin,int rowCount,int sign){
		
		return artInfoDao.getArtInfoList(userId, begin, rowCount, sign);
	}
	public List<TAppArtInfo> getMyArtInfoList(int id, int type) {
		return artInfoDao.getMyArtInfoList(id, type);
	}
	
	public List<TAppArtInfo> getArtInfoList(int userId,int  begin,int rowCount,int sign,int artId){
		
		return artInfoDao.getArtInfoList(userId, begin, rowCount, sign,artId);
	}	
	public int getArtInfoList1(int userId,int  begin,int rowCount,int sign){
		
		return artInfoDao.getArtInfoList1(userId, begin, rowCount, sign);
	}
	
	public int getTotal(int userId,int rowCount,int sign){
		return artInfoDao.getTotal(userId, rowCount, sign);
	}
	
	public TAppArtInfo getArtInfoByID(int id){
		TAppArtInfo artInfo= null;
		List<TAppArtInfo> artInfoList = (List<TAppArtInfo>)artInfoDao.getArtInfoByID(id);
		if(artInfoList!=null && artInfoList.size()>0){
			artInfo = artInfoList.get(0);
		}
		return artInfo;
	}
	
	public int getTotalsArt(int id ,String sign){
		
		return artInfoDao.getTotalsArt(id,sign);
	}
	
	
	public void saveOrUpdateArtInfo(TAppArtInfo item){
		artInfoDao.saveOrUpdateArtInfo(item);
	}

	public void delArtInfo(TAppArtInfo item){
		artInfoDao.delArtInfo(item);
	}
	public void delImgInfo(int id){
		TAppImagesInfo imgInfo=imgInfoDao.getAppImagesInfo(id);
		imgInfoDao.delImgInfo(imgInfo);
		artInfoDao.updateImgCount_1Byid(imgInfo.getParentId());
	}
	
	
	public List<TAppImagesInfo> getAppImagesInfos(int id,int begin,int length){
		return imgInfoDao.getImgInfoByID(id,begin,length);
	}
	
	
	public void saveImginfo(TAppImagesInfo img){
		 imgInfoDao.saveImgInfo(img);
	}
	public void updateImginfo(TAppImagesInfo img){
		 imgInfoDao.updateImgInfo(img);
	}
	public int getCountByparentId(int parentId){
		return imgInfoDao.getCountByparentId(parentId);
	}
	
	public TAppImagesInfo getAppImagesInfo(int id){
		return imgInfoDao.getAppImagesInfo(id);
	}

	public void setUpImg(int id) {
		TAppImagesInfo imgInfo=imgInfoDao.getAppImagesInfo(id);
		TAppArtInfo appArtInfo = artInfoDao.getArtInfoByID(imgInfo.getParentId()).get(0);
		appArtInfo.setUrl(imgInfo.getUrl());
		// TODO Auto-generated method stub
		artInfoDao.saveOrUpdateArtInfo(appArtInfo);
	}
	public int countAppImagesInfos(int artId) {
		return imgInfoDao.countAppImagesInfos(artId);
	}
	public List<TAppArtInfo> getMyZuoPinList(int id, int type) {
		return artInfoDao.getMyZuoPinList(id, type);
	}

}
