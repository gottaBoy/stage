<%@page import="com.smt.webapp.util.CommonUtil"%>
<%@page import="com.smt.common.StageVariale"%>
<%@page import="com.smt.webapp.util.OnlineUser"%>
<%@page import="com.smt.entity.TAppUser"%>

<%@page import="com.smt.webapp.util.UserSession"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.*" %>
<%
	String path = request.getContextPath();
	String urlRewriteUrl = CommonUtil.getIsnullReturnString((String)request.getParameter("urlRewriteUrl"), "0");
	String urlRewriteParam = CommonUtil.getIsnullReturnString((String)request.getParameter("urlRewriteParam"), "0");
	String nickName = "";
	TAppUser step1_tappUser = (TAppUser)session.getAttribute("step1_tappUser");
 	if(step1_tappUser != null){
		nickName = step1_tappUser.getUsername();
 	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title><%=StageVariale.title%></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="description" content="<%=StageVariale.description%>">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css"></link>
	<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/theme/css/main.css" id="pagestyle"/>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/information.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/login.css">
	<link href="<%=request.getContextPath() %>/theme/css/page.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/swfobject.js"></script>
 
</head>
  <body style="background: #ffffff;">

  <jsp:include page="../public/head2.jsp">
  <jsp:param value="no" name="titleType"/>
  </jsp:include>
 


  <!-- 主内容开始 -->
<div class="content_login">
     <div class="register">
         <h2>欢迎加入<span>第1舞台</span>大家庭！</h2>
         <h3>第1舞台是文化演艺人才在线交易平台。<br />
开启您的个人舞台，即时获取<span>行业信息</span>，即时获取更多与<span>行业精英</span>合作的机会。<br />
个人信息真实有效，在线交易安全可靠，第1舞台祝您早日成功！</h3>
     </div>
     
     <div class="register_fenlei">
     <ul>
        <li>
           <a class="hei" href="javascript:jcxx_submit()">注册观众会员</a>
           <div>
             我不是专业人士，<br />但我希望了解行业最新最全的信息。
             <p>* 目前观众会员无法应征任务，观众会员可以申请升级为专业会员。</p>
           </div>
        </li>
        
        <li>
           <a href="<%=request.getContextPath()%>/member/userinfo!registerSoon.htm" class="hong">注册专业会员</a>
           <div>
             我是演艺行业未来之星/优秀人才，<br />我要加入，获得更多合作/工作机会！
           </div>
        </li>
     </ul>
     </div>
     
     <div style=" height:60px; width:1000px;"></div>
     
</div>

<!-- 主内容结束 -->
<jsp:include page="../public/bottom2.jsp"></jsp:include>

<script type="text/javascript">

function jcxx_submit(){
		$.ajax({
		   url:"<%=request.getContextPath() %>/member/userinfo!saveOrUpdate.htm?sign=1&isOrg=100&userInfo.nickName=<%=nickName%>&norSign=1000",
		   type:'POST',
		   data:$("#jcxxForm").serialize(),
		   success:function(data){
			   if(data == 1){
				   art.dialog.alert("保存成功！", 1);
					window.location = "<%=request.getContextPath()%>/member/userinfo!norUserInfo.htm";  
			   }
		   }
		});
}
</script>
  </body>
</html>