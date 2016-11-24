<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.smt.entity.*"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    
    <title><%=StageVariale.title%></title>
            <!--   task/updateUserTask2.jsp  -->
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
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js2/func.js"></script>

	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/address.js"></script>

	<script type="text/javascript">
		$(document).ready(function(){
			if("${userTask.provice}"!=""){
				initAddress('provice','city','${userTask.provice}','${userTask.city}');
			}else{
				initAddress("provice","city","上海","");  
			}
		});


		function checknull(){
			var title =$("#title").val();
			var place=$("#place").val();
			var content=$("#content").val();
			var startDate=$("#startDate").val();
			var startTime=$("#startTime").val();
			var endDate=$("#endDate").val();
			var endTime=$("#endTime").val();
			var price=$("#price").val();
			
			if(title==""){
				$("#yzxx").text("");
				$("#yzxx").append("【标题】不能为空！");
				return false;
			}else if(title.length>200){
				$("#yzxx").text("");
				$("#yzxx").append("【标题】不能超过200个字符！");
				return false;
			}
			
			if(price==""){
				$("#yzxx").text("");
				$("#yzxx").append("【赏金】不能为空！");
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
			
			if(content==""){}else if(content.length>1000){
			    $("#yzxx").text("");
				$("#yzxx").append("【内容】不能超过1000个字符！");
				return false;
			}
			return true;
		}
		
		function updateUserTask(){
			if(checknull()){
				$("#userTaskForm").attr("action","<%=request.getContextPath() %>/member/task!updateUserTask.htm");
				var form = $(document.getElementById('userTaskForm'));
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
				window.parent.tishi("保存成功！");
			}
		}
		
		function delUserTask(){
		     art.dialog({
		        icon: 'warning',
				content: '删除当前任务，您确定吗？',
				ok: function () {
					$("#userTaskForm").attr("action","<%=request.getContextPath() %>/member/task!delUserTask.htm");
					$("#userTaskForm").submit();
					window.parent.tishi("删除任务成功！");
				},
				cancel: true
		});
		}
		//结束任务
		function overUserTask(status,old){
			if(old == 3){
				alert("当前任务已通过审核!");
				return;
			}
		    	art.dialog({
		        icon: 'warning',
				content: '你确定要通过当前任务吗？',
				ok: function () {

						$.post('<%=request.getContextPath() %>/member/task!verify.htm?status='+status+"&task.id="+$("#id").val(),
								function(data){
									if(data=="1"){							
									window.parent.tishi("通过任务成功！");
								}
							},"html");


					//$("#userTaskForm").attr("action","<%=request.getContextPath() %>/member/task!verify.htm?status="+status);
					//$("#userTaskForm").submit();
					//window.parent.tishi("通过任务成功！");
				},
				cancel: true
		});
		}
	</script>
  </head>
  <body style="width: 520px;height: 400px">
   <%
   SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
   TAppTask userTask=(TAppTask)request.getAttribute("userTask");
   List<TAppTaskRole> taskRoles=(List<TAppTaskRole>)request.getAttribute("userTaskRole");

                String startTime=userTask.getStartDate().substring(11,16);
                String endTime=userTask.getEndDate().substring(11,16);
				String applyStartDate="";
				String startTime1="";
				if(userTask.getApplyStartDate() !=null) {
					applyStartDate= df.format(userTask.getApplyStartDate());
					startTime1=applyStartDate.substring(11,16);
				}
				String applyEndDate="";
				String endTime1="";
				if(userTask.getApplyEndDate()!=null) {
					applyEndDate=df.format(userTask.getApplyEndDate());
					endTime1=applyEndDate.substring(11,16);
				}
                 %>
	<form id="userTaskForm" method="post" action="" >
		<input type="hidden" name="task.id" id="id" value="<%=userTask.getId() %>"/>
		<input type="hidden" name="task.creatTime" value="<%=userTask.getCreatTime() %>"/>
		<input type="hidden" name="task.userId" value="<%=userTask.getUserId() %>"/>
		<div class="add_table_box">
        <table width="450" border="0" align="center" cellpadding="0" cellspacing="0" class="add__Popup_title">
            <tr>
                <td height="18"><%=HttpSessionHelper.getUserSession(request).getUserName() %> 任务编辑</td>
            </tr>
        </table>
        <table width="540" border="0" align="center" cellpadding="0" cellspacing="0" class="add__Popup_con">
    <tr>
        <td  align="right" width="70"><font color=red>*</font>任务名称 </td>
        <td colspan="2"><input type="text" name="task.title" id="title" value="<%=userTask.getTitle() %>" class="add_popup_input" style="width: 200px"/></td>
    	<td  align="right" style="padding-right: 30px">
    		<font color=red>*</font>任务总预算 
    			<input type="text" name="task.price" id="price" value="<%=userTask.getPrice() %>" class="add_popup_input" style="width:50px;vertical-align: middle" onkeydown="checkKeyForFloat(this.value,event)"/>&nbsp;&nbsp;元 </td>
    </tr>

    <tr>
        <td  align="right"><font color=red>*</font>任务所在地 </td>
        <td colspan="3">
                  <select  name="task.provice" id="provice" class="sel_jcxx"></select>
                  <select   name="task.city" id="city" class="sel_jcxx"></select>
</td>
    </tr>


    <tr>
        <td  align="right">详细地址 </td>
        <td colspan="3"><input type="text" name="task.place" id="place" value="<%=userTask.getPlace() %>" class="add_popup_input" style="width: 368px"/></td>
    </tr>
    <tr>
        <td align="right" width="61">开始时间</td>
        <%
					String dateTime=df.format(new Date()).substring(0,10);// new Date()为获取当前系统时间 
		         %>
        <td width="162"><table width="158" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td><input type="text" name="startDate" id="startDate" class="add_popup_time" value="<%=userTask.getStartDate().substring(0,10) %>" onclick="WdatePicker()" /></td>
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
        <td align="right" width="58">结束时间</td>
        <td width="179"><table width="158" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td><input type="text" name="endDate" id="endDate" class="add_popup_time" value="<%=userTask.getEndDate().substring(0,10) %>" onclick="WdatePicker()" /></td>
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
        <td align="right" width="61"><font color=red>*</font>应征时间</td>
        <td width="162"><table width="158" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td><input type="text" name="startDate1" id="startDate1" class="add_popup_time" value="<%=(applyStartDate.length()>0?applyStartDate.substring(0,10):"") %>" onclick="WdatePicker()" /></td>
                <td align="right"><select name="startTime1" id="startTime1">
                <%
						for(int i=8;i<24;i++){
							String timestr=(i<10)?"0"+i+":00":i+":00";
			   %>
                    <option value="<%=timestr%>" <%=timestr.equals(startTime1)?"selected":""%>> 
                      <%=timestr%>
                    </option>
                 <%
					}
				%>
                </select></td>
            </tr>
        </table></td>
        <td align="right" width="58">结束时间</td>
        <td width="179"><table width="158" border="0" align="left" cellpadding="0" cellspacing="0">
            <tr>
                <td><input type="text" name="endDate1" id="endDate1" class="add_popup_time" value="<%=(applyEndDate.length()>0?applyEndDate.substring(0,10):"") %>"  onclick="WdatePicker()" /></td>
                <td align="right"><select name="endTime1" id="endTime1">
                    <%
						for(int i=8;i<24;i++){
							String timestr=(i<10)?"0"+i+":00":i+":00";
			   %>
                    <option value="<%=timestr%>" <%=timestr.equals(endTime1)?"selected":""%>> 
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
        <td align="right">任务内容</td>
        <td colspan="3"><textarea name="task.content" id="content" cols="45" rows="5" class="add_popup_textarea "><%=userTask.getContent() %></textarea></td>
        </tr>
    <tr>
        <td colspan="4"><input type='button' value="添加人员需求信息" onclick="add_role();"></td>
        </tr>
    <tr><td colspan=4 >
		<table id=defaultTable style="visibility:hidden;">
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
        <td ><table width="300" border="0" align="center" cellpadding="0" cellspacing="0" class="add_popup_button">
            <tr>
<%--              <s:if test="#request.active!='-1'"> --%>
<!--                 <td align="center"><a href="javascript:updateUserTask();"> -->
<%--                 	<img src="<%=request.getContextPath() %>/theme/images/nav_bc.jpg" width="60" height="28" /></a></td> --%>
<!--                 <td align="center"><a href="javascript:delUserTask(); "> -->
<%--                 	<img src="<%=request.getContextPath() %>/theme/images/nav_del.jpg" width="60" height="28" /></a></td>  --%>
<!--                 <td align="center"><a href="javascript:overUserTask(); "> -->
<%--                 	<img src="<%=request.getContextPath() %>/theme/images/nav_js.jpg" width="60" height="28" /></a></td> --%>
<%--              </s:if>   	 --%>
<%--                 <td align="center"><a href="javascript:overUserTask(2,<%=userTask.getStatus()%>); "> --%>
<%--                 	<img src="<%=request.getContextPath() %>/theme/images/nav_qx.jpg" width="60" height="28" /></a></td> --%>
                	<td align="center"><a href="javascript:overUserTask(3,<%=userTask.getStatus()%>); "> -->
                	<img src="<%=request.getContextPath() %>/theme/images2/nav_js.jpg" width="60" height="28" /></a></td>
            </tr>
        </table></td>
        </tr>
</table>


        </div>
        </form>
<script>
<%
if(taskRoles!=null) {
	for(TAppTaskRole ttr:taskRoles) {
		out.println("add_role('"+ttr.getId()+"','"+ttr.getRoleName()+"','"+ttr.getRoleDesc()+"','"+ttr.getRoleNum()+"','"+(ttr.getPriceLow()!=null?ttr.getPriceLow():"")+"','"+(ttr.getPriceHigh()!=null?ttr.getPriceHigh():"")+"');\n");
	}
}
%>
</script>
  </body>
</html>