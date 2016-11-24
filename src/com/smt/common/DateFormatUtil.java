package com.smt.common;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class DateFormatUtil {

	/**
	 * 获取格式化后的时间
	 * @param date要格式化的时间
	 * @param formatString格式化的格式
	 * @return
	 */
	public static String getDate(Date date, String formatString) {
		DateFormat format = new SimpleDateFormat(formatString);
		return format.format(date);
	}
	
	
	/**
	 * 获取指定小数位数的小数
	 * @param value要格式化的值
	 * @param length保留几位小数
	 * @return
	 */
	public static double getFormatDouble(double value, int length) {
		if(length < 0)
			length = 0;
		BigDecimal b = new BigDecimal(value);
		return b.setScale(length, BigDecimal.ROUND_HALF_UP).doubleValue();
	}
	
	/**
	 * 获取上个月最后一天的日期
	 * @return
	 */
	public static String getLastMonthDay() {
		//获取当前时间
		Calendar cal = Calendar.getInstance();
		Date date = new Date();
		cal.setTime(date);
		//下面可以设置月份，注：月份设置要减1，所以设置1月就是1-1，设置2月就是2-1，如此类推
		cal.set(Calendar.MONTH, cal.get(Calendar.MONTH)-1);
		
		//得到一个月最最后一天日期(31/30/29/28)
		int MaxDay=cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		//按你的要求设置时间
		cal.set( cal.get(Calendar.YEAR), cal.get(Calendar.MONTH), MaxDay, 23, 59, 59);
		//按格式输出
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return sdf.format(cal.getTime());
		//System.out.println(sdf.format(cal.getTime()));	
	}
	
	/**
	 * 获取Double类型的计算值
	 * @param value1需计算的值1（除数）
	 * @param value2需计算的值1（被除数）
	 * @param calType计算类型（+、-、*、/）如果不是这四种返回0
	 * @param length计算的结果保留几位小数
	 * @return
	 */
	public static double calValue(double value1, double value2, String calType, int length) {
		BigDecimal bd1 = new BigDecimal(value1);
		BigDecimal bd2 = new BigDecimal(value2);
		if(calType.equals("+")) {
			double value = 0;
			BigDecimal temp = bd1.add(bd2);
			if(temp.doubleValue() > 0)
				value = temp.setScale(length, BigDecimal.ROUND_HALF_UP).doubleValue();
			else if(temp.doubleValue() < 0) 
				value = temp.setScale(length, BigDecimal.ROUND_HALF_DOWN).doubleValue();
			return value;
			//return bd1.add(bd2).setScale(length, BigDecimal.ROUND_HALF_UP).doubleValue();
		} else if(calType.equals("-")) {
			double value = 0;
			BigDecimal temp = bd1.subtract(bd2);
			if(temp.doubleValue() > 0)
				value = temp.setScale(length, BigDecimal.ROUND_HALF_UP).doubleValue();
			else if(temp.doubleValue() < 0) 
				value = temp.setScale(length, BigDecimal.ROUND_HALF_DOWN).doubleValue();
			return value;
			//return bd1.subtract(bd2).setScale(length, BigDecimal.ROUND_HALF_UP).doubleValue();
		} else if(calType.equals("*")) {
			double value = 0;
			BigDecimal temp = bd1.multiply(bd2);
			if(temp.doubleValue() > 0)
				value = temp.setScale(length, BigDecimal.ROUND_HALF_UP).doubleValue();
			else if(temp.doubleValue() < 0) 
				value = temp.setScale(length, BigDecimal.ROUND_HALF_DOWN).doubleValue();
			return value;
			//return bd1.multiply(bd2).setScale(length, BigDecimal.ROUND_HALF_UP).doubleValue();
		} else if(calType.equals("/")) {
			if(value2 == 0) {
				return 0;
			}
			double value = 0;
			BigDecimal temp = bd1.divide(bd2, length, BigDecimal.ROUND_HALF_EVEN);
			if(temp.doubleValue() > 0)
				value = temp.setScale(length, BigDecimal.ROUND_HALF_UP).doubleValue();
			else if(temp.doubleValue() < 0) 
				value = temp.setScale(length, BigDecimal.ROUND_HALF_DOWN).doubleValue();
			return value;
			//return bd1.divide(bd2).setScale(length, BigDecimal.ROUND_HALF_UP).doubleValue();
		} else {
			return 0;
		}
			
	}
	
	//用来全局控制 上一周，本周，下一周的周数变化
	private static int weeks = 0;
	
	/**
	 * 获得本周一的日期 
	 */
	public static String getMondayOFWeek() {
		weeks = 0;
		int mondayPlus = getMondayPlus();
		GregorianCalendar currentDate = new GregorianCalendar();
		currentDate.add(GregorianCalendar.DATE, mondayPlus);
		Date monday = currentDate.getTime();

		String preMonday = getDate(monday, "yyyy-MM-dd");
		return preMonday;
	} 
	
	/**
	 * 获得上周星期一的日期
	 */
	public static String getPreviousWeekday() {
		weeks--;
		int mondayPlus = getMondayPlus();
		GregorianCalendar currentDate = new GregorianCalendar();
		currentDate.add(GregorianCalendar.DATE, mondayPlus + 7 * weeks);
		Date monday = currentDate.getTime();
		String preMonday = getDate(monday, "yyyy-MM-dd");
		return preMonday;
	}

	/**
	 * 获得上周星期日的日期
	 */
	public static String getPreviousWeekSunday() {
		weeks = 0;
		weeks--;
		int mondayPlus = getMondayPlus();
		GregorianCalendar currentDate = new GregorianCalendar();
		currentDate.add(GregorianCalendar.DATE, mondayPlus + weeks);
		Date monday = currentDate.getTime();
		String preMonday = getDate(monday, "yyyy-MM-dd");
		return preMonday;
	} 
	
	/**
	 * 获得上上周星期日的日期
	 */
	public static String getPreviousWeekSunday1() {
		weeks--;
		weeks-=7;
		int mondayPlus = getMondayPlus();
		GregorianCalendar currentDate = new GregorianCalendar();
		currentDate.add(GregorianCalendar.DATE, mondayPlus + weeks);
		Date monday = currentDate.getTime();
		String preMonday = getDate(monday, "yyyy-MM-dd");
		return preMonday;
	} 
	
	public static String getPreviousYear() {
		Calendar c = Calendar.getInstance();
		c.setTime(new Date());
		c.add(Calendar.YEAR, -1);
		return getDate(c.getTime(), "yyyy");
	}

	//获得当前日期与本周日相差的天数
	private static int getMondayPlus() {
		Calendar cd = Calendar.getInstance();
		// 获得今天是一周的第几天，星期日是第一天，星期二是第二天......
		int dayOfWeek = cd.get(Calendar.DAY_OF_WEEK) - 1; // 因为按中国礼拜一作为第一天所以这里减1
		if (dayOfWeek == 1) {
			return 0;
		} else {
			return 1 - dayOfWeek;
		}
	} 

	/**
	 * 获取两个日期的间隔分钟
	 * 计算格式sj1-sj2
	 * @param sj1
	 * @param sj2
	 * @return
	 */
	public static long getTwoDayByMinutes(String sj1, String sj2) {
		SimpleDateFormat myFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		long hour = 0;
		try {
			Date date = myFormatter.parse(sj1);
			Date mydate = myFormatter.parse(sj2);
			hour = (date.getTime() - mydate.getTime()) / (60 * 1000);
		} catch (Exception e) {
			return 0;
		}
		return hour;
	}  
	/**
	 * 获取两个日期的间隔天数
	 * 计算格式sj1-sj2
	 * @param sj1
	 * @param sj2
	 * @return
	 */
	public static int getTwoDay(String sj1, String sj2) {
		SimpleDateFormat myFormatter = new SimpleDateFormat("yyyy-MM-dd");
		long day = 0;
		try {
			Date date = myFormatter.parse(sj1);
			Date mydate = myFormatter.parse(sj2);
			day = (date.getTime() - mydate.getTime()) / (24 * 60 * 60 * 1000);
		} catch (Exception e) {
			return 0;
		}
		return (int)day;
	}  
	public static void main(String[] args) {
		//System.out.println(getTwoDay("2014-03-06 24:00:00","2014-03-04 08:00:00"));
		String endDate = "2014-07-19";
		int time = 9;
		if(time < 10) {
			endDate = endDate + " 0" + time + ":00:00";
		} else {
			endDate = endDate + " " + time + ":00:00";
		}
		
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		long minutes = DateFormatUtil.getTwoDayByMinutes(df.format(new Date()), endDate);
		System.out.println(minutes);
	}
}

