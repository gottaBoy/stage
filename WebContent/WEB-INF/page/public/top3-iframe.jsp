<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>



	<div class="top_t_login">


       <%
			if(userSession == null || hasNoMy!=null){
		%>

    	<a href="<%=request.getContextPath() %>/loginHtml.htm?flag=0"  target="_top"><img src="<%=request.getContextPath() %>/theme/user/images/Land.png" width="18" height="20" /><span>登 陆</span></a>
        <a href="<%=request.getContextPath() %>/loginHtml.htm?flag=1"  target="_top"><img src="<%=request.getContextPath() %>/theme/user/images/Registration.png" width="21" height="20" /><span>注 册</span></a>

    <% }else { %>
	        	欢迎您！
	<%if("1".equals(userSession.getAuthority())) {%>
	<a href="<%=request.getContextPath() %>/member/userinfo!getUserForManager.htm" target="_top"><%=userSession.getUserName() %></a>&nbsp; | &nbsp;
	<a href="<%=request.getContextPath() %>/member/userinfo!getUserForManager.htm" target="_top">我的第1舞台</a>
 	<%}else if("0".equals(userSession.getAuthority())){ %>
		 <%if(1==userSession.getIsOrg()){ %>
		 <a href="<%=request.getContextPath() %>/orgListAction.htm?id=<%=userSession.getId() %>" target="_top">
		 <%=userSession.getUserName() %></a>&nbsp; | &nbsp;
		  <%} else{%>
		  <a href="<%=request.getContextPath() %>/index/presonList.htm?id=<%=userSession.getId() %>" target="_top">
		 <%=userSession.getUserName() %></a>&nbsp; | &nbsp;
		  <%} %>
		 <%if(1==userSession.getIsOrg()){ %>
			 <a href="<%=request.getContextPath() %>/member/orginfo.htm" target="_top">我的第1舞台</a>
		 <%} else{%>
			<a href="<%=request.getContextPath() %>/member/userinfo.htm" target="_top">我的第1舞台</a>
		 <%} %>  
		<a href="<%=request.getContextPath() %>/member/message!toMessage.htm?sign=2" target="_top"><img src="<%=request.getContextPath() %>/theme/images/email.gif" width="18" height="18" /></a>&nbsp;<a href="<%=request.getContextPath() %>/member/message!toMessage.htm?sign=2" target="_top">(<font id="unreadMessageCount" color="red">0</font>)</a>
	<%} %>
	&nbsp; |  &nbsp;<a href="<%=request.getContextPath() %>/user/userAction!doOut.htm" class="member_link" target="_top">退出</a>
	<%} %>



	</div>
  <div class="top_t_b Layout">
   	<h1>第一舞台</h1>
        <div class="top_t_b_r fr">
   	  		<a href="javascript:publishTask()" ><img src="<%=request.getContextPath() %>/theme/user/images/top_t_b_r.gif" width="131" height="42" /></a>
      </div>
    <div class="top_t_b_c fr">
            <form id="headSearchFrom" method="get"   target="_top">
            <div class="searchbox">


				<div id="options">
					<dl>
						<dt>
							<input type="text" value="找艺人" name="keyTypeStr" id="text" />
							<input id="keyType" type="hidden" value="1" name="keyType" />
							<b></b>
						</dt>
						<dd>
							<div id="1">找艺人</div>
							<div id="2">找机构</div>
						</dd>
					</dl>
				</div>


				<div id="inputbox" ><input type="text" name="headKeywords" id="headKeywords" value="请输入关键词"   onkeydown="if(event.keyCode==13) searchHeader()"   class="birds" style="height:34px"/></div>
				<input type="button" id="" value="搜 索" name="" class="sreachbtn" onclick="javascript:searchHeader()"/>
            </div>
        
            </form>
        </div>
        
  </div>

 

 <script language="javascript">
function searchHeader(){
	if($("#keyType").val()=='2'){
		$("#headSearchFrom").attr("action","<%=request.getContextPath()%>/index/indexAction!toOrg.htm");
	}else{
		$("#headSearchFrom").attr("action","<%=request.getContextPath()%>/index/indexAction!toFenlei.htm");		
	}
	$("#headSearchFrom").submit();
 }

//显示未读短信条数
function getUnreadMessageCount(){
	$.post('<%=request.getContextPath()%>/member/message!getUnreadMessageCount.htm?dfdf=<%=new Date()%>',function(data){
			$("#unreadMessageCount").html(data);				
	},"html");
}


function publishTask(){
	<%if(userSession != null){%>
		window.open("<%=request.getContextPath()%>/member/task.htm?userId=<%=userSession.getId() %>","_top");
	<%}else{ 
		//art.dialog.alert("请先登录！");

		String url ="?r="+HttpSessionHelper.urlEncode("/member/task.htm?userId=@{loginUserId}");
		%>
		window.open("<%=request.getContextPath() %>/loginHtml.htm<%=url%>&flag="+2,"_top");
		//parent.showPop(2,'<%=request.getContextPath() %>/loginHtml.htm<%=url%>');
	<%}%>
}
$(document).ready(function(){	
		<%if(userSession != null){%>
			getUnreadMessageCount();
		<%}%>
});


 </script>