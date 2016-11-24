<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="org.apache.struts2.ServletActionContext"%>
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
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/common.js"></script>

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
	    
	    

        function doSubmit(){
	    	if(checknull()){
				   var cost1_Id =  document.getElementById("cost1").value;
				    var cost2_Id =  document.getElementById("cost2").value;
	                var cost3_Id =  document.getElementById("cost3").value;	    
	                             
	 				if(cost3_Id==''){	 
	 				     if(cost2_Id==''){document.getElementById("costInfo.profession").value=cost1_Id;	}
	 				     else{document.getElementById("costInfo.profession").value=cost2_Id;}					 					 
	 				}else{
	 					document.getElementById("costInfo.profession").value=cost3_Id;
	 				}
         	 

	        var costId=document.getElementById("costInfo.profession").value;
					//alert(1);
	               $.post('<%=request.getContextPath()%>/member/cost!checkCostId.htm?userId=<s:property value="#request.userId"/>&&costId='+costId,
						function(data){
							if(data==1){
								art.dialog.tips("您已添加该职业，不能再添加！");}
							else{
							  $.ajax({
								   url:"<%=request.getContextPath() %>/member/cost!saveOrgCost.htm?userId="+<s:property value="#request.userId"/>,
								   type:'POST',
								   data:$("#costForm").serialize(),
								   success:function(data){
									   if(data=="1"){
										art.dialog.close(); 
									   }
								   }
								}); 
							}
						});
	        	   
				  

	        }  
        }
        
       var userId="<%=HttpSessionHelper.getUserSession(ServletActionContext.getRequest()).getId()%>";
			
	function queryCost1()
	{
		var cost1_Id = $("#cost1").val();
		//默认为不选择
		if(cost1_Id == 0)
		{		
			document.getElementById("cost2").options.length=0;
			document.getElementById("cost3").options.length=0;
		}
		else
		{  
		   costDao.getTalentByFlag(cost1_Id,userId,callback_1);
		}	
	}
	
	function callback_1(data1)
	{
     document.getElementById("cost2").options.length=0;

      //每次获得新的数据的时候先把每二个下拉框架的长度清0
      if(data1.length>0){
	 
	      document.getElementById("div2").style.display="block";
	      for(var i=0;i< data1.length;i ++){
	        var value = data1[i].id;
	        var text = data1[i].typeName;
	        var option = new Option(text, value);
	        //根据每组value和text标记的值创建一个option对象
	        try{
	          document.getElementById("cost2").add(option);//将option对象添加到第二个下拉框中
	        }catch(e){
	        }
	      }
	      //同时关联第三级
	      var cost2_Id =  document.getElementById("cost2").value;
	      costDao.getTalentByFlag(cost2_Id,userId,callback_2);
	      
	  }else{ 	 
	  	   document.getElementById("div2").style.display="none";
	  	   document.getElementById("div3").style.display="none";
	  }

	}
	

	function queryCost2()
	{
   	  var cost2_Id =  document.getElementById("cost2").value;
      costDao.getTalentByFlag(cost2_Id,userId,callback_2);
	}
	function callback_2(data2)
	{
      //每次获得新的数据的时候先把每三个下拉框架的长度清0
	  document.getElementById("cost3").options.length=0;

	  if(data2.length>0){
	 
	      document.getElementById("div3").style.display="block";
	      for(var i=0;i< data2.length;i ++){
	        var value = data2[i].id;
	        var text = data2[i].typeName;
	        var option = new Option(text, value);
	        //根据每组value和text标记的值创建一个option对象
	        try{
	          document.getElementById("cost3").add(option);//将option对象添加到第三个下拉框中
	        }catch(e){
	        }
	      }

	  }else{ 
	 
	  	   document.getElementById("div3").style.display="none";
	  }
     
	}
	
	function change1()
	{
		queryCost1();
	}
	
	function change2()
	{
		queryCost2();
	}

    window.onload=function(){
    
    	queryCost1();
    
    }
		
	</script>
  </head>
  <body>
	<form id="costForm" name="costForm" action="member/cost!saveOrgCost.htm?userId=<s:property value="#request.userId"/>" method="post">
	<input type="hidden" name="costInfo.id" id="costInfo.id" value="${costInfo.id }"/> 
	<input type="hidden" name="costInfo.userId" id="costInfo.userId" value="${costInfo.userId }"/> 
	<input type="hidden" name="costInfo.creatTime" id="costInfo.creatTime" value="${costInfo.creatTime }"/> 
	<input type="hidden" name="costInfo.orderNo" id="costInfo.orderNo" value="${orderNo }"/> 
	<input type="hidden" name="costInfo.isConsult" id="costInfo.isConsult" value="0"/> 
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

                   <table>
                   <tr>
                      <td>
                      	<select name="cost1" id="cost1"  onchange="change1();">
					       <s:iterator value="#request.talentCategories" var="talent">
					       <option value="<s:property value="#talent.id"/>"><s:property value="#talent.typeName"/></option>			       
					       </s:iterator>
				       </select>
                      </td>
                      <td> <div id='div2' style="display: none">
                      	 	<select  name="cost2" id="cost2" onchange="change2();">
               				</select>  </div> 
                      </td>
                      <td>
                      		<div id='div3' style="display: none">
			               <select  name="cost3" id="cost3">
			               </select>
					       
					       </div>
                      </td>
                   </tr>
                         
                   </table>
        
		       <input type="hidden" name="costInfo.profession" id="costInfo.profession" style="width:300px;"   class="add_popup_input" /></td>
		    </tr>
		    <tr>
		        <td  align="right">关键字 </td>
		        <td colspan="3" >
		       
		        <input type="text" name="costInfo.keywords" id="costInfo.keywords" maxlength="100"  style="width:360px;"  value="${costInfo.keywords }"  class="add_popup_input" /></td>
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