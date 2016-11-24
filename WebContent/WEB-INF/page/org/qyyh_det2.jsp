<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@page import="com.smt.entity.TAppFriendInfo"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="pg" uri="/page-tags"%>  
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragrma","no-cache");
response.setDateHeader("Expires",0);
%>
 <%
UserSession userSession = HttpSessionHelper.getUserSession(request) ;
TAppFriendInfo friendInfo = (TAppFriendInfo)request.getAttribute("friendInfo");
String switchId = "1";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <!--  org/qyyh_det2.jsp --> 
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
.current_span {
	background-color:#66C1FF;
	cursor:pointer;
	font-size:12px;
}
.span {
	cursor:pointer;
	color:color: #5C5C5C;
	font-size:12px;

}
</style>
<%-- 	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/global_layout.css" /> --%>
<%-- 	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/layout.css" /> --%>
<%-- 	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css" /> --%>
<%-- 	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" /> --%>
	<link href="<%=request.getContextPath() %>/theme/css/page.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath() %>/theme/css2/style.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath() %>/theme/css2/hg.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath() %>/theme/css2/qiyezhongxin.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css"></link>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/address.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/swfobject.js"></script>
	<SCRIPT type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js2/zzsc.js"></SCRIPT>
	<script language="javascript" type="text/javascript">
		$().ready(function(){
			var sexValue = '<s:property value="#request.sex"/>';
			$("#sex_value").val(sexValue);
				$("#sex_div span").attr("class", "span");$("#sex_span"+sexValue).attr("class", "current_span");
			var pro1Value = '<s:property value="#request.pro1"/>';
			$("#profession_value").val(pro1Value);
			var pro2Value = '<s:property value="#request.pro2"/>';
			$("#pro2_value").val(pro2Value);
			$("#profession_div span").attr("class", "span");$("#profession_span"+pro1Value).attr("class", "current_span");
			$("#profession1_div span").attr("class", "span");$("#profession1_span"+pro2Value).attr("class", "current_span");
			var priceValue = '<s:property value="#request.price"/>';
			$("#price_value").val(priceValue);
			$("#price_div span").attr("class", "span");$("#price_span"+priceValue).attr("class", "current_span");
		
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

		
			
		});
		function handleImgLoadError(oEvent)
	{
   oEvent.srcElement.src='<%=request.getContextPath()%>/theme/images/no_img_tj.jpg';
	}
		function onClickSelect(id){
			var sign = id.substring(0,3);
			$(".change."+sign).removeClass("change");
			$("#"+id).addClass("change");
			$("#"+sign+"Select").val(id);
			var sex = $("#sexSelect").val()==""?"sex0":$("#sexSelect").val();
			var pro = $("#proSelect").val()==""?"pro0":$("#proSelect").val();
			var pri = $("#priSelect").val()==""?"pri0":$("#priSelect").val();
			window.location.href='orgListAction.htm?sign=1&&id=<s:property value="#request.id"/>&&sex='+sex+'&&pro='+pro+'&&pri='+pri;
		}
		
		 function addFriend(friendId){
			$.post('<%=request.getContextPath()%>/friend!addFriend.htm',{friendId:friendId},function(data){
			  if(data==1){
			  
			   		location.reload() ;
			  }else if(data == 2){
			      art.dialog.tips('不能关注自己');
			  }
			},"html");
		 }
		 
		 function alertInfo(content){
				art.dialog({
					content:content,
					width:300
				});
			}
		 
		 function sendMessage(){
 			art.dialog.open('<%=request.getContextPath()%>/messageSend!send.htm?id=<s:property value="#request.userInfo.userId"/>',{width:550,height:300,resize: false});
	 	 }
	 	 
	 	 function qianYueTa(){
	     	<%if(userSession==null){%>
	  	    	openWindowLogin();
	  	    <%  }else{  int loginUserId=userSession.getId();%>
	  	    var bqyUserId=<s:property value="#request.userInfo.userId"/>;
	  	    if(bqyUserId==<%=loginUserId %>){
	  	    	art.dialog.tips("不能签约自己！");
	  	    }else{
				var p=window.open("about:blank"); 
		  	    $.ajax({
				   url:"<%=request.getContextPath() %>/member/business!checkUserCost.htm?bqyUserId=<s:property value='#request.userInfo.userId'/>",
				   type:'POST',
				   success:function(data){
							
					   if(data=="2"){
						   	p.close();
							art.dialog.tips("该用户未添加职业，不能签约!");
					   } else {
					   		p.location = '<%=request.getContextPath() %>/member/business!toOrder.htm?bqyUserId=<s:property value="#request.userInfo.userId"/>';
					   }
				   }
				});
	  	    	
			 }
			  <%  }%>
	     }
     
     
     //打开登录窗口
		function openWindowLogin(){
         	art.dialog.open('<%=request.getContextPath() %>/windowLogin.html',{width:400,height:310,resize: false});
         }
     
     function onImgError(obj,newSrc){
    	 $(obj).attr('src',newSrc);
     }
     function setSearchValue(e, type, value) {
     	if(type==1){//性别
     		$('#sex_value').val(value);//$("#sex_div span").attr("class", "span");$(e).attr("class", "current_span");
     	}
     	if(type==2){//职业
     		$('#profession1_value').val(value);//$("#profession_div span").attr("class", "span");$(e).attr("class", "current_span");
     	}if(type==3){//价格
     		$('#price_value').val(value);//$("#profession_div span").attr("class", "span");$(e).attr("class", "current_span");
     	}
     	searchStar();
     }
     function setSearchValue1(e, type, value) {
     $("#profession_div span").attr("class", "span");$(e).attr("class", "current_span");
     $('#profession_value').val(value);
     searchStar();
     }
    function searchStar(){
	    var sex = $("#sex_value").val();
	    var profession = $("#profession_value").val()+"_"+$('#profession1_value').val();
	    var price = $("#price_value").val();
	    window.location.href='orgListAction.htm?id=<s:property value="#request.id"/>&sex='+sex+'&profession='+profession+'&price='+price;
     }
	</script>
  </head>
  <body>
  
 <jsp:include page="/WEB-INF/page/public/head2.jsp">
   <jsp:param value="no" name="titleType"/>
