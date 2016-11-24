<%@page import="com.smt.common.StageVariale"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.smt.entity.*"%>
<%@page import="com.smt.webapp.service.*"%>
<%@page import="com.smt.webapp.web.*"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String id = request.getParameter("prof");
%>
<style type="text/css">
	a.red:hover {color: #FF0000;}
</style>
<script type="text/javascript">
	
	function handleImgLoadError(oEvent)
   	{
       oEvent.srcElement.src='<%=request.getContextPath()%>/theme/images/no_img_tj.jpg';
	}
	
	function doInfo(url){
		window.open(url);
	}
</script>

<div class="clear"></div>
<%
	String felterValue = "";
	int switchId = Integer.parseInt(id);
	int sign = switchId - 1;
	int orderBySign = 0;
	switch (switchId) {
		case 1 ://新加入
			felterValue = "newUserAdd";
			orderBySign = 6;
			break;
		case 2 ://演员
			felterValue = "yanyuan";
			break;
		case 3 ://音乐
			felterValue = "yinyue";
			break;
		case 5 ://模特
			felterValue = "mote";
			break;
		case 4 ://舞蹈
			felterValue = "wudao";
			break;
		case 6 ://达人
			felterValue = "daren";
			break;
		case 7 ://幕后
			felterValue = "muhou";
			break;

		default :
			break;
	}
%>
<div class="nex">
	<dl class="nex-p">
		<dt>
			<a><%=StageVariale.getEnProfById(id)%>/<span><%=StageVariale.getProfById(id)%></span></a>
		</dt>
		<dd>
			<a target="_blank" href="<%=request.getContextPath() %>/query/queryAction!toQuery.htm?orderBySign=<%=orderBySign %>&sign=<%=sign %>&filterValue=<%=felterValue %>">查看更多</a>
		</dd>
	</dl>
	<s:iterator value="#request.list" var="item" status="st">
		<s:if test="#st.index<4">
		<s:if test="#st.last">
			<dl class="nex-p3 l">
		</s:if>
		<s:else>
			<dl class="nex-p2 l">
		</s:else>
		
		<dt>
			<div class="container"  
				id="container<%=switchId %><s:property value="#item[0].userId"/>">
				<div onerror="handleImgLoadError(event);" style="background: url(/stageUpload/indexHeadImage/<s:property value="#item[0].userId"/>.png?date=<s:property value="#request.date"/>) no-repeat center center;width:242px; height:222px;"></div>
				
				
				<!-- <img width="242" height="222" src="/stageUpload/indexHeadImage/<s:property value="#item[0].userId"/>.png" 
				onerror="handleImgLoadError(event);" />	 -->	 	
				<div style="cursor:pointer;" onclick="doInfo('<%=request.getContextPath()%>/presonList.htm?id=<s:property value="#item[0].userId"/>')" class="overlay" id="overlay<%=switchId %><s:property value="#item[0].userId"/>">
					<div  class="hover" id="hover<%=switchId %><s:property value="#item[0].userId"/>">
				       <h1>昵称：<a href="presonList.htm?id=<s:property value="#item[0].userId"/>" style="color: #fff"><s:property value="#item[0].nickName"/>(<s:property value="#item[0].provice"/><s:property value="#item[0].city"/>)</a></h1>
				       		<s:action name="userDetailTop3cost" namespace="" executeResult="true">
						 		<s:param name="userId"><s:property value="#item[0].userId"/></s:param>
					   		</s:action>
			        <div id="word" class="pp"><a><h1>简介：</h1>
			        <s:if test="#item[0].introduction.length()>50">
			        	<s:property value="#item[0].introduction.substring(0,50)"/>
			        </s:if>
			        <s:else>
			        	<s:property value="#item[0].introduction"/>
			        </s:else>
			        </a></div>
			        <%
			        UserSession userSession=HttpSessionHelper.getUserSession(request);
    					if(userSession==null){
    				%>
			        <p style="float:right"><a href="javascript:void(0)" onclick="parent.showPop(1,'<%=request.getContextPath() %>/loginHtml.htm');event.cancelBubble=true;"  class="red" >联系他/她</a>
			        <% }else{%>
			        	 <p style="float:right"><a href="javascript:void(0)"  onclick="parent.sendMessage(<s:property value="#item[0].userId"/>);event.cancelBubble=true;"  class="red">联系他/她</a>
			        <%} %>
				    </div>				
				</div>
<!-- 			    style="color:#3490b5;" -->
			</div>
			
		</dt>
		<dd>
			<a href="presonList.htm?id=<s:property value="#item[0].userId"/>" /><s:property value="#item[0].nickName"/></a>
		</dd>
		<dd>
			职业：
<%-- 			<s:property value="#item[0].profession" /> --%>
<%-- 				<s:property value="#costList[i][0].typeName"/> --%>
<%-- 			<s:property value="#request.costList[<s:property value="#st.index" />]" /> --%>
			${costList[0][1]["typeName"]}
			
		</dd>
		<dd>
			人气：
			<s:property value="#item[0].popularityTotal" />
			次
		</dd>
		</dl>
		</s:if>
	</s:iterator>
</div>




<script type="text/javascript">
$(document).ready(function(){
	
	
	$(".container").each(function(){
// 		$(this).css({"cursor" : "hand"});
		var colour = $(this).find("div[class=overlay]");
		var content = $(this).find("div[class=hover]");
		$(this).hover(function(){
			content.stop().show().css({ "left" : "-232px"}).animate({left : 0}, 200);
			colour.stop().fadeTo(242, .7);
			//$(this).css("padding", "0px");
		},function(){
			content.stop().animate({left : 242}, 300);
			colour.stop().fadeTo(242, 0);
			//$(this).css("padding", "1px");
		});
	});
});
</script>
	
