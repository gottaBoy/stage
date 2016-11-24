package com.smt.webapp.weih5.utils;

import java.util.Date;
import java.util.Iterator;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.smt.webapp.weih5.utils.model.ValidCodeModel;

public class H5ValidCodeCache {

	private static Logger logger = Logger.getLogger("H5ValidCodeCache");

	private static final int SLEEP_TIME = 1000 * 60 * 30; // 30 mins

	private static ConcurrentHashMap<String, ValidCodeModel> _LOGIN_CACHE = new ConcurrentHashMap<String, ValidCodeModel>();
	private static ConcurrentHashMap<String, ValidCodeModel> _RETRIEVEPSD_CACHE = new ConcurrentHashMap<String, ValidCodeModel>();

	static {
		Thread timerThread = new Thread(new Runnable() {

			public void run() {
				String threadName = Thread.currentThread().getName();
				logger.warn("Start thread: " + threadName);

				while (true) {
					final long currentDateTime = new Date().getTime();
					/**
					 * clean login cache
					 */
					if (_LOGIN_CACHE.size() > 0) {
						logger.warn("Start to clean _LOGIN_CACHE...");
						Iterator<Map.Entry<String, ValidCodeModel>> it = _LOGIN_CACHE.entrySet().iterator();
						while (it.hasNext()) {
							Map.Entry<String, ValidCodeModel> entry = it.next();
							ValidCodeModel validCodeModel = entry.getValue();
							
							if (validCodeModel == null || currentDateTime > validCodeModel.getOverdueTime()) {
								if(validCodeModel!=null){
									logger.warn("currentDateTime:" + currentDateTime + ";getOverdueTime:" + validCodeModel.getOverdueTime());
								}
								
								logger.warn("delete this overdue item: " + entry.getKey());
								it.remove();
							}
						}
						logger.warn("size of _LOGIN_CACHE now: " + _LOGIN_CACHE.size());
					}

					/**
					 * clean retrieve cache
					 */
					if (_RETRIEVEPSD_CACHE.size() > 0) {
						logger.warn("Start to clean _RETRIEVEPSD_CACHE...");
						Iterator<Map.Entry<String, ValidCodeModel>> it = _RETRIEVEPSD_CACHE.entrySet().iterator();
						while (it.hasNext()) {
							Map.Entry<String, ValidCodeModel> entry = it.next();
							ValidCodeModel validCodeModel = entry.getValue();
							if (validCodeModel == null || currentDateTime > validCodeModel.getOverdueTime()) {
								logger.warn("delete this overdue item: " + entry.getKey());
								it.remove();
							}
						}
						logger.warn("size of _RETRIEVEPSD_CACHE now: " + _RETRIEVEPSD_CACHE.size());
					}

					/**
					 * thread sleep
					 */
					try {
						logger.warn("Start to sleep...");
						Thread.sleep(SLEEP_TIME);
						logger.warn("Wake up...");
					} catch (Exception e) {
						e.printStackTrace();
						logger.error("Exception during timerThread sleep: " + e);
					}
				}
			}
		});

		timerThread.setName("[Thread-CacheClean]");
		timerThread.setDaemon(true);
		timerThread.start();
	}

	public static void addLoginValidCode(String phone, int validCode) {
		ValidCodeModel validCodeModel = new ValidCodeModel(validCode);
		_LOGIN_CACHE.put(phone, validCodeModel);
	}

	public static int findLoginValidCode(String phone) {

		if (StringUtils.isBlank(phone)) {
			return -1;
		}

		if (_LOGIN_CACHE.containsKey(phone)) {
			ValidCodeModel validCodeModel = _LOGIN_CACHE.get(phone);
			if (validCodeModel == null) {
				return -1;
			} else {
				return validCodeModel.getValidCode();
			}
		}
		logger.warn("findLoginValidCode(String phone) can't find one");
		return -1;
	}

	public static void addRetrievePsdValidCode(String phone, int validCode) {
		ValidCodeModel validCodeModel = new ValidCodeModel(validCode);
		_RETRIEVEPSD_CACHE.put(phone, validCodeModel);
	}

	public static int findRetrievePsdValidCode(String phone) {
		if (StringUtils.isBlank(phone)) {
			return -1;
		}

		if (_RETRIEVEPSD_CACHE.containsKey(phone)) {
			ValidCodeModel validCodeModel = _RETRIEVEPSD_CACHE.get(phone);
			if (validCodeModel == null) {
				return -1;
			} else {
				return validCodeModel.getValidCode();
			}
		}
		return -1;
	}

}