</jsp:include>
<img id="d1photo" src="<%=request.getContextPath() %>/theme/images2/d1photo.jpg" style="z-index:1000;position:fixed; bottom:120px; _margin-bottom:120px;"/>
<a id="QQlink" target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=979961675&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:1847791078:53" alt="点击这里给我发消息" title="点击这里给我发消息"/></a>
<div class="qy-banner">
  <div class="qy-bleft l"><img src="theme/images2/tu76.jpg" width="5" height="130" /></div>
  <div class="qy-bzhong l">
  		<table width="100%" >
  			<tr>
  				<td width="110"><img width="110" height="100" id="photo_pic" onerror="handleImgLoadError(event);" src="/stageUpload/headImage/<s:property value='#request.user.id'/>.png" complete="complete"/></td>
  				<td>
  					<table>
  						<tr>
  							<td style="font-weight:bold;font-size:24px;line-height:32px;height:38px;" align="left">
  								<s:property value="#request.userInfo.nickName"/>
						         <input type="text" id="yrNameId" style="display: none;" value="<s:property value="#request.userInfo.nickName"/>" />
						         <input type="text" id="yrUrl" style="display: none;" value="http://d15t.cn/stage01/orgListAction.htm?id=<s:property value="#request.userInfo.userId"/>" />
						         
						         	<a style="font-weight:bolder;font-size:12px;">老板等级：<span id="grade"></span>&nbsp;&nbsp;艺人等级：<span id="sellerGrade"></span></a>
						         	<s:if test="#request.user.rzState==3">
								         	<a style="color:#37bc07;font-size:14px;margin:0 10px"><img src="theme/images2/tu95.jpg" width="15" height="17" />&nbsp;&nbsp;实名认证</a>
								         	&nbsp;
								         	</s:if>
								         	<s:else>
								         		<a style="color:#cc0000;font-size:14px;margin:0 10px"><img src="theme/images2/tu95_1.jpg" width="15" height="17" />&nbsp;&nbsp;未认证</a>
								         	&nbsp;
								         	</s:else>
						          <%if(userSession == null){ %>
						         <input name="" onclick="document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'"" type="button" value="联系TA"  class="an3"/>
						         <%} else{%>
						         <a href="javascript:sendMessage()"><img width="112" height="31" src="theme/images2/tu93.jpg" complete="complete"/></a>
						         <% } %>
						         <div id="light" class="white_content"> 
							        <iframe src="<%=request.getContextPath() %>/login.html" name="wank" width="630px"  height="500px" scrolling="no" frameborder="0"></iframe> 
							        </div>
							        <div id="fade" class="black_overlay"></div>
							       <a class="qy-tu3">旗下艺人：<input name="" type="text" value="<s:property value='#request.yrSun'/>" class="qx"/></a>
  							</td>
  							
  						</tr>
  						<tr>
			           		<td><s:property value="#request.userInfo.provice"/> | <s:property value="#request.userInfo.city"/><!--  <div class="jiathis_style" ><span class="jiathis_txt">分享到：</span>
								<a class="jiathis_button_icons_1"></a>
								<a class="jiathis_button_icons_2"></a>
								<a class="jiathis_button_icons_3"></a>
								<a class="jiathis_button_icons_4"></a>
								<a class="jiathis_button_icons_5"></a>
								<a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"></a>
								<a class="jiathis_counter_style"></a>
								</div>
								<script type="text/javascript">
								var yrname = $("#yrNameId").val();
								var yrurl = $("#yrUrl").val();
								var jiathis_config={
									url:yrurl,
									summary:"我在第一舞台发现了一个超牛逼的公司，非常棒！",
									title:"超喜欢 #"+yrname+"#",
									shortUrl:false,
									hideMore:false
								}
								</script>
								<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
						
			
				         	
							</div> --></td>
			           	</tr>
			           	<tr>
			           		<td>
			           			
						         		手机:&nbsp;&nbsp;
									 <%
						                if(userSession==null){
						             %>
						               请登录后查看
						             <%
										} else {
						             %><s:property value="#request.userInfo.mobile"/>
						             <!--
						            <s:if test="#request.userInfo.mobileRadio==1">
						            	<s:property value="#request.userInfo.mobile.substring(0,6)"/>*****
						            </s:if>
						            <s:elseif test="#request.userInfo.mobileRadio==2">
						            	<s:property value="#request.userInfo.mobile"/>
						            </s:elseif>
						            <s:else>
						            	<s:if test="#request.friend==1">
						            	
						                </s:if>
						                <s:elseif test="#request.friend==2">
						                    <s:property value="#request.userInfo.mobile"/>
						                </s:elseif>
						            </s:else>-->
						             <%
										}
						             %>
								   
						            QQ:&nbsp;&nbsp;
						            <%
						                if(userSession==null){
						             %>
						               请登录后查看
						             <%
										} else {
						             %>
						            <s:property value="#request.userInfo.qq"/>
<!--
						            <s:if test="#request.userInfo.qqRadio==1">
						            	<s:property value="#request.userInfo.qq.substring(0,6)"/>*****
						            </s:if>
						            <s:elseif test="#request.userInfo.qqRadio==2">
						            	<s:property value="#request.userInfo.qq"/>
						            </s:elseif>
						            <s:else>
						            	<s:if test="#request.friend==1">
						            	
						                </s:if>
						                <s:elseif test="#request.friend==2">
						                    <s:property value="#request.userInfo.qq"/>
						                </s:elseif>
						            </s:else>-->
						             <%
										}
						             %>
						            
			           		</td>
			           	</tr>
			           	<tr>
			           		<td style="font-family: 微软雅黑;">
			           			企业介绍：
					         		<s:if test="#request.userInfo.introduction.length() < 120">
									<s:property value="#request.userInfo.introduction" />
								</s:if>
								<s:elseif test="#request.userInfo.introduction==null||#request.userInfo.introduction==''">暂无</s:elseif>
								<s:else>
									<s:property value="#request.userInfo.introduction.substring(0,119)" /> <b>...</b><a href="javascript:alertInfo('<s:property value="#request.userInfo.introduction"/>')" style="color:#00b7ed">查看全部介绍</a>
								</s:else>
					        
			           		</td>
			           	</tr>
  					</table>
  				</td>
  			</tr>
  		</table>
     
