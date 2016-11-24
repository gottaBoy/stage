<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="pg" uri="/page-tags"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    
    <title><%=StageVariale.title%></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/global_layout.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css" />
	<link href="<%=request.getContextPath() %>/theme/css/page.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/imagerManager.js"></script>
		<link rel="stylesheet" href="<%=request.getContextPath() %>/theme/kindeditor/themes/default/default.css" />
	<link rel="stylesheet" href="<%=request.getContextPath() %>/theme/kindeditor/plugins/code/prettify.css" />
	<script type="text/javascript" language="javascript"  src="<%=request.getContextPath() %>/theme/kindeditor/kindeditor-all-min.js"></script>
	<script type="text/javascript" language="javascript"  src="<%=request.getContextPath() %>/theme/kindeditor/lang/zh_CN.js"></script>
	<script type="text/javascript" language="javascript"  src="<%=request.getContextPath() %>/theme/kindeditor/plugins/code/prettify.js"></script>

<style> 
body,div,ul,li,p{margin:0;padding:0;}
body{color:#666;font:12px/1.5 Arial;}
ul{list-style-type:none;}

</style>
	<script type="text/javascript">
	function doSubmit(){
			$.ajax({
				   url:"<%=request.getContextPath() %>/member/evaluate!addSkillEvaluate.htm?skillId="+${skillId},
				   type:'POST',
				   data:$("#evaluateForm").serialize(),
				   success:function(data){
							
					   if(data=="1"){
					   //alert("jiayou");
						   //	location.reload();
						   window.location.href=window.location.href;
					   } 
				   }
				});
	}

	</script>
  </head>
  <body>
	 <table width="98%" border="0" cellpadding="0" cellspacing="0">
         <tr>
         	<td style="border-bottom:1px solid #ccc" height="30" colspan="2">
         		<span style="font-size:20px;color:#550000">评论详情</span>
         	</td>
         </tr>
          <s:iterator value="#request.sList" var="evaluate">
           <tr>
            <td width="380" height="30" style="vertical-align: middle;"><s:property value="#evaluate[0].content"/></td>
            <td width="160" height="30" style="vertical-align: middle;" align="right"><s:property value="#evaluate[1].nickName"/>&nbsp;</td>
          </tr>
           <tr >
            <td style="border-bottom:1px solid #ccc" height="30" style="vertical-align: middle;"><s:property value="#evaluate[0].createtime"/></td>
            <td style="border-bottom:1px solid #ccc" height="30" align="right" id="grade_<s:property value="#evaluate[0].id"/>"></td>
            <input type="hidden" id="gradeInput_<s:property value="#evaluate[0].id"/>" value="<s:property value="#evaluate[1].grade"/>"/>
          </tr>
          <script type="text/javascript">
				var grade = document.getElementById("gradeInput_<s:property value="#evaluate[0].id"/>").value;
				var imgG1 = '<img src=\"../theme/images2/m21.gif\" />&nbsp;';
				var imgG2 = '<img src=\"../theme/images2/m22.gif\" />&nbsp;';
				var imgG3 = '<img src=\"../theme/images2/m23.gif\" />&nbsp;';
				if(grade<=3&&grade!=null){
					for(var j = 0; j < grade; j++) {
						$("#grade_<s:property value="#evaluate[0].id"/>").append(imgG1);
					}
				}else if(grade>3&&grade<=6){
					for(var j = 0; j < (grade-3); j++) {
						$("#grade_<s:property value="#evaluate[0].id"/>").append(imgG2);
					}
				}else{
					for(var j = 0; j < (grade-6); j++) {
						$("#grade_<s:property value="#evaluate[0].id"/>").append(imgG3);
					}
				}
			
		</script>	
          </s:iterator>
          <tr>
            <td height="30" colspan="2" align="left"> 
            <table width="540" border="0" align="center" cellpadding="0" cellspacing="0" class="page" style="margin-top: 0px;">
			    <tr>
			        <td align="center"><pg:pages  pageNo='${pageNumP}' rowCount ="5"  url="presonList!addEvaluate.htm" params="skillId=${skillId}"  total='${totalP}' ></pg:pages></td>
			    </tr>
			</table>
		</td>
           </tr>
        </table>
        <form id="evaluateForm" name="evaluateForm" action="member/evaluate!addSkillEvaluate.htm" method="post">
         <table width="98%" border="0" cellpadding="0" cellspacing="0">
         	<tr>
         		<td width="80%">
         			 <textarea name="skillEvaluate.content" id="content" cols="20" rows="4" class="add_popup_textarea "></textarea>
         		</td>
         		<td style="vertical-align: middle;">
         			<a href="javascript:doSubmit();"><img src="<%=request.getContextPath() %>/theme/images/nav_bc.jpg" width="60" height="28" /></a>
         		</td>
         	</tr>
         </table>
         </form>
  </body>
</html>