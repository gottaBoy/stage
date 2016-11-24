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
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/idialog.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/zhezhao.css" />
	
 	<script type='text/javascript' src='<%=request.getContextPath() %>/dwr/interface/costDao.js'></script> 
	<script type='text/javascript' src='<%=request.getContextPath() %>/dwr/engine.js'></script>
	<script type='text/javascript' src='<%=request.getContextPath() %>/dwr/util.js'></script>

	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/common.js"></script>

	<script type="text/javascript">
	var userId="<%=HttpSessionHelper.getUserSession(ServletActionContext.getRequest()).getId()%>";			
	
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
	                             
	 				if(cost3_Id=='' || cost3_Id == -1){	 
	 				     if(cost2_Id=='' || cost2_Id == -1){
	 				     	document.getElementById("costInfo.profession").value=cost1_Id;
	 				     } else{
	 				     	document.getElementById("costInfo.profession").value=cost2_Id;
	 				     }					 					 
	 				}else{
	 					document.getElementById("costInfo.profession").value=cost3_Id;
	 				}
  	               var costId=document.getElementById("costInfo.profession").value;
					//alert(1);
	               $.post('<%=request.getContextPath()%>/member/cost!checkCostId.htm?costId='+costId,
						function(data){
						
							if(data==1){
								art.dialog.tips("您已添加该职业，不能再添加！");
							} else {
						        $.ajax({
								   url:"<%=request.getContextPath() %>/member/cost!saveCost.htm",
								   type:'POST',
								   data:$("#costForm").serialize(),
								   success:function(data1){
									   if(data1 == 1){
										   parent.getUserInfoCost();
										   parent.getUserInfo2();
				   						   parent.showContent(3);
										   art.dialog.close();
									   }
								   }
								});
							}
				        },"html");
		      	   } 
        }        
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
	      
	      var option1 = new Option("其他",  "-1");
	        //根据每组value和text标记的值创建一个option对象
	      try{
	      	  document.getElementById("cost2").add(option1);//将option对象添加到第二个下拉框中
	      }catch(e){
	      }
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
	      var option1 = new Option("其他",  "-1");
	        //根据每组value和text标记的值创建一个option对象
	      try{
	      	  document.getElementById("cost3").add(option1);//将option对象添加到第二个下拉框中
	      }catch(e){
	      }
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
        parent.maskshow();
    	queryCost1();
    
    }
		
	</script>
  </head>
  <body >
	<form id="costForm" name="costForm" action="member/cost!saveCost.htm" method="post">
	<input type="hidden" name="costInfo.id" id="costInfo.id" value="${costInfo.id }"/> 
	<input type="hidden" name="costInfo.userId" id="costInfo.userId" value="${costInfo.userId }"/> 
	<input type="hidden" name="costInfo.creatTime" id="costInfo.creatTime" value="${costInfo.creatTime }"/> 
	<input type="hidden" name="costInfo.orderNo" id="costInfo.orderNo" value="${orderNo }"/> 
	<input type="hidden" name="costInfo.isConsult" id="costInfo.isConsult" value="0"/> 
	
	
<div  style="height:450px;">
  <span class="zhezhaoClose" title="关闭"></span>
    

<div class="jineng">
<div class="jineng_left">
<h3>职业技能</h3>
<ul>
<li>
    <div class="name"> 职业：</div>
<table>
	<tr>
		<td>
			<select name="cost1" id="cost1"  onchange="change1();">
				<s:iterator value="#request.talentCategories" var="talent">
					<option value="<s:property value="#talent.id"/>"><s:property value="#talent.typeName"/></option>			       
				</s:iterator>
			</select>
		</td>
		<td> 
			<div id='div2' style="display: none">
				<select  name="cost2" id="cost2" onchange="change2();">
				</select> 
			</div> 
		</td>
		<td>
			<div id='div3' style="display: none">
				<select  name="cost3" id="cost3">
				</select>
			</div>
		</td>
	</tr>
</table>

</li>
<li>
    <div class="name"> 细分名称：</div>
    <input /><span>如箫、唢呐、埙、巴乌、芦笙等，多个细分项之间用逗号隔开，每个细分项不超过6个字。</span>
</li>
<li>
    <div class="name"> 价格：</div>
    <input class="duan" /> 
    <font style="font:normal 12px/32px 微软雅黑; height:32px;">(单位)场、次、小时、天等</font>
</li>
<li>
<div class="tianjia">亲，请合理填写您的职业价格，这将直接影响到客户与您的交易意向哦。</div>
</li>

<li>
<a href="#"></a>
</li>
</ul>
</div>
<div class="baocun2" style="text-align:center;width:100%;">
<a href="#"  style="margin-left:200px;text-decoration: none;" >保存</a> 
</div>
</div>
  

	
 


        </form>
  </body>
</html>