<!--       <p class="qy-tu4">旗下艺人：<input name="" type="text" value="123" class="qx"/></p> -->
  </div>
  <div class="qy-bright l"><img src="theme/images2/tu78.jpg" width="5" height="130" /></div>
</div>
<!-- JiaThis Button BEGIN -->
<script type="text/javascript" >
var yrname = $("#yrNameId").val();
var yrurl = $("#yrUrl").val();
	var yrname = $("#yrNameId").val();
	var yrurl = $("#yrUrl").val();
	var jiathis_config={
		url:yrurl,
		summary:"我在第一舞台发现了一个超牛逼的公司，非常棒！",
		title:"超喜欢 #"+yrname+"#",
		pic:"http://d15t.cn/stageUpload/headImage/600.png",//图片
		shortUrl:false,
		hideMore:false
	}
</script>
<script type="text/javascript" src="http://v3.jiathis.com/code_mini/jiathis_r.js?btn=r.gif&move=0" charset="utf-8"></script>
<!-- JiaThis Button END -->

<!--预约-->
<div class="nex4">
  <dl class="nex-p">
     <dt><a >Reservation/<span>艺人预约</span></a></dt>
  </dl>
  
  <!--  <dl class="search">
     <dt>&nbsp;</dt>
     <dd>性别：</dd> 
     <dd>职业：</dd> 
     <dd>职业：</dd> 
  </dl>-->
  		<div id="search_list_div" style="width:1003px;height:120PX;background-color:#E6e7e9">
		  <table style="color: #5C5C5C" width="100%;">
			<tr valign="top">
				<td style="font-size:12px;width: 55px;padding-top: 10px;"><div><table width="100%"><tr><td>&nbsp;&nbsp;&nbsp;性别:</td></tr></table></div></td>
				<td align="left" style="padding-top: 10px;">
					<div id="sex_div">
			            <span id="sex_span0" onclick="setSearchValue(this,1,0)" class="current_span" style="margin-left:3px;">&nbsp;不限&nbsp;&nbsp;</span>
			            <span id="sex_span1" onclick="setSearchValue(this,1,1)" class="span">&nbsp;男&nbsp;</span>&nbsp;&nbsp;
			            <span id="sex_span2" onclick="setSearchValue(this,1,2)" class="span">&nbsp;女&nbsp;</span>&nbsp;&nbsp;
		       	 	</div>
		       	 	<input id="sex_value" style="display: none;" value="0"/>
				</td>
			</tr>
			<tr valign="top">
				<td style="font-size:12px;width: 55px;padding-top: 10px;"><div><table width="100%"><tr><td>&nbsp;&nbsp;&nbsp;职业:</td></tr></table></div></td>
				<td align="left" style="padding-top: 10px;">
					<div id="profession_div">
			            <span id="profession_span0" onclick="setSearchValue1(this,2,0)" class="current_span" style="margin-left:3px;">&nbsp;不限&nbsp;&nbsp;</span>
			            <span id="profession_span1" onclick="setSearchValue1(this,2,1)" class="span">&nbsp;演员&nbsp;</span>&nbsp;&nbsp;
			            <span id="profession_span2" onclick="setSearchValue1(this,2,2)" class="span">&nbsp;音乐&nbsp;</span>&nbsp;&nbsp;
			            <span id="profession_span3" onclick="setSearchValue1(this,2,3)" class="span">&nbsp;舞蹈&nbsp;</span>&nbsp;&nbsp;
			            <span id="profession_span4" onclick="setSearchValue1(this,2,4)" class="span">&nbsp;模特&nbsp;</span>&nbsp;&nbsp;
			            <span id="profession_span5" onclick="setSearchValue1(this,2,5)" class="span">&nbsp;达人&nbsp;</span>&nbsp;&nbsp;
			            <span id="profession_span6" onclick="setSearchValue1(this,2,6)" class="span">&nbsp;幕后&nbsp;</span>&nbsp;&nbsp;
		       	 	</div>
		       	 	<input id="profession_value" style="display: none;" value="0"/>
				</td>
			</tr>
			<tr valign="top">
				<td style="font-size:12px;width: 55px;padding-top: 10px;"><div ><table width="100%"><tr><td>&nbsp;&nbsp;&nbsp;职业:</td></tr></table></div></td>
				<td align="left" style="padding-top: 10px;">
					<div id="profession1_div">
						<span id="profession1_span0" onclick="setSearchValue(this,2,0)" class="current_span" style="margin-left:3px;">&nbsp;不限&nbsp;&nbsp;</span>
			             <s:iterator value="#request.professionListAll" var="pro" >
			             	<span id="profession1_span<s:property value="#pro.id"/>" name="name_<s:property value="#pro.subId"/>" onclick="setSearchValue(this,2,<s:property value="#pro.id"/>)"  class="span">&nbsp;<s:property value="#pro.TypeName"/>&nbsp;</span>&nbsp;&nbsp;
			         </s:iterator>     
		       	 	</div>
		       	 	<input id="profession1_value" style="display: none;" value="0"/>
		       	 	
				</td>
			</tr>
			<tr valign="top">
				<td style="font-size:12px;width: 55px;padding-top: 10px;"><div><table width="100%"><tr><td>&nbsp;&nbsp;&nbsp;价格:</td></tr></table></div></td>
				<td align="left" style="padding-top: 10px;">
					<div id="price_div">
			            <span id="price_span0" onclick="setSearchValue(this,3,0)" class="current_span" style="margin-left:3px;">&nbsp;不限&nbsp;&nbsp;</span>
			            <span id="price_span1" onclick="setSearchValue(this,3,1)" class="span">&nbsp;100-500&nbsp;</span>&nbsp;&nbsp;
			            <span id="price_span2" onclick="setSearchValue(this,3,2)" class="span">&nbsp;500-1000&nbsp;</span>&nbsp;&nbsp;
			            <span id="price_span3" onclick="setSearchValue(this,3,3)" class="span">&nbsp;1000-2000&nbsp;</span>&nbsp;&nbsp;
			            <span id="price_span4" onclick="setSearchValue(this,3,4)" class="span">&nbsp;2000以上&nbsp;</span>&nbsp;&nbsp;
		       	 	</div>
		       	 	<input id="price_value" style="display: none;" value="0"/>
				</td>
			</tr>
			</table>
			</div>
			

  <dl class="m1">
     <dt></dt>
  </dl>
  <s:if test="#request.yrxxs.size()==0">
	<font style="color:red ;font-size:14px; font-weight:bold;">没有要显示的结果！</font>
  </s:if>
  
  <s:iterator value="#request.yrxxs" var="item">

		<s:if test="#st.last">
			<dl class="nex4-p3 l">
		</s:if>
		<s:else>
			<dl class="nex4-p2 l">
		</s:else>
		<dt>
			<div onclick="window.location.href='presonList.htm?id=<s:property value="#item[1].userId"/>'" style="cursor: pointer;" class="container"bid="container<%=switchId %><s:property value="#item[1].userId"/>">	
				<img width="242" height="222" src="/stageUpload/indexHeadImage/<s:property value="#item[1].userId"/>.png" onerror="handleImgLoadError(event);" />			
				<div class="overlay" id="overlay<%=switchId %><s:property value="#item[1].userId"/>">
					<div class="hover" id="hover<%=switchId %><s:property value="#item[1].userId"/>">
				       <h1>昵称：<a href="presonList.htm?id=<s:property value="#item[1].userId"/>" style="color: blue"><s:property value="#item[1].nickName"/>(<s:property value="#item[1].provice"/><s:property value="#item[1].city"/>)</a></h1>
				       		<s:action name="userDetailTop3cost" namespace="" executeResult="true">
						 		<s:param name="userId"><s:property value="#item[1].userId"/></s:param>
					   		</s:action>
			        <div class="pp"><a><h1>简介：</h1><s:if test="#item[1].introduction.length() < 100">
				<s:property value="#item[1].introduction" />
			</s:if>
			<s:else>
				<s:property value="#item[1].introduction.substring(0,99)" />...
			</s:else>
			        <p style="float:right"><a href="javascript:sendMessage(<s:property value="#item[1].userId"/>)" style="color:#3490b5;">联系他/她</a>
				    </div>				
				</div>
			    
			</div>
			
		</dt>
		<dd>
			<a href="presonList.htm?id=<s:property value="#item[1].userId"/>" style="color: #000000;" /><s:property value="#item[1].nickName"/></a>
		</dd>
		<dd>
			职业：
			<s:property value="#item[3].typeName" />
		</dd>
		<dd>
			人气：
			<s:property value="#item[1].popularityTotal" />
			次
		</dd>
		</dl>
	</s:iterator>
<table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="page">
    <tr>
        <td align="center"><pg:pages  pageNo='${pageNum}' rowCount ="8"  url="orgListAction.htm" params='id=${id}'  total='${game}' ></pg:pages></td>
    </tr>
</table>
</div>

<script type="text/javascript">
$(document).ready(function(){
	$(".container").each(function(){
		var colour = $(this).find("div[class=overlay]");
		var content = $(this).find("div[class=hover]");
		$(this).hover(function(){
			content.stop().show().css({ "left" : "-242px"}).animate({left : 0}, 300);
			colour.stop().fadeTo(242, .7);
		},function(){
			content.stop().animate({left : 242}, 300);
			colour.stop().fadeTo(242, 0);
		});
	});
});

</script>



<!-- 主内容结束 -->
<jsp:include page="../public/bottom2.jsp"></jsp:include>
  </body>
</html>
