<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.smt.entity.TAppScheduleInfo"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript">
		
		function checknull(){
			var title =$("#title").val();
			var address=$("#address").val();
			var content=$("#content").val();
			var startDate=$("#startDate").val();
			var startTime=$("#startTime").val();
			var endDate=$("#endDate").val();
			var endTime=$("#endTime").val();
			
			if(title==""){
				$("#yzxx").text("");
				$("#yzxx").append("【标题】不能为空！");
				return false;
			}else if(title.length>200){
				$("#yzxx").text("");
				$("#yzxx").append("【标题】不能超过200个字符！");
				return false;
			}
			
			if(address==""){}else if(address.length>256){
				$("#yzxx").append("【地址】不能超过256个字符！");
				return false;
			}
			
			if((startDate>endDate)||(startDate==endDate&&startTime>=endTime)){
			    $("#yzxx").text("");
				$("#yzxx").append("【开始时间】必须早于【结束时间】！");
				return false;
			}
			
			if(content==""){}else if(content.length>1000){
			    $("#yzxx").text("");
				$("#yzxx").append("【内容】不能超过1000个字符！");
				return false;
			}
			return true;
		}
		
		function updateScheduleInfo(){
			var startDate=$("#startDate").val();
			var startTime=$("#startTime").val();
			var endDate=$("#endDate").val();
			var endTime=$("#endTime").val();
			var id=$("#id").val();
			var startDateTime=startDate+" "+startTime;
			var endDateTime=endDate+" "+endTime;
			
			$.post('<%=request.getContextPath()%>/member/scheduleInfo!checkStartDate.htm?userId=<s:property value="#request.userId"/>&&startDate='+startDateTime+'&endDate='+endDateTime+'&id='+id,
				function(data){
					if(data == 1){
						//验证
						if(checknull()){
							$("#scheduleInfoForm").attr("action","<%=request.getContextPath() %>/member/scheduleInfo!updateScheduleInfo.htm");
							$.ajax({
							   url:"<%=request.getContextPath() %>/member/scheduleInfo!updateScheduleInfo.htm",
							   type:'POST',
							   data:$("#scheduleInfoForm").serialize(),
							   success:function(data){
								   if("" == '<s:property value="#request.userId"/>'){
										window.parent.tishi("保存成功！");
									}
									else{
										window.parent.frames[1].tishi("保存成功！");
									}
							   }
							}); 
				   			
						}
					}else{
						 $("#yzxx").text("");
						$("#yzxx").append("【档期时间】与其他档期的时间重叠，请重新选择！");
					}
				}
				,"html");
			
			
		}
		
		function delScheduleInfo(){
		     art.dialog({
		        icon: 'warning',
				content: '删除当前信息，您确定吗？',
				ok: function () {
					$("#scheduleInfoForm").attr("action","<%=request.getContextPath() %>/member/scheduleInfo!delScheduleInfo.htm");
					var form = $(document.getElementById('scheduleInfoForm'));
			        //获取浏览器参数
			        var browserName = navigator.userAgent.toLowerCase();
			        if (/chrome/i.test(browserName) && /webkit/i.test(browserName) && /mozilla/i.test(browserName)) {
			        //chrome浏览器
			        var tmp = form.attr('action');
			            $.post(tmp, form.serialize());
			        }else {
			            //执行SUBMIT  
			           form.submit();   
			    	} 
					//$("#scheduleInfoForm").submit();
					if("" == '<s:property value="#request.userId"/>'){
						window.parent.tishi("删除成功！");
						}
					else{
						window.parent.frames[1].tishi("删除成功！");
					}
				},
				cancel: true
		});
		}
	</script>
  </head>
  <body style="width: 520px;height: 370px">
   <%TAppScheduleInfo scheduleInfo=(TAppScheduleInfo)request.getAttribute("scheduleInfo");
                String startTime=scheduleInfo.getStartDate().substring(11,16);
                String endTime=scheduleInfo.getEndDate().substring(11,16);
                 %>
	<form id="scheduleInfoForm" method="post" action="" >
		<input type="hidden" name="scheduleInfo.id" id="id" value="<%=scheduleInfo.getId() %>"/>
		<input type="hidden" name="scheduleInfo.creatTime" value="<%=scheduleInfo.getCreatTime() %>"/>
		<input type="hidden" name="scheduleInfo.userId" value="<%=scheduleInfo.getUserId() %>"/>
		<div class="add_table_box">
        <table width="450" border="0" align="center" cellpadding="0" cellspacing="0" class="add__Popup_title">
            <tr>
                <td height="18">档期安排</td>
            </tr>
        </table>
        <table width="460" border="0" align="center" cellpadding="0" cellspacing="0" class="add__Popup_con">
    <tr>
        <td width="61" align="right"><font color=red>*</font>标题 </td>
        <td width="162"><input type="text" name="scheduleInfo.title" id="title" value="<%=scheduleInfo.getTitle() %>" class="add_popup_input" /></td>
        <td width="58" align="right">地点 </td>
        <td width="179"><input type="text" name="scheduleInfo.address" id="address" value="<%=scheduleInfo.getAddress() %>" class="add_popup_input" /></td>
    </tr>
    <tr>
        <td align="right">开始时间</td>
        <%	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
					String dateTime=df.format(new Date()).substring(0,10);// new Date()为获取当前系统时间 
		         %>
        <td><table width="158" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td><input type="text" name="startDate" id="startDate" class="add_popup_time" value="<%=scheduleInfo.getStartDate().substring(0,10) %>" onclick="WdatePicker()" /></td>
                <td align="right"><select name="startTime" id="startTime">
                <%
						for(int i=8;i<24;i++){
							String timestr=(i<10)?"0"+i+":00":i+":00";
			   %>
                    <option value="<%=timestr%>" <%=timestr.equals(startTime)?"selected":""%>> 
                      <%=timestr%>
                    </option>
                 <%
					}
				%>
                </select></td>
            </tr>
        </table></td>
        <td align="right">结束时间</td>
        <td><table width="158" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td><input type="text" name="endDate" id="endDate" class="add_popup_time" value="<%=scheduleInfo.getEndDate().substring(0,10) %>" onclick="WdatePicker()" /></td>
                <td align="right"><select name="endTime" id="endTime">
                    <%
						for(int i=8;i<24;i++){
							String timestr=(i<10)?"0"+i+":00":i+":00";
			   %>
                    <option value="<%=timestr%>" <%=timestr.equals(endTime)?"selected":""%>> 
                      <%=timestr%>
                    </option>
                 <%
					}
				%>
                </select></td>
            </tr>
        </table></td>
    </tr>
    <tr>
        <td align="right">内容</td>
        <td colspan="3"><textarea name="scheduleInfo.content" id="content" cols="45" rows="5" class="add_popup_textarea "><%=scheduleInfo.getContent() %></textarea></td>
        </tr>
   </table>
    <table width="400" border="0" align="center" cellpadding="0" cellspacing="0" style="margin:5px auto;">
            <tr>
                <td width="31">&nbsp;</td>
                <td width="369" style="height:26px; line-height:26px; color:#F00;" id="yzxx"></td>
            </tr>
    <tr>
        <td>&nbsp;</td>
        <td ><table width="220" border="0" align="center" cellpadding="0" cellspacing="0" class="add_popup_button">
            <tr>
                <td align="center"><a href="javascript:updateScheduleInfo();">
                	<img src="<%=request.getContextPath() %>/theme/images/nav_bc.jpg" width="60" height="28" /></a></td>
                <td align="center"><a href="javascript:delScheduleInfo(); ">
                	<img src="<%=request.getContextPath() %>/theme/images/nav_del.jpg" width="60" height="28" /></a></td> 
                <td align="center"><a href="javascript:art.dialog.close(); ">
                	<img src="<%=request.getContextPath() %>/theme/images/nav_qx.jpg" width="60" height="28" /></a></td>
            </tr>
        </table></td>
        </tr>
</table>
        

        </div>
        </form>
  </body>
</html>