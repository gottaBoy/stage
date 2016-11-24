<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>





<ul style="color: #fff">


<s:iterator value="#request.costList" var="item" status="status">
<s:if test="#status.index<3">
<li style="font-weight: bold"><label style="color: #d85a80"><s:property value="#item[1].typeName"/>：</label>

<s:if test="#item[0].isConsult==1">面议</s:if>
<s:else><s:property value="#item[0].bprice"/> 元/<s:property value="#item[0].unit"/></s:else></li>
</s:if>

</s:iterator>

</ul>

