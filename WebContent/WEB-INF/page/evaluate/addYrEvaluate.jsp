<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <!--  page\evaluate\addYrEvaluate.jsp -->
    <title><%=StageVariale.title%></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>


	<script type="text/javascript">
	
	
		function CloseWin() 
		{ 
			art.dialog.close(); 
		 
		} 
		window.onload = function (){
			if('${flag}'==1){
				//$("#sp_general").css("display","none");
				//$("#sp_poor").css("display","none");
				//$("#star1").css("display","none");
				//$("#star2").css("display","none");
		        //$("#star3").css("display","none");
			}
		};

        function doSubmit(){
			var evaluation = $("input[name=evalRadio]:checked").val();
				$("#pjGrade").val(evaluation);
            	$.ajax({
				   url:"<%=request.getContextPath() %>/member/evaluate!doAddYrEvaluate.htm?evaluation="+evaluation,
				   type:'POST',
				   data:$("#evaluateForm").serialize(),
				   success:function(data){
					   if(data=="1"){
						   	window.parent.tishi("保存成功！");
						   	art.dialog.close();
					   } 
				   }
				});
        }
        
        function clickRadio(radioValue){
         	 $("#pjGrade").val(radioValue);
		}

	</script>
  </head>
  <body>
	<form id="evaluateForm" name="evaluateForm" action="member/evaluate!doAddYrEvaluate.htm" method="post">
	<input type="hidden" name="evaluate.businessId" value="${businessId }"/> 
	<s:if test="#evaluate.pjGrade==null">
		<input type="hidden" name="evaluate.pjGrade" id="pjGrade" value="${evaluate.pjGrade}"/> 
	</s:if>
	<s:else>
		<input type="hidden" name="evaluate.pjGrade" id="pjGrade" value="1"/> 
	</s:else>
		
	<table width="520" border="0" align="center" cellpadding="0" cellspacing="0" >
    <tr>
        <td height="340" bgcolor="#FFFFFF">
        
        <!-- 弹出框内容 开始 -->
        <div class="add_table_box">
        <table width="450" border="0" align="center" cellpadding="0" cellspacing="0" class="add__Popup_title">
            <tr>
                <td height="18">交易评价</td>
            </tr>
        </table>
        <table width="460" border="0" align="center" cellpadding="0" cellspacing="0" class="add__Popup_con">
           <tr>
                <td  align="right" >评价：</td>
                <td  align="left" colspan="3" >
				<s:if test="#request.flag==1 || #request.flag==2">

					<s:if test="evaluate.pjGrade==1"><span id="sp_good"><input type="radio" name="evalRadio" id="good" value="1" onclick="clickRadio(this.value)"  checked="checked"  />好&nbsp;&nbsp;&nbsp;</span></s:if>
					<s:else><span id="sp_good"><input type="radio" name="evalRadio" id="good" value="1" onclick="clickRadio(this.value)" />好&nbsp;&nbsp;&nbsp;</span>
					</s:else>
                	
					<s:if test="evaluate.pjGrade==0"><span id="sp_general"><input type="radio" name="evalRadio" id="general" value="0" onclick="clickRadio(this.value)"  checked="checked"/>一般&nbsp;&nbsp;&nbsp;</span></s:if>
					<s:else><span id="sp_good"><span id="sp_general"><input type="radio" name="evalRadio" id="general" value="0" onclick="clickRadio(this.value)" />一般&nbsp;&nbsp;&nbsp;</span>
					</s:else>

					<s:if test="evaluate.pjGrade==-1"><span id="sp_poor"><input type="radio" name="evalRadio" id="poor" value="-1" onclick="clickRadio(this.value)" checked="checked" />差&nbsp;&nbsp;&nbsp;</span></s:if>
					<s:else><span id="sp_good"><span id="sp_poor"><input type="radio" name="evalRadio" id="poor" value="-1" onclick="clickRadio(this.value)" />差&nbsp;&nbsp;&nbsp;</span>
					</s:else>
                	
                	
				</s:if>
				<s:else>
                	<span id="sp_good"><input type="radio" name="evalRadio" id="good" value="1"  checked="checked" onclick="clickRadio(this.value)"/>好&nbsp;&nbsp;&nbsp;</span>
                	<span id="sp_general"><input type="radio" name="evalRadio" id="general" value="0" onclick="clickRadio(this.value)" />一般&nbsp;&nbsp;&nbsp;</span>
                	<span id="sp_poor"><input type="radio" name="evalRadio" id="poor" value="-1" onclick="clickRadio(this.value)" />差&nbsp;&nbsp;&nbsp;</span>
				</s:else>
                </td>
                
            </tr>
		    <tr>
		        <td align="right">内容：</td>
		        <td align="left" colspan="3"><textarea name="evaluate.pjContent" id="pjContent" cols="20" rows="4" class="add_popup_textarea "><s:if test="evaluate.pjContent!=null"> ${evaluate.pjContent} </s:if><s:else>【不想说】</s:else></textarea></td>
		     </tr>
		     <tr>
		       <td align="right"></td>
		       <td colspan="3" style="color:#F00;" id="yzxx"></td>
		     </tr>
		    <tr>
		        <td colspan="4" align="center">
				<s:if test="#request.flag==0 || #request.flag==1">
		        <a href="javascript:doSubmit();"><img src="<%=request.getContextPath() %>/theme/images/nav_bc.jpg" width="60" height="28" /></a>
				</s:if>
		        <a href="javascript:CloseWin();"><img src="<%=request.getContextPath() %>/theme/images/nav_qx.jpg" width="60" height="28" /></a>
		        
		        </td>
		        </tr>
		</table>
        

        </div>
         <!-- 弹出框内容 结束 -->
        
        </td>
    </tr>
</table>
	
 
        </form>
  </body>
</html>