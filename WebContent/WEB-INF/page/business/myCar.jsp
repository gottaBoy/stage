<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 

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

	<script type="text/javascript">

	
		function CloseWin() 
		{ 
			art.dialog.close(); 
		 
		}
		
		function toBusinessUpdate(bqyUserId,id){
		   art.dialog.open('<%=request.getContextPath() %>/member/business!toPreOrder.htm?bqyUserId='+bqyUserId+'&id='+id,{width:680,height:455,resize: false});
	    }
	    
	    function delBusinessInfo(id){
	    	art.dialog({
		        icon: 'warning',
				content: '您确认删除吗？',
				ok: function () {
				
				    $.post('<%=request.getContextPath()%>/member/business!delBusinessInfo.htm?id='+id,
						function(data){
							if(data=="1"){
							//art.dialog.tips("删除成功!");
							parent.getMyCarCount();
							window.location.reload();
						}
					},"html");

					
				},
				cancel: true
			});
	    }
	    
	    function myCarSubmit(){
	    	art.dialog({
		        icon: 'warning',
				content: '您确认提交购物车内的所有订单吗？',
				ok: function () {
				
				    $.post('<%=request.getContextPath()%>/member/business!doMyCarSubmit.htm',
						function(data){
							if(data=="1"){
							parent.getMyCarCount();
							//parent.toMyBusiness();	//方法写在head.jsp
   	    					CloseWin();
						}
					},"html");

					
				},
				cancel: true
			});
	    }
		
		function myCarNOSubmit(){
	    	art.dialog({
		        icon: 'warning',
				content: '您购物车还没有订单，请下单后再次提交？',
				ok: function () {art.dialog.close();},
				cancel: true
			});
	    }
	    
	    //继续选择
	    function continueDo(){
	        parent.getMyCarCount();
	    	CloseWin();
	    }
</script>
  </head>
 
 
<body >
<table width="800" border="0" align="center" cellpadding="0" cellspacing="0" class="order_con" >
    <tr>
        <td height="32" background="<%=request.getContextPath() %>/theme/images/order_titbj.jpg" class="order_title">我的购物车</td>
    </tr>
    <tr>
        <td height="520"><table width="798" border="0" align="center" cellpadding="0" cellspacing="0" class="my_car ">
            <tr>
                <td width="148" height="36"  align="center" bgcolor="#EEEEEE">艺人</td>
                <td width="170" align="center" bgcolor="#EEEEEE">职业</td>
                <td width="160" align="center" bgcolor="#EEEEEE">时间 </td>
                <td width="160" align="center" bgcolor="#EEEEEE">地点</td>
                <td width="80" align="center" bgcolor="#EEEEEE">价格</td>
                <td width="80" align="center" bgcolor="#EEEEEE">操作</td>
            </tr>
            <s:iterator value="#request.myCarList" var="myCar">
            <tr >
                <td height="50" align="center" bgcolor="#FFFDEE" class="bor_car"> <a href="javaScript:toBusinessUpdate(<s:property value="#myCar[0].bqyUserId"/>,<s:property value="#myCar[0].id"/>)" class="qy_link"><s:property value="#myCar[2]"/></a></td>
                <td align="center" bgcolor="#FFFDEE" class="bor_car">
                	<s:if test="#myCar[0].profession.length()>=20">
	         		<s:property value='#myCar[0].profession.substring(0,20)'/><b>...</b>
	         		</s:if>     
             		<s:else><s:property value="#myCar[0].profession"/></s:else> 
             	</td>
                 <td align="center" bgcolor="#FFFDEE" class="bor_car"><s:property value="#myCar[0].beginDate"/>&nbsp;至&nbsp;<s:property value="#myCar[0].endDate"/></td>
                <td align="center" bgcolor="#FFFDEE" class="bor_car"><s:property value="#myCar[0].address"/></td>
                <td align="center" bgcolor="#FFFDEE" class="bor_car">￥<fmt:formatNumber pattern="0.00"><s:property value="#myCar[0].price"/></fmt:formatNumber></td>
                <td align="center" bgcolor="#FFFDEE" class="bor_car"><a href="javaScript:delBusinessInfo(<s:property value="#myCar[0].id"/>);" class="del_link">删除</a></td>
            </tr>
            </s:iterator>
            <tr >
                <td height="60" colspan="7" align="right" bgcolor="#F5F5F5" class="bor_car02"><table width="300" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td width="74" align="right" class="car_zj">总计：</td>
                        <td width="226" align="left" class="car_zj_jg">￥<fmt:formatNumber pattern="0.00"><s:property value="#request.myCarSumAmount"/></fmt:formatNumber></td>
                        </tr>
                </table></td>
                </tr>
        </table>
            <table width="798" border="0" align="center" cellpadding="0" cellspacing="0" style="margin-top:20px;">
                <tr>
                    <td width="39">&nbsp;</td>
                    <td width="635" height="36"><a href="javaScript:continueDo();"><img src="<%=request.getContextPath() %>/theme/images/car_jxgw.jpg" width="80" height="34" /></a></td>
                    <%List list=(List)request.getAttribute("myCarList");
                    	if(list.size()>0){
                     %>
                    <td width="124"><a href="javaScript:myCarSubmit();"><img src="<%=request.getContextPath() %>/theme/images/order_ddtj.jpg" width="100" height="36" /></a></td>
                	<%}else{ %>
                	<td width="124"><a href="javaScript:myCarNOSubmit();"><img src="<%=request.getContextPath() %>/theme/images/order_ddtj.jpg" width="100" height="36" /></a></td>
                	<%} %>
                </tr>
        </table></td>
    </tr>
</table>
 </body>
</html>
