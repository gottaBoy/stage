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
	<script type="text/javascript" src="<%=request.getContextPath() %>/theme/js2/upload/swfupload.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/theme/js2/upload/handlers.js"></script>

<script type="text/javascript">

	function CloseWin() 
	{  
		parent.location.href=parent.document.location;
		art.dialog.close(); 
	 
	} 
	

  	   
var upload1;

function startUploadFile(){
	upload1.setUploadURL("<%=request.getContextPath() %>/member/business!uploadFile.htm?id=" + $("#orderId").val());
	upload1.startUpload();
}

$(function() {
	upload1 = new SWFUpload({
		upload_url: "",
		post_params: {"SESSID" : "file"},
		file_post_name: "file",
		
		// File Upload Settings
		file_size_limit : "5 MB",	// 1000MB
		file_types : "*.jpg;*.gif;*.pdf;*.swf;*.png;*.txt;*.doc;*.docx",
		file_types_description : "jpg ,gif ,pdf ,swf ,png, txt, doc, docx",
		file_upload_limit : "0",
						
		file_queue_error_handler : fileQueueError,
		file_dialog_complete_handler : fileDialogComplete,//选择好文件后提交
		file_queued_handler : fileQueued,
		upload_progress_handler : uploadProgress,
		upload_error_handler : uploadError,
		upload_success_handler : uploadSuccess,
		upload_complete_handler : uploadComplete,

		// Button Settings
		button_image_url : "images/SmallSpyGlassWithTransperancy_17x18.png",
		button_placeholder_id : "spanButtonPlaceholder",
		button_width: 100,
		button_height: 18,
		button_text : '<span class="button">选择文件</span>',
		button_text_style : '.button { font-family: Helvetica, Arial, sans-serif; font-size: 12pt; } .buttonSmall { font-size: 10pt; }',
		button_text_top_padding: 0,
		button_text_left_padding: 18,
		button_window_mode: SWFUpload.WINDOW_MODE.TRANSPARENT,
		button_cursor: SWFUpload.CURSOR.HAND,
		
		// Flash Settings
		flash_url : "<%=request.getContextPath() %>/theme/js2/upload/swfupload.swf",

		custom_settings : {
			upload_target : "divFileProgressContainer"
		},
		// Debug Settings
		debug: false  //是否显示调试窗口
	});   
		   
});

function closeDialog() {
	if($("#type").val() == 2) {
		parent.window.location.href = '<%=request.getContextPath() %>/member/business!myBuyerList.htm?dfdf=<%=new Date()%>';
	}
}
</script>
  </head>
  <body>
  <div id="content">
  <input type="hidden" value="<s:property value="#request.id"/>" id="orderId" />
  <input type="hidden" value="<s:property value="#request.type"/>" id="type" />
	<div style=" border: solid 1px #7FAAFF; background-color: #C5D9FF; padding: 2px; width:324px;">
        <span id="spanButtonPlaceholder"></span>
        <!--<input id="btnUpload" type="button" value="上  传"
            onclick="startUploadFile();" class="btn3_mouseout" onMouseUp="this.className='btn3_mouseup'"
            onmousedown="this.className='btn3_mousedown'"
            onMouseOver="this.className='btn3_mouseover'"
            onmouseout="this.className='btn3_mouseout'"/>-->
        <input id="btnCancel" type="button" value="取消所有上传"
            onclick="cancelUpload();" disabled="disabled" class="btn3_mouseout" onMouseUp="this.className='btn3_mouseup'"
            onmousedown="this.className='btn3_mousedown'"
            onMouseOver="this.className='btn3_mouseover'"
            onmouseout="this.className='btn3_mouseout'"/>
    </div>
    
    <div id="divFileProgressContainer" style="height:auto"></div>
    <div id="thumbnails">
        <table id="infoTable" border="0" width="330" style="display: inline; border: solid 1px #7FAAFF; background-color: #C5D9FF; padding: 2px;margin-top:8px; margin-bottom:10px;">
        </table>
    </div>      
    <div style="text-align: center; padding-top:10px;" >
        <input value="导入文件" type="button" onclick="startUploadFile()" class="control_btn_wide_yellow" />
        <input value="取消" type="button" onclick="closeDialog()" class="control_btn_wide_yellow" />
    </div>
    
    </div>
  </body>
</html>