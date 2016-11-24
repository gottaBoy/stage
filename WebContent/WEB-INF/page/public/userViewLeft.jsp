<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	UserSession userSession = HttpSessionHelper.getUserSession(request) ;
%>
 <s:if test="#request.nowId==#request.userId">
 	<div onmouseover="changeCss(this,1,1)" onmouseout="changeCss(this,2,1)" title="编辑"onclick="updatePro(<s:property value="#request.id"/>,1)">
 		<div class="showCss" style="display: none;width: 280px;height: 320px;" id="pre">
			<table width="100%" style="height: 320px;">
				<tr>
					<td style="font-size: 14px;color: #eeeeee;font-weight: bold;" align="center">编辑</td>
				</tr>
			</table>
		</div>
 </s:if>
 <s:else>
 	<div>
 </s:else>
<ul class="gr-nex1-left1">
            <li class="gezl" style="font-weight: bold;">
          		<table>
          			<tr>
          				<td width="190">个人资料</td>
          				<td > <a href="javascript:sendMessage();"><img src="theme/images2/tu205.png" width="72" height="21"/></a></td>
          			</tr>
          		</table>  
            </li>
            <li style="font-weight: bold;">手机:&nbsp;&nbsp;
			 <%
                if(userSession==null){
             %>
               请登录后查看
             <%
				} else {
             %><s:property value="#request.userInfo.mobile"/>
            <!--
             <s:if test="#request.nowId==#request.userId">
             	<s:property value="#request.userInfo.mobile"/>
             	
             </s:if>
             <s:else>
             	<s:if test="#request.userInfo.mobileRadio==1">
	            	<a onmouseover="setTimeout(showdetails1,100);" onmouseout="setTimeout(hidedetails1,100)"><s:property value="#request.userInfo.mobile.substring(0,6)"/>*****</a>
	            </s:if>
	            <s:elseif test="#request.userInfo.mobileRadio==2">
	            	<s:property value="#request.userInfo.mobile"/>
	            </s:elseif>
	            <s:else>
	            	<s:if test="#request.friend==1">
	            		<a onmouseover="setTimeout(showdetails1,100);" onmouseout="setTimeout(hidedetails1,100)"><s:property value="#request.userInfo.mobile.substring(0,6)"/>*****</a>
	                </s:if>
	                <s:elseif test="#request.friend==2">
	                    <s:property value="#request.userInfo.mobile"/>
	                </s:elseif>
	            </s:else>
             </s:else>
           	-->
             <%
				}
             %>
		   </li>
            <li style="font-weight: bold;">QQ:&nbsp;&nbsp;
            <%
                if(userSession==null){
             %>
               请登录后查看
             <%
				} else {
             %>
             <s:property value="#request.userInfo.qq"/>
<!--
              <s:if test="#request.nowId==#request.userId">
              	<s:property value="#request.userInfo.qq"/>
              </s:if>
              <s:else>
              	 <s:if test="#request.userInfo.qqRadio==1">
	            	<a onmouseover="setTimeout(showdetails1,100);" onmouseout="setTimeout(hidedetails1,100)"><s:property value="#request.userInfo.qq.substring(0,4)"/>****</a>
	            </s:if>
	            <s:elseif test="#request.userInfo.qqRadio==2">
	            	<s:property value="#request.userInfo.qq"/>
	            </s:elseif>
	            <s:else>
	            	<s:if test="#request.friend==1">
	            	<a onmouseover="setTimeout(showdetails1,100);" onmouseout="setTimeout(hidedetails1,100)"><s:property value="#request.userInfo.qq.substring(0,4)"/>****</a>
	                </s:if>
	                <s:elseif test="#request.friend==2">
	                    <s:property value="#request.userInfo.qq"/>
	                </s:elseif>
	            </s:else>
              </s:else>
         -->
             <%
				}
             %>

            </li>
             <li>出生日期:&nbsp;&nbsp; <s:property value="#request.userInfo.birthday"/></li>
            <li>星座:&nbsp;&nbsp;${constellation}</li>
            <li>所在地:&nbsp;&nbsp;<s:property value="#request.userInfo.provice"/>&nbsp;&nbsp;<s:property value="#request.userInfo.city"/></li>
            <li>身高:&nbsp;&nbsp;<s:property value="#request.userInfo.height"/>cm</li>
            <li>体重:&nbsp;&nbsp;<s:property value="#request.userInfo.weight"/>kg</li>
            <li>三围:&nbsp;&nbsp;<s:property value="#request.userInfo.heartSize"/>&nbsp;<span class="shu_line">|</span>&nbsp;<s:property value="#request.userInfo.waistSize"/>&nbsp;<span 
class="shu_line">|</span>&nbsp;<s:property value="#request.userInfo.bottocksSize"/></li>
            <li>血型:&nbsp;&nbsp;<s:property value="#request.userInfo.booldType"/></li>
            
            <!--<li>手机:&nbsp;&nbsp;
			 <%
                if(userSession==null){
             %>
               请登录后查看
             <%
				} else {
             %>
            <s:if test="#request.userInfo.mobileRadio==1">
            	
            </s:if>
            <s:elseif test="#request.userInfo.mobileRadio==2">
            	<s:property value="#request.userInfo.mobile"/>
            </s:elseif>
            <s:else>
            	<s:if test="#request.friend==1">
            	
                </s:if>
                <s:elseif test="#request.friend==2">
                    <s:property value="#request.userInfo.mobile"/>
                </s:elseif>
            </s:else>
             <%
				}
             %>
		   </li>
            <li>QQ:&nbsp;&nbsp;
            <%
                if(userSession==null){
             %>
               请登录后查看
             <%
				} else {
             %>
            <s:if test="#request.userInfo.qqRadio==1">
            	
            </s:if>
            <s:elseif test="#request.userInfo.qqRadio==2">
            	<s:property value="#request.userInfo.qq"/>
            </s:elseif>
            <s:else>
            	<s:if test="#request.friend==1">
            	
                </s:if>
                <s:elseif test="#request.friend==2">
                    <s:property value="#request.userInfo.qq"/>
                </s:elseif>
            </s:else>
             <%
				}
             %>
            </li>-->
<!--             <li>头发颜色:&nbsp;&nbsp;黑</li> -->
<!--             <li>鞋码:&nbsp;&nbsp;35</li> -->
</ul>
</div>