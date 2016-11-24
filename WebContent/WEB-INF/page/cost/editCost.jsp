<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    
    <title><%=StageVariale.title%></title>
    <style>
html,body {
	margin: 0; /* Remove body margin/padding */
	padding: 0;
	overflow: auto; /* Remove scroll bars on browser window */
	font: 12px "Lucida Grande", "Lucida Sans Unicode", Tahoma, Verdana;
}
</style>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="description" content="<%=StageVariale.description%>">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />

	<script type='text/javascript'src='<%=request.getContextPath() %>/dwr/interface/costDao.js'></script> 
	<script type='text/javascript' src='<%=request.getContextPath() %>/dwr/engine.js'></script>
	<script type='text/javascript' src='<%=request.getContextPath() %>/dwr/util.js'></script>

	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/common.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>

	<script type="text/javascript">
	
		function checknull(){
		
		    //if(document.getElementById("sfmy").checked==true)
			//{
			//    return true;
			//}
			
			var bprice=$("#costInfo\\.bprice").val();
			var eprice=$("#costInfo\\.eprice").val();
 			var unit=$("#costInfo\\.unit").val();

			if(bprice==""){
				$("#yzxx").text("");
				$("#yzxx").append("【价格】不能为空！");
				return false;
			}
			
			if(eprice==""){
				$("#yzxx").text("");
				$("#yzxx").append("【价格】不能为空！");
				return false;
			}
			
			if(parseFloat(bprice)>parseFloat(eprice)){
			    $("#yzxx").text("");
			    $("#yzxx").append("【价格区间】填写错误！");
				return false;
			}
			
			if(unit==""){
				$("#yzxx").text("");
				$("#yzxx").append("【单位】不能为空！");
				return false;
			}
			
			return true;
		}
	    
	    
		var isSubmit = false;
        function doSubmit(){
	    	if(checknull()){
				if(!isSubmit){  
	        	   isSubmit = true; 
	        	   $.ajax({
					   url:"<%=request.getContextPath() %>/member/cost!saveCost.htm",
					   type:'POST',
					   data:$("#costForm").serialize(),
					   success:function(data1){
						   if(data1 == 1){
							   parent.getUserInfoCost();
							   art.dialog.close();
						   }
					   }
					});
	      	   } 
	        }  
        }
        $().ready(function(){
           
           
        	 //if(document.getElementById("costInfo.isConsult").value=='1')
        	 //{
        	 //  document.getElementById("sfmy").checked=true;
        	 //  document.getElementById("price_div").style.display="none";               
        	 //}else
        	 //{
        	 //	document.getElementById("sfmy").checked=false;
        	 // }

    	});
    
					
	</script>
  </head>
  <body>
	<form id="costForm" name="costForm" action="member/cost!saveCost.htm" method="post">
	<input type="hidden" name="costInfo.id " value="${costInfo.id }"/> 
	<input type="hidden" name="costInfo.userId" value="${costInfo.userId }"/> 
	<input type="hidden" name="costInfo.creatTime" value="${costInfo.creatTime }"/> 
	<input type="hidden" name="costInfo.orderNo" value="${orderNo }"/> 
	<input type="hidden" name="costInfo.isConsult" id="costInfo.isConsult" value="${costInfo.isConsult }"/> 
	<table width="520" border="0" align="center" cellpadding="0" cellspacing="0" >
    <tr>
        <td height="360" bgcolor="#FFFFFF">
        
        <!-- 弹出框内容 开始 -->
        <div class="add_table_box">
        <table width="450" border="0" align="center" cellpadding="0" cellspacing="0" class="add__Popup_title">
            <tr>
                <td height="18">第${orderNo }职业</td>
            </tr>
        </table>
        <table width="460" border="0" align="center" cellpadding="0" cellspacing="0" class="add__Popup_con">
		    <tr>
		        <td width="70" align="right"><font color=red>*</font>职业</td>
		        <td id="proTd" colspan="3" >
						<b>${cost }</b>
                   
        
		       <input type="hidden" name="costInfo.profession" id="costInfo.profession" style="width:300px;"   value="${costInfo.profession }"  class="add_popup_input" /></td>
		    </tr>
		    <tr>
		        <td  align="right">关键字 </td>
		        <td colspan="3" >
		       
		        <input type="text" name="costInfo.keywords" id="costInfo.keywords"   maxlength="100" style="width:360px;"  value="${costInfo.keywords }"  class="add_popup_input" /></td>
		    </tr>
		    <%--
		    <tr>
		        <td  align="right"> </td>
		        <td colspan="3" >
		       <INPUT  onclick="divDisplay('price_div')" type=checkbox name="sfmy" id="sfmy">是否面议</td>
		    </tr>
		     --%>
		    <tr>
		        <td colspan="4"  align="center">
		         <div id="price_div" style=" DISPLAY: block">
		              <table>
		              		<tr >
						        <td align="right"><font color=red>*</font>价格区间</td>
						        <td  colspan="3">
						        <input type="text" name="costInfo.bprice" id="costInfo.bprice" maxlength="10" style="width:50px;"  onkeydown="checkKeyForFloat(this.value,event)"  value="${costInfo.bprice }"  class="add_popup_input" />
						        - <input type="text" name="costInfo.eprice" id="costInfo.eprice" maxlength="10" style="width:50px;"  value="${costInfo.eprice }" onkeydown="checkKeyForFloat(this.value,event)"  class="add_popup_input" />(元)
						       /<input type="text" name="costInfo.unit"  id="costInfo.unit" maxlength="10" style="width:35px;"  value="${costInfo.unit }"  class="add_popup_input" />(单位:<font color=red>场、次、小时、天等</font>)
						        
						        </td>
						     </tr>		              
		              </table>
		         </div>
		   
		        </td>
		    </tr>
		     <tr>
		       <td align="right"></td>
		       <td colspan="3" style="color:#F00;" id="yzxx"></td>
		     </tr>
		    <tr>
		        <td colspan="4" align="center">
		        <a href="javascript:doSubmit();"><img src="<%=request.getContextPath() %>/theme/images/nav_bc.jpg" width="60" height="28" /></a>
		        <a href="javascript:art.dialog.close();"><img src="<%=request.getContextPath() %>/theme/images/nav_qx.jpg" width="60" height="28" /></a>
		        
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