<%@page import="com.smt.webapp.util.OnlineUser"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@page import="com.smt.entity.*"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="pg" uri="/page-tags"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.*, java.text.SimpleDateFormat" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title><%=StageVariale.title%></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/global_layout.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/layout.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/theme/css2/lrtk.css" />
    <link href="<%=request.getContextPath() %>/theme/css/page.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/slides.jquery.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
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
		//应征
		
		function addPersonTask(taskId,flag, taskRoleId){
		<% 
  	    	if(userSession!=null){
  	    %>
			var userName = "<%=userSession.getUserName()%>";
			if(<%=userSession.getId() %>==1346){
	  	    	art.dialog.tips("您已被限制该操作！");return;
	  	    }
	  	    <%  }%>
			if(flag==0){ //非企业用户，非观众用户
				if(userName.indexOf("公司艺人")<0){  //非艺人
					//art.dialog.alert("success");
					//return;
					$.ajax({
					   url:"<%=request.getContextPath() %>/member/task!addPersonTask.htm?taskId="+${task.id}+"&taskRoleId="+taskRoleId,
					   type:'POST',
					   success:function(data){
						   if(data=="1"){
								window.location.reload();
						   }
					   }
					});
				}else{
					art.dialog.alert("公司艺人不能单独应征任务！");
				}
			}else if(flag==100){
				//art.dialog.open('<%=request.getContextPath() %>/member/task!addTaskByOrg.htm?taskId='+taskId,{width:550,height:450,resize: false});				
				art.dialog.alert("观众会员不能应征任务！");			
			}else{
				art.dialog.alert("企业会员暂时不能应征任务！");
			}
			
		}
		
		//发布任务
		 function fabuTask(){
        	<% 
  	    	if(userSession==null){
  	    %>
  	    parent.showPop(0,'<%=request.getContextPath() %>/loginHtml.htm');
  	    //openWindowLogin();
  	    <%  }else{%>
  	    window.open ('<%=request.getContextPath() %>/member/task.htm','','') 
		  <%  }%>
        }

		//回复发布人
		function toAddMessage(){
		
		<% 
   	    	if(HttpSessionHelper.getUserSession(request)==null){
  	    %>
  	   openWindowLogin();
  	    <%  }else{
  	    	TAppTask task=(TAppTask)request.getAttribute("task");
  	    %>
  	    
  		art.dialog.open('<%=request.getContextPath()%>/messageSend!send.htm?id=<%=task.getUserId() %>',{width:550,height:300,resize: false});

		  <%  }%>
		}
		
		//打开登录窗口
		function openWindowLogin(){
         	art.dialog.open('<%=request.getContextPath() %>/windowLogin.html',{width:400,height:310,resize: false});
         }
 	
</script>
  </head>
 
 
<body >
    <jsp:include page="/WEB-INF/page/public/head2.jsp">
      <jsp:param value="no" name="titleType"/>
  </jsp:include>
  

<img id="d1photo" src="<%=request.getContextPath() %>/theme/images2/d1photo.jpg" style="z-index:1000;position:fixed; bottom:120px; _margin-bottom:120px;"/>
<a id="QQlink" target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=979961675&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:1847791078:53" alt="点击这里给我发消息" title="点击这里给我发消息"/></a>
<!-- 主内容开始 -->
<!-- 最新任务内容  开始 -->
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
<div id="task_list">
<div class="task_left">
<table width="100%" >
	<tr>
		<td width="20%"><h2 class="list_contitle padding_text">最新任务</h2></td>

	</tr>
</table>
<%
TAppTask task=(TAppTask)request.getAttribute("task");
List<TAppTaskRole> taskRoles=(List<TAppTaskRole>)request.getAttribute("userTaskRole");

SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm");//设置日期格式

