<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="pg" uri="/page-tags"%>  
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	UserSession userSession = HttpSessionHelper.getUserSession(request) ;
	request.setAttribute("userSession",userSession);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
  <!-- page/org/orgList2.jsp -->

    <script src="http://tjs.sjs.sinajs.cn/open/api/js/wb.js" type="text/javascript" charset="utf-8"></script>
    <title><%=StageVariale.title%></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<META HTTP-EQUIV="Cache-Control" CONTENT="no-store, must-revalidate"> 
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">

	<link rel="stylesheet" href="<%=request.getContextPath() %>/theme/org/css/style2.css" />
	<script type="text/javascript" src="<%=request.getContextPath() %>/theme/user/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/theme/user/js/select.js"></script>
	<SCRIPT type=text/javascript src="<%=request.getContextPath() %>/theme/js2/common.js"></SCRIPT>

		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/idialog.css">
 	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />

	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>

  </head>
<body>
<div class="top Layout">
	<jsp:include page="/WEB-INF/page/public/org_header.jsp"></jsp:include>
</div>

<!-- main -->

<div class="jbxx mian Layout">
<!-- 	<div class="jbxx_banner">
    	<img src="<%=request.getContextPath() %>/theme/org/images/jbxx_banner_1.jpg" width="936" height="213" /> 
    </div> -->
    <div class="jbxx_c">
    	<h2><s:property value="#request.userInfo.nickName"/></h2>
        <div><i>公&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;司：</i><p> <s:property value="#request.userInfo.nickName"/></p></div>
        <div><i>咨询电话：</i>
		 <s:if test="#request.userSession==null">
				  <p>请登陆后查看</p>
		  </s:if>
		  <s:else>
				<p> <s:property value="#request.userInfo.mobile"/></p>
		  </s:else>
          </div>

        <div><i>咨询Email：</i>
		 <s:if test="#request.userSession==null">
				  <p>请登陆后查看</p>
		  </s:if>
		  <s:else>
				 <p><s:property value="#request.user.email"/></p>
		  </s:else>
		 </div>
        <div><i>机构地址：</i>
			<p><s:property value="#request.userInfo.provice"/> <s:property value="#request.userInfo.city"/> <s:property value="#request.userInfo.place"/></p>
		</div>

        <div><i>机构简介：</i>
        	 <p> <s:property escape="false"  value='#request.userInfo.introduction.replaceAll("\n", "<br>")' /></p>
        </div>
    </div>
</div>






<jsp:include page="/WEB-INF/page/public/footer.jsp"></jsp:include>

</body>
</html>
