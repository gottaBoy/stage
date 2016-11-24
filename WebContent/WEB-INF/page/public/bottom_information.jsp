<%@page import="com.smt.entity.TAppInformation"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>



<%
String personPage = (String)request.getAttribute("personPage");

List oneMenu_bottom=(List)request.getAttribute("oneMenu_bottom");
List twoMenu_bottom=(List)request.getAttribute("twoMenu_bottom");
if(personPage==null){
	for(int i=0;i<oneMenu_bottom.size();i++){
		TAppInformation oneMenuInfo=(TAppInformation)oneMenu_bottom.get(i);
%>
			<ul class="bottom2-wz l">
					 <li class="wz2"><a href="javascript:void(0)"><%=oneMenuInfo.getMenuName() %></a></li>
					<%
						for(int j=0;j<twoMenu_bottom.size();j++){
							TAppInformation twoMenuInfo=(TAppInformation)twoMenu_bottom.get(j);
							if(oneMenuInfo.getId().equals(twoMenuInfo.getParentId())){
					%>
								<li>
								<a target="_blank" href="<%=request.getContextPath() %>/about/about!toAbout.htm?id=<%=twoMenuInfo.getId() %>&sign=<%=oneMenuInfo.getId() %>"><%=twoMenuInfo.getMenuName() %></a>
							   </li>
					<%  } 
					} 
					%>

					<% 	if(oneMenuInfo.getMenuCode().equals("more")) {%>
						<li class="second_li"><a href="http://www.epiao1616.com" target="_blank">人民大舞台票务网站</a></li>
					<%}%>
			</ul>
			<%}%>
			<div  class="copyright">
			Copyright © 2013-2014 上海艺起来文化发展有限公司 版权所有　沪ICP备14021568号-2 
			</div>
<%
}else{
	for(int i=0;i<oneMenu_bottom.size();i++){
		TAppInformation oneMenuInfo=(TAppInformation)oneMenu_bottom.get(i);
		if(!oneMenuInfo.getMenuCode().equals("more")) {
	%>
			<dl>
					<dd><a href="javascript:void(0)"><%=oneMenuInfo.getMenuName() %></a></dd>
					<%
						for(int j=0;j<twoMenu_bottom.size();j++){
							TAppInformation twoMenuInfo=(TAppInformation)twoMenu_bottom.get(j);
							if(oneMenuInfo.getId().equals(twoMenuInfo.getParentId())){
					%>
								<dt>
								<a target="_blank" href="<%=request.getContextPath() %>/about/about!toAbout.htm?id=<%=twoMenuInfo.getId() %>&sign=<%=oneMenuInfo.getId() %>"><%=twoMenuInfo.getMenuName() %></a>
							   </dt>
					<%  } 
					} %>
			</dl>
			<%}%>
	<%}%>
		<dl class="mianR">
		<dd><a href="javascript:void(0)">更多</a></dd>
			<dt>	<a target="_blank" href="/about/about!toAbout.htm?id=136&sign=5">合作链接</a></dt>
			<dt><a href="http://www.epiao1616.com" target="_blank">人民大舞台票务网站</a>	</dt>	
		</dl>
        <div class="blank"></div>
        <div class="foot_c_b">
        	Copyright © 2013-2014 上海艺起来文化发展有限公司 版权所有　沪ICP备14021568号-2 
        </div>
<%}%>