String applyStartDate="";
if(task.getApplyStartDate() !=null) {
	applyStartDate= df.format(task.getApplyStartDate());
}
String applyEndDate="";
if(task.getApplyEndDate()!=null) {
	applyEndDate=df.format(task.getApplyEndDate());
}
%>
<table width="720" border="0" align="center" cellpadding="0" cellspacing="1" class="task_table">
    <tr>
        <td  colspan=2 bgcolor="#F6F6F6" class="task_tit">${task.title }<input type="hidden" id="url" value="http://d15t.cn/taskMore/taskMore!toTaskMoreDetail.htm?id=${task.id }"/><input type="hidden" id="title1" value="<s:property value="#request.task.title"/>"/> <input type="hidden" id="place1" value="<s:property value="#request.task.place"/>"/><input type="hidden" id="price1" value="<s:property value="#request.task.price"/>"/><input type="hidden" id="content1" value="<s:property value="#request.task.content"/>"/></td>
    </tr>
    <script type="text/javascript" >
	var title1 = $("#title1").val();
	var place1 = $("#place1").val();
	var price1 = $("#price1").val();
	var content1 = $("#content1").val();
	var url1 = $("#url").val();
	var jiathis_config={
	siteNum:6,
	sm:"qzone,tsina,tqq,weixin,tieba,tsohu",
	url:url1,
	summary:"标题："+title1+"，地点："+place1+"，赏金："+price1+"，内容："+content1,//摘要
	title:"企业商城#第一舞台#",//标题#微博话题#
	pic:"http://d15t.cn/stageUpload/headImage/600.png",//图片
	showClose:true,
	shortUrl:false,
	hideMore:false
}
</script>
<script type="text/javascript" src="http://v3.jiathis.com/code_mini/jiathis_r.js?btn=r.gif&move=0" charset="utf-8"></script>
    <tr>
        <td bgcolor="#F6F6F6" >任务地点：&nbsp;&nbsp;&nbsp;&nbsp;${task.provice }${task.city }${task.place }</td>
        <td bgcolor="#F6F6F6" >任务总预算：&nbsp;&nbsp;&nbsp;&nbsp;${task.price }&nbsp;&nbsp;元</td>
    </tr>
    <tr>
        <td bgcolor="#F6F6F6" width="450">开始时间：&nbsp;&nbsp;&nbsp;&nbsp;${task.startDate }&nbsp;&nbsp;至&nbsp;&nbsp;${task.endDate }</td>
        <td bgcolor="#F6F6F6">发布人： <s:if test="#request.user.isOrg==1">
        	&nbsp;&nbsp;&nbsp;&nbsp;<a target="_blank" href="<%=request.getContextPath() %>/orgListAction.htm?id=${userInfo.userId }" style="color: red">${userInfo.nickName }</a>
            </s:if>
            <s:else>
            &nbsp;&nbsp;&nbsp;&nbsp;<a target="_blank" href="<%=request.getContextPath() %>/presonList.htm?id=${userInfo.userId }" style="color: red">${userInfo.nickName }</a>
            </s:else> </td>
    </tr>
    <tr>
        <td bgcolor="#F6F6F6" width="450">应征时间：&nbsp;&nbsp;&nbsp;&nbsp;<%=applyStartDate%>&nbsp;&nbsp;至&nbsp;&nbsp;<%=applyEndDate%></td>
        <td bgcolor="#F6F6F6"></td>
    </tr>
    <tr>
    	<td bgcolor="#F6F6F6"></td>
    	<td bgcolor="#F6F6F6">&nbsp;<!--  <div class="jiathis_style" style="padding-right: 10px;"><span class="jiathis_txt">分享到：</span>
					<a class="jiathis_button_icons_1"></a>
					<a class="jiathis_button_icons_2"></a>
					<a class="jiathis_button_icons_3"></a>
					<a class="jiathis_button_icons_4"></a>
					<a class="jiathis_button_icons_5"></a>
					<a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"></a>
					<a class="jiathis_counter_style"></a>
					</div>
					<script type="text/javascript">

					var jiathis_config={
						summary:"标题：${task.title }，地点：${task.place }，赏金：${task.price }，内容：${task.content }",
						title:"第一舞台 #最新任务# ",
						shortUrl:false,
						hideMore:false
					}
					</script>
<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
<!-- JiaThis Button END -->

	         	
</div></td>
    </tr>
</table>

