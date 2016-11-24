<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	UserSession userSession = HttpSessionHelper.getUserSession(request) ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    
    <title><%=StageVariale.title%></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">
<%-- 	<link href="<%=path %>/theme/css2/style.css" rel="stylesheet" type="text/css" /> --%>
	<SCRIPT type=text/javascript src="<%=request.getContextPath() %>/theme/js2/jquery-1.7.1.min.js"></SCRIPT>
		<script type="text/javascript" language="javascript" src="<%=path %>/01stageDialog/jquery.artDialog.js"></script>
<%-- 	<script type="text/javascript" language="javascript" src="<%=path %>/01stageDialog/plugins/iframeTools.js"></script> --%>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css"></link>
		<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<SCRIPT type=text/javascript src="<%=request.getContextPath() %>/theme/js2/common.js"></SCRIPT>
	<link href="<%=path %>/theme/css2/qiyezhongxin.css" rel="stylesheet" type="text/css" />
<%-- 	<link href="<%=path %>/theme/css2/gerenye.css" rel="stylesheet" type="text/css" /> --%>
	<style type="text/css">
		.pointer{
			cursor: pointer;
		}
	</style>
	<script type="text/javascript">  
	function handleImgLoadError(oEvent)
   	{
       oEvent.srcElement.src= '<%=request.getContextPath()%>/theme/temp/photo.jpg';
  	}
  	 
  	 function indexImgLoadError(oEvent)
   	{
       oEvent.srcElement.src= '<%=request.getContextPath()%>/theme/images/no_img_tj.jpg';
  	}
	function setTab03Syn(i,obj){
		for(var j = 1 ; j<=2 ; j++){
			if(i==j){
				$("#TabTab03Con"+i).show();
				$("#font"+i).addClass("change");
			}else{
				$("#TabTab03Con"+j).hide();
				$("#font"+j).removeClass("change");
			}
		}
	}
	
	function refresh(){
		window.location.reload();
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
					   		p.location = '<%=request.getContextPath() %>/member/business!toPreOrder.htm?bqyUserId=<s:property value="#request.userInfo.userId"/>';
					   }
				   }
				});
			 }
			  <%  }%>
	     }
	
	function toGrowthView(id){
		art.dialog.open('<%=request.getContextPath() %>/growth!toGrowth.htm?id='+id,{width:530,height:380,resize: false});
	}
	</script>
	<style type="text/css">
