package com.smt.webapp.weih5.utils;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.ConnectException;
import java.net.URL;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;

import com.alibaba.fastjson.JSONObject;

public class H5WeixinUtils {

	// 获取access_token的接口地址（GET） 限200（次/天）
	public final static String ACCESS_TOKEN_URL = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=APPID&secret=APPSECRET";

	// 获取jsapi ticket的接口地址（GET） 限200（次/天）
	public final static String JSAPI_TICKET_URL = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token=ACCESS_TOKEN&type=jsapi";

	//public final static String SignForJsapiTicket = "http://www.d15t.com/weih5/h5IndexPage.htm";
	public final static String SignForJsapiTicket = "http://4e421ec3.ngrok.io/stage01/weih5/h5IndexPage.htm";
	
	
	/**
	 * public field, such as token
	 */
	public static String ACCESS_TOKEN = "";
	public static String JSAPI_TICKET = "";
	
	public static String TIMESTAMP = "1414723227";
	public static String NONCESTR = "noncestr";
	
	public static void updateJsapiTicket(String token) {
		JSAPI_TICKET = getJsapiTicket(token);
	}

	public static String getJsapiTicket(String token) {
		String ticket = "";
		String requestUrl = JSAPI_TICKET_URL.replace("ACCESS_TOKEN", token);
		JSONObject jsonObject = httpRequest(requestUrl, "GET", null);
		// 如果请求成功
		if (null != jsonObject) {
			try {
				ticket = jsonObject.getString("ticket");
			} catch (Exception e) {
				ticket = null;
			}
		}
		return ticket;
	}

	public static void updateAccessToken(String appid, String appsecret) {
		ACCESS_TOKEN = getAccessToken(appid, appsecret);
	}

	public static String getAccessToken(String appid, String appsecret) {

		String accessToken = "";

		String requestUrl = ACCESS_TOKEN_URL.replace("APPID", appid).replace("APPSECRET", appsecret);
		JSONObject jsonObject = httpRequest(requestUrl, "GET", null);
		// 如果请求成功
		if (null != jsonObject) {
			try {
				accessToken = jsonObject.getString("access_token");
			} catch (Exception e) {
				accessToken = null;
			}
		}
		return accessToken;
	}

	public static JSONObject httpRequest(String requestUrl, String requestMethod, String outputStr) {
		JSONObject jsonObject = null;
		StringBuffer buffer = new StringBuffer();
		try {
			// 创建SSLContext对象，并使用我们指定的信任管理器初始化
			TrustManager[] tm = { new WeixinX509TrustManager() };
			SSLContext sslContext = SSLContext.getInstance("SSL", "SunJSSE");
			sslContext.init(null, tm, new java.security.SecureRandom());
			// 从上述SSLContext对象中得到SSLSocketFactory对象
			SSLSocketFactory ssf = sslContext.getSocketFactory();

			URL url = new URL(requestUrl);
			HttpsURLConnection httpUrlConn = (HttpsURLConnection) url.openConnection();
			httpUrlConn.setSSLSocketFactory(ssf);

			httpUrlConn.setDoOutput(true);
			httpUrlConn.setDoInput(true);
			httpUrlConn.setUseCaches(false);
			// 设置请求方式（GET/POST）
			httpUrlConn.setRequestMethod(requestMethod);

			if ("GET".equalsIgnoreCase(requestMethod))
				httpUrlConn.connect();

			// 当有数据需要提交时
			if (null != outputStr) {
				OutputStream outputStream = httpUrlConn.getOutputStream();
				// 注意编码格式，防止中文乱码
				outputStream.write(outputStr.getBytes("UTF8"));
				outputStream.close();
			}

			// 将返回的输入流转换成字符串
			InputStream inputStream = httpUrlConn.getInputStream();
			InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf8");
			BufferedReader bufferedReader = new BufferedReader(inputStreamReader);

			String str = null;
			while ((str = bufferedReader.readLine()) != null) {
				buffer.append(str);
			}
			bufferedReader.close();
			inputStreamReader.close();
			// 释放资源
			inputStream.close();
			inputStream = null;
			httpUrlConn.disconnect();
			// jsonObject = JSONObject.fromObject(buffer.toString());
			jsonObject = JSONObject.parseObject(buffer.toString());
		} catch (ConnectException ce) {
			// logger.error("Weixin server connection timed out.");
			ce.printStackTrace();
		} catch (Exception e) {
			// logger.error("https request error:{}", e);
			e.printStackTrace();
		}
		return jsonObject;
	}
}
