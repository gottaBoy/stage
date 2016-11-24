package com.smt.webapp.weih5.utils;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

public class HttpPostUtil {

	 public static String doHttpPostJson(String Url,String json)
	    {
	        String message = "";
	        System.out.println(json);
	        try
	        {
	            URL url = new URL(Url);
	            HttpURLConnection http = (HttpURLConnection) url.openConnection(); 
	            http.setRequestMethod("POST");     
	            http.setRequestProperty("Content-Type","application/x-www-form-urlencoded");  
	            http.setDoOutput(true);    
	            http.setDoInput(true);
	            System.setProperty("sun.net.client.defaultConnectTimeout", "30000");//连接超时30秒
	            System.setProperty("sun.net.client.defaultReadTimeout", "30000"); //读取超时30秒
	            http.connect();
	            OutputStream os= http.getOutputStream();  
	            os.write(json.getBytes("UTF-8"));//传入参数
	            os.flush();
	            os.close();
	            InputStream is =http.getInputStream();
	            int size =is.available();
	            byte[] jsonBytes =new byte[size];
	            is.read(jsonBytes);
	            message=new String(jsonBytes,"UTF-8");
	            System.out.println(message);
	        } 
	        catch (MalformedURLException e)
	        {
	              e.printStackTrace();
	          }
	        catch (IOException e)
	          {
	              e.printStackTrace();
	          } 
	        return message;
	    }
}
