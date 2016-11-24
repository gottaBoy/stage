<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    
<%
   String type = request.getParameter("type");

%>

    <title><%=StageVariale.title%></title>
    <!--   task/addUserTask.jsp  -->
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
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/common.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js2/func.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js2/validate.js"></script>
	
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/address.js"></script>

	<script type="text/javascript">
	
		$(document).ready(function(){
			if("${userTask.provice}"!=""){
				initAddress('provice','city','${userTask.provice}','${userTask.city}');
			}else{
				initAddress("provice","city","无","");  
			}
		});
		

		function checknull(){
			var title =$("#title").val();
			if(title==""){
				$("#yzxx").text("");
				$("#yzxx").append("【任务名称】不能为空！");
				return false;
			}else if(title.length>200){
				$("#yzxx").text("");
				$("#yzxx").append("【任务名称】不能超过200个字符！");
				return false;
			}

			<%
				if("1".equals(type)){
					out.print("return true;");
				}
			%>


			var place=$("#place").val();
			var content=$("#content").val();
			var startDate=$("#startDate").val();
			var startTime=$("#startTime").val();
			var endDate=$("#endDate").val();
			var endTime=$("#endTime").val();
			var startDate1=$("#startDate1").val();
			var startTime1=$("#startTime1").val();
			var endDate1=$("#endDate1").val();
			var endTime1=$("#endTime1").val();
			var price=$("#price").val();
						      
			
			if(price==""){
				$("#yzxx").text("");
				$("#yzxx").append("【任务总预算】不能为空！");
				return false;
			} else {
				if(!DoWell.Valid.isIntegerUnsigned(price)) {
					$("#yzxx").text("");
					$("#yzxx").append("【任务总预算】必须为正整数！");
					return false;
				}
			}




			if(place==""){
				$("#yzxx").text("");
				$("#yzxx").append("【任务地点】不能为空！");
				return false;
			}
			
			if(place==""){}else if(place.length>256){
				$("#yzxx").append("【地点】不能超过256个字符！");
				return false;
			}
			
			
			if((startDate>endDate)||(startDate==endDate&&startTime>=endTime)){
			    $("#yzxx").text("");
				$("#yzxx").append("【开始时间】必须早于【结束时间】！");
				return false;
			}
			
			if((startDate1>endDate1)||(startDate1==endDate1&&startTime1>=endTime1)){
			    $("#yzxx").text("");
				$("#yzxx").append("【应征时间】必须早于【结束时间】！");
				return false;
			}

			if((endDate1>endDate)||(endDate1==endDate&&endTime1>=endTime)){
			    $("#yzxx").text("");
				$("#yzxx").append("【应征结束时间】必须早于【任务结束时间】！");
				return false;
			}

			if(content==""){
			    $("#yzxx").text("");
				$("#yzxx").append("【任务内容】不能为空！");
				return false;
			}else if(content.length>2000){
			    $("#yzxx").text("");
				$("#yzxx").append("【任务内容】不能超过2000个字符！");
				return false;
			}
			return true;
		}
	
		function addUserTask(){
			if(checknull()){
				$.ajax({
				   url:"<%=request.getContextPath() %>/member/task!addUserTask.htm",
				   type:'POST',
				   data:$("#userTaskForm").serialize(),
				   success:function(data){
					   window.parent.tishi("保存成功！");
				   }
				});
				
			}	
		}
	</script>
  </head>
  <body style="width: 520px;height: 560px">
	<form id="userTaskForm" method="post" action="" >

	<INPUT TYPE="hidden" NAME="type" value="<%=type%>">

		<div class="add_table_box">
        <table width="450" border="0" align="center" cellpadding="0" cellspacing="0" class="add__Popup_title">
            <tr>
                <td height="18"><%=HttpSessionHelper.getUserSession(request).getUserName() %> 任务发布</td>
            </tr>
        </table>
        <table width="530" border="0" align="center" cellpadding="0" cellspacing="0" class="add__Popup_con">
    <tr>
        <td  align="right" width="70"><font color=red>*</font>任务名称 </td>
        <td colspan="2"><input type="text" name="task.title" id="title" class="add_popup_input" style="width:230px"/></td>
		<td  style="padding-right: 20px">
		<%if(!"1".equals(type)){%>
		<font color=red>*</font>任务总预算
			 <input type="text" name="task.price" id="price" class="add_popup_input" style="width:50px;vertical-align: middle"/>&nbsp;&nbsp;元 
		<%}%>	 
			 </td>
    </tr>



    <tr>
        <td  align="right"><font color=red>*</font>任务所在地 </td>
        <td colspan="3">
                  <select  name="task.provice" id="provice" class="sel_jcxx"></select>
                  <select   name="task.city" id="city" class="sel_jcxx"></select>
