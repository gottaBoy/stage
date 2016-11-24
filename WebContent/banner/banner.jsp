<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="pg" uri="/page-tags"%> 
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="" />
<meta name="description" content="" />
<title></title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/banner/css/style.css" />
<script type="text/javascript" src="<%=request.getContextPath() %>/banner/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/banner/js/bigpicroll.js"></script>
</head>
<body>
<!-- 代码 开始 -->
<div class="hdwrap">
  <div class="hdflash f_list">
  <div class="flashlist">
  <s:iterator value="#request.list" var="vo" status="st">
    <div class="f_out">
      <a href="<s:property value="#vo.plink"/>" target="_blank">
        <img src="<%=request.getContextPath() %>/<s:property value="#vo.purl"/>" alt="" title="" width="690" height="220" />
      </a>
      <div class="picintro">
        <h2>
          <a href="javascript:void(0)" title="" target="_blank">
            <s:property value="#vo.title" />
          </a>
        </h2>
        <p id="htm<s:property value='#st.index' />">
			<s:property escape='false' value="#vo.content" />
        </p>
      </div>
    </div>
</s:iterator>    
  <div class="flash_tab">
    <div class="tabs f_tabs" style="width:200px;">
      <ul>
        <li class="f_tab opdiv">
          <a href="javascript:void(0);" title="">
          </a>
        </li>
        <li class="f_tab opdiv">
          <a href="javascript:void(0);" title="">
          </a>
        </li>
        <li class="f_tab opdiv">
          <a href="javascript:void(0);" title="">
          </a>
        </li>
        <li class="f_tab opdiv">
          <a href="javascript:void(0);" title=" ">
          </a>
        </li>
        <li class="f_tab opdiv">
          <a href="javascript:void(0);" title="">
          </a>
        </li>
         <li class="f_tab opdiv">
          <a href="javascript:void(0);" title="">
          </a>
        </li>
      </ul>
    </div>
  </div>
  <script type="text/javascript">
    FeatureList(".f_list", {
      "onclass": "noopdiv",
      "offclass": "opdiv",
      "pause_on_act": "mouseover",
      "interval": 5000,
      "speed": 5
    });
    
//     function html_decode(str)  
//     {  
//       var s = "";  
//       if (str.length == 0) return "";  
//       s = str.replace("/&gt;/g", "&");  
//       s = s.replace("/&lt;/g", "<");  
//       s = s.replace("/&gt;/g", ">");  
//       s = s.replace("/&nbsp;/g", " ");  
//       s = s.replace("/&#39;/g", "\'");  
//       s = s.replace("/&quot;/g", "\"");  
//       s = s.replace("/<br>/g", "\n");  
//       return s;  
//     }

    
  </script>
</div>
</div>
</div>
</body>
</html>