package com.smt.common;
import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.util.*;

import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;

public class VideoUtil {
    
    /**
     * 获取视频信息
     * @param url
     * @return
     */
   
    public static Map  getYoukuContent(String urlStr){
    	Map map = new HashMap();
    	 if(urlStr.indexOf("v.youku.com")!=-1){
             try {
            	String code = urlStr.substring(urlStr.indexOf("id_")+3,urlStr.lastIndexOf(".html"));
            	String link ="http://v.youku.com/player/getPlayList/VideoIDS/"+code+"/timezone/+08/version/5/source/out?password=&ran=2513&n=3";
            	URL url = new URL(link);
             	//Object obj = url.getContent();
             	Reader reader = new InputStreamReader(new BufferedInputStream(url.openStream()));                 
             	int c;   
             	String str ="";
             	while ((c = reader.read()) != -1) {                          
             		str=str+(char) c;                  
             	}                  
             	reader.close(); 
             	//System.out.println(str);
             	//JSONArray array = new JSONArray();
             	JSONObject json = new JSONObject(str);
             	String data = json.get("data").toString();
             	//System.out.println(data);
             	data = data.substring(1, data.length()-1);
             	JSONObject json1 = new JSONObject(data);
             	String img = json1.get("logo").toString();
             	String swf = "http://player.youku.com/player.php/sid/"+code+"/v.swf";
             	String title = json1.get("title").toString();
             	//System.out.println(img);
             	//System.out.println(swf);
             	//System.out.println(title);
             	map.put("img", img);
             	map.put("swf", swf);
             	map.put("title", title);
             	map.put("status","1");
             	return map;
             	//String embed = "<embed src=\""+swf+"\" quality=\"high\" width=\"480\" height=\"400\" align=\"middle\" allowNetworking=\"all\" allowScriptAccess=\"always\" type=\"application/x-shockwave-flash\"></embed>";
             } catch (Exception e) {
                 return null;
             }
         } else if(urlStr.indexOf("tudou.com")!=-1) {
        	 //http://www.tudou.com/l/jwcZy7x7BRY/&resourceId=0_04_05_99&iid=179145969/v.swf
        	 try {
             	//String iid = urlStr.substring(urlStr.indexOf("iid=")+4,urlStr.lastIndexOf("/v.swf"));
             	
             	//String img = "http://i01.img.tudou.com/data/imgs/i/042/471/321/p.jpg";
             	//System.out.println(img);
              	//System.out.println(title);
              	//map.put("img", img);
              	map.put("swf", urlStr);
           
              	map.put("status","1");
              	return map;
              	//String embed = "<embed src=\""+swf+"\" quality=\"high\" width=\"480\" height=\"400\" align=\"middle\" allowNetworking=\"all\" allowScriptAccess=\"always\" type=\"application/x-shockwave-flash\"></embed>";
              } catch (Exception e) {
                  return null;
              }
         } else{
        	 map.put("status","0");
         }
		return map;
    }
    
    
    public static void main(String[] args) throws IOException, JSONException {
        String url = "http://v.youku.com/v_show/id_XMjU0MjI2NzY0.html";
        //String url = "http://www.tudou.com/programs/view/pVploWOtCQM/";
        //String url = "http://v.ku6.com/special/show_4024167/9t7p64bisV2A31Hz.html";
        //String url = "http://v.ku6.com/show/BpP5LeyVwvikbT1F.html";
        //String url = "http://6.cn/watch/14757577.html";
        //String url = "http://www.56.com/u64/v_NTkzMDEzMTc.html";
        //Video video = getVideoInfo(url);
        //System.out.println("视频缩略图："+video.getPic());
        //System.out.println("视频地址："+video.getFlash());
        //System.out.println("视频时长："+video.getTime());
//    	URL url = new URL("http://v.youku.com/player/getPlayList/VideoIDS/XMjU0MjI2NzY0/timezone/+08/version/5/source/out?password=&ran=2513&n=3");
//    	//Object obj = url.getContent();
//    	Reader reader = new InputStreamReader(new BufferedInputStream(url.openStream()));                 
//    	int c;   
//    	String str ="";
//    	while ((c = reader.read()) != -1) {                          
//    		str=str+(char) c;                  
//    	}                  
//    	reader.close(); 
//    	System.out.println(str);
//    	//JSONArray array = new JSONArray();
//    	JSONObject json = new JSONObject(str);
//    	String data = json.get("data").toString();
//    	System.out.println(data);
//    	data = data.substring(1, data.length()-1);
//    	JSONObject json1 = new JSONObject(data);
//    	
//    	System.out.println(json1.get("logo").toString());
    	//JSONObject json = JSONObject.fromObject(str);
    	//System.out.println(json.get("data"));
    	
    	
    	VideoUtil  v = new VideoUtil();
    	//Map youkuContent = v.getYoukuContent("http://www.tudou.com/a/v1cIDrJouKE/&iid=132255824&rpid=85659912&resourceId=85659912_04_05_99/v.swf");
    	Map youkuContent = v.getYoukuContent("http%3A%2F%2Fv.youku.com%2Fv_show%2Fid_XNzg3NzIxODY0.html");
    	System.out.println(youkuContent);
    	
    }
}