/* 		.gr-nex2-right9 { width:100%; margin:10px auto;} */
/*          .gr-nex2-right9 ul { width:520px; margin:10px auto;} */
/* 		 .gr-nex2-right9 ul li { height:30px; line-height:30px; padding-left:16px; border-bottom:1px #ccc solid;} */
/* 		.gr-nex2-right9 ul li a { height:30px; line-height:30px; font-family:"微软雅黑","宋体"; color:#000; font-size:12px;} */
/* 		.gr-nex2-right9 ul li a:hover { height:30px; line-height:30px; font-family:"微软雅黑","宋体"; color:#D12127; font-size:12px;} */
		.gr-nex2-right9 ul li span { float:right; font-family:"微软雅黑","宋体"; color:#666; font-size:11px;}
	</style>
<!--top4-->
<div class="qy-banner">
  <div class="qy-bleft l"><img src="theme/images2/tu89.jpg" width="5" height="191" /></div>
  <div class="gr-zhong l">
      <ul class="zhong-tu l">
         <li>
<!--          <img src="theme/images2/tu92.jpg" width="112" height="102" /> -->
<img style="border:1px solid #e3e3e3; padding:2px;" onerror="indexImgLoadError(event);" src="/stageUpload/headImage/<s:property value="#request.userInfo.userId"/>.png" width="110" height="100" />
         </li>
          <%
    		if(userSession==null){
    	 %>
         <li><a href="javascript:void(0)"><img onclick = "showPop(1,'<%=request.getContextPath() %>/loginHtml.htm')" src="theme/images2/tu93.jpg" width="112" height="31" /></a></li>
         <li><a href="javascript:void(0)"><img onclick = "showPop(1,'<%=request.getContextPath() %>/loginHtml.htm')" src="theme/images2/tu94.jpg" width="112" height="31" /></a></li>
          <div id="light" class="white_content"> 
	        <iframe src="" name="wank" width="630px"  height="500px" scrolling="no" frameborder="0"></iframe> 
	        </div>
	        <div id="fade" class="black_overlay"></div>
         <% }else{ %>
         	  <li><a href="javascript:sendMessage();"><img src="theme/images2/tu93.jpg" width="112" height="31" /></a></li>
         	  <li><a href="javascript:qianYueTa();"><img src="theme/images2/tu94.jpg" width="112" height="31" /></a></li>
          <div id="light" class="white_content"> 
         <% } %>
      </ul>
       <ul class="qy-tu2 l">
    
         <table style="font-weight:bold;font-size:24px;line-height:32px;height:38px;">
	         <tr>
	         	<td><s:property value="#request.userInfo.nickName"/><a style="font-size:12px;color:#F00;font-size:16px;margin:0 10px;display: none;">lv3&nbsp;</a><s:if test="#request.user.rzState==3">
		         	<a style="color:#37bc07;font-size:12px;margin:0 10px"><img src="theme/images2/tu95.jpg" width="15" height="17" />&nbsp;实名认证</a>
		         	&nbsp;&nbsp;&nbsp;
	         	</s:if>
	         	<s:else>
	         		<a style="color:#cc0000;font-size:12px;margin:0 10px"><img src="theme/images2/tu95_1.jpg" width="15" height="17" />&nbsp;未认证</a>
		         	&nbsp;&nbsp;&nbsp;
	         	</s:else><input type="text" id="yrNameId" style="display: none;" value="<s:property value="#request.userInfo.nickName"/>" /><input type="text" id="yrUrl" style="display: none;" value="http://d15t.cn/stage01/presonList.htm?id=<s:property value="#request.userInfo.userId"/>" /><input type="text" id="yrPic" style="display: none;" value="http://d15t.cn/stageUpload/headImage/<s:property value="#request.userInfo.userId"/>.png" /> </td>
	         	<!--<td valign="top"><span style="font-size:12px;">分享到：<wb:share-button addition="simple" type="icon" default_text="我在第一舞台发现了<s:property value="#request.userInfo.nickName"/>，非常棒！" pic="http://localhost:8080/stageUpload/headImage/<s:property value="#request.userInfo.userId"/>.png"></wb:share-button> </span></td>
	         	<td>
	         		<div id="qqwb_share__" data-appkey="801425800" data-icon="2" data-counter="0" data-counter_pos="right" data-content="超喜欢第一舞台里的<s:property value="#request.userInfo.nickName"/>，非常nice！"  data-pic="http://d15t.cn/stageUpload/img/66/223/775762.jpg"></div>
	         	</td>-->
	         	<td><!-- JiaThis Button BEGIN -->
					<div class="jiathis_style"><span class="jiathis_txt">分享到：</span>
					<a class="jiathis_button_icons_1"></a>
					<a class="jiathis_button_icons_2"></a>
					<a class="jiathis_button_icons_3"></a>
					<a class="jiathis_button_icons_4"></a>
					<a class="jiathis_button_icons_5"></a>
					<a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"></a>
					<a class="jiathis_counter_style"></a>
					</div>
					<script type="text/javascript" >
					var yrname = $("#yrNameId").val();
					var yrurl = $("#yrUrl").val();
					var yrpic = $("#yrPic").val();
					var jiathis_config={
						url:yrurl,
						summary:"我在第一舞台发现了ta，非常棒！",
						title:"超喜欢 #"+yrname+"#",
						pic:yrpic,
						shortUrl:false,
						hideMore:false
					}
					</script>
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
<!-- JiaThis Button END -->

	         	
</div>
</td>
	         	<td><%
				if(userSession==null){
			%>
              &nbsp;&nbsp;&nbsp;<img src="theme/images2/gz.png" width="20" height="20" /><a style="color:#ff8000;font-size:12px;margin:0 10px" href="javascript:void(0)" onclick="parent.showPop(1,'<%=request.getContextPath() %>/loginHtml.htm');event.cancelBubble=true;">加关注</a>
              &nbsp;&nbsp;&nbsp;<img src="theme/images2/ding.png" width="20" height="20" /><a style="color:#bd0000;font-size:12px;margin:0 10px" href="javascript:void(0)" onclick="parent.showPop(1,'<%=request.getContextPath() %>/loginHtml.htm');event.cancelBubble=true;">顶一下&nbsp;<s:property value="#request.dingCount"/></a>
			<% }else{%>
				 <s:if test="#request.friendInfo==null">&nbsp;&nbsp;&nbsp;<img src="theme/images2/gz.png" width="20" height="20" /><a style="color:#ff8000;font-size:12px;margin:0 10px" href="javascript:addFriend(<s:property value="#request.id"/>)">加关注</a></s:if>
           <s:else>&nbsp;&nbsp;&nbsp;<img src="theme/images2/gz.png" width="20" height="20" /><span style="color:#ff8000;font-size:12px">已关注</span></s:else>
           		&nbsp;&nbsp;&nbsp;<img src="theme/images2/ding.png" width="20" height="20" /><a style="color:#bd0000;font-size:12px;margin:0 10px" href="javascript:addDing(<s:property value="#request.id"/>)">顶一下&nbsp;<s:property value="#request.dingCount"/></a>
			<%} %>
            </td>
	         </tr>
	         <tr></tr>
         </table>
 <li>
         	<p>
<%--          	<s:property value="#request.costList[0][1].typeName" />&nbsp;<s:property value="#request.costList[1][1].typeName" /> --%>
<%-- <s:iterator value="#request.costList" var="item"> --%>
<%-- 				<s:property value="#item[1].typeName"/> --%>
<%-- 			</s:iterator> --%>
			<s:property value="#request.costList[0][1].typeName" />&nbsp;<s:property value="#request.costList[1][1].typeName" />&nbsp;
			<s:property value="#request.costList[2][1].typeName" />&nbsp;<s:property value="#request.costList[3][1].typeName" />&nbsp;
			<s:property value="#request.costList[4][1].typeName" />&nbsp;
         	</p>
         </li>
         <li><s:property value="#request.userInfo.provice"/> | <s:property value="#request.userInfo.city"/></li>
<!--          <li>企业网站：<a href="" style="color:#00b7ed">http://www.sankezhongzi.com</a></li> -->
         <li style="border-bottom:1px solid #ccc">签约次数：<input name="" type="text" value="<s:property value="#request.userInfo.signNumber"/>" class="qx"/>&nbsp;&nbsp;&nbsp;好评率：<input name="" type="text" value="<s:property value="#request.userInfo.feedbackRate"/>%" class="qx"/></li>
         <br/>
         <li>
         	<s:if test="#request.user.isOrg==1">公司介绍:&nbsp;</s:if>
			<s:elseif test="#request.user.isOrg==0">个人介绍:&nbsp;</s:elseif>
					<s:if test="#request.userInfo.introduction.length() < 120">
				<s:property value="#request.userInfo.introduction" />
			</s:if>
			<s:else>
				<s:property value="#request.userInfo.introduction.substring(0,119)" />
			</s:else>
			...<a href="javascript:alertInfo('<s:property value='#request.userInfo.introduction' />')" style="color:#00b7ed">查看全部介绍</a>
         </li>
<%--          <li>个人简介：<s:property value="#request.userInfo.introduction.substring(0,35)"/>...</li> --%>
<!--          <li>企业介绍：本公司承接各种类型公司企业活动、演出策划、推广。本公司承演出演出策划...... <a href="" style="color:#00b7ed">查看全部介绍</a></li> -->
      </ul>
      <p class="gr-tu3">手机:&nbsp;&nbsp;
			 <%
                if(userSession==null){
             %>
               请登录后查看
             <%
				} else {
             %>
            <s:if test="#request.userInfo1.mobileRadio==1">
            	<!-- 不公开 -->
            </s:if>
            <s:elseif test="#request.userInfo1.mobileRadio==2">
            	<s:property value="#request.userInfo1.mobile"/>
            </s:elseif>
            <s:else>
            	<s:if test="#request.friend==1">
            	<!--仅对好友公开-->
                </s:if>
                <s:elseif test="#request.friend==2">
                    <s:property value="#request.userInfo1.mobile"/>
                </s:elseif>
            </s:else>
             <%
				}
             %>
		   </p>
            <p class="gr-tu4">QQ:&nbsp;&nbsp;
            <%
                if(userSession==null){
             %>
               请登录后查看
             <%
				} else {
             %>
            <s:if test="#request.userInfo1.qqRadio==1">
            	
            </s:if>
            <s:elseif test="#request.userInfo1.qqRadio==2">
            	<s:property value="#request.userInfo1.qq"/>
            </s:elseif>
            <s:else>
            	<s:if test="#request.friend==1">
            	
                </s:if>
                <s:elseif test="#request.friend==2">
                    <s:property value="#request.userInfo1.qq"/>
                </s:elseif>
            </s:else>
             <%
				}
             %>
            </p>
      <ul class="gr-dtpf l" style="display: none;">
         <li class="dt">动态评分</li>
         <li class="dt2">好评率<s:property value="#request.userInfo.feedbackRate"/>%</li>
         <li>描述相符<img src="theme/images2/tu96.jpg" /><img src="theme/images2/tu96.jpg" /><img src="theme/images2/tu96.jpg" /><img src="theme/images2/tu96.jpg" /><img src="theme/images2/tu96.jpg" />&nbsp;&nbsp;10</li>
         <li>工作态度</li>
         <li>完成质量</li>
      </ul>
  </div>
  <div class="qy-bright l"><img src="theme/images2/tu91.jpg" width="5" height="191" /></div>
</div>