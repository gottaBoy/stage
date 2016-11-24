package com.smt.common;

import java.util.Calendar;

public class Constellation {
	 public static final String[] constellationArr = { "水瓶座", "双鱼座", "牡羊座", "金牛座",
		 "双子座", "巨蟹座", "狮子座", "处女座", "天秤座","天蝎座", "射手座", "魔羯座" };    
	 public static final int[] constellationEdgeDay = { 20, 19, 21, 21, 21, 22, 23, 23, 23, 23, 22, 22 };    
	 public static String date2Constellation(Calendar time) {    
         int month = time.get(Calendar.MONTH);    
         int day = time.get(Calendar.DAY_OF_MONTH);    
         if (day < constellationEdgeDay[month]) {    
             month = month - 1;    
         }    
         if (month >= 0) {    
             return constellationArr[month];    
         }    
         //default to return 魔羯    
         return constellationArr[11];    
     } 
}
