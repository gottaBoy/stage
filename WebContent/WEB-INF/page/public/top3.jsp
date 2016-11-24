<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<div style="position: fixed;right: 0px;top: 520px;width: 93px;height: 150px;">
<a id="QQlink" target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=979961675&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:1847791078:53" alt="点击这里给我发消息" title="点击这里给我发消息"/></a>
</div>


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
            <form id="headSearchFrom" method="get"  >
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


				<div id="inputbox"><input type="text" name="headKeywords" id="headKeywords"  onkeydown="if(event.keyCode==13) searchHeader()" value="请输入关键词" class="birds" /></div>
				<input type="button" id="" value="搜 索" name="" class="sreachbtn"onclick="javascript:searchHeader()"/>
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


 	//弹出登录框或者注册框 flag=1时 弹出登录框 flag=2时注册框
 	function showPop(flag,url){
 		//$(document).scrollTop(0);
		if(url.indexOf("?")>0)
	 		window.location.href = '<%=request.getContextPath() %>' + url+"&flag="+flag;
		else
 			window.location.href = '<%=request.getContextPath() %>' + url+"?flag="+flag;
 	}
 </script>