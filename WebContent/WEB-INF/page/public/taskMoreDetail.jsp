<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@page import="com.smt.entity.*"%>
<%@ page import="javax.servlet.*, java.text.SimpleDateFormat" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	UserSession userSession = HttpSessionHelper.getUserSession(request) ;
	String state = "";
	if(userSession!=null){
		if(userSession.getState()!=null){
			state = userSession.getState();
		}
	}

	String hasNoMy=(String)session.getAttribute("hasNoMy");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--  public/taskMoreDetail.jsp-->
<title><%=StageVariale.title%></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	
<META HTTP-EQUIV="Cache-Control" CONTENT="no-store, must-revalidate"> 
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">

<link rel="stylesheet" href="<%=path%>/theme/fenlei/css/style2.css" />
<link rel="stylesheet" href="<%=path%>/theme/task/css/task.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />

<script type="text/javascript" src="<%=path%>/theme/fenlei/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=path%>/theme/fenlei/js/common.js"></script>
<script type="text/javascript" src="<%=path%>/theme/fenlei/js/Focus.js"></script>
<script type="text/javascript" src="<%=path%>/theme/fenlei/js/xsgd.js"></script>
<script type="text/javascript" src="<%=path%>/theme/fenlei/js/select.js"></script>

<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>

 
<script>

 $(document).ready(function(){	 
	var oDiv = document.getElementById('task1_xx');
	var oImg = document.getElementById('img');
	oImg.onmouseover = function(){
		oDiv.style.display = 'block';
	}
	  
	oImg.onmouseout = function(){
		oDiv.style.display = 'none';
	}
	  
	oDiv.onmouseover = function(){
		oDiv.style.display = 'block';
	}
	  
	oDiv.onmouseout = function(){
		oDiv.style.display = 'none';
	}
 });


		//应征
		
		function addPersonTask(taskId,flag, taskRoleId){
			<% if(userSession==null){%>
				art.dialog.alert("请先登录然后再应征！");			
			<% }%>
		<% 
  	    	if(userSession!=null){
  	    %>
			var userName = "<%=userSession.getUserName()%>";
			if(<%=userSession.getId() %>==1346){
	  	    	art.dialog.tips("您已被限制该操作！");return;
	  	    }
	  	    <%  }%>

			<%if("0".equals(state)){%>
					art.dialog.alert("新用户注册请等待审核，审核结果将尽快通过邮箱通知您，审核通过后您既可以应征任务！");			
			<%}else{%>


			if(flag==0 || flag==1){ //非企业用户，非观众用户
			//if(flag==0){ //非企业用户，非观众用户
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
			
			<%}%>

		}
		
	function showSee(i){
		$("#see_"+i).show();
	}
	function noSee(i){
		$("#see_"+i).hide();
	}
	function replaceImg(obj){
			obj.src = '<%=request.getContextPath() %>/theme/images/tu03.jpg';
			obj.onerror=null;  
	}

function sendMessage(id){
		art.dialog.open('<%=request.getContextPath()%>/messageSend!send.htm?id='+id,{width:550,height:300,resize: false});
}

</script>
</head>

<body>

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



<div class="task_all">
    <div class="task">
    
    
         <div class="task1" style="height: 310px;">
             <div class="task1_bg"></div>
             <div class="task1_fb">
                    &nbsp;&nbsp;&nbsp;我也要发任务，<br />
                    &nbsp;&nbsp;&nbsp;坐等艺人应征<br />
                    <a href="javascript:publishTask()">发布任务</a>
             </div>
             <div class="task1_xx" id="task1_xx" style="top: 163px;left: 60px;">
                 <p>
				 <s:if test="#request.user.isOrg==1">
					<a href="/index/orgListAction.htm?id=${user.id}">
                </s:if>
			   <s:else>
			   <a  href="/index/presonList.htm?id=${user.id}">
			   </s:else>
				  <img width="60" src="/stageUpload/headImage/${user.id}.png?date=<%=new java.util.Date()%>" onerror="javascript:replaceImg(this)"  /><font style="font-size:12px;">
				  <s:if test="#request.userInfo.nickName.length() > 6">
				    <s:property value='#request.userInfo.nickName.substring(0,6)'/>
				  </s:if>
				  <s:else>
					<s:property value='#request.userInfo.nickName'/>
				  </s:else>
				  </font></a><br />
                 <a href='javascript:sendMessage(<s:property value="#request.task.userId"/>)' class="s">私信</a>
                 <a href='<%=request.getContextPath() %>/member/friendInfo!addFriendInfo.htm?sign=2&friendId=<s:property value="#request.task.userId"/>' class="s">关注</a></p>
             </div>
             <div class="task1_rw" style="width:750px;">
                 <h3>${task.title }</h3>
				 <s:set name="price1" value="#request.task.price" scope="request"/>
				 <%
				 String price1Str = ((request.getAttribute("price1")==null) ? "0" : (String)request.getAttribute("price1"));
				 String price2Str = "";
				if(org.apache.commons.lang.math.NumberUtils.isNumber(price1Str)){
					java.text.NumberFormat nf=java.text.NumberFormat.getCurrencyInstance(java.util.Locale.CHINA);
					price2Str = nf.format(new Double(price1Str));
				}else{
					price2Str = price1Str;
				}


 
TAppTask task=(TAppTask)request.getAttribute("task");
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

                 <div class="task1_nr"><span>总 预 算：</span>      <b>&nbsp;&nbsp;&nbsp;&nbsp;<%=price2Str%>&nbsp;&nbsp;</b></div>
                 <div class="task1_nr"><span>任务地点：</span>     &nbsp;&nbsp;&nbsp;&nbsp;${task.provice}${task.city}${task.place}</div>

                 <div class="task1_nr"><span>任务时间：</span>     &nbsp;&nbsp;&nbsp;&nbsp;${task.startDate }&nbsp;&nbsp;至&nbsp;&nbsp;${task.endDate }</div>
                 <%if(applyStartDate.length()>0){%>
				 <div class="task1_nr"><span>应征时间：</span>     &nbsp;&nbsp;&nbsp;&nbsp;<%=applyStartDate%>&nbsp;&nbsp;至&nbsp;&nbsp;<%=applyEndDate%></div>
                <%}%>
				<div class="task1_nr"><span>发 布 人：</span>
				<s:if test="#request.user.isOrg==1">
				<p style="width: 220px;"><a href="/index/orgListAction.htm?id=${user.id}"><img id="img" width="60" src="/stageUpload/headImage/${user.id}.png?date=<%=new java.util.Date()%>" onerror="javascript:replaceImg(this)"  /><font style="font-size:14px;">				  
				<s:if test="#request.userInfo.nickName.length() > 6">
				    <s:property value='#request.userInfo.nickName.substring(0,6)'/>
				  </s:if>
				  <s:else>
					<s:property value='#request.userInfo.nickName'/>
				  </s:else> </font></a> <br /><font>好评率 ${userInfo.grade}</font></p>
                </s:if>
			   <s:else>
                <p style="width: 220px;"><a  href="/index/presonList.htm?id=${user.id}"><img id="img"  width="60" src="/stageUpload/headImage/${user.id}.png?date=<%=new java.util.Date()%>" onerror="javascript:replaceImg(this)" /><font style="font-size:14px;">				 
				<s:if test="#request.userInfo.nickName.length() > 6">
				    <s:property value='#request.userInfo.nickName.substring(0,6)'/>
				  </s:if>
				  <s:else>
					<s:property value='#request.userInfo.nickName'/>
				  </s:else>
				  </font></a> <br /><font>好评率 ${userInfo.grade}</font></p>
               </s:else>
			   </div>


             </div>
         </div>
         
         
         <div class="task2">
             <h3>任务详细内容：</h3>
             <div class="task2_cont">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%
		if(task!=null && task.getContent()!=null )
			out.print(task.getContent().replace("\n", "<br>"));
			//${task.content }
		%>
		
			 </div>
		<%
		List<TAppTaskRole> taskRoles=(List<TAppTaskRole>)request.getAttribute("userTaskRole");

		if(taskRoles!=null && taskRoles.size()>0) {
		%>
              <table cellpadding="0" cellspacing="0" border="0" class="task2_table">
                 <tr>
                   <td width="150" class="task2_bg">角色需求</td>
                   <td width="327" class="task2_bg">角色描述</td>
                   <td width="66" class="task2_bg">人数</td>
                   <td width="167" class="task2_bg">价格</td>
                   <td width="100" class="task2_bg"></td> 
                 </tr>
				<%
					for(TAppTaskRole ttr:taskRoles) {			
				%>
                 <tr>
                   <td><%=ttr.getRoleName()%></td> 
                   <td><%=ttr.getRoleDesc()%> </td>
                   <td><%=ttr.getRoleNum()%></td>
                   <td>
<%
				java.text.NumberFormat nf=java.text.NumberFormat.getCurrencyInstance(java.util.Locale.CHINA);
				String price3Str = ((ttr.getPriceLow()==null) ? "0" : ttr.getPriceLow().toString());
				String price4Str =  ((ttr.getPriceHigh()==null) ? "0" : ttr.getPriceHigh().toString());
				if(org.apache.commons.lang.math.NumberUtils.isNumber(price3Str)){
					
					price3Str = nf.format(new Double(price3Str));
				} 
				if(org.apache.commons.lang.math.NumberUtils.isNumber(price4Str)){
					
					price4Str = nf.format(new Double(price4Str));
				} 
%>
				   <%=price3Str%>-<%=price4Str%> </td>
                   <td>
			<% if(userSession==null){
			String url ="?r="+HttpSessionHelper.urlEncode("/taskMore/taskMore!toTaskMoreDetail.htm?id="+task.getId());
			%>

			<a style="margin-left: 18px;" href="javascript:parent.showPop(0,'<%=request.getContextPath() %>/loginHtml.htm<%=url%>');">应征</a>
			<% }else{%>
				<%
				Object flag = request.getAttribute("yzFlag_"+ttr.getId());
				if(flag!=null && flag.equals(1)){
			%>
					已应征
				<%}else{%>
					<a href="javascript:addPersonTask('${task.id }','${isOrg}', '<%=ttr.getId()%>')">应征</a>
				<%} %>
				
			<%} %>


</td>
                 </tr>
            <%}%>
 
              </table>
            <%}else{%>


			<div class="task2_one">

			<% if(userSession==null){
			String url ="?r="+HttpSessionHelper.urlEncode("/taskMore/taskMore!toTaskMoreDetail.htm?id="+task.getId());
			%>

			<a style="margin-left: 18px;" href="javascript:parent.showPop(0,'<%=request.getContextPath() %>/loginHtml.htm<%=url%>');">应征</a>
			<% }else{%>

				<s:if test="#request.yzFlag==null || #request.yzFlag==0">
					 <a href="javascript:addPersonTask('${task.id }','${isOrg}', '0')">应征</a>
				</s:if><s:else >
					已应征
				</s:else>
				
			<%} %>
				</div>

			<%}%>
         </div>
         
         
<s:if test="#request.personList.size>0">
 <div class="task3">
             <h3>应征该任务的艺人</h3>
             <ul>
<s:iterator value="#request.personList" var="item" status="ci">  
				<li>
				<s:if test="#item[2].isOrg==1">
					<a href="/index/orgListAction.htm?id=<s:property value='#item[0].personId'/>" target="_blank">
                </s:if>
			   <s:else>
					<a href="/index/presonList.htm?id=<s:property value='#item[0].personId'/>" target="_blank">
			   </s:else>
				<img  width="60" src="/stageUpload/headImage/<s:property value='#item[0].personId'/>.png?date=<%=new java.util.Date()%>" onerror="javascript:replaceImg(this)"/><s:property value='#item[1].nickName'/></a> <br /><font>好评率 <s:property value='#item[1].grade'/></font></li>
</s:iterator>
             </ul> 
         </div> 
</s:if>

<!--          <div class="task3">
             <h3>应征该任务的艺人</h3>
             <ul>
               <li><a href="#"><img src="/theme/task/images/task_img02.jpg" />nana</a> <br /><font>好评率98%</font></li>
               <li><a href="#"><img src="/theme/task/images/task_img02.jpg" />nana</a> <br /><font>好评率98%</font></li>
               <li><a href="#"><img src="/theme/task/images/task_img02.jpg" />nana</a> <br /><font>好评率98%</font></li>
               <li><a href="#"><img src="/theme/task/images/task_img02.jpg" />nana</a> <br /><font>好评率98%</font></li>
               <li><a href="#"><img src="/theme/task/images/task_img02.jpg" />nana</a> <br /><font>好评率98%</font></li>
               <li><a href="#"><img src="/theme/task/images/task_img02.jpg" />nana</a> <br /><font>好评率98%</font></li>
               <li><a href="#"><img src="/theme/task/images/task_img02.jpg" />nana</a> <br /><font>好评率98%</font></li>
               <li><a href="#"><img src="/theme/task/images/task_img02.jpg" />nana</a> <br /><font>好评率98%</font></li>
               <li><a href="#"><img src="/theme/task/images/task_img02.jpg" />nana</a> <br /><font>好评率98%</font></li>
               <li><a href="#"><img src="/theme/task/images/task_img02.jpg" />nana</a> <br /><font>好评率98%</font></li>
             </ul>
             <div class="list_fy">
               <div>共<span>6</span>页</div>
               <ul>
                  <li class="pre"><a href="#"></a></li>
                  <li><a href="#" class="on">1</a></li>
                  <li><a href="#">2</a></li>
                  <li><a href="#">3</a></li>
                  <li><a href="#">4</a></li>
                  <li><a href="#">6</a></li>
                  <li class="next"><a href="#"></a></li>
               </ul>
             </div>
         </div> -->
         
         <div class="task4">
             <h3>看看其他任务</h3>
             <div>
 
			<s:iterator value="#request.userTaskList" var="item" status="ci">
				<s:if test="#item[0].id !=  #request.task.id">
             <ul onmouseover="showSee('${ci.index}')" onmouseout="noSee('${ci.index}')">
               <li class="task4_li1"><a href="/taskMore/taskMore!toTaskMoreDetail.htm?id=<s:property value='#item[0].id'/>"><s:property value='#item[0].title'/></a></li>
               <li>
			   <s:if test="#item[0].price=='面议'">面议</s:if>
			   <s:else>
				 <s:set name="price5" value="#item[0].price" scope="request"/>


				 <%
				 String price5Str = ((request.getAttribute("price5")==null) ? "0" : (String)request.getAttribute("price5"));
				 String price6Str = "";
				if(org.apache.commons.lang.math.NumberUtils.isNumber(price5Str)){
					java.text.NumberFormat nf=java.text.NumberFormat.getCurrencyInstance(java.util.Locale.CHINA);
					price6Str = nf.format(new Double(price5Str));
				}else{
					price6Str = price5Str;					
				}
				out.print(price6Str);
				%>
			   
			   </s:else>
			   </li>
               <li><a href="/taskMore/taskMore!toTaskMoreDetail.htm?id=<s:property value='#item[0].id'/>" class="see"  id="see_${ci.index}" >去看看</a></li>
             </ul>
			 </s:if>
			</s:iterator>
 
             </div>
             <div class="task4_more" style="clear:both"><a href="/index/indexAction!toJobChance.htm">查看更多任务</a></div>
         </div>
         
         
    </div>
</div>



<!-- foot  -->
<jsp:include page="/WEB-INF/page/public/footer.jsp"></jsp:include>

</body>
</html>
