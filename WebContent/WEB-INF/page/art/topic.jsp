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
<!--  public/jobChance.jsp-->
<title>形象照拍摄<%=StageVariale.title%></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
<META HTTP-EQUIV="Cache-Control" CONTENT="no-store, must-revalidate"> 
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">

<link rel="stylesheet" href="<%=path%>/theme/novice/css/novice.css" />
 
<style>
	.foot{ font: 12px/1.5 微软雅黑,Arial, Helvetica, sans-serif;color: black;}
</style>



<link rel="stylesheet" href="<%=path%>/theme/job/css/style2.css" />
<script type="text/javascript" src="<%=path%>/theme/job/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=path%>/theme/job/js/common.js"></script>
<script type="text/javascript" src="<%=path%>/theme/job/js/Focus.js"></script>
<script type="text/javascript" src="<%=path%>/theme/job/js/xsgd.js"></script>
<script type="text/javascript" src="<%=path%>/theme/job/js/select.js"></script>
<script type="text/javascript" src="<%=path%>/theme/job/js/select2.js"></script>

<script type="text/javascript" src="<%=path%>/theme/js2/common.js"></script>
<script type="text/javascript" src="<%=path%>/theme/fenlei/js/common.js"></script>

    <link rel="stylesheet" type="text/css" href="<%=path%>/theme/art2/css/topic.css">
 	<script type="text/javascript" src="<%=path%>/theme/art2/js/ImgSlider.js"></script>

</head>


<body>


<script language="javascript">

 
function publishTask(){
	<%if(userSession != null){%>
		this.location = "<%=request.getContextPath()%>/member/task.htm?userId=<%=userSession.getId() %>";
	<%}else{
		//art.dialog.alert("请先登录！");

			
		String url ="?r="+HttpSessionHelper.urlEncode("<%=request.getContextPath()%>/member/task.htm?userId=@{loginUserId}");
		%>
		parent.showPop(2,'<%=request.getContextPath() %>/loginHtml.htm<%=url%>');
	<%}%>
}

