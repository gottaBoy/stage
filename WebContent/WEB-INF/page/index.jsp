<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns:wb="http://open.weibo.com/wb">
<head>
<%-- <link href="<%=request.getContextPath() %>/theme/css2/style.css" rel="stylesheet" type="text/css" /> --%>
<link href="<%=request.getContextPath() %>/theme/css2/hg.css" rel="stylesheet" type="text/css" />
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/theme/css2/gd.css" />
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/theme/css2/lrtk.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
<SCRIPT type=text/javascript src="<%=request.getContextPath() %>/theme/js2/jquery-1.7.1.min.js"></SCRIPT>
<SCRIPT type=text/javascript src="<%=request.getContextPath() %>/theme/js2/zzsc.js"></SCRIPT>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.lazyload.mini.js"></script>
    <!--jQuery动画暂停插件-->
<script type="text/javascript" src="<%=request.getContextPath() %>/theme/js2/jquery.pause.min.js"></script>
<%-- <script type="text/javascript" src="<%=request.getContextPath() %>/theme/js2/scrolltopcontrol.js"></script> --%>
<%-- <script type="text/javascript" src="<%=request.getContextPath() %>/theme/js2/js.js"></script> --%>
    <!--滚动效果js-->
<script type="text/javascript" src="<%=request.getContextPath() %>/theme/js2/weiboscroll.js"></script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>

<title><%=StageVariale.title%></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
<META HTTP-EQUIV="Cache-Control" CONTENT="no-store, must-revalidate"> 
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">

<style>
.black_overlay{display:none;position:absolute;top:0%;left:0%;width:100%;height:4250px;background-color:black;z-index:1001;-moz-opacity:0.8;opacity:.80;filter: alpha(opacity=80);}
.white_content{display:none;position:absolute;top:25%;left:25%;width:630px;height:4250px;z-index:1002;overflow:auto;}
</style>

<script type="text/javascript">
$(function() {
    $("img").lazyload({placeholder : "1.jpg",	effect : "fadeIn" });
});
function toAdd(){
	    <% 
	    	UserSession userSession=HttpSessionHelper.getUserSession(request);
	    	if(userSession==null){
	    %>
	    window.open ('<%=request.getContextPath() %>/login.html','_self','height=600,width=980,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no'); 

	    <%  }else{%>
		art.dialog.open('<%=request.getContextPath()%>/member/task!toTask.htm',{resize: false});
	  <%  }%>
	}
	function refresh(){
		window.location.reload();
	}
	
	function openPerson(id){
		window.open("<%=request.getContextPath()%>/presonList.htm?id="+id);
	}
	function sendMessage(userId){
		art.dialog.open('<%=request.getContextPath()%>/messageSend!send.htm?id='+userId,{width:550,height:300,resize: false});
}
	function subRegister(){
		//$("#userForm").submit();
		//window.frames["login_iframe"].document.forms['userForm'].submit();
	}
// 	function register_ok(){
<%-- 		window.location.href="<%=request.getContextPath()%>/"; --%>
// 	}

// $(document).ready(function(){
// 	$(".pp").wordLimit(400);
	 
// });

function b(){
	h = $(window).height();
	t = $(document).scrollTop();
	if(t > h){
		$('#gotop').show();
	}else{
		$('#gotop').hide();
	}
}
$(document).ready(function(e) {
	b();
	$('#gotop').click(function(){
		$(document).scrollTop(0);	
	})
	$('#code').hover(function(){
			$(this).attr('id','code_hover');
			$('#code_img').show();
		},function(){
			$(this).attr('id','code');
			$('#code_img').hide();
	})
	
});

$(window).scroll(function(e){
	b();		
})
</script>
</head>
<body>
<img id="d1photo" src="<%=request.getContextPath() %>/theme/images2/d1photo.jpg"/>
<a id="QQlink" target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=979961675&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:1847791078:53" alt="点击这里给我发消息" title="点击这里给我发消息"/></a>
<!--二维码和返回顶部-->
<div id="code"></div>
<div id="code_img"></div>
<a id="gotop" href="javascript:void(0)" style="display:none;"></a>

<!--二维码和返回顶部-->


