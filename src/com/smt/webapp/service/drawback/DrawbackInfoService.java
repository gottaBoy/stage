package com.smt.webapp.service.drawback;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smt.entity.TAppDrawbackInfo;
import com.smt.webapp.dao.drawback.DrawbackInfoDao;

@Service
public class DrawbackInfoService {

	@Autowired
	private DrawbackInfoDao drawbackInfoDao;
	
	public List getMyDrawback(int userId,int  begin,int rowCount,int sign){
		return drawbackInfoDao.getMyDrawback(userId, begin, rowCount, sign);
	}
	
	public List getPayList(){
		return drawbackInfoDao.getPayList();
	}
	
	public int getTotal(int userId,int rowCount,int sign){
		return drawbackInfoDao.getTotal(userId, rowCount, sign);
	}
	
	public double getReturnPrice(int orderId, int type){
		return drawbackInfoDao.getReturnPrice(orderId, type);
	}
	
	public void saveOrEditDrawback(TAppDrawbackInfo drawback){
		drawbackInfoDao.saveOrEditDrawback(drawback);
	}
	
	//获取申请退款时自动生成的退款编号
	public String getNewDrawbackNo(String nowDate){
		nowDate=nowDate.substring(0,4)+nowDate.substring(5,7)+nowDate.substring(8,10);
		String newDrawbackNo=nowDate+"000001";
		String maxDrawbackNo=drawbackInfoDao.getMaxDrawbackNo(nowDate);
		if(!maxDrawbackNo.equals("")){
			newDrawbackNo=nowDate+getNumberStr(Integer.parseInt(maxDrawbackNo.substring(10))+1);
		}
		return "TK" + newDrawbackNo;
	}
	
	private String getNumberStr(int num){
		if(num<10){
			return "00000"+num;
		}else if(num>=10&&num<100){
			return "0000"+num;
		}else if(num>=100&&num<1000){
			return "000"+num;
		}else if(num>=1000&&num<10000){
			return "00"+num;
		}else if(num>=10000&&num<100000){
			return "0"+num;
		}else if(num>=100000){
			return ""+num;
		}else{
			return "000000";	//表示溢出
		}
	}
	
	public TAppDrawbackInfo getDrawbackById(int id){
		return drawbackInfoDao.getDrawbackById(id);
	}
	
	public TAppDrawbackInfo getDrawbackByCode(String orderCode){
		return drawbackInfoDao.getDrawbackByCode(orderCode);
	}
	
	public TAppDrawbackInfo getDrawbackByBusinessId(int businessId){
		return drawbackInfoDao.getDrawbackByBusinessId(businessId);
	}
}
