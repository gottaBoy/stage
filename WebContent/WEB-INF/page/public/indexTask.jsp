<%@page import="com.smt.webapp.util.CommonUtil"%>
<%@page import="java.net.URLEncoder"%> 
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<div class="tpqh3-t"><span>工作机会</span><div class="r"><img src="theme/images2/wo2.png" width="20" height="14" style="cursor: pointer;" onclick="TurnLeft()"/><img src="theme/images2/wo1.png" style="cursor: pointer;" width="20" height="14" onclick="TurnRight()"/><a target="_blank" href="<%=request.getContextPath() %>/taskMore/taskMore!toTaskMore.htm">查看更多</a></div></div>
<div id="con">
  <ul class="task">
    <s:iterator value="#request.list" var="item" status="index">
    <li>
      <div class="l task1">
        <div class="l">
          <s:if test="#item[1].isOrg==1">
            <a href="orgListAction.htm?id=<s:property value="#item[2].userId"/>" >
              <img height="60" width="60" src="/stageUpload/headImage/<s:property value='#item[2].userId'/>.png" onerror="javascript:this.src='<%=request.getContextPath() %>/theme/images/no_img.jpg'" />
            </a>
          </s:if>
          <s:else>
            <a href="<%=request.getContextPath() %>/presonList.htm?id=<s:property value="#item[2].userId"/>" >
              <img height="60" width="60" src="/stageUpload/headImage/<s:property value='#item[2].userId'/>.png" onerror="javascript:this.src='<%=request.getContextPath() %>/theme/images/no_img.jpg'" />
            </a>
          </s:else>
        </div>
        <div class="task2">
          <div>
            <s:if test="#item[1].isOrg==1">
              <a style="color: black;" href="orgListAction.htm?id=<s:property value='#item[2].userId'/>" ><s:property value="#item[2].nickName.length()>20?#item[2].nickName.substring(0,20)+'...':#item[2].nickName"/></a>
            </s:if>
            <s:else>
              <a class="zxrw_xq" href="<%=request.getContextPath() %>/presonList.htm?id=<s:property value="#item[2].userId"/>" ><s:property value="#item[2].nickName.length()>20?#item[2].nickName.substring(0,20)+'...':#item[2].nickName"/></a>
            </s:else>
          </div>
          <div><a  href="<%=request.getContextPath() %>/taskMore/taskMore!toTaskMoreDetail.htm?id=<s:property value="#item[0].id"/>" class="zxrw_xq"><s:property value="#item[0].title.length()>20?#item[0].title.substring(0,20)+'...':#item[0].title"/></a></div>
          <div>地点：<s:property value="#item[0].place.length()>15?#item[0].place.substring(0,15)+'...':#item[0].place"/></div>
        </div>
        <div class="task3"><a href="<%=request.getContextPath() %>/taskMore/taskMore!toTaskMoreDetail.htm?id=<s:property value="#item[0].id"/>" class="zxrw_xq" >查看详情</a></div>
        
        <s:if test="#index.index<33">
        <div class="task4"></div>
        </s:if>
      </div>
      
      </li>
    </s:iterator>
  </ul>

</div>

