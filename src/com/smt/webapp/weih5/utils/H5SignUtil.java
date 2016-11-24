package com.smt.webapp.weih5.utils;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Formatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class H5SignUtil {

	//private static String token = "weixinTokenZ9ff";
	private static String token = "weichuan";
	
	public static String signForJsapiTicket(String url) {
		return signForJsapiTicket(H5WeixinUtils.JSAPI_TICKET, H5WeixinUtils.TIMESTAMP, H5WeixinUtils.NONCESTR, url);
	}

	public static String signForJsapiTicket(String ticket, String timestamp, String nonce, String url) {
		String tmpStr = null;

		try {
			MessageDigest md = null;

			String template = "jsapi_ticket=JJJTTT&noncestr=NNNNNN&timestamp=TTTTTT&url=UUUUUU";
			String wholeString = template.replace("JJJTTT", ticket).replace("TTTTTT", timestamp).replace("NNNNNN", nonce).replace("UUUUUU", url);

			md = MessageDigest.getInstance("SHA-1");
			byte[] digest = md.digest(wholeString.getBytes());
			tmpStr = byteToStr(digest);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return tmpStr;
	}

	// public static String signForJsapiTicket(String ticket, String timestamp,
	// String nonce, String url) {
	//
	// String tmpStr = null;
	//
	// try {
	//
	// String jsapi_ticket = "jsapi_ticket";
	// Map<String, String> ret = sign(jsapi_ticket, timestamp, nonce, url);
	// for (Map.Entry entry : ret.entrySet()) {
	// // System.out.println(entry.getKey() + "======== " +
	// // entry.getValue());
	// }
	// System.out.println("signature:  " + ret.get("signature") + ": timestamp "
	// + ret.get("timestamp"));
	//
	// tmpStr = createLinkString(ret);
	//
	// System.out.println(tmpStr);
	//
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	//
	// return tmpStr;
	// }

	public static String createLinkString(Map<String, String> params) {
		List<String> keys = new ArrayList<String>(params.keySet());
		Collections.sort(keys);
		String prestr = "";
		for (int i = 0; i < keys.size(); i++) {
			String key = keys.get(i);
			String value = params.get(key);
			if (i == keys.size() - 1) {// 拼接时，不包括最后一个&字符
				prestr = prestr + key + "=" + value;
			} else {
				prestr = prestr + key + "=" + value + "&";
			}
		}
		return prestr;
	}

	public static Map<String, String> sign(String jsapi_ticket, String timestamp, String nonce, String url) {
		Map<String, String> ret = new HashMap<String, String>();
		String nonce_str = nonce;
		String string1;
		String signature = "";
		// 注意这里参数名必须全部小写，且必须有序
		string1 = "jsapi_ticket=" + jsapi_ticket + "&noncestr=" + nonce_str + "&timestamp=" + timestamp + "&url=" + url;
		// System.out.println(string1);
		try {
			MessageDigest crypt = MessageDigest.getInstance("SHA-1");
			crypt.reset();
			crypt.update(string1.getBytes("UTF-8"));
			signature = byteToHex(crypt.digest());
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		ret.put("url", url);
		ret.put("jsapi_ticket", jsapi_ticket);
		ret.put("nonceStr", nonce_str);
		ret.put("timestamp", timestamp);
		ret.put("signature", signature);
		return ret;
	}

	private static String byteToHex(final byte[] hash) {
		Formatter formatter = new Formatter();
		for (byte b : hash) {
			formatter.format("%02x", b);
		}
		String result = formatter.toString();
		formatter.close();
		return result;
	}

	/**
	 * --------------------------------------------
	 * 
	 * @param signature
	 * @param timestamp
	 * @param nonce
	 * @return
	 */

	public static boolean checkSignature(String signature, String timestamp, String nonce) {
		String[] arr = new String[] { token, timestamp, nonce };
		// 将token、timestamp、nonce三个参数进行字典序排序
		Arrays.sort(arr);
		StringBuilder content = new StringBuilder();
		for (int i = 0; i < arr.length; i++) {
			content.append(arr[i]);
		}
		MessageDigest md = null;
		String tmpStr = null;

		try {
			md = MessageDigest.getInstance("SHA-1");
			// 将三个参数字符串拼接成一个字符串进行sha1加密
			byte[] digest = md.digest(content.toString().getBytes());
			tmpStr = byteToStr(digest);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}

		content = null;
		// 将sha1加密后的字符串可与signature对比，标识该请求来源于微信
		return tmpStr != null ? tmpStr.equals(signature.toUpperCase()) : false;
	}

	/**
	 * 将字节数组转换为十六进制字符串
	 *
	 * @param byteArray
	 * @return
	 */
	private static String byteToStr(byte[] byteArray) {
		String strDigest = "";
		for (int i = 0; i < byteArray.length; i++) {
			strDigest += byteToHexStr(byteArray[i]);
		}
		return strDigest;
	}

	/**
	 * 将字节转换为十六进制字符串
	 *
	 * @param mByte
	 * @return
	 */
	private static String byteToHexStr(byte mByte) {
		char[] Digit = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
		char[] tempArr = new char[2];
		tempArr[0] = Digit[(mByte >>> 4) & 0X0F];
		tempArr[1] = Digit[mByte & 0X0F];

		String s = new String(tempArr);
		return s;
	}
}
