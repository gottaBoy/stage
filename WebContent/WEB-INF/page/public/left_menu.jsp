<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java"  pageEncoding="UTF-8"%>
<div class="member_menu">
        <h1>我的第1舞台</h1>
        <h2></h2>
        <ul>
		<s:iterator value="menus" var="menu" status="st">


		
		<s:if test="#menu.menuName!='档期管理'">
			<li>
				<a href='<%=request.getContextPath() %>/<s:property value="#menu.link"/>?userId=0' id='menu_<s:property value="#menu.menuNo"/>' <s:if test="menuFlag==(#menu.id)">class="change"</s:if>  onclick='changeMenuClass(<s:property value="#menu.menuNo"/>)'>
					
					<s:if test="#menu.menuName=='个人信息'">
						<% 
							if(1==HttpSessionHelper.getIsOrg(request)){
						%>
						 公司信息		
						<%}else {%>
						个人信息
						<%} %>
					
					</s:if>
					<s:elseif test="#menu.menuName=='我的交易'">
						
						 我的交易
					</s:elseif>
					<s:elseif test="#menu.menuName=='站内短信'">
						
						 站内短信(<font id="unreadMessageCount2" color="red">${unreadMessageCount}</font>)
					</s:elseif>
					<s:elseif test="#menu.menuName=='评价管理'">
						
						 评价管理(<font id="unreadMessageCount3" color="red">${unreadPJCount}</font>)
					</s:elseif>
					<s:else>
						<s:property value="#menu.menuName"/>
					</s:else>
					
				</a>
			</li>
		</s:if>


		<% 
			if("diyirenwu".equals(com.smt.webapp.util.HttpSessionHelper.getUserSession(request).getUserName())){
		%>
		<s:if test="#menu.menuName=='任务发布'">
			<li>
				<a href='<%=request.getContextPath() %>/member/task!findZhua.htm' id='menu_111' <s:if test="menuFlag==111">class="change"</s:if>  onclick='changeMenuClass(111)'>
				任务抓取
				</a>
			</li>
		</s:if>
		<%}%>


		</s:iterator>
        </ul>
</div>