<table width="720" border="0" cellspacing="0" cellpadding="0" class="task_table_con">
    <tr>
        <td height="28" class="task_table_con_title">详细内容</td>
    </tr>
    <tr>
        <td height="450" valign="top" class="task_table_con_textheight "><p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%

		if(task!=null && task.getContent()!=null )
			out.print(task.getContent().replace("\n", "<br>"));
			//${task.content }
		%></p>
		<%
		if(taskRoles!=null && taskRoles.size()>0) {
		%>
        	<table width="680" border="0" align="right" cellpadding="0" cellspacing="0" style="margin-top:40px; text-align:center;">
			<tr class="taskrole_title"><td>人员名称</td><td>人员具体描述</td><td>人数</td><td>价格预算区间(元)</td><td></td>
			</tr>
<%
	for(TAppTaskRole ttr:taskRoles) {			
%>
		<tr>
		    <td  align="center"  ><%=ttr.getRoleName()%>
		    </a></td>	        
	        <td  align="left"  ><%=ttr.getRoleDesc()%>  
	        </td>
		    <td  align="center"  ><%=ttr.getRoleNum()%>
		    </a></td>	        
	        <td  align="left"  ><%=(ttr.getPriceLow()!=null?ttr.getPriceLow():"")%>-<%=(ttr.getPriceHigh()!=null?ttr.getPriceHigh():"")%> 
	        </td>
			<td >
			<% if(userSession==null){
			%>
				<div onclick="parent.showPop(0,'<%=request.getContextPath() %>/loginHtml.htm');event.cancelBubble=true;"  style="background:url(<%=request.getContextPath() %>/theme/images2/xzfq.png) no-repeat;height:34px; width:111px; color:#FFFFFF; font-size:14px; font-weight:bold; line-height:34px; cursor:pointer;">应征该任务</div>
			<% }else{%>
				<%
				Object flag = request.getAttribute("yzFlag_"+ttr.getId());
				if(flag!=null && flag.equals(1)){
			%>
					<div  style="background:url(<%=request.getContextPath() %>/theme/images2/xzfq.png) no-repeat;height:34px; width:111px; color:#FFFFFF; font-size:14px; font-weight:bold; line-height:34px; ">已应征</div>
				<%}else{%>
					<div onclick="addPersonTask(${task.id },${isOrg}, <%=ttr.getId()%>)"  style="background:url(<%=request.getContextPath() %>/theme/images2/xzfq.png) no-repeat;height:34px; width:111px; color:#FFFFFF; font-size:14px; font-weight:bold; line-height:34px; cursor:pointer;">应征该任务</div>
				<%} %>
				
			<%} %>
				
			</td>
	    </tr>
	<%}%>
                <tr>
                	<td colspan=5 ><br><a href="javaScript:toAddMessage();"><img src="<%=request.getContextPath() %>/theme/images/hf_ico.jpg" width="80" height="36" /></a> <a href="javaScript:history.go(-1);"><img src="<%=request.getContextPath() %>/theme/images/fhsyy.jpg" width="100" height="36" /></a></td>
                </tr>
            </table>
		<%
		} else {
		%>
        	<table width="680" border="0" align="right" cellpadding="0" cellspacing="0" style="margin-top:40px; text-align:center;">
                <tr>
                	<td >
                	<% if(userSession==null){
							%>
							<div onclick="parent.showPop(0,'<%=request.getContextPath() %>/loginHtml.htm');event.cancelBubble=true;"  style="background:url(<%=request.getContextPath() %>/theme/images2/xzfq.png) no-repeat;height:34px; width:111px; color:#FFFFFF; font-size:14px; font-weight:bold; line-height:34px; cursor:pointer;">应征该任务</div>
								<% }else{%>
								<s:if test="#request.yzFlag==null || #request.yzFlag==0">
									<div onclick="addPersonTask(${task.id },${isOrg}, 0)"  style="background:url(<%=request.getContextPath() %>/theme/images2/xzfq.png) no-repeat;height:34px; width:111px; color:#FFFFFF; font-size:14px; font-weight:bold; line-height:34px; cursor:pointer;">应征该任务</div>
								</s:if><s:else >
									<div  style="background:url(<%=request.getContextPath() %>/theme/images2/xzfq.png) no-repeat;height:34px; width:111px; color:#FFFFFF; font-size:14px; font-weight:bold; line-height:34px; ">已应征</div>
								</s:else>
									
									<%} %>
                		
                	</td>
                	<td align="right"><a href="javaScript:toAddMessage();"><img src="<%=request.getContextPath() %>/theme/images/hf_ico.jpg" width="80" height="36" /></a></td>
                    <td align="right" width="120px"><a href="javaScript:history.go(-1);"><img src="<%=request.getContextPath() %>/theme/images/fhsyy.jpg" width="100" height="36" /></a></td>
                </tr>
            </table>
		<%}%>
            <p>&nbsp;</p>
        
        </td>
    </tr>
</table>

</div>
</td>
</tr>
</table>
<div class="task_right" style="display: none;">
<ul>
<li><a href="javascript:fabuTask();">发布任务>></a></li>
<li><a href="javascript:toAdd();">委托我们>></a></li>
</ul>

</div>


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
