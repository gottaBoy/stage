<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	UserSession userSession = HttpSessionHelper.getUserSession(request) ;

	String hasNoMy=(String)session.getAttribute("hasNoMy");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--  public/novice.jsp-->
<title>新手上路<%=StageVariale.title%></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
<META HTTP-EQUIV="Cache-Control" CONTENT="no-store, must-revalidate"> 
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">

<link rel="stylesheet" href="<%=path%>/theme/novice/css/novice.css" />
 




<link rel="stylesheet" href="<%=path%>/theme/job/css/style2.css" />
<script type="text/javascript" src="<%=path%>/theme/job/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=path%>/theme/job/js/common.js"></script>
<script type="text/javascript" src="<%=path%>/theme/job/js/Focus.js"></script>
<script type="text/javascript" src="<%=path%>/theme/job/js/xsgd.js"></script>
<script type="text/javascript" src="<%=path%>/theme/job/js/select.js"></script>
<script type="text/javascript" src="<%=path%>/theme/job/js/select2.js"></script>

<script type="text/javascript" src="<%=path%>/theme/js2/common.js"></script>
<script type="text/javascript" src="<%=path%>/theme/fenlei/js/common.js"></script>
</head>


<body>


<script language="javascript">

 
function publishTask(){
	<%if(userSession != null){%>
		this.location = "<%=request.getContextPath()%>/member/task.htm?userId=<%=userSession.getId() %>";
	<%}else{
		//art.dialog.alert("请先登录！");

			
		String url ="?r="+HttpSessionHelper.urlEncode("/member/task.htm?userId=@{loginUserId}");
		%>
		parent.showPop(2,'<%=request.getContextPath() %>/loginHtml.htm<%=url%>');
	<%}%>
}

function replaceImg(obj){
		obj.src = '<%=request.getContextPath() %>/theme/images/tu03.jpg';
}

function pinfen(){
}
function removeThis(obj){
	$(obj).html('');
}
 
</script>

<div class="top Layout">
<div class="top_t">

<%@include file= "/WEB-INF/page/public/top3.jsp"%>

</div>
<div class="top_c">
	<div class="top_c_nav mian Layout">
   	  <div class="top_c_nav_l fl" style="margin-left:-34px;">
      	<ul>
        	<li class="fwfl"><a >全部服务分类</a><div class="arrow_Downward"></div>
              <div class="Cnav" id="fwfl_c">


 <%@include file= "/WEB-INF/page/public/menu.jsp"%>


 







<div class="novice">
   <div class="novice_poster">
     <img src="<%=path%>/theme/novice/images/novice_banner.jpg" />
   </div>
</div>

<div class="novice_cont">
    <div class="novice_cont_a">
        <a href="#a01" class="lanmu_a">&nbsp;</a>
        <a href="#a02" class="lanmu_b">&nbsp;</a>
        <a href="#a03" class="lanmu_c">&nbsp;</a>
    </div>
</div>

<div class="novice_cont1">
<a name="a01" class="bt01"></a>
<div class="novice_cont1_a">
如果你是<span>艺人</span>，<br />
第1舞台就是你的免费经纪人，<br />
她助你接到更多演出通告，助你实现才艺价值！<br />
<a href="/about/about!toAbout.htm?id=132&sign=2">点我教你如何成为专业会员</a>  ，开启明星之路。<br />
</div>
<div class="novice_cont1_b">
如果你是<span>演艺机构</span>，<br />
第1舞台就是你的免费企业官网，<br />
她助你打造专业品牌形象！<br />
<a href="/about/about!toAbout.htm?id=134&sign=3">点我教你如何成为企业会员</a>  ，为你的企业摇旗呐喊。<br />
</div>
<div class="novice_cont1_c">
如果你是<span>买家/演出采购商</span>，<br />
第1舞台就是你不可多得的演艺资源库，<br />
她为你提供一站式演艺解决方案！<br />
<a href="/loginHtml.htm?flag=1">点我成为观众会员</a>  ，海量演艺资源库为你提供精准的演艺解决方案。<br />
</div>
</div>

<div class="novice_cont2">
<a name="a02" class="bt02"></a>
<div class="novice_cont2_a">
<p>垂直服务于文化演出行业，<br />
<span>海量行业人才</span>库。
</p>
<p>
全面覆盖文化演出行业，<br />
帮你<span>解决一切演艺问题</span>。<br />
</p>
<p>
签约实名认证艺人，线上生成订单，<br />
<span>交易安全有保障</span>。<br />
</p>
<p>
响应式信息互通，<br />
保证买家与艺人的实时对接和无缝沟通。<br />
</p>
</div>
</div>

<div class="novice_cont3">
<a name="a03" class="bt02"></a>
<div class="novice_cont3_a">
线上生成订单，交易细节有据可循，法律保障安全。<br />
评价体系真实有效，选择优质艺人，服务到位信誉佳。<br />
出现争议，官方仲裁。<br />
<div>
（第1舞台暂时只提供线上下单，线下付款服务，为买家和卖家提<br />
供最高效方便的交易模式；希望使用线上付款的用户请耐心等待，<br />
我们将择日推出该功能，进一步保障你的利益。）

</div>
</div>
<div class="novice_cont3_b">
<font>找人嫌麻烦，</font>坐等艺人上门应征？<br />
<a href="javascript:publishTask()">立即发布任务</a><br />
<font style="margin-bottom:10px;">发布任务嫌麻烦？</font><br />
交给第1舞台，为你提供高效、优质的项目解决方案。<br />
电话咨询：<span>021—52902120</span><br />
&nbsp;qq&nbsp;咨询：<span>979961675</span><br />
</div>
</div>


<!-- foot  -->
<jsp:include page="/WEB-INF/page/public/footer.jsp"></jsp:include>

</body>
</html>