</td>
    </tr>

<%if("1".equals(type)){%>
    <tr>
        <td  align="right"> 联系邮箱 </td>
        <td colspan="3">
                  <input type="text" name="task.email" id="email" class="add_popup_input" style="width:230px"/>
        </td>
    </tr>
    <tr>
        <td  align="right">  联系电话 </td>
        <td colspan="3">
                  <input type="text" name="task.phone" id="phone" class="add_popup_input" style="width:230px"/>
         </td>
    </tr>
    <tr>
        <td  align="right">   联系QQ </td>
        <td colspan="3">
                  <input type="text" name="task.qq" id="qq" class="add_popup_input" style="width:230px"/>
         </td>
    </tr>
<%}%>


	<%if(!"1".equals(type)){%>
    <tr>
         <td  align="right"><font color=red>*</font>详细地址 </td>
        <td colspan="3"><input type="text" name="task.place" id="place" class="add_popup_input" style="width:368px" /></td>
    </tr>


    <tr>
        <td align="right" width="61"><font color=red>*</font>任务时间</td>
        <%	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
					String dateTime=df.format(new Date()).substring(0,10);// new Date()为获取当前系统时间 
		         %>
        <td colspan=3 >
		<table width="158" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td><input type="text" name="startDate" id="startDate" class="add_popup_time" value="<%=dateTime %>" onclick="WdatePicker()" /></td>
                <td align="right"><select name="startTime" id="startTime">
                <%
						for(int i=0;i<24;i++){
							String timestr=(i<10)?"0"+i+":00":i+":00";
			   %>
                    <option value="<%=timestr%>" <%=timestr.equals("08:00")?"selected":""%>> 
                      <%=timestr%>
                    </option>
                 <%
					}
				%>
                </select></td>
				<td> 至 </td>
				 <td><input type="text" name="endDate" id="endDate" class="add_popup_time" value="<%=dateTime %>"  onclick="WdatePicker()" /></td>
                <td align="right"><select name="endTime" id="endTime">
                    <%
						for(int i=0;i<24;i++){
							String timestr=(i<10)?"0"+i+":00":i+":00";
			   %>
                    <option value="<%=timestr%>" <%=timestr.equals("08:00")?"selected":""%>> 
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
        <td align="right" width="61"><font color=red>*</font>应征时间</td>
        <td colspan=3 ><table width="158" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td><input type="text" name="startDate1" id="startDate1" class="add_popup_time" value="<%=dateTime %>" onclick="WdatePicker()" /></td>
                <td align="right"><select name="startTime1" id="startTime1">
                <%
						for(int i=0;i<24;i++){
							String timestr=(i<10)?"0"+i+":00":i+":00";
			   %>
                    <option value="<%=timestr%>" <%=timestr.equals("08:00")?"selected":""%>> 
                      <%=timestr%>
                    </option>
                 <%
					}
				%>
                </select></td>
				<td > 至 </td>
				<td><input type="text" name="endDate1" id="endDate1" class="add_popup_time" value="<%=dateTime %>"  onclick="WdatePicker()" /></td>
                <td align="right"><select name="endTime1" id="endTime1">
                    <%
						for(int i=0;i<24;i++){
							String timestr=(i<10)?"0"+i+":00":i+":00";
			   %>
                    <option value="<%=timestr%>" <%=timestr.equals("08:00")?"selected":""%>> 
                      <%=timestr%>
                    </option>
                 <%
					}
				%>
                </select></td>
            </tr>
        </table></td>
    </tr>
<%}%>


    <tr>
        <td align="right"><font color=red>*</font>任务内容</td>
        <td colspan="3"><textarea name="task.content" id="content" cols="45" rows="5" class="add_popup_textarea "></textarea></td>
        </tr>
    <tr>
        <td colspan="4"> <%if(!"1".equals(type)){%> <input type='button' value="添加人员需求信息" onclick="add_role();"> <%}%></td>
        </tr>
    <tr><td colspan=4 >
		<table id=defaultTable style="visibility:hidden;">
		</tr>
		<tr><td>人员名称</td><td>人员具体描述</td><td>人数</td><td>价格预算区间(元)</td><td></td>
		</tr>
		</table>
		</td>
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
                <td align="center">
					
				<a href="javascript:addUserTask();">
                	<img src="<%=request.getContextPath() %>/theme/images/nav_bc.jpg" width="60" height="28" /></a>
					
					</td>
             <!--     <td align="center"><img src="<%=request.getContextPath() %>/theme/images/nav_del.jpg" width="60" height="28" /></td>  -->
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