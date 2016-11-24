<%@page import="com.smt.common.StageVariale"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>

<style type="text/css">
	a.red:hover {color: #FF0000;}
.top-1 {
	padding-left:10px;
	padding-right:10px;
	padding-top:10px;
}
.top-2 {
	padding-left:10px;
	padding-top:10px;
}

.top-2 div {
	margin-left:70px;
}
.top-3 {
	padding-right:15px;
	text-align:right;
}
.top-3 a {
	text-decoration:underline;
	color:#1A85A7;
}
</style>

<s:iterator value="#request.list" var="item" status="st">
<div>
  <div class="l top-1">
    <a href="<%=request.getContextPath() %>/presonList.htm?id=<s:property value="#item[0].userId"/>" target="_blank">
      <img height="60" width="60" src="/stageUpload/headImage/<s:property value='#item[0].userId'/>.png" onerror="javascript:this.src='<%=request.getContextPath() %>/theme/images/no_img.jpg'" />
    </a>
  </div>
  <div class="top-2">
    <div style="color:#000;"><s:property value="#item[0].nickName.length()>10?#item[0].nickName.substring(0,10)+'...':#item[0].nickName"/></div>
    <div>职业：
      <s:iterator value="#request.costList" var="item1" status="st1">
        <s:if test="#st.index==#st1.index">
          <s:property value="#item1[0][1].TypeName"/>
        </s:if>
      </s:iterator>
    </div>
    <div>人气：<s:property value="#item[0].popularityTotal" /></div>
  </div>
  <div class="top-3"><a href="<%=request.getContextPath() %>/presonList.htm?id=<s:property value='#item[0].userId'/>" class="zxrw_xq" target="_blank">查看详情>></a></div>
</div>
<div style="border-bottom:dotted 1px #ccc; height:5px; margin:5px;"></div>
</s:iterator>
