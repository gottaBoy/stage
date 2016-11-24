<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@page import="com.smt.webapp.util.HttpSessionHelper"%>

<%@ taglib prefix="pg" uri="/page-tags"%>
<%
	String path = request.getContextPath();
	UserSession userSession = HttpSessionHelper.getUserSession(request) ;

	String hasNoMy=(String)session.getAttribute("hasNoMy");
%>


<link rel="stylesheet" href="<%=path%>/theme/job/css/style3.css" />
<style>
.top_c{ background:#333; width:100%; height:45px;}
.top_c .top_c_nav .top_c_nav_l{margin-left:-60px;}
.top_c .top_c_nav .top_c_nav_l ul li{ float:left; margin:0 20px; font-size:14px; line-height:45px;}
.top_c .top_c_nav .top_c_nav_l ul li a{color:#FFF;}
.top_c .top_c_nav .top_c_nav_l .fwfl{ position:relative; padding-right:15px; z-index:20;}
.top_c .top_c_nav .top_c_nav_l .fwfl .arrow_Downward{ position:absolute; right:0px; top:21px; width:12px; height:6px; background:url(<%=request.getContextPath() %>/theme/job/images/fwfl_Downward.png) no-repeat;}
.top_c .top_c_nav .top_c_nav_l .fwfl .arrow_Upward{ position:absolute; right:0px; top:21px; width:12px; height:6px; background:url(<%=request.getContextPath() %>/theme/job/images/fwfl_Upward.png) no-repeat;}
.top_c .top_c_nav .top_c_nav_l .fwfl #fwfl_c{ position:absolute; line-height:normal; font-size:12px; left:0; top:45px;height:422px; display:none;}
.top_c .top_c_nav .top_c_nav_l .fwfl #fwfl_c .item .product_wrap_c ul li{ line-height:28px; margin-right:15px; margin-left:0}
.top_c .top_c_nav .top_c_nav_l .fwfl #fwfl_c .item .product_wrap_c ul li a{ color:#9a9a9a}
.top_c .top_c_nav .top_c_nav_r{ margin:7px 28px 0 0}
.top_c .top_c_nav .top_c_nav_r img{ margin:0 5px;}
.top_c .top_c_nav .top_c_nav_r .top_c_nav_r_input{ background:url(<%=request.getContextPath() %>/theme/job/images/top_c_nav_r_input.png) no-repeat; width:147px; height:16px; padding:2px 8px; line-height:16px; color:#FFF; font-size:12px;}
.top_c .top_c_nav .top_c_nav_r .top_c_nav_r_submit{ background:url(<%=request.getContextPath() %>/theme/job/images/top_c_nav_r_submit.png) no-repeat; width:35px; height:31px; cursor:pointer; margin-left:5px;}


.Cnav{ width:235px; height:530px; position:relative; background:url(<%=request.getContextPath() %>/theme/job/images/Cnav_bg.gif) #333333 top repeat-x; z-index:2}
.Cnav .item{ margin-left:1px; padding:10px 15px; width:204px; position:relative; height:41px;}
.Cnav .item .product{ color:#FFF; position:relative;}
.Cnav .item .product h3{ margin-bottom:5px;}
.Cnav .item .product span{ position:absolute; right:0; top:5px; width:6px; height:12px;}
.Cnav .item .product span.product_Arrow{ background:url(<%=request.getContextPath() %>/theme/job/images/product_Arrow1.png) no-repeat;}
.Cnav .item .product span.product_Arrow2{ background:url(<%=request.getContextPath() %>/theme/job/images/product_Arrow2.png) no-repeat;}
.Cnav .item .product .Cnav_Column a{ display:inline-block; margin-right:20px; color:#FFF;}
.Cnav .item .product .Cnav_Column a.Cnav_Column_margin{ margin-right:39px;}
.Cnav .active{ background:#FFF;}
.Cnav .active h3{ color:#333333}
.Cnav .active .product .Cnav_Column a{ color:#333333;}
.Cnav .item .product_wrap{ display:none; position:absolute; left:234px; top:-1px; background:#FFF; border:1px solid #cecece; border-left:0; width:636px; padding:10px 15px 15px;-webkit-box-shadow: 3px 0 5px rgba(0,0,0,0.2);-moz-box-shadow: 3px 0 5px rgba(0,0,0,0.2);
box-shadow: 3px 0 5px rgba(0,0,0,0.2); z-index:10;}
.product_wrap .product_wrap_c h2{ color:#e20822;}
.product_wrap .product_wrap_c h3{ background:url(<%=request.getContextPath() %>/theme/job/images/product_wrap_c_h3.gif) left center no-repeat; padding-left:15px; color:#333333; margin-top:5px;}
.product_wrap .product_wrap_c ul{ overflow:hidden; margin-top:5px;}
.product_wrap .product_wrap_c ul li{ float:left; margin-right:15px;white-space:nowrap; line-height:28px;}
.product_wrap .product_wrap_c ul li a{ color:#9a9a9a; font-size:14px;}
.product_wrap .product_wrap_hr{height:1px;border:none;border-top:1px dotted #d4d4d4;margin:10px 0;*margin:10px 0 -4px 0;float:none;*float:left;display:block;}
.Cnav .item .posOne{ border-top:0; top:0}
.Cnav .item .posTwo{ height:335px;}
.Content_r{ overflow:hidden; padding-top:10px;}



.product_wrap .product_wrap_c h2{ color:#e20822;}
.product_wrap .product_wrap_c h3{ background:url(<%=request.getContextPath() %>/theme/job/images/product_wrap_c_h3.gif) left center no-repeat; padding-left:15px; color:#333333; margin-top:5px;}
.product_wrap .product_wrap_c ul{ overflow:hidden; margin-top:5px;}
.product_wrap .product_wrap_c ul li{ float:left; margin-right:15px;white-space:nowrap; line-height:28px;}
.product_wrap .product_wrap_c ul li a{ color:#9a9a9a; font-size:14px;}
.product_wrap .product_wrap_hr{height:1px;border:none;border-top:1px dotted #d4d4d4;margin:10px 0;*margin:10px 0 -4px 0;float:none;*float:left;display:block;}
</style>
<script language="javascript">

var pageNum = 0;
var total = 0;

$(function(){
		$("#tcc").mouseover(function(){
			$("#open").fadeIn();
		}).mouseout(function(){
			$("#open").fadeOut();	
		});

		//商品分类
			
		$(".fwfl").hover(function(){
			$(this).find(".arrow_Downward").removeClass().addClass("arrow_Upward")
			$(this).find("#fwfl_c").show()
		},function(){
			$(this).find(".arrow_Upward").removeClass().addClass("arrow_Downward")
			$(this).find("#fwfl_c").hide()
		});
		
		
			
		$('.Cnav .item').hover(function(){
			$(this).addClass('active').find('.product span').attr("class","product_Arrow2");
			$(this).find('.product_wrap').show();
		},function(){
			$(this).removeClass('active').find('.product span').attr("class","product_Arrow")
			$(this).find('.product_wrap').hide();
		});


});

	function pinfen(){
		/*
		//动态评分
		var imgSrc = '<img src=\"theme/images2/tu96.jpg\" />&nbsp;';
		var imgSrc1 = '<img src=\"theme/images2/x2.png\" />&nbsp;';
		var imgSrc2 = '<img src=\"theme/images2/x1x.png\" />&nbsp;';
		var msGradeValue = '<s:property value="#request.userEvaluation.msGradeValue"/>';
		var GradeValue2 = (msGradeValue*10)%10;
		var GradeValue1 = (msGradeValue*10-GradeValue2)/10;
		//alert(msGradeValue+"  ,"+msGradeValue1+"  ,"+msGradeValue2);
			for(var j = 0; j < GradeValue1; j++) {
				$("#msGrade").append(imgSrc);
			}
			if(GradeValue2>=5&&GradeValue2<=9){
				$("#msGrade").append(imgSrc1);
				for(var j = 0; j < 4-GradeValue1; j++) {
					$("#msGrade").append(imgSrc2);
				}
			}else{
				for(var j = 0; j < 5-GradeValue1; j++) {
					$("#msGrade").append(imgSrc2);
				}
			}

		var tdGradeValue = '<s:property value="#request.userEvaluation.tdGradeValue"/>';
		GradeValue2 = (tdGradeValue*10)%10;
		GradeValue1 = (tdGradeValue*10-GradeValue2)/10;
			for(var j = 0; j < GradeValue1; j++) {
				$("#tdGrade").append(imgSrc);
			}
			if(GradeValue2>=5&&GradeValue2<=9){
				$("#tdGrade").append(imgSrc1);
				for(var j = 0; j < 4-GradeValue1; j++) {
					$("#tdGrade").append(imgSrc2);
				}
			}else{
				for(var j = 0; j < 5-GradeValue1; j++) {
					$("#tdGrade").append(imgSrc2);
				}
			}

		var zlGradeValue = '<s:property value="#request.userEvaluation.zlGradeValue"/>';
		GradeValue2 = (zlGradeValue*10)%10;
		GradeValue1 = (zlGradeValue*10-GradeValue2)/10;
			for(var j = 0; j < GradeValue1; j++) {
				$("#zlGrade").append(imgSrc);
			}
			if(GradeValue2>=5&&GradeValue2<=9){
				$("#zlGrade").append(imgSrc1);
				for(var j = 0; j < 4-GradeValue1; j++) {
					$("#zlGrade").append(imgSrc2);
				}
			}else{
				for(var j = 0; j < 5-GradeValue1; j++) {
					$("#zlGrade").append(imgSrc2);
				}
			}

		var grade = '<s:property value="#request.userInfo.grade"/>';
		var sellerGrade = '<s:property value="#request.userInfo.sellerGrade"/>';
		var imgG1 = '<img src=\"theme/images2/m21.gif\" />&nbsp;';
		var imgG2 = '<img src=\"theme/images2/m22.gif\" />&nbsp;';
		var imgG3 = '<img src=\"theme/images2/m23.gif\" />&nbsp;';
		var imgSG1 = '<img src=\"theme/images2/m41.gif\" />&nbsp;';
		var imgSG2 = '<img src=\"theme/images2/m42.gif\" />&nbsp;';
		var imgSG3 = '<img src=\"theme/images2/m43.gif\" />&nbsp;';
		if(grade<=3&&grade!=null){
			for(var j = 0; j < grade; j++) {
				$("#grade").append(imgG1);
			}
		}else if(grade>3&&grade<=6){
			for(var j = 0; j < (grade-3); j++) {
				$("#grade").append(imgG2);
			}
		}else{
			for(var j = 0; j < (grade-6); j++) {
				$("#grade").append(imgG3);
			}
		}
		if(sellerGrade<=3&&sellerGrade!=null){
			for(var j = 0; j < sellerGrade; j++) {
				$("#sellerGrade").append(imgSG1);
			}
		}else if(sellerGrade>3&&sellerGrade<=6){
			for(var j = 0; j < (sellerGrade-3); j++) {
				$("#sellerGrade").append(imgSG2);
			}
		}else{
			for(var j = 0; j < (sellerGrade-6); j++) {
				$("#sellerGrade").append(imgSG3);
			}
		}
		*/

	}
	 function qianYueTa(){
	     	<%if(userSession==null){%>
				//art.dialog.alert("请先登录!");
			<%
				com.smt.entity.TAppUserInfo userInfo1 = (com.smt.entity.TAppUserInfo)request.getAttribute("userInfo");
				String url = "";
				if(userInfo1!=null){
					Integer uId = userInfo1.getUserId();
					url = "?r="+HttpSessionHelper.urlEncode("/member/business!toPreOrder.htm?bqyUserId="+uId.toString());
				}
			%>

	  	    	parent.showPop(2,'<%=request.getContextPath() %>/loginHtml.htm<%=url%>');
	  	    	//openWindowLogin();
	  	    <%  }else{  int loginUserId=userSession.getId();%>
	  	    var bqyUserId=<s:property value="#request.userInfo.userId"/>;
	  	    if(bqyUserId==<%=loginUserId %>){
	  	    	art.dialog.tips("不能预约自己！");
	  	    }else{
		  	    $.ajax({
				   url:"<%=request.getContextPath() %>/member/business!checkUserCost.htm?bqyUserId=<s:property value='#request.userInfo.userId'/>",
				   type:'POST',
				   success:function(data){
							
					   if(data=="2"){
							art.dialog.tips("该用户未添加职业，不能预约!");
					   } else {
							/*art.dialog.confirm("第一舞台暂时只提供线上下单，线下付款服务，为买家和卖家提供最高效方便的交易模式，<br>希望使用线上付款的用户请耐心等待，我们将择日推出该功能，进一步保障您的利益。",function () {    
								window.open('<%=request.getContextPath() %>/member/business!toOrder.htm?bqyUserId=<s:property value="#request.userInfo.userId"/>');
							}, 
							function () {    art.dialog.close();  
							});
							*/
							window.open('<%=request.getContextPath() %>/member/business!toPreOrder.htm?bqyUserId=<s:property value="#request.userInfo.userId"/>');
					   }
				   }
				});
				//art.dialog.open('<%=request.getContextPath() %>/member/business!toOrder.htm?bqyUserId=<s:property value="#request.userInfo.userId"/>',{width:680,height:455,resize: false});
			 }
			  <%  }%>
	     }



	  function headSubmit(){
		if($("#headKeywords").val()=="请输入关键词"){ 
			$("#headKeywords").val("");
			return;
		}
			$("#headSearchFrom").submit();
		}
		
		function showHelp(){
			art.dialog({
					icon: 'help',
					content: '艺人职业价格为参考价，具体价格可与艺人协商。',
					ok: true,
					cancel: false
				});
		}


	function addFriend(friendId){
       <%if(userSession == null){%>
		   	//art.dialog.alert("请先登录!");
			parent.showPop(2,'<%=request.getContextPath() %>/loginHtml.htm');
		<%}else{%>
			$.post('<%=request.getContextPath()%>/friend!addFriend.htm?friendId='+friendId,{},function(data){
			  if(data==1){
					location.reload() ;
			  }else if(data == 2){
				  art.dialog.tips('不能关注自己');
			  }else if(data == 3){
				  art.dialog.tips('登陆后才能关注！');
			  }else if(data == 4){
				  art.dialog.tips('已关注TA！');
			  }
			},"html");
		<%}%>
	 }
	


	function sendMessage(){
			art.dialog.open('<%=request.getContextPath()%>/messageSend!send.htm?id=<s:property value="#request.userInfo.userId"/>',{width:550,height:300,resize: false});
	}
	function jiathis(){
		$("#jia").show();
	}
	function hidehis(){
		$("#jia").hide();
	}

</script>


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





<div class="top_b">
  <div class="top_b_c mian Layout">
  		<div class="top_b_c_Tleft">
		<s:if test="#request.preUserId!=null"><a href="<%=request.getContextPath() %>/index/presonList.htm?id=${preUserId}&actionName=userBaseInfo"></s:if>
		<s:else><a href="#" title="没有上一页了"></s:else>
		<img src="<%=request.getContextPath() %>/theme/user/images/Tleft.png" width="31" height="56" /></a></div>
    	<div class="top_b_c_l fl" style="clear:both">
   	  		<a href="<%=request.getContextPath() %>/index/presonList.htm?id=${id}"  id="tcc"><img src='<%=request.getContextPath() %>/stageUpload/headImage/${user.id}.png?date=<%=new java.util.Date()%>' width="123" height="123"  onerror="javascript:this.src='<%=request.getContextPath() %>/theme/images/tu03.jpg'" /></a>
            <div class="top_b_c_l_c Layout">
            	<a href='javascript:addFriend("${user.id}")' class="fl"><img src="<%=request.getContextPath() %>/theme/user/images/gz.png" width="59" height="28" /></a><a href="javascript:sendMessage()" class="fr"><img src="<%=request.getContextPath() %>/theme/user/images/sx.png" width="61" height="28" /></a>
            </div>
          <ul class="top_b_c_l_b Layout">
            <li><a href="<%=request.getContextPath() %>/index/presonList.htm?id=${id}&actionName=userFriends&sign=1#userTab" ><strong>${friendGZTotal}</strong><span>关注</span></a></li>
            <li><a href="<%=request.getContextPath() %>/index/presonList.htm?id=${id}&actionName=userFriends&sign=2#userTab" ><strong>${friendFSTotal}</strong><span>粉丝</span></a></li>
          </ul>
          <div class="top_b_c_l_tc" id="open">
          	<h2>动态评分</h2>
            <h2>好评率：<span><s:property value="#request.goodRate"/></span></h2>
            <ul>
            	<li><p>描述相符：</p><span>&nbsp;<s:property value="#request.totalMsRemarksStr"/></span>
				<!-- <em>老板等级：</em><b><span id="grade"></span></b> --></li>
                <li><p>演出态度：</p><span>&nbsp;<s:property value="#request.totalTdRemarksStr"/></span>
				<!-- <em>艺人等级：</em><b><span id="sellerGrade"></b> --></li>
                <li><p>完成质量：</p><span>&nbsp;<s:property value="#request.totalZlRemarksStr"/></span></li>
            </ul>
          </div>
  	  	</div>
   		<div class="top_b_c_c fl">
       	  <div class="top_b_c_c_t">
           	<h2><a><s:property value="#request.userInfo.nickName"/></a>
			<s:if test="#request.user.parentID!=null">
			<a href="<%=request.getContextPath() %>/orgListAction.htm?id=${user.parentID}" title='<s:property value="#request.qyUInfo.nickName"/>'><font 
			<s:if test="request.qyUInfo.idCopy!=null">style='color:yellow'</s:if><s:else>style='color:gray'</s:else>>(企)</font></a>
			</s:if>
			</h2><s:if test="#request.userInfo.idCard!=null"><img src="<%=request.getContextPath() %>/theme/user/images/sfz.png" width="41" height="21" /></s:if><s:if test="#request.user.isOrg!=100"><img src="<%=request.getContextPath() %>/theme/user/images/vip.png" width="28" height="13" /></s:if>
			
			


					<a class="jiathis_button_weixin" href="javascript:fenxian()"><img src="<%=request.getContextPath() %>/theme/user/images/ewm.gif" width="19" height="19" /></a>
					<div class="jiathis_style" id="fenxiang">
					</div>
					<script type="text/javascript" >

					function 	fenxian(){
						if($("#fenxiang").style.display=="none"){
							$("#fenxiang").show().css({'top':$(e).offset().top+20,'left':$(e).offset().left});
						}else{
							$("#fenxiang").hide();
							 yrname = '<s:property value="#request.userInfo.nickName"/>';
							 yrurl = 'http://www.d15t.cn/index/presonList.htm?id=<s:property value="#request.userInfo.userId"/>';
							 yrpic = 'http://www.d15t.cn/stageUpload/headImage/<s:property value="#request.userInfo.userId"/>.png';
							 jiathis_config={
								url:yrurl,
								sm:"weixin",
								summary:"我在第一舞台发现了ta，非常棒！",
								title:"超喜欢 #"+yrname+"#",
								pic:yrpic,
								shortUrl:false,
								hideMore:false
							}
						}	
					}
					</script>
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>


          </div>
          <div class="top_b_c_c_Address">
          	<p><s:property value="#request.userInfo.provice"/></p><span>|</span><p><s:property value="#request.userInfo.city"/></p>
          </div>
          <div class="top_b_c_c_rq Layout">
          	<!--<p>签约次数：<span><s:property value="#request.userInfo.signNumber"/></span></p>--><p>人气指数：<span><s:property value="#request.userInfo.popularityTotal"/></span></p><a class="fx fr"><img src="<%=request.getContextPath() %>/theme/user/images/fx.jpg" width="79" height="30" onclick='javascript:jiathis()' style="cursor:pointer"/></a>

								<div class="jiathis_style" id="jia" onclick='javascript:hidehis()'  style="position:absolute;display:none;margin-top:25px;margin-left:450px;zIndex:1;background:url(<%=request.getContextPath() %>/theme/user/images/top_b_bg.gif) repeat-x;height:25px;"><a class="jiathis_button_icons_1"></a>
								<a class="jiathis_button_icons_2"></a>
								<a class="jiathis_button_icons_3"></a>
								<a class="jiathis_button_icons_4"></a>
								<a class="jiathis_button_icons_5"></a>

								</div>
								<script type="text/javascript">

								 yrname2 = '<s:property value="#request.userInfo.nickName"/>';
								 yrurl2 = 'http://www.d15t.cn/index/presonList.htm?id=<s:property value="#request.userInfo.userId"/>';
								 yrpic2 = 'http://www.d15t.cn/stageUpload/headImage/<s:property value="#request.userInfo.userId"/>.png';
								 jiathis_config={
									url:yrurl2,
									sm:"qzone,tsina,tqq,weixin,tieba,tsohu",
									summary:"我在第一舞台发现了ta，非常棒！",
									title:"超喜欢 #"+yrname2+"#",
									pic:yrpic2,
									shortUrl:false,
									hideMore:true
								}

 
								</script>
								<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>


          </div>
          <div class="top_b_c_c_jj">
          	<h2>个人简介</h2>
            <p style="width:570px;height:100px;overflow:hidden;"> 
			<s:if test="#request.userInfo.introduction.length() > 100"><s:property escape="false" value='#request.userInfo.introduction.substring(0,100).replaceAll("\n", "<br>")' />...</s:if><s:else><s:property escape="false" value='#request.userInfo.introduction.replaceAll("\n", "<br>")' /></s:else></p>
            <div class="More"><a href="<%=request.getContextPath() %>/index/presonList.htm?id=${id}#userInfo" >更多信息.....</a></div>
          </div>
        </div>
        <div class="top_b_c_r fr">
        	<h3>欢迎来砍价<a title="艺人职业价格为参考价，具体价格可与艺人协商。" target="_blank"><img src="<%=request.getContextPath() %>/theme/user/images/help.png" width="18" height="18" /></a></h3>
          <ul style="height:150px;">

		 <s:iterator value="#request.costList" var="item">
				<li title='<s:if test="#item[0].keywords==null || #item[0].keywords.length() == 0"><s:property value="#item[1].typeName"/></s:if><s:else><s:property value="#item[0].keywords" /></s:else>'> 

				<s:if test="#item[0].keywords==null || #item[0].keywords.length() == 0"><s:property value="#item[1].typeName"/>  </s:if>
				<s:elseif test="#item[0].keywords.length() > 6"><s:property value="#item[0].keywords.substring(0,6)" /></s:elseif>
				<s:else><s:property value="#item[0].keywords" /></s:else>
				：<span><s:property value="#item[0].bprice"/></span> 元/<s:property value="#item[0].unit"/> </li>
		</s:iterator>

            </ul>
            <a onclick="qianYueTa()"   class="yy" style="cursor: pointer;"><img src="<%=request.getContextPath() %>/theme/user/images/yy.png" width="181" height="58" /></a>
        </div>
    <div class="top_b_c_Tright">
		<s:if test="#request.postUserId!=null"><a href="<%=request.getContextPath() %>/index/presonList.htm?id=${postUserId}&actionName=userBaseInfo"></s:if>
		<s:else><a href="#" title="没有下一页了"></s:else>

	<img src="<%=request.getContextPath() %>/theme/user/images/Tright.png" width="31" height="56" /></a></div>
  </div>
</div>
<div class="Content_nav">
	<div class="Content_nav_c mian">
       <a name="userTab"></a>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
      <td <%if(request.getParameter("actionName")==null || "userBaseInfo".equals(request.getParameter("actionName"))){ out.print(" class='on'"); }%> ><a href="<%=request.getContextPath() %>/index/presonList.htm?id=${id}#userTab"  ><p class="grxx"></p><span>基本信息</span></a></td>
      <td<%if("userZuopin".equals(request.getParameter("actionName"))){ out.print(" class='on'"); }%>><a href="<%=request.getContextPath() %>/index/presonList.htm?id=${id}&actionName=userZuopin#userTab"  ><p class="xgzp"></p><span>相关作品</span></a></td>
      <td <%if("userSaleRemarks".equals(request.getParameter("actionName"))){ out.print(" class='on'"); }%>><a href="<%=request.getContextPath() %>/index/presonList.htm?id=${id}&actionName=userSaleRemarks#userTab"  ><p class="jypj"></p><span>交易评价</span></a></td>
      <td <%if("userSaleRecords".equals(request.getParameter("actionName"))){ out.print(" class='on'"); }%>><a href="<%=request.getContextPath() %>/index/presonList.htm?id=${id}&actionName=userSaleRecords#userTab"  ><p class="jyjl"></p><span>交易记录</span></a></td>
      <td <%if("userFriends".equals(request.getParameter("actionName"))){ out.print(" class='on'"); }%>><a href="<%=request.getContextPath() %>/index/presonList.htm?id=${id}&actionName=userFriends#userTab"  ><p class="tadhy"></p><span>TA的好友</span></a></td>
      </tr>
      </table>
    </div>
</div>