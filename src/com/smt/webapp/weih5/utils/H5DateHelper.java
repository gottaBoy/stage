package com.smt.webapp.weih5.utils;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class H5DateHelper {

	public static Date calDateAfterOnHour(Date targetDate, int hourCount) {
		Calendar targetCalendar = Calendar.getInstance();
		targetCalendar.setTime(targetDate);
		targetCalendar.set(Calendar.HOUR, targetCalendar.get(Calendar.HOUR) + hourCount);
		return targetCalendar.getTime();
	}

	public static Date calDateAfterOnMinute(Date targetDate, int minuteCount) {
		Calendar targetCalendar = Calendar.getInstance();
		targetCalendar.setTime(targetDate);
		targetCalendar.set(Calendar.MINUTE, targetCalendar.get(Calendar.MINUTE) + minuteCount);
		return targetCalendar.getTime();
	}

	public static int countDays(String start, String end, String format) {
		try {
			DateFormat formater = new SimpleDateFormat(format);
			Date startDate = formater.parse(start);
			Date endDate = formater.parse(end);
			long timeDif = endDate.getTime() - startDate.getTime();
			return (int) (timeDif / (1000 * 60 * 60 * 24));
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
}
