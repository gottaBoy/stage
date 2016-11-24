<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
	
	<div class="top_t_login">


       <%
			if(userSession == null || hasNoMy!=null){
		%>

    	<a href="javascript:showPop(0,'/loginHtml.htm')"  ><img src="<%=request.getContextPath() %>/theme/user/images/Land.png" width="18" height="20" /><span>登 陆</span></a>
        <a href="javascript:showPop(1,'/loginHtml.htm')"  ><img src="<%=request.getContextPath() %>/theme/user/images/Registration.png" width="21" height="20" /><span>注 册</span></a>

    <% }else { %>
	        	欢迎您！
	<%if("1".equals(userSession.getAuthority())) {%>
	<a href="<%=request.getContextPath() %>/member/userinfo!getUserForManager.htm"><%=userSession.getUserName() %></a>&nbsp; | &nbsp;
	<a href="<%=request.getContextPath() %>/member/userinfo!getUserForManager.htm">我的第1舞台</a>
 	<%}else if("0".equals(userSession.getAuthority())){ %>
		 <%if(1==userSession.getIsOrg()){ %>
		 <a href="<%=request.getContextPath() %>/orgListAction.htm?id=<%=userSession.getId() %>">
		 <%=userSession.getUserName() %></a>&nbsp; | &nbsp;
		  <%} else{%>
		  <a href="<%=request.getContextPath() %>/index/presonList.htm?id=<%=userSession.getId() %>">
		 <%=userSession.getUserName() %></a>&nbsp; | &nbsp;
		  <%} %>
		 <%if(1==userSession.getIsOrg()){ %>
			 <a href="<%=request.getContextPath() %>/member/orginfo.htm">我的第1舞台</a>
		 <%} else{%>
			<a href="<%=request.getContextPath() %>/member/userinfo.htm">我的第1舞台</a>
		 <%} %>  
		<a href="<%=request.getContextPath() %>/member/message!toMessage.htm?sign=2"><img src="<%=request.getContextPath() %>/theme/images/email.gif" width="18" height="18" /></a>&nbsp;<a href="<%=request.getContextPath() %>/member/message!toMessage.htm?sign=2">(<font id="unreadMessageCount" color="red">0</font>)</a>
	<%} %>
	&nbsp; |  &nbsp;<a href="<%=request.getContextPath() %>/user/userAction!doOut.htm" class="member_link">退出</a>
	<%} %>



	</div>
  <div class="top_t_b Layout">
   	<h1>第一舞台</h1>
        <div class="top_t_b_r fr">
   	  		<a href="javascript:publishTask()" ><img src="<%=request.getContextPath() %>/theme/user/images/top_t_b_r.gif" width="131" height="42" /></a>
      </div>
    <div class="top_t_b_c fr">
            <form id="headSearchFrom" method="post" action="<%=request.getContextPath() %>/query/queryAction!toQuery.htm">
            <div class="searchbox">
            <div id="inputbox"><input type="text" name="headKeywords" id="headKeywords" value="请输入关键词" class="birds" /></div>
            <input type="submit" id="" value="搜 索" name="" class="sreachbtn" />
            </div>
        
            </form>
        </div>
        
  </div>
</div>

  <jsp:include page="/WEB-INF/page/public/head3.jsp">
   <jsp:param value="no" name="titleType"/>
</jsp:include>
<!-- 
<div class="top_c">
	<div class="top_c_nav mian Layout">
   	  <div class="top_c_nav_l fl"><a href="#" title="网站导航">网站导航</a><a href="/" title="首页">首页</a><a href="#" title="新手上路">新手上路</a><a href="#" title="机构">机构</a><a href="" title="工作机会">工作机会</a></div>
        <div class="top_c_nav_r fr">
        	<img src="/theme/user/images/login.png" width="16" height="16" />
            <input type="text" value="" class="top_c_nav_r_input" />
            <img src="/theme/user/images/password.png" width="11" height="15" />
            <input type="password" value="" class="top_c_nav_r_input" />
            <input type="submit" class="top_c_nav_r_submit" value="" />
       	</div>
    </div>
</div>
 -->

 <script language="javascript">
//显示未读短信条数
function getUnreadMessageCount(){
	$.post('<%=request.getContextPath()%>/member/message!getUnreadMessageCount.htm?dfdf=<%=new Date()%>',function(data){
			$("#unreadMessageCount").html(data);				
	},"html");
}
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

 
$(document).ready(function(){	
		<%if(userSession != null){%>
			getUnreadMessageCount();
		<%}%>

		pinfen();
});

 </script>