<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@page import="com.smt.webapp.util.UserSession"%>

<%@page import="com.smt.entity.TAppUserInfo"%>


<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="pg" uri="/page-tags"%>  
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	UserSession userSession = HttpSessionHelper.getUserSession(request) ;
	request.setAttribute("userSession",userSession);
%>


		  <%
		  String proStr = "";
		  TAppUserInfo userInfo = (TAppUserInfo)request.getAttribute("userInfo");
		  String professionStr = userInfo.getProfessionStr();
		  if(professionStr==null){
				if(userInfo.getProfession()!=null){
					proStr = userInfo.getProfession();
				}
		  }else{
			  String[] proArr = professionStr.split(",");
			  java.util.Set proSet = new java.util.HashSet();
			  for(int i=0;i<proArr.length;i++){
				  proSet.add(proArr[i]);
			  }
			  java.util.Iterator it = proSet.iterator();
			  %>
			  <%
			  while(it.hasNext()){
					proStr += it.next()+" ";
			  }
		  }
		  %>





<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
  <!-- page/user/presonalList2_xinxi.jsp -->

    <script src="http://tjs.sjs.sinajs.cn/open/api/js/wb.js" type="text/javascript" charset="utf-8"></script>
    <title>${userInfo.nickName} ${userInfo.city} <%=StageVariale.title%></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<META HTTP-EQUIV="Cache-Control" CONTENT="no-store, must-revalidate"> 
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="${userInfo.nickName},<%=proStr%>,${userInfo.city}">
	<meta http-equiv="description" content="<s:property escape='false'  value='#request.userInfo.introduction.replaceAll("\n", " ")'/>">

	<link rel="stylesheet" href="<%=request.getContextPath() %>/theme/user/css/style.css" />
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
	<jsp:include page="/WEB-INF/page/public/persnal_header.jsp"></jsp:include>
</div>

<!-- main -->
<div class="Content Layout">
	<div class="grxx_c mian Layout">
		<div class="grxx_c_l fl">
		  <table width="100%" border="0" cellspacing="0" cellpadding="0">
		  <tr>
		  <td align="right" width="71">昵&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;称：</td>
		  <td><s:property value="#request.userInfo.nickName"/></td>
		  <td align="right" width="71">生&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日：</td>
		  <td><s:property value="#request.userInfo.birthday"/></td>
		  </tr>
		  <tr>
		  <td align="right">所在城市：</td>
		  <td><s:property value="#request.userInfo.city"/></td>
		  <td align="right">职&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;业：</td>
		  <td>
		  <%=proStr%>
		  </td>
		  </tr>
		  <tr>
		  <td align="right">手&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;机：</td>
		  <td>
		  <s:if test="#request.userSession==null">
				  请登陆后查看
		  </s:if>
		  <s:elseif test="#request.qyUInfo!=null">
				 <s:property value="#request.qyUInfo.mobile"/>
		  </s:elseif>
		  <s:else>
				 <s:property value="#request.userInfo.mobile"/>
		  </s:else>

		 </td>
		  <td align="right">Email：</td>
		  <td>
		  <s:if test="#request.userSession==null">
				  请登陆后查看
			</s:if>
		  <s:elseif test="#request.qyUser!=null">
				 <s:property value="#request.qyUser.email"/>
		 </s:elseif>
		  <s:else>
			  <s:if test="#request.user.email != 'XXXXX@XXX.COM' ">
				 <s:property value="#request.user.email"/>
			  </s:if>
		  </s:else>
		  </td>
		  </tr>

		  <tr>
		  <td align="right">身&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;高：</td>
		  <td><s:property value="#request.userInfo.height"/><s:if test="#request.userInfo.height!=null">cm</s:if></td>
		  <td align="right">体&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;重：</td>
		  <td><s:property value="#request.userInfo.weight"/><s:if test="#request.userInfo.height!=null">kg</s:if></td>
		  </tr>
		  <tr>
		  <td align="right">三&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;围：</td>
		  <td><s:property value="#request.userInfo.heartSize"/><s:if test="#request.userInfo.waistSize!=null">-</s:if><s:property value="#request.userInfo.waistSize"/><s:if test="#request.userInfo.bottocksSize!=null">-</s:if><s:property value="#request.userInfo.bottocksSize"/></td>
		  <td align="right">血&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;型：</td>
		  <td><s:property value="#request.userInfo.booldType"/><s:if test="#request.userInfo.booldType!=null">型</s:if></td>
		  </tr>
		  </table>
		  <div class="grxx_c_l_c">
			<a name="userInfo"></a>
			<h2>个人介绍</h2>
			<p><s:property escape="false"  value='#request.userInfo.introduction.replaceAll("\n", "<br>")'/></p>
		  </div>
		  <div class="grxx_c_l_c">
			<h2>个人经历</h2>
		 <s:iterator value="#request.listGrow" var="item">
				<span><b><s:property value="#item.title"/></b> ( <s:property value="#item.startDate"/> 至 <s:property value="#item.endDate"/>)  </span>
				<span><s:property escape="false"  value='#item.content.replaceAll("\n", "<br>")'/> </span>
				<br>
		</s:iterator>
		  </div>
		</div>
		<div class="grxx_c_r fr">
			<img src="<%=request.getContextPath() %>/stageUpload/indexHeadImage/${user.id}.png?date=<%=new java.util.Date()%>" width="223"  /> 
		</div>
	</div>
<!-- 	<div class="grxx_b mian Layout">
		<ul>
			<iterator value="request.artInfoList" var="item" status="st">
				<if test="st.index<4">
					<li><img src="{item[2]}" width="152" height="228" /></li>
				<if>
			<iterator>
		</ul>
	</div> -->
</div>
<!-- main -->


<jsp:include page="/WEB-INF/page/public/footer.jsp"></jsp:include>

</body>
</html>