<jsp:include page="/WEB-INF/page/public/head2.jsp">
   <jsp:param value="no" name="titleType"/>
</jsp:include>

<!--图片滚动--> 
<div class="banner">
   <div class="banner1 l">
       <div class="banner1-z l"></div>
       <div class="banner1-zz l">
         <iframe src="<%=request.getContextPath() %>/index/banner.htm?type=1" name="wank" width="690"  height="240" scrolling="No" frameborder="0"></iframe> 
      </div>
      <div class="banner3-z l"></div>
   </div>
   <div class="banner2 l">
	<%
    if(userSession==null){
    %>
    <div class="banner2-1" onclick = "showPop(1,'<%=request.getContextPath() %>/loginHtml.htm')"><div>大项目、找整包，请点这里。</div></div>
    <div class="banner2-2" onclick = "showPop(1,'<%=request.getContextPath() %>/loginHtml.htm')"><div>发通告、找艺人，请点这里。</div></div>
    <% }else{%>
    <div class="banner2-1" onclick="toAdd()"><div>大项目、找整包，请点这里。</div></div>
    <a href="member/task.htm" target="_blank"><div class="banner2-2"><div>发通告、找艺人，请点这里。</div></div></a>
    <%} %>
     <div class="banner2-3">第1舞台真诚服务，交易放心又轻松</div>
     <div>
       <div class="banner2-4 l">担保交易</div>
       <div class="banner2-5 l">资格认证</div>
       <div class="banner2-6 l">身份验证</div>
     </div>
   </div>
</div>
<!--图片切换-->

<!--最新任务-->
<div class="zxrw">
     <s:action name="taskAction" namespace="" executeResult="true"></s:action>
</div>
<!--最新任务-->

<!--TOP排行榜-->
<div class="tpqh">
  <div class="tpqh-1 l">
    <iframe src="doIndex.html" name="wank" width="1003"  height="412" scrolling="No" frameborder="0"></iframe>
  </div> 
  <!--<div class="tpqh-2 l">
    <s:action name="indexAction" namespace="" executeResult="true">
      <s:param name="prof" value="8"></s:param>
    </s:action>
  </div> --> 
</div>
<!--TOP排行榜-->

<div style="height:10px;"></div>
<s:action name="indexAction" namespace="" executeResult="true">
        	<s:param name="prof" value="1"></s:param>
</s:action>
<s:action name="indexAction" namespace="" executeResult="true">
        	<s:param name="prof" value="9"></s:param>
</s:action>
<!--正文-->
<s:action name="indexAction" namespace="" executeResult="true">
        	<s:param name="prof" value="2"></s:param>
</s:action>
<s:action name="indexAction" namespace="" executeResult="true">
        	<s:param name="prof" value="3"></s:param>
</s:action>
<s:action name="indexAction" namespace="" executeResult="true">
        	<s:param name="prof" value="4"></s:param>
</s:action>
<s:action name="indexAction" namespace="" executeResult="true">
        	<s:param name="prof" value="5"></s:param>
</s:action>
<s:action name="indexAction" namespace="" executeResult="true">
        	<s:param name="prof" value="6"></s:param>
</s:action>
<s:action name="indexAction" namespace="" executeResult="true">
        	<s:param name="prof" value="7"></s:param>
</s:action>
<!--正文-->
<!--广告位-->
<div class="gg">我是广告位</div>
<!-- 底部开始 -->
<jsp:include page="/WEB-INF/page/public/bottom2.jsp"></jsp:include>
<!-- 底部结束 --> 



<!-- JiaThis Button BEGIN -->
<script type="text/javascript" >
var jiathis_config={
	siteNum:6,
	sm:"qzone,tsina,tqq,weixin,tieba,tsohu",
	url:window.location.href,
	summary:"第1舞台演艺人才在线交易网",//摘要
	title:"#第1舞台#",//标题#微博话题#
	pic:"http://d15t.cn/stageUpload/headImage/600.png",//图片
	showClose:true,
	shortUrl:false,
	hideMore:true
}
</script>
<script type="text/javascript" src="http://v3.jiathis.com/code_mini/jiathis_r.js?btn=r.gif&move=0" charset="utf-8"></script>
<!-- JiaThis Button END -->
</body>
</html>