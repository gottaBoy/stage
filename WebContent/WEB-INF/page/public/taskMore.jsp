<%@page import="com.smt.webapp.util.OnlineUser"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="pg" uri="/page-tags"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title><%=StageVariale.title%></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="<%=StageVariale.description%>">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/global_layout.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/layout.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
    	<link href="<%=request.getContextPath() %>/theme/css/page.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/slides.jquery.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/common.js"></script>
	<style>
.black_overlay{display:none;position:absolute;top:0%;left:0%;width:100%;height:4250px;background-color:black;z-index:1001;-moz-opacity:0.8;opacity:.80;filter: alpha(opacity=80);}
.white_content{display:none;position:absolute;top:25%;left:25%;width:630px;height:4250px;z-index:1002;overflow:auto;}
</style>
	<script language="javascript" type="text/javascript">
	
		function handleImgLoadError(oEvent){
           oEvent.srcElement.src='<%=request.getContextPath() %>/theme/images/rz_imgphoto.jpg';
  	    }
  	    
  	    //委托我们
  	    function toAdd(){
  	    <% 
  	    	UserSession userSession=HttpSessionHelper.getUserSession(request);
  	    	if(userSession==null){
  	    %>
  	     parent.showPop(1,'<%=request.getContextPath() %>/loginHtml.htm');
  	    //openWindowLogin();
  	    <%  }else{%>
  	    
		art.dialog.open('<%=request.getContextPath()%>/member/task!toTask.htm',{resize: false});
		  <%  }%>
		}
		
		//发布任务
		 function fabuTask(){
        	<% 
  	    	if(userSession==null){
  	    %>
  	    parent.showPop(1,'<%=request.getContextPath() %>/loginHtml.htm');
  	   // openWindowLogin();
  	    <%  }else{%>
  	    window.open ('<%=request.getContextPath() %>/member/task.htm','','') 
		  <%  }%>
        }
		
		//打开登录窗口
		function openWindowLogin(){
<%--          	art.dialog.open('<%=request.getContextPath() %>/windowLogin.html',{width:400,height:310,resize: false}); --%>
			document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'
         }
         
       
 		
</script>
  </head>
 
 
<body >

    <jsp:include page="/WEB-INF/page/public/head2.jsp">
      <jsp:param value="no" name="titleType"/>
  </jsp:include>
 <!-- JiaThis Button BEGIN -->
<script type="text/javascript" >
var jiathis_config={
	siteNum:6,
	sm:"qzone,tsina,tqq,weixin,tieba,tsohu",
	url:"http://d15t.cn/taskMore/taskMore!toTaskMore.htm",
	summary:"第一舞台，演艺人才的淘宝网！",//摘要
	title:"最新任务#第一舞台#",//标题#微博话题#
	pic:"http://d15t.cn/stageUpload/headImage/600.png",//图片
	showClose:true,
	shortUrl:false,
	hideMore:false
}
</script>
<script type="text/javascript" src="http://v3.jiathis.com/code_mini/jiathis_r.js?btn=r.gif&move=0" charset="utf-8"></script>
<!-- JiaThis Button END -->
<!-- 主内容开始 -->
<!-- 最新任务内容  开始 -->
<img id="d1photo" src="<%=request.getContextPath() %>/theme/images2/d1photo.jpg" style="z-index:1000;position:fixed; bottom:120px; _margin-bottom:120px;"/>
<a id="QQlink" target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=979961675&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:1847791078:53" alt="点击这里给我发消息" title="点击这里给我发消息"/></a>

<div class="clear"></div>
<table width="100%" >
	<tr>
		<td width="100%" align="center">
			<table width="980">
				<tr>
					<td width="100%" align="right" style="padding-top: 10px;">
						<div class="task_right">
						<ul>
						<li><a href="javascript:fabuTask();">发布任务>></a></li>
						<li><a href="javascript:toAdd();">委托我们>></a></li>
						</ul>
						</div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<div id="task_list" >
				<div class="task_left" ><h2 class="list_contitle padding_text">最新任务</h2>
				
				<ul>
				<s:iterator value="#request.taskList" var="item">
				<li>
				<table width="942" border="0" cellspacing="0" cellpadding="0" class="time_img">
				    <tr>
				        <td width="20%">
				        	<div class="task_left_map" style="cursor: pointer;font-size: 12px" title="<s:property value="#item[0].place"/>">
				        		<s:if test="#item[0].place.length()>13">
				        			<s:property value="#item[0].place.substring(0,13)"/>...
				        		</s:if>
				        		<s:else>
				        			<s:property value="#item[0].place"/>
				        		</s:else>
				        		
				        	</div>
				        </td>
				        <td width="30%"><span><a href="<%=request.getContextPath() %>/taskMore/taskMore!toTaskMoreDetail.htm?id=<s:property value="#item[0].id"/>">
				        		<s:if test="#item[0].title.length()>18">
				        			<s:property value="#item[0].title.substring(0,18)"/>..
				        		</s:if>
				        		<s:else>
				        			<s:property value="#item[0].title"/>
				        		</s:else>
				        	</a></span></td>
				        <td width="8%"><span class="task_left_title"><s:property value="#item[0].price"/>&nbsp;&nbsp;元</span></td>
				        <td width="20%"><span class="task_left_title"><s:property value="#item[2].nickName"/></span></td>
				        <td width="20%" align="left" ><span class="task_left_time"> 
				        <img src="<%=request.getContextPath() %>/theme/images/time.gif" /><s:property value="%{@com.smt.webapp.util.CommonUtil@getDateDif(#item[0].endDate+':00')}"/>&nbsp;后截止任务       
				        </span></td>
				    </tr>
				</table>
				</li>
				</s:iterator>
				</ul>
				<div id="light" class="white_content"> 
					        <iframe src="<%=request.getContextPath() %>/login.html" name="wank" width="630px"  height="500px" scrolling="no" frameborder="0"></iframe> 
					        </div>
					        <div id="fade" class="black_overlay"></div>
				<table width="730" border="0" align="center" style="margin-bottom:20px;" cellpadding="0" cellspacing="0" class="page">
						    <tr>
						        <td align="center" style="height:80px;"><pg:pages  pageNo='${pageNum}' rowCount ="10"  url="taskMore!toTaskMore.htm"  total='${total}' ></pg:pages></td>
						    </tr>
					</table>
				
				</div>
			
		</td>
	</tr>
</table>




<!-- 合作企业 开始 -->

<div class="home_right_hzqy_200" style="display: none;">
<h2 class="list_contitle padding_text_02">合作企业</h2>
<ul>
<li>杭州跨世纪模特经纪公司</li>
<li>北京礼仪模特公司新时代传媒
</li>
<li>上海模特公司,上海模特经纪公司
</li>
<li>朗雅传媒-礼仪模特演艺服务专家
</li>
<li>杭州跨世纪模特经纪公司</li>
<li>北京礼仪模特公司新时代传媒
</li>
<li>上海模特公司,上海模特经纪公司
</li>
<li>朗雅传媒-礼仪模特演艺服务专家
</li>



</ul>
</div>



</div>


<div class="clear"></div>

</div>

<div class="clear"></div>
<!-- 主内容结束 -->
<!-- 底部开始 -->
<jsp:include page="/WEB-INF/page/public/bottom2.jsp"></jsp:include>

<!-- 底部结束 --> 
  
  </body>
</html>
