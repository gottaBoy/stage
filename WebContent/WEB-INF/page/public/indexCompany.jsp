<%@page import="com.smt.webapp.util.CommonUtil"%>
<%@page import="java.net.URLEncoder"%> 
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!--合作企业-->
<div class="hz" >
   <p class="hz1 l"><img src="theme/images2/tu22.jpg" width="5" height="234" /></p>
  <div class="hz2 l">
    <p ></p>
    <table width="100%">
    	<tr>
    		<td class="hz2-t">企业商城</td>
    		<td width="70"><a target="_blank" href="qyList1.htm">更多企业</a></td>
    	</tr>
    </table>
    <table style="margin-left:  10px;" >
   		<tr>
    <s:iterator value="#request.list1" var="item">
   		<td width="160" align="center">
   			<table>
   				<tr>
   					<td><a target="_blank" href="orgListAction.htm?id=<s:property value="#item[1].userId"/>"><img src="/stageUpload/headImage/<s:property value="#item[1].userId"/>.png" onerror="javascript:this.src='<%=request.getContextPath() %>/theme/images2/qylogo.jpg'"" height="150" width="150"/></td>
   				</tr>
   				<tr>
   					<td align="center">
   						<s:if test="#item[1].nickName.length()<10">
   							<s:property value="#item[1].nickName"/>
   						</s:if>
   						<s:else>
   							<s:property value="#item[1].nickName.substring(0,10)"/>..
   						</s:else>
   					</td>
   				</tr>
   				<tr>
   					<td align="center>
   						<s:if test="#item[0].rzState==3">
				         	<a style="color:#37bc07;font-size:12px;margin:0 10px"><img src="theme/images2/tu95.jpg" width="15" height="17" />&nbsp;&nbsp;实名认证</a>
				         	&nbsp;&nbsp;&nbsp;
				         	</s:if>
				         	<s:else>
				         		<a style="color:#cc0000;font-size:12px;margin:0 10px"><img src="theme/images2/tu95_1.jpg" width="15" height="17" />&nbsp;&nbsp;未认证</a>
				         	&nbsp;&nbsp;&nbsp;
			         	</s:else>
   					</td>
   				</tr>
   			</table>
   		</td>
    		
    </s:iterator>
    	</tr>
    </table>
   </div>
   <p class="hz1 l"><img src="theme/images2/tu23.jpg" width="5" height="234" /></p>
</div>