<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    
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

<style> 
body,div,ul,li,p{margin:0;padding:0;}
body{color:#666;font:12px/1.5 Arial;}
ul{list-style-type:none;}
#star1{position:relative;width:350px;margin:10px auto;}
#star1 ul,#star1 span{float:left;display:inline;height:19px;line-height:19px;}
#star1 ul{margin:0 10px;}
#star1 li{float:left;width:24px;cursor:pointer;text-indent:-9999px;background:url(<%=request.getContextPath()%>/theme/images/star.png) no-repeat;}
#star1 strong{color:#f60;padding-left:10px;}
#star1 li.on{background-position:0 -28px;}
#star1 p{position:absolute;top:20px;width:159px;height:60px;display:none;background:url(<%=request.getContextPath()%>/theme/images/icon.gif) no-repeat;padding:7px 10px 0;}
#star1 p em{color:#f60;display:block;font-style:normal;}

#star2{position:relative;width:350px;margin:10px auto;}
#star2 ul,#star2 span{float:left;display:inline;height:19px;line-height:19px;}
#star2 ul{margin:0 10px;}
#star2 li{float:left;width:24px;cursor:pointer;text-indent:-9999px;background:url(<%=request.getContextPath()%>/theme/images/star.png) no-repeat;}
#star2 strong{color:#f60;padding-left:10px;}
#star2 li.on{background-position:0 -28px;}
#star2 p{position:absolute;top:20px;width:159px;height:60px;display:none;background:url(<%=request.getContextPath()%>/theme/images/icon.gif) no-repeat;padding:7px 10px 0;}
#star2 p em{color:#f60;display:block;font-style:normal;}

#star3{position:relative;width:350px;margin:10px auto;}
#star3 ul,#star3 span{float:left;display:inline;height:19px;line-height:19px;}
#star3 ul{margin:0 10px;}
#star3 li{float:left;width:24px;cursor:pointer;text-indent:-9999px;background:url(<%=request.getContextPath()%>/theme/images/star.png) no-repeat;}
#star3 strong{color:#f60;padding-left:10px;}
#star3 li.on{background-position:0 -28px;}
#star3 p{position:absolute;top:20px;width:159px;height:60px;display:none;background:url(<%=request.getContextPath()%>/theme/images/icon.gif) no-repeat;padding:7px 10px 0;}
#star3 p em{color:#f60;display:block;font-style:normal;}
</style>
	<script type="text/javascript">
	
	window.onload = function ()
{
	var oStar1 = document.getElementById("star1");
	var aLi1 = oStar1.getElementsByTagName("li");
	var oUl1 = oStar1.getElementsByTagName("ul")[0];
	var oSpan1 = oStar1.getElementsByTagName("span")[1];
	var oP1 = oStar1.getElementsByTagName("p")[0];
	var aMsg1 = [
				"很不满意|差得太离谱，与卖家描述的严重不符，非常不满",
				"不满意|部分有破损，与卖家描述的不符，不满意",
				"一般|质量一般，没有卖家描述的那么好",
				"满意|质量不错，与卖家描述的基本一致，还是挺满意的",
				"非常满意|质量非常好，与卖家描述的完全一致，非常满意"
				]
				
	var oStar2 = document.getElementById("star2");
	var aLi2 = oStar2.getElementsByTagName("li");
	var oUl2 = oStar2.getElementsByTagName("ul")[0];
	var oSpan2 = oStar2.getElementsByTagName("span")[1];
	var oP2 = oStar2.getElementsByTagName("p")[0];
	var aMsg2 = [
				"很不满意|差得太离谱，与卖家描述的严重不符，非常不满",
				"不满意|部分有破损，与卖家描述的不符，不满意",
				"一般|质量一般，没有卖家描述的那么好",
				"满意|质量不错，与卖家描述的基本一致，还是挺满意的",
				"非常满意|质量非常好，与卖家描述的完全一致，非常满意"
				]
	
	var oStar3 = document.getElementById("star3");
	var aLi3 = oStar3.getElementsByTagName("li");
	var oUl3 = oStar3.getElementsByTagName("ul")[0];
	var oSpan3 = oStar3.getElementsByTagName("span")[1];
	var oP3 = oStar3.getElementsByTagName("p")[0];
	var aMsg3 = [
				"很不满意|差得太离谱，与卖家描述的严重不符，非常不满",
				"不满意|部分有破损，与卖家描述的不符，不满意",
				"一般|质量一般，没有卖家描述的那么好",
				"满意|质量不错，与卖家描述的基本一致，还是挺满意的",
				"非常满意|质量非常好，与卖家描述的完全一致，非常满意"
				]
	var i = iScore1 = iStar1 = 0;
	var iScore2 = iStar2 = 0;
	var iScore3 = iStar3 = 0;
	for (i = 1; i <= 5; i++)
	{
		aLi1[i - 1].index = i;
		aLi2[i - 1].index = i;
		aLi3[i - 1].index = i;
		//鼠标移过显示分数
		aLi1[i - 1].onmouseover = function ()
		{
			fnPoint1(this.index);
			//浮动层显示
			oP1.style.display = "none";
			//计算浮动层位置
			oP1.style.left = oUl1.offsetLeft + this.index * this.offsetWidth - 104 + "px";
			//匹配浮动层文字内容
			oP1.innerHTML = "<em><b>" + this.index + "</b> 分 " + aMsg1[this.index - 1].match(/(.+)\|/)[1] + "</em>" + aMsg1[this.index - 1].match(/\|(.+)/)[1]
		};
		aLi2[i - 1].onmouseover = function ()
		{
			fnPoint2(this.index);
			//浮动层显示
			oP2.style.display = "none";
			//计算浮动层位置
			oP2.style.left = oUl2.offsetLeft + this.index * this.offsetWidth - 104 + "px";
			//匹配浮动层文字内容
			oP2.innerHTML = "<em><b>" + this.index + "</b> 分 " + aMsg2[this.index - 1].match(/(.+)\|/)[1] + "</em>" + aMsg2[this.index - 1].match(/\|(.+)/)[1]
		};
		aLi3[i - 1].onmouseover = function ()
		{
			fnPoint3(this.index);
			//浮动层显示
			oP3.style.display = "none";
			//计算浮动层位置
			oP3.style.left = oUl3.offsetLeft + this.index * this.offsetWidth - 104 + "px";
			//匹配浮动层文字内容
			oP3.innerHTML = "<em><b>" + this.index + "</b> 分 " + aMsg3[this.index - 1].match(/(.+)\|/)[1] + "</em>" + aMsg3[this.index - 1].match(/\|(.+)/)[1]
		};
		//鼠标离开后恢复上次评分
		aLi1[i - 1].onmouseout = function ()
		{
			fnPoint1();
			//关闭浮动层
			oP1.style.display = "none"
		};
		aLi2[i - 1].onmouseout = function ()
		{
			fnPoint2();
			//关闭浮动层
			oP2.style.display = "none"
		};
		aLi3[i - 1].onmouseout = function ()
		{
			fnPoint3();
			//关闭浮动层
			oP3.style.display = "none"
		};
		//点击后进行评分处理
		aLi1[i - 1].onclick = function ()
		{
			iStar1 = this.index;
			oP1.style.display = "none";
			//oSpan.innerHTML = "<strong>" + (this.index) + " 分</strong> (" + aMsg[this.index - 1].match(/\|(.+)/)[1] + ")"
			oSpan1.innerHTML = "<strong>" + (this.index) + " 分</strong> (" + aMsg1[this.index - 1].match(/(.+)\|/)[1] + ")"
			$("#msGrade").val(iStar1);
		}
		aLi2[i - 1].onclick = function ()
		{
			iStar2 = this.index;
			oP2.style.display = "none";
			//oSpan.innerHTML = "<strong>" + (this.index) + " 分</strong> (" + aMsg[this.index - 1].match(/\|(.+)/)[1] + ")"
			oSpan2.innerHTML = "<strong>" + (this.index) + " 分</strong> (" + aMsg2[this.index - 1].match(/(.+)\|/)[1] + ")"
			$("#tdGrade").val(iStar2);
		}
		aLi3[i - 1].onclick = function ()
		{
			iStar3 = this.index;
			oP3.style.display = "none";
			//oSpan.innerHTML = "<strong>" + (this.index) + " 分</strong> (" + aMsg[this.index - 1].match(/\|(.+)/)[1] + ")"
			oSpan3.innerHTML = "<strong>" + (this.index) + " 分</strong> (" + aMsg3[this.index - 1].match(/(.+)\|/)[1] + ")"
			$("#zlGrade").val(iStar3);
		}
	}
	//评分处理
	function fnPoint1(iArg)
	{
		//分数赋值
		iScore1 = iArg || iStar1;
		for (i = 0; i < aLi1.length; i++) aLi1[i].className = i < iScore1 ? "on" : "";	
	}
	function fnPoint2(iArg)
	{
		//分数赋值
		iScore2 = iArg || iStar2;
		for (i = 0; i < aLi2.length; i++) aLi2[i].className = i < iScore2 ? "on" : "";	
	}
	function fnPoint3(iArg)
	{
		//分数赋值
		iScore3 = iArg || iStar3;
		for (i = 0; i < aLi3.length; i++) aLi3[i].className = i < iScore3 ? "on" : "";	
	}
	
	if('${flag}'>0){
		fnPoint1(${evaluate.msGrade});
		aLi1[${evaluate.msGrade}-1].click();
		fnPoint2(${evaluate.tdGrade});
		aLi2[${evaluate.tdGrade}-1].click();
		fnPoint3(${evaluate.zlGrade});
		aLi3[${evaluate.zlGrade}-1].click();
		/*
		$("#sp_general").css("display","none");
		$("#sp_poor").css("display","none");
		$("#star1").css("display","none");
		$("#star2").css("display","none");
        $("#star3").css("display","none");
		*/
	}
};
			
		function CloseWin() 
		{ 
			art.dialog.close(); 
		 
		} 
		

        function doSubmit(){
        	var evaluation = $("input[name=evalRadio]:checked").val();
			$("#pjGrade").val(evaluation);
        	if('${flag}'==0){
        		 var msGrade=$("#msGrade").val();
	            var tdGrade=$("#tdGrade").val();
	            var zlGrade=$("#zlGrade").val();
	           
	            if(msGrade==""){
	            	art.dialog.tips("请对【描述相符】评价等级！");
	            	return;
	            }
	            if(tdGrade==""){
	            	art.dialog.tips("请对【工作态度】评价等级！");
	            	return;
	            }
	            if(zlGrade==""){
	            	art.dialog.tips("请对【完成质量】评价等级！");
	            	return;
	            }
        	}
           
           	$.ajax({
				   url:"<%=request.getContextPath() %>/member/evaluate!doAddEvaluate.htm?evaluation="+evaluation+"&flag="+${flag},
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
		
        function clickRadio1(radioValue, key){
			if(key == 1)
	         	 $("#msGrade").val(radioValue);
			else if (key==2)
	         	 $("#tdGrade").val(radioValue);
			else if (key==3)
	         	 $("#zlGrade").val(radioValue);
		}
		

	</script>
  </head>
  <body>
	<form id="evaluateForm" name="evaluateForm" action="member/evaluate!doAddEvaluate.htm" method="post">
	<input type="hidden" name="evaluate.businessId" value="${businessId }"/> 
	<s:if test="#evaluate.pjGrade==null">
		<input type="hidden" name="evaluate.pjGrade" id="pjGrade" value="${evaluate.pjGrade}"/> 
	</s:if>
	<s:else>
		<input type="hidden" name="evaluate.pjGrade" id="pjGrade" value="1"/> 
	</s:else>
	
	<input type="hidden" name="evaluate.msGrade" id="msGrade" value="${evaluate.msGrade}" /> 
	<input type="hidden" name="evaluate.tdGrade" id="tdGrade" value="${evaluate.tdGrade}" /> 
	<input type="hidden" name="evaluate.zlGrade" id="zlGrade" value="${evaluate.zlGrade}" /> 
	
	<table width="520" border="0" align="center" cellpadding="0" cellspacing="0" >
    <tr>
        <td height="360" bgcolor="#FFFFFF">
        
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
		        
		        <td align="left" colspan="4">
		        	<div id="star1">
		        		<span>描述相符：</span>
					    <ul>
					        <li><a href="javascript:clickRadio1(1, 1);">1</a></li>
					        <li><a href="javascript:clickRadio1(2, 1);">2</a></li>
					        <li><a href="javascript:clickRadio1(3, 1);">3</a></li>
					        <li><a href="javascript:clickRadio1(4, 1);">4</a></li>
					        <li><a href="javascript:clickRadio1(5, 1);">5</a></li>
					    </ul>
					    <span></span>
					    <p></p>
					</div>
				</td>
		     </tr>
		      <tr>
		         
		         <td align="left" colspan="4">
			        <div id="star2">
			        	<span>工作态度：</span>
					    <ul>
					        <li><a href="javascript:clickRadio1(1, 2);">1</a></li>
					        <li><a href="javascript:clickRadio1(2, 2);">2</a></li>
					        <li><a href="javascript:clickRadio1(3, 2);">3</a></li>
					        <li><a href="javascript:clickRadio1(4, 2);">4</a></li>
					        <li><a href="javascript:clickRadio1(5, 2);">5</a></li>
					    </ul>
					    <span></span>
					    <p></p>
					</div>
				</td>
		     </tr>
		      <tr>
		        
		        <td align="left" colspan="4">
			        <div id="star3">
			        	<span>完成质量：</span>
					    <ul>
					        <li><a href="javascript:clickRadio1(1, 3);">1</a></li>
					        <li><a href="javascript:clickRadio1(2, 3);">2</a></li>
					        <li><a href="javascript:clickRadio1(3, 3);">3</a></li>
					        <li><a href="javascript:clickRadio1(4, 3);">4</a></li>
					        <li><a href="javascript:clickRadio1(5, 3);">5</a></li>
					    </ul>
					    <span></span>
					    <p></p>
					</div>
				</td>
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