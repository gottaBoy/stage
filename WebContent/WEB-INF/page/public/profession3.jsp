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
	String felterValue = "";
	int switchId = Integer.parseInt(id);
	int sign = switchId - 1;
	int orderBySign = 0;
	switch (switchId) {
		case 0 ://机构
			felterValue = "org";
			break;
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

<script language="javascript">
 

function replaceImg(obj){
	var imgSrc = obj.src.replace('indexHeadImage','headImage');
	obj.src = imgSrc;
 
	obj.onerror=function(){
		obj.src = '<%=request.getContextPath() %>/theme/images/tu03.jpg';
		obj.onerror=null;  
	}
}


	function handleImgLoadError(oEvent,imgSrc){
		oEvent.srcElement.src=imgSrc;
		
		oEvent.srcElement.onerror=function(){
			oEvent.srcElement.src = '<%=request.getContextPath() %>/theme/images/tu03.jpg';
			oEvent.srcElement.onerror=null;  
		}
	}
</script>



    <div class="Cposition">
    	
<%if("9".equals(request.getParameter("prof"))){%>
	<h2>机构</h2><span>|</span><em>ORGANIZATION</em>
		<a  target='_blank' href="<%=request.getContextPath() %>/index/indexAction!toOrg.htm"><i>more</i><img src="<%=request.getContextPath() %>/theme/index/images/Cposition_more.jpg" width="14" height="14" /></a>
<%}else{%>
	<h2><%=StageVariale.getProfById(id)%></h2><span>|</span><em><%=StageVariale.getEnProfById(id)%></em>
		<a  target='_blank' href="<%=request.getContextPath() %>/index/indexAction!toFenlei.htm?orderBySign=<%=orderBySign %>&sign=<%=sign %>&filterValue=<%=felterValue %>"><i>more</i><img src="<%=request.getContextPath() %>/theme/index/images/Cposition_more.jpg" width="14" height="14" /></a>
<%}%>
		
    </div>

<%if("5".equals(request.getParameter("prof"))){%>
		</div>
		<div class="Column_Model">
			<div class="Column2">
				<div class="Column_c2">
<%}else if("3".equals(request.getParameter("prof"))){%>
		</div>
		<div class="Column_Music">
			<div class="Column2">
					<div class="Column_c2">
<%}else{%>
		<div class="Column">
			<div class="Column_c">
<%}%>

        	<ul>
 
<s:if test="#request.prof==9">
	<s:iterator value="#request.orgList" var="item" status="st">
            	<li>
                      <a  target='_blank'  href='<%=request.getContextPath() %>/index/orgListAction.htm?id=<s:property value="#item[1].userId"/>' >
                          <img  onerror="javascript:replaceImg(this)"  src="<%=request.getContextPath() %>/stageUpload/indexHeadImage/<s:property value="#item[1].userId"/>.png?date=<s:property value="#request.date"/>" width="178" height="178" /> 
                          <p>人气：<span><s:property value="#item[1].popularityTotal" /></span> </p>
						  <p class="pellips" title='<s:property value="#item[1].nickName" />(<s:property value="#item[1].provice"/><s:property value="#item[1].city"/>)'>昵称：
						  <s:property value="#item[1].nickName" /></p>
                          
                      </a>
                  </li>
	</s:iterator> 
</s:if>


	<s:iterator value="#request.newList" var="item" status="st">
            	<li style="height:266px;">
                      <a  target='_blank' href='<%=request.getContextPath() %>/index/presonList.htm?id=<s:property value="#item[0].userId"/>' >
                          <img  onerror="javascript:replaceImg(this)"  src="<%=request.getContextPath() %>/stageUpload/indexHeadImage/<s:property value="#item[0].userId"/>.png?date=<s:property value="#request.date"/>" width="178" height="178" /> 
                          <p   title='<s:property value="#item[0].nickName" />(<s:property value="#item[0].provice"/><s:property value="#item[0].city"/>)'>昵称：
						  <s:property value="#item[0].nickName" /></p>
                          <p>人气：<span><s:property value="#item[0].popularityTotal" /></span></p>
						  <p  
						  title='<s:iterator value="#item[2]" var="costItem" status="st2"> <s:if test="#costItem[0].keywords==''"><s:property value="#costItem[1].typeName" /></s:if><s:else><s:property value="#costItem[0].keywords" /></s:else></s:iterator>'>
						  职业：
						  <s:iterator value="#item[2]" var="costItem" status="st2">
								<s:if test="#costItem[0].keywords==''">
									<s:property value="#costItem[1].typeName" />
								</s:if>
								<s:else>
									<s:if test="#costItem[0].keywords.length()>=10">
											<s:property value="#costItem[0].keywords.substring(0,10)" />
									</s:if>
									<s:else>
											<s:property value="#costItem[0].keywords" />
									</s:else>
								</s:else>
						  </s:iterator>
						  </p>
 


                          

                      </a>
                  </li>
	</s:iterator>
            </ul>
     </div>
  </div>