function replaceImg(obj){
		obj.src = '<%=request.getContextPath()%>/theme/images/tu03.jpg';
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


 
 
	<div class="banner">
		<img alt="在这个看脸的时代，你作为一个艺人，还没有一套展示自我艺术范儿的颜照或者一段专属video？" title="在这个看脸的时代，你作为一个艺人，还没有一套展示自我艺术范儿的颜照或者一段专属video？" src="/theme/art2/img/banner.jpg">
	</div>
	<div class="container tab-items">
		<div class="tab tab_lf tab_act"><img src="/theme/art2/img/auto1.png"></div>
		<div class="tab tab_rg"><img src="/theme/art2/img/auto2.png"></div>
	</div>
	<div class="tab-panels">
		<div class="tab_con active">
			<div class="container center"><img src="/theme/art2/img/auto1-1.png"></div>
			<div class="box-slider">
				<div class="bigpic">
					<div class="btn pre"></div><div class="btn next"></div>
					<img class="bpic" src="/theme/art2/img/img01.png" />
					<div class="intro">
						<div class="bg"></div>
					</div>
				</div>
				<div name="ztbox">
					<div class="spic">
						<div id="left"></div>
						<div id="conter">
							<ul>
							  <li class="on"><img class="smallpic" src="/theme/art2/img/img01.png" /><span class="snum"><b></b>/<strong></strong></span> </li>
							  <li><img class="smallpic" src="/theme/art2/img/img02.png" /><span class="snum"><b></b>/<strong></strong></span></li>
							  <li><img class="smallpic" src="/theme/art2/img/img03.png" /><span class="snum"><b></b>/<strong></strong></span></li>
							  <li><img class="smallpic" src="/theme/art2/img/img04.png" /><span class="snum"><b></b>/<strong></strong></span></li>
							  <li><img class="smallpic" src="/theme/art2/img/img05.png" /><span class="snum"><b></b>/<strong></strong></span></li>
							  <li><img class="smallpic" src="/theme/art2/img/img06.png" /><span class="snum"><b></b>/<strong></strong></span></li>
							  <li><img class="smallpic" src="/theme/art2/img/img07.png" /><span class="snum"><b></b>/<strong></strong></span></li>
							  <li><img class="smallpic" src="/theme/art2/img/img08.png" /><span class="snum"><b></b>/<strong></strong></span></li>
							  <li><img class="smallpic" src="/theme/art2/img/img09.png" /><span class="snum"><b></b>/<strong></strong></span></li>
							  <li><img class="smallpic" src="/theme/art2/img/img10.png" /><span class="snum"><b></b>/<strong></strong></span></li>
							  <li><img class="smallpic" src="/theme/art2/img/img11.png" /><span class="snum"><b></b>/<strong></strong></span></li>
							  <li><img class="smallpic" src="/theme/art2/img/img12.png" /><span class="snum"><b></b>/<strong></strong></span></li>
							  <li><img class="smallpic" src="/theme/art2/img/img13.png" /><span class="snum"><b></b>/<strong></strong></span></li>
							  <li><img class="smallpic" src="/theme/art2/img/img14.png" /><span class="snum"><b></b>/<strong></strong></span></li>
							  <li><img class="smallpic" src="/theme/art2/img/img15.png" /><span class="snum"><b></b>/<strong></strong></span></li>
							  <li><img class="smallpic" src="/theme/art2/img/img16.png" /><span class="snum"><b></b>/<strong></strong></span></li>
							  <li><img class="smallpic" src="/theme/art2/img/img17.png" /><span class="snum"><b></b>/<strong></strong></span></li>
							</ul>
						</div>
						<div id="right"></div>
					</div>
					<div id="scroll"><span></span></div>
				</div>
			</div>
			<div class="container center"><img src="/theme/art2/img/shitouSay.gif"></div>
			<div class="container center mar"><img src="/theme/art2/img/tc_Icon.png"></div>
			<div class="container">
				<div class="tc tc1 tab_lf">
					<img src="/theme/art2/img/tc1.gif">
				</div>
				<div class="tc tc2 tab_lf">
					<img src="/theme/art2/img/tc2.gif">
				</div>
				<div class="tc tc3 tab_rg">
					<img src="/theme/art2/img/tc3.gif">
				</div>
			</div>
		</div>
		<div class="tab_con" >
			<div class="container center"><img src="/theme/art2/img/auto2-1.png"></div>
			<div class="mod18Box">
				<div class="mod18">
					<span id="prev2" class="btn2 prev2"></span>
					<span id="next2" class="btn2 next2"></span>
					<span id="prevTop2" class="btn2 prev2"></span>
					<span id="nextTop2" class="btn2 next2"></span>
					<div id="picBox2" class="picBox">
						<ul class="cf">
							<li><a href="###"><img width="1070px" height="450px" src="/theme/art2/img/d-img01.png" alt="" /></a></li>
							<li><a href="###"><img width="1070px" height="450px" src="/theme/art2/img/d-img02.png" alt="" /></a></li>
							<li><a href="###"><img width="1070px" height="450px" src="/theme/art2/img/d-img03.png" alt="" /></a></li>
							<li><a href="###"><img width="1070px" height="450px" src="/theme/art2/img/d-img04.png" alt="" /></a></li>
							<li><a href="###"><img width="1070px" height="450px" src="/theme/art2/img/d-img05.png" alt="" /></a></li>
							<li><a href="###"><img width="1070px" height="450px" src="/theme/art2/img/d-img06.png" alt="" /></a></li>
							<li><a href="###"><img width="1070px" height="450px" src="/theme/art2/img/d-img07.png" alt="" /></a></li>
							<li><a href="###"><img width="1070px" height="450px" src="/theme/art2/img/d-img08.png" alt="" /></a></li>
							<li><a href="###"><img width="1070px" height="450px" src="/theme/art2/img/d-img09.png" alt="" /></a></li>
							<li><a href="###"><img width="1070px" height="450px" src="/theme/art2/img/d-img10.png" alt="" /></a></li>
							<li><a href="###"><img width="1070px" height="450px" src="/theme/art2/img/d-img11.png" alt="" /></a></li>
							<li><a href="###"><img width="1070px" height="450px" src="/theme/art2/img/d-img12.png" alt="" /></a></li>
							<li><a href="###"><img width="1070px" height="450px" src="/theme/art2/img/d-img13.png" alt="" /></a></li>
							<li><a href="###"><img width="1070px" height="450px" src="/theme/art2/img/d-img14.png" alt="" /></a></li>
						</ul>
					</div>
					<div id="listBox2" class="listBox">
						<ul class="cf">
							<li class="on"><i class="arr2"></i><img width="124px" height="90px" src="/theme/art2/img/d-img01.png" alt="" /></li>
							<li><i class="arr2"></i><img width="124px" height="90px" src="/theme/art2/img/d-img02.png" alt="" /></li>
							<li><i class="arr2"></i><img width="124px" height="90px" src="/theme/art2/img/d-img03.png" alt="" /></li>
							<li><i class="arr2"></i><img width="124px" height="90px" src="/theme/art2/img/d-img04.png" alt="" /></li>
							<li><i class="arr2"></i><img width="124px" height="90px" src="/theme/art2/img/d-img05.png" alt="" /></li>
							<li><i class="arr2"></i><img width="124px" height="90px" src="/theme/art2/img/d-img06.png" alt="" /></li>
							<li><i class="arr2"></i><img width="124px" height="90px" src="/theme/art2/img/d-img07.png" alt="" /></li>
							<li><i class="arr2"></i><img width="124px" height="90px" src="/theme/art2/img/d-img08.png" alt="" /></li>
							<li><i class="arr2"></i><img width="124px" height="90px" src="/theme/art2/img/d-img09.png" alt="" /></li>
							<li><i class="arr2"></i><img width="124px" height="90px" src="/theme/art2/img/d-img10.png" alt="" /></li>
							<li><i class="arr2"></i><img width="124px" height="90px" src="/theme/art2/img/d-img11.png" alt="" /></li>
							<li><i class="arr2"></i><img width="124px" height="90px" src="/theme/art2/img/d-img12.png" alt="" /></li>
							<li><i class="arr2"></i><img width="124px" height="90px" src="/theme/art2/img/d-img13.png" alt="" /></li>
							<li><i class="arr2"></i><img width="124px" height="90px" src="/theme/art2/img/d-img14.png" alt="" /></li>
						</ul>
					</div>
				</div>
				<script type="text/javascript">
					<!--
					(function(){
						function G(s){
							return document.getElementById(s);
						}
						function getStyle(obj, attr){
							if(obj.currentStyle){
								return obj.currentStyle[attr];
							}else{
								return getComputedStyle(obj, false)[attr];
							}
						}
						function Animate(obj, json){
							if(obj.timer){
								clearInterval(obj.timer);
							}
							obj.timer = setInterval(function(){
								for(var attr in json){
									var iCur = parseInt(getStyle(obj, attr));
									iCur = iCur ? iCur : 0;
									var iSpeed = (json[attr] - iCur) / 8;
									iSpeed = iSpeed > 0 ? Math.ceil(iSpeed) : Math.floor(iSpeed);
									obj.style[attr] = iCur + iSpeed + 'px';
									if(iCur == json[attr]){
										clearInterval(obj.timer);
									}
								}
							}, 30);
						}

						var oPic = G("picBox2");
						var oList = G("listBox2");
						var oPrev = G("prev2");
						var oNext = G("next2");
						var oPrevTop = G("prevTop2");
						var oNextTop = G("nextTop2");

						var oPicLi = oPic.getElementsByTagName("li");
						var oListLi = oList.getElementsByTagName("li");
						var len1 = oPicLi.length;
						var len2 = oListLi.length;
						var oPicUl = oPic.getElementsByTagName("ul")[0];
						var oListUl = oList.getElementsByTagName("ul")[0];
						var w1 = 1070;
						var w2 = 142;

						oPicUl.style.width = 1070 * len1 + "px";
						oListUl.style.width = 150 * len2 + "px";

						var index = 0;
						var num = 8;
						var num2 = Math.ceil(num / 2);

						function Change(){

							Animate(oPicUl, {left: - index * w1});
							if(index < num2){
								Animate(oListUl, {left: 0});
							}else if(index + num2 <= len2){
								Animate(oListUl, {left: - (index - num2) * w2});
							}else{
								Animate(oListUl, {left: - (len2 - num + 1)* w2});
							}

							for (var i = 0; i < len2; i++) {
								oListLi[i].className = "";
								if(i == index){
									oListLi[i].className = "on";
								}
							}
						}
						oNextTop.onclick = oNext.onclick = function(){
							index ++;
							index = index == len2 ? 0 : index;
							Change();
						}

						oPrevTop.onclick = oPrev.onclick = function(){
							index --;
							index = index == -1 ? len2 -1 : index;
							Change();
						}

						for (var i = 0; i < len2; i++) {
							oListLi[i].index = i;
							oListLi[i].onclick = function(){
								index = this.index;
								Change();
							}
						}
					})()
					//-->
				</script>
			</div>
			<div class="container center"><img src="/theme/art2/img/ddSay.gif"></div>
			<div class="container center mar"><img src="/theme/art2/img/tc_Icon.png"></div>
			<div class="container">
				<div class="tc tc1 tab_lf" style="margin-left:180px;">
					<img src="/theme/art2/img/tc4.gif">
				</div>
				<div class="tc tc2 tab_lf">
					<img src="/theme/art2/img/tc5.gif">
				</div>
			</div>
		</div>
	</div>
	<div class="container center mar"><img src="/theme/art2/img/error_Icon.png"></div>
	<div class="container center mar"><img src="/theme/art2/img/error_Icon2.gif"></div>	
	<div class="container">
		<div class="tab_lf zp">
			<span class="spanMin">
				<img src="/theme/art2/img/erro_Icon3.gif">
				<img class="sM7" src="/theme/art2/img/erro_Icon7.gif">
				<img src="/theme/art2/img/erro_Icon5.gif">
			</span>
			<span>
				<img src="/theme/art2/img/erro_Icon9.gif">
			</span>
		</div>
		<div class="tab_rg zp">
			<span>
				<img src="/theme/art2/img/erro_Icon10.gif">
			</span>
			<span class="spanMin">
				<img src="/theme/art2/img/erro_Icon4.gif">
				<img class="sM8" src="/theme/art2/img/erro_Icon8.gif">
				<img src="/theme/art2/img/erro_Icon6.gif">
			</span>
		</div>
	</div>
	<div class="container center mar"><img src="/theme/art2/img/erro_Icon11.gif"></div>
	<div class="container why">
		<span class="why2"><img src="/theme/art2/img/erro_Icon16.png"></span>
		<span class="why3"><img src="/theme/art2/img/erro_Icon14.png"></span>
		<span class="why1"><img src="/theme/art2/img/erro_Icon13.png"></span>
		<span class="why5"><img src="/theme/art2/img/erro_Icon17.png"></span>
		<span class="why4"><img src="/theme/art2/img/erro_Icon15.png"></span>
	</div>
	<div class="container center mar60"><img src="/theme/art2/img/erro_Icon18.gif"></div>

<!-- foot  -->
<jsp:include page="/WEB-INF/page/public/footer.jsp"></jsp:include>

</body>
</html>
