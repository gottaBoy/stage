package com.smt.webapp.util;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.math.NumberUtils;

import com.smt.webapp.web.presonList.JsonDateValueProcessor;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.util.CycleDetectionStrategy;


public class CommonUtil {
    
    public CommonUtil() {
        // TODO Auto-generated constructor stub
    }
    
    //此方法专门用于完成数字的格式化显示

    public static String multipleAndNumberFormat(String value,int days){
    	return multipleAndNumberFormat("0.00",value,days);
    }
    
    public static String multipleAndNumberFormat(String pattern,String value,int days){
    	DecimalFormat df = new DecimalFormat(pattern) ;	
    	
    	double res = 0.0D;
    	if(NumberUtils.isNumber(value)){
			res = NumberUtils.createDouble(value);	
		}
    	res = res*days;
    	
    	return df.format(res) ;	
    }
    
    public static String numberFormat(String value){
    	return numberFormat("0.00",value);
	}
    
    
    //此方法专门用于完成数字的格式化显示
    public static String numberFormat(String pattern,String value){	
		DecimalFormat df = new DecimalFormat(pattern) ;	
		String str = "";
		if(NumberUtils.isNumber(value)){
			str = df.format(NumberUtils.createDouble(value)) ;	
		}else{
			str = "";
		}
		return str;
	}
    
    
    
    public static void outputJson(HttpServletResponse response, Map map) {
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setExcludes(new String[] { "" });
		jsonConfig.setIgnoreDefaultExcludes(false);
		jsonConfig.setCycleDetectionStrategy(CycleDetectionStrategy.LENIENT);
		jsonConfig.registerJsonValueProcessor(Date.class,
				new JsonDateValueProcessor("yyyy-MM-dd HH:mm:ss"));
		
		response.setContentType("text/javascript;charset=UTF-8");
		try {
			PrintWriter out = response.getWriter();
			out.write(JSONObject.fromObject(map, jsonConfig).toString());
		} catch (IOException e) {
		}
		
	}
	
    public static String getTime(Date date) {
    	SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	String time=df.format(date);
        return (time);
    }
    
    public static String getDate(Date date) {
    	SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
    	String time=df.format(date);
        return (time);
    }
    
    public static Date getTime(String time) throws Exception {
    	SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	return df.parse(time);
    }
    
    public static Date getDate(String date) throws Exception {
    	SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd");
    	return df.parse(date);
    }
    
   
	private static String upperCaseOne(String s) {
		return s.substring(0, 1).toUpperCase() + s.substring(1);
	}
	public static boolean isNumber(String str){
	    java.util.regex.Pattern pattern=java.util.regex.Pattern.compile("[0-9]*");
	    java.util.regex.Matcher match=pattern.matcher(str);
	    if(match.matches()==false){
	        return false;
	    }else{
	        return true;
	    }
	}
	
	public static String getDateString(String time){
		try {
			//Calendar dCalendar = DateFormat.
			Date date = new Date();
			
			Date old = CommonUtil.getTime(time);
			Long cc= date.getTime()-old.getTime();
			if(cc<=1000*60){
				return "刚刚";
			}else if(1000*60<cc&&cc<=1000*60*2){
				return "一分钟前";
			}else if(1000*60*2<cc&&cc<=1000*60*5){
				return "两分钟前";
			}else if(1000*60*5<cc&&cc<=1000*60*10){
				return "五分钟前";
			}else if(1000*60*10<cc&&cc<=1000*60*60){
				return "十分钟前";
			}else if(1000*60*60<cc&&cc<=1000*60*60*2){
				return "一小时前";
			}else if(1000*60*10*2<cc&&cc<=1000*60*60*24){
				return "两小时前";
			}else{
				return "一天前";
			}
			
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "一天前";
	}
	
	public static String getDateDif(String time) throws ParseException{
		
		SimpleDateFormat dfs = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		java.util.Date begin=new Date();
		java.util.Date end = dfs.parse(time);
		long between=(end.getTime()-begin.getTime())/1000;//除以1000是为了转换成秒

		long day1=between/(24*3600);
		long hour1=between%(24*3600)/3600;
		long minute1=between%3600/60;
		//long second1=between%60/60;
		String dayStr=String.valueOf(day1);
		String hourStr=String.valueOf(hour1);;
		String dateDif="";
		if(hour1<=9&&hour1>0){
			hourStr="0"+hourStr;
		}
		else if(hour1==0){
			hourStr="01";
		}
		if(day1==0){
			dateDif=hourStr+"小时";
		}else{
			if(day1<=9){
				dayStr="0"+dayStr;
			}
			dateDif=dayStr+"天"+hourStr+"小时";
		}
		return dateDif;
		
	}
	
	public static List getInputList(HttpServletRequest request, String keyName,Class objectClass) throws Exception {
		Field[] fields = objectClass.getDeclaredFields();
		List list = new ArrayList();
		int length = 0;
		if (request.getParameterValues(keyName) != null) {
			length = request.getParameterValues(keyName).length;
		}
		Class[] paraTypes = new Class[] { String.class };
		for (int i = 0; i <length; i++) {
			Object object = objectClass.newInstance();
			for (int j = 0; j < fields.length; j++) {
				Method method = objectClass.getDeclaredMethod("set"
						+ upperCaseOne(fields[j].getName()), paraTypes);
				Object[] paraValues = new String[] { "" };
				if (request.getParameterValues(fields[j].getName()+"1") != null) {
					if (request.getParameterValues(fields[j].getName()+"1")[i] != null) {
						    paraValues = new String[] { (String) request
								.getParameterValues(fields[j].getName()+"1")[i] };
						
					}
				}
				method.invoke(object, paraValues);
			}
			list.add(object);
		}
		return list;
	}
	
	public static String getIsnullReturnString(String str,String returnString){
		if(str != null&&!"".equals(str)){
			return str;
		}
		return returnString;
	}
    
	
}

