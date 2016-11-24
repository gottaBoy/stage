package com.smt.webapp.weih5.utils;

import javax.servlet.http.HttpServlet;

public class H5WeixinHelper extends HttpServlet {
     /*
      * laster
      * */
	//public static final String APP_ID = "wx0d3fd20d7b2a3065";
	//public static final String APP_SECRET = "7520ce8d801d807ba3a345ec11d842d1";
	public static final String APP_ID = "wxdd928fdfa2c4e0c3";
	public static final String APP_SECRET = "78e7d769a342b69477533ad34a570fa7";
	
	private static final int AT_SLEEP_TIME = 1000 * 60 * 60; // 1 hour

	public void init() {
		UpdateTokenTask tokenTask = new UpdateTokenTask();
		Thread thread = new Thread(tokenTask);
		thread.setName("TASK-UPDATE-ACTOKEN: ");
		thread.start();
	}

	class UpdateTokenTask implements Runnable {

		public void run() {
			while (true) {
				log("start to get acc");

				// get access token
//				H5WeixinUtils.updateAccessToken(APP_ID, APP_SECRET);
				String token = H5WeixinUtils.getAccessToken(APP_ID, APP_SECRET);
				H5WeixinUtils.updateJsapiTicket(token);

				System.out.println("token: " + token);
				System.out.println("tickte: " + H5WeixinUtils.JSAPI_TICKET);
				
				try {
					log("start to sleep...");
					Thread.sleep(AT_SLEEP_TIME);
					log("wake up.");
				} catch (InterruptedException e) {
					e.printStackTrace();
					log("Exception : " + e);
				}
			}
		}

		private void log(String msg) {
			System.out.println(Thread.currentThread() + msg);
		}
	}
}
