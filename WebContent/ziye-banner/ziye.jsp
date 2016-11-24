<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<meta name="keywords" content="" />
<meta name="description" content="" />
<title></title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/ziye-banner/css/style.css" />
<script type="text/javascript" src="<%=request.getContextPath() %>/ziye-banner/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/ziye-banner/js/bigpicroll.js"></script>
</head>
<body>
<div class="hdwrap">
  <div class="hdflash f_list">
  <div class="flashlist">
  <s:iterator value="#request.list" var="vo">
    <div class="f_out">
      <a href="<s:property value="#vo.plink"/>" target="_blank">
        <img src="<%=request.getContextPath() %>/<s:property value="#vo.purl"/>" alt="" title=""
        width="750" height="326" />
      </a>
    </div>
   </s:iterator>
  </div>
  <div class="flash_tab">
    <div class="tabs f_tabs">
      <ul>
        <s:iterator value="#request.list" var="vo">
          <li class="f_tab opdiv">
            <a href="javascript:void(0);" title="">
            </a>
          </li>
        </s:iterator>
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
  </script>
</div>
</div>

</body>
</html>