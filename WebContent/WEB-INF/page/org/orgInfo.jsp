<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@page import="com.smt.entity.TAppUserInfo"%>


<%@page import="com.smt.webapp.util.HttpSessionHelper"%>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
	UserSession userSession = HttpSessionHelper.getUserSession(request);
	int isForOrg = HttpSessionHelper.getOrgData(request); //0:no  1:yes
	int isIndividual = HttpSessionHelper.getIsOrg(request);

%>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>


       <!--- ------org\orgInfo.jsp    -->
    <title><%=StageVariale.title%></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
<META HTTP-EQUIV="Cache-Control" CONTENT="no-store, must-revalidate"> 
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">
	
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/layout.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/idialog.css">
 	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<link href="<%=request.getContextPath() %>/theme/css/WdatePicker.css" rel="stylesheet" type="text/css">

	<link href="<%=request.getContextPath() %>/theme/css/style.css" rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath() %>/theme/css/hg.css" rel="stylesheet" type="text/css">

	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/information.css">  
	<script type="text/javascript" src="<%=request.getContextPath() %>/theme/js/main.js"></script>

	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/3!register.css" />
	<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/theme/css/main.css" id="pagestyle"/>

	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/common.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js2/jquery.cookie.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/address.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>

	<link rel="stylesheet" href="<%=request.getContextPath() %>/theme/kindeditor/themes/default/default.css" />
	<link rel="stylesheet" href="<%=request.getContextPath() %>/theme/kindeditor/plugins/code/prettify.css" />
	<script type="text/javascript" language="javascript"  src="<%=request.getContextPath() %>/theme/kindeditor/kindeditor.js"></script>
	<script type="text/javascript" language="javascript"  src="<%=request.getContextPath()%>/theme/kindeditor/lang/zh_CN.js"></script>
<SCRIPT type="text/javascript" src="<%=request.getContextPath()%>/theme/js2/common.js"></SCRIPT>

<script type="text/javascript" src="<%=request.getContextPath()%>/theme/js/9!tool1.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/theme/js/4!register.js"></script>

	<script type="text/javascript" language="javascript" src="<%=request.getContextPath()%>/theme/js/swfobject.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath()%>/theme/js/imagerManager.js"></script>
	<style type="text/css" media="screen">
		html, body { height:auto !important;background-color: #f5f5f5;}
		#flashContent { width:100%; height:100%; }
		.black_overlay{display:none;position:absolute;top:0%;left:0%;width:100%;height:4250px;background-color:black;z-index:1001;-moz-opacity:0.8;opacity:.80;filter: alpha(opacity=80);}
		.white_content{display:none;position:absolute;top:25%;width:630px;height:4250px;z-index:1002;overflow:auto;}

		.shangchuang_2{ display:block; height: 35px; float: left; font: normal 14px/35px "微软雅黑"; background: url(<%=request.getContextPath()%>/theme/images/tu07.jpg) no-repeat; margin-left:0px; width: 127px; padding-left: 46px; color:#fff; text-decoration:none; margin-top:0;}


		#weixin_img{
			width:371px; height:354px; background:url(/theme/images2/2wm.png) no-repeat; position:fixed; left:230px; top:30px; display:none; z-index:9999;
		_position:absolute;_bottom:auto;_top:expression(eval(document.documentElement.scrollTop+document.documentElement.clientHeight-this.offsetHeight-(parseInt(this.currentStyle.marginTop,10)||0)-(parseInt(this.currentStyle.marginBottom,10)||0)));
}

.xiugai{
	margin-left: 650px;
	width: auto;
	color:black;
	line-height:32px;
	height: 32px;
}
.xiugai a:link{
	color:#25D;
	font-size:14px;
}


a.querenbaocun3 {
text-decoration: none;
display: block;
float: left;
background: url(/theme/images/tu06.jpg) no-repeat;
color: white;
font: normal 18px/40px "微软雅黑";
text-align: center;
width: 115px;
height: 40px;
margin-left: 15px;
margin-top: 0px;
margin-bottom: 40px;
}


	</style>



<script type="text/javascript">
function toggleAll(status){
	$("#jcxxForm input:not(:button,:hidden)").attr("disabled", status);
	$("#jcxxForm select").attr("disabled", status);
	$("#jcxxForm textarea").attr("disabled", status);
}



$(document).ready(function(){

	if("${userInfo.provice}"!=""){
		initAddress('provice','city','${userInfo.provice}','${userInfo.city}');
	}else{
		initAddress("provice","city","上海","");  
	}

	
	getUserPercent();
<%
TAppUserInfo userInfo = (TAppUserInfo)request.getAttribute("userInfo");

String[] companyTagsArr = null;
if(userInfo!=null){
		String companyTags = userInfo.getCompanyTags();
		System.out.println("*****************************************"+companyTags);
		companyTagsArr = org.apache.commons.lang.StringUtils.split(companyTags,",");
}
if(companyTagsArr!=null){
		for(int i=0; i<companyTagsArr.length; i++){
			if("广告/公关".equals(companyTagsArr[i])){
					out.print("jQuery1.mk.register.selectVocation(2);");
			}
			if("婚庆/会展".equals(companyTagsArr[i])){
					out.print("jQuery1.mk.register.selectVocation(14);");
			}
			if("演艺经纪".equals(companyTagsArr[i])){
					out.print("jQuery1.mk.register.selectVocation(144);");
			}
			if("剧团".equals(companyTagsArr[i])){
					out.print("jQuery1.mk.register.selectVocation(3);");
			}
			if("影视制作".equals(companyTagsArr[i])){
					out.print("jQuery1.mk.register.selectVocation(4);");
			}
			if("文化传媒".equals(companyTagsArr[i])){
					out.print("jQuery1.mk.register.selectVocation(16);");
			}
			if("多媒体".equals(companyTagsArr[i])){
					out.print("jQuery1.mk.register.selectVocation(15);");
			}
			if("幕后制作".equals(companyTagsArr[i])){
					out.print("jQuery1.mk.register.selectVocation(17);");
			}
			if("动漫".equals(companyTagsArr[i])){
					out.print("jQuery1.mk.register.selectVocation(18);");
			}
			if("租赁".equals(companyTagsArr[i])){
					out.print("jQuery1.mk.register.selectVocation(19);");
			}
			if("舞美/布景".equals(companyTagsArr[i])){
					out.print("jQuery1.mk.register.selectVocation(20);");
			}
 
		}
}
%>

	toggleAll(true);
	$("#myinfobaocun").html('<a href="javascript:modifyForm();">修改</a>');

	getUserInfoGrowth();
});


function getUserPercent(){
	$.ajax({
		url:"<%=request.getContextPath() %>/member/userinfo!getPercent.htm",
		type:'POST',
		dataType:'json', 
		success:function(data){
			var d = parseInt(data);
			$(".wanzheng").html('');
			if(d > 0 && d <=50){
				$(".wanzheng").html('个人信息完整度：（<span>*</span>为必填项）<img src="<%=request.getContextPath()%>/theme/images/wanzheng1.jpg" />'+d+'%');
			}else if(d > 50 && d <= 70){
				$(".wanzheng").html('个人信息完整度：（<span>*</span>为必填项）<img src="<%=request.getContextPath()%>/theme/images/wanzheng2.jpg" />'+d+'%');
			}else if(d > 70 && d <= 99){
				$(".wanzheng").html('个人信息完整度：（<span>*</span>为必填项）<img src="<%=request.getContextPath()%>/theme/images/wanzheng.jpg" />'+d+'%');
			}else{
				$(".wanzheng").html('个人信息完整度：（<span>*</span>为必填项）<img src="<%=request.getContextPath()%>/theme/images/wanzheng3.jpg" />'+d+'%');
			}
		}
	});
}

function addGrowth(){
			if($("#costInfo\\.keywords").val()=="如拍企业微电影/婚礼策划等"){ 
					$("#costInfo\\.keywords").val("");
			}


			var bulletinImg=$("#costInfo\\.bigImage").val();
            var bprice=$("#costInfo\\.bprice").val();
            var unit=$("#costInfo\\.unit").val();
            var title = $("#costInfo\\.keywords").val(); 
			/*
            if(bulletinImg==""){
                art.dialog.tips("请上传项目海报！", 2);
                return;
            }
			*/
            if(title==""){
                art.dialog.tips("项目名称不能为空！", 2);
                $("#costInfo\\.keywords").focus();
                return;
            }
            if(bprice==""){
                art.dialog.tips("价格不能为空！", 2);
                $("#costInfo\\.bprice").focus();
                return;
            }
			
            if(unit==""){
                art.dialog.tips("单位不能为空！", 2);
                $("#costInfo\\.unit").focus();
                return;
            }

			var re=/^([a-z]|[A-Z]|[\u4E00-\u9FA5]|[\uFE30-\uFFA0])*$/gi;
			if(!re.test(unit)){
				art.dialog.tips("单位不能有数字，符号！", 2);
                $("#costInfo\\.unit").focus();
                return;
            }
			
            if(unit.length>4){
                art.dialog.tips("单位长度不能超过4个汉字！", 2);
                $("#costInfo\\.unit").focus();
                return;
            }
		$.ajax({
				url:"<%=request.getContextPath() %>/member/cost!saveOrgServiceCost.htm",
				type:'POST',
				data:$("#serviceForm").serialize(),
				success:function(data){
					if(data == "1"){
						getUserInfoGrowth();
						$("#costInfo\\.bigImage").val("");
						$("#yulanImg").attr("src", "");

						$("#costInfo\\.keywords").val("");
						$("#costInfo\\.bprice").val("");
						$("#costInfo\\.unit").val("");
						$("#costInfo\\.detail").val("");
						$("#yulanImgLi").hide();
					}
				}
		});
}

var myK = null;
var editor = null;
KindEditor.ready(function(K) {
				myK = K;
				editor = K.editor({
					uploadJson : '<%=request.getContextPath()%>/servlet/Upload?userId=<%=userSession.getId()%>',
					allowFileManager : true,
					imageUploadLimit:1
				});
				K('#J_selectImage2').click(function() {
					editor.loadPlugin('multiimage', function() {
						editor.plugin.multiImageDialog({
							clickFn : function(urlList) {
								var div = K('#J_imageView');
								div.html('');
								K.each(urlList, function(i, data) {
									//alert(data.url);
									$("#yulanImg").attr("src", data.url +"?date=" + new Date().getTime());
									$("#costInfo\\.bigImage").val(data.url);
									$("#yulanImgLi").show();
								});
								editor.hideDialog();
							}
						});
					});
				});
			});
 

function file_dialog_complete_handler(){
	//flash 传完后的
//	alert(10);
}

function handleImgLoadError(oEvent){
       oEvent.srcElement.src='<%=request.getContextPath()%>/theme/images/no_img.jpg';
}



function toUpdateGrowth(id){
	$("#btn_"+id).html("<a href='javascript:toUpdateGrowthAction(\""+id+"\");'  >保存</a>&nbsp;&nbsp;<a href='javascript:getUserInfoGrowth("+id+");' >取消</a>");
	$("#title_"+id).attr("disabled", false);
	$("#price_"+id).attr("disabled", false);
	$("#unit_"+id).attr("disabled", false);
	$("#content_"+id).attr("disabled", false);
}

function toUpdateGrowthAction(id){
	if($("#title_"+id).val()==""){
		art.dialog.tips("标题不能为空！", 2);
		return false;
	}
	if($("#unit_"+id).val().length>4){
		art.dialog.tips("单位长度不能超过4个汉字！", 2);
		return;
	}
	if($("#price_"+id).val()==""){
		art.dialog.tips("价格不能为空！", 2);
		return false;
	}
	/*
	if($("#unit_"+id).val()==""){
		art.dialog.tips("单位不能为空！", 2);
		return false;
	}
	if($("#content_"+id).val()==""){
		art.dialog.tips("内容不能为空！", 2);
		return false;
	}
	*/
	$.ajax({
			url:"/member/cost!updateOrgCost.htm?id="+id,
			type:'POST',
			data:$("#growthForm_"+id).serialize(),
			success:function(data){
				if(data == "1"){
					art.dialog.tips("服务项目修改成功！");
					getUserInfoGrowth();
				}
			}
	});
	
	
}



//获取用户成长经历
function getUserInfoGrowth() {
	$.ajax({
		url:"<%=request.getContextPath() %>/member/userinfo!getOrgCostList.htm?id=<%=userSession.getId()%>",
		type:'POST',
		dataType:'json', 
		success:function(data){
			var d = eval(data);
			$("#serviceHistory").html("");
			var html = "";

			for(var i = 0; i < d.length; i++) {
				var obj = d[i];

				html += "<form id='growthForm_"+obj.id+"'><div class='name'> 项目海报：</div>";
				html += "<div class='xinxi'><a  style='cursor:pointer;' class='shangchuang_2' id='J_selectImage_"+obj.id+"'>更新海报</a></div>";
				html += "<div class='xiugai' id='btn_"+obj.id+"' style='margin-left:550px'><a href='javascript:toUpdateGrowth(\""+obj.id+"\");' >修改</a>&nbsp;&nbsp;<a href='javascript:delOrgCost("+obj.id+");' >删除</a></div>";

				html += "<li id='haibao_"+obj.id+"'><div class='name'> 海报预览：</div><input type='hidden' name='yulanImgHid_"+obj.id+"' id='yulanImgHid_"+obj.id+"'> <img id='yulanImg_"+obj.id+"' src='"+obj.bigImage+"' width='247' height='163'/></li>";
			 
				html += "<li><div class='name'> 项目名称：</div>";
				html += "<input  size='50'  type='text' name='title_"+obj.id+"' id='title_"+obj.id+"' value='"+obj.keywords+"' disabled/></li>";

				html += "<li><div class='name'> 价格：</div><input class='duan' name='price_"+obj.id+"'  id='price_"+obj.id+"'  value='"+obj.bPrice+"' disabled/> <div style='float:left;font:normal 14px/32px 微软雅黑; margin-right:10px; height:32px;'>/</div><input  name='unit_"+obj.id+"' id='unit_"+obj.id+"'  size='2' style='width:30px;' value='"+obj.unit+"' disabled/><font style='font:normal 12px/32px 微软雅黑; height:32px;'>(单位)场、次、小时、天等</font>";


				html += "<li><div class='name'> 项目详情：</div><textarea id='content_"+obj.id+"'  name='content_"+obj.id+"' disabled>"+obj.detail+"</textarea></li>";


				html += "<li><hr></li></form>";

			}

			$("#serviceHistory").html(html);


			

			for(var i = 0; i < d.length; i++) {
				var obj = d[i];
				var objId = obj.id;
				myK('#J_selectImage_'+objId).click(function() {
					var tempId = this.id;
					var currentObjId = tempId.substring(tempId.lastIndexOf("_")+1);
					editor.loadPlugin('multiimage', function() {
						editor.plugin.multiImageDialog({
							clickFn : function(urlList) {
								var div = myK('#J_imageView');
								div.html('');
								myK.each(urlList, function(i, data) {
									$("#yulanImg_"+currentObjId).attr("src", data.url +"?date=" + new Date().getTime());
									$("#yulanImgHid_"+currentObjId).val(data.url);
								});
								editor.hideDialog();
							}
						});
					});
				});
			}




			
 		}
	});
}
 
function delOrgCost(id){
	art.dialog({
		icon: 'warning',
		content: '删除当前信息，您确定吗？',
		ok: function () {
		
		$.post('<%=request.getContextPath()%>/member/cost!delOrgCost.htm?id='+id,
			function(data){
				if(data=="1"){
					getUserInfoGrowth();
				}
			},"html");
		},
		cancel: true
	});
}


function modifyForm(){
	toggleAll(false);
	$("#myinfobaocun").html('<a href="javascript:submitForm();">保存</a>');
}
function checknull(){



        var introduction=$("#userInfo\\.introduction").val();
	   // if(introduction.length>500){
		//		art.dialog.tips("【个人介绍】不能超过500个字符！");
		//		return ;
	  //    }

	var nickName=$("#userInfo\\.nickName").val();
	//var realName=$("#userInfo\\.name").val();
	//var place = $("#userInfo\\.place").val();

	if(nickName==""){
		art.dialog.tips("昵称不能为空！", 2);
		return false;
	}
/*
	if(place==""){
		art.dialog.tips("详细地址不能为空！", 2);
		return false;
	}	

	if(realName==""){
		art.dialog.tips("真实姓名不能为空！", 2);
		return false;
	}
	*/
	return true;
}


function submitForm(){
		var objs = $("#current-job > div ");
		var tags = "";
		for(var i=0; i<objs.length; i++){
			var val = $(objs[i]," > a").text().trim();
			if(i==(objs.length-1)){
				if(val != "未选择" && val != ""){
					tags += val ;
				}
			}else{
				if(val != "未选择" && val != ""){
					tags += val + ",";
				}
			}
		}
		if(tags==""){
			art.dialog.tips("请选择【公司标签】！");
			return;
		}
		$("#userInfo\\.companyTags").val(tags);

        var seviceScope=$("#userInfo\\.seviceScope").val();
	    if(seviceScope==""){
				art.dialog.tips("【服务范围】不能为空！");
				return ;
	      }

	if(checknull()){
		$.ajax({
			url:"<%=request.getContextPath() %>/member/userinfo!updateOnlyOrgInfo.htm",
			type:'POST',
			data:$("#jcxxForm").serialize(),
			success:function(data){
				if(data == "1"){
					art.dialog.tips("保存成功！", 3);
					toggleAll(true);
					$("#myinfobaocun").html('<a href="javascript:modifyForm();">修改</a>');
					//window.location = "<%=request.getContextPath()%>/member/userinfo.htm";
			   }
		   }
		});
	}
}


//分享页面
function userShare(wzd){
	art.dialog.open('<%=request.getContextPath()%>/member/userinfo!toUserShare.htm?wzd='+wzd,{lock:true,resize: false,fixed:true});
}

//删除用户头像
function delHeadImg() {
	$.ajax({
	   url:"<%=request.getContextPath() %>/member/userinfo!delHeadImg.htm",
	   type:'POST',
	   success:function(data){
		   if(data == "1") {
			   getUserInfo();
		   }
	   }
	});
}
 
 
 
			
//修改密码
function updatePass(){
	art.dialog.open('<%=request.getContextPath()%>/user/userAction!doUpdatePassWord.htm',{lock:true,resize: false});
}

//实名认证
function realName(){
	art.dialog.open('<%=request.getContextPath()%>/member/userinfo.htm?sign=4',{width:700,height:650,lock:true,resize: false,close: function () {
				     		 location.reload();
				  		}});
}
 

function tishi(content){
	art.dialog.tips(content);
}


//修改手机/邮箱
function updateEmailOrMobile(flag){
		art.dialog.open('<%=request.getContextPath()%>/user/userAction!doUpdateEmail.htm?flag='+flag,{lock:true,resize: false	});
}


var updateFlag = false;
function setUpdateFlag() {
	updateFlag = true;
}







//===============================
 

//修改头像
function uploadPic(imgid,rPath,fileName){
		art.dialog.open('<%=request.getContextPath()%>/member/userinfo.htm?swfFile=indexHeadImage&sign=100&rPath='+rPath+'&dateRandomStr='+fileName+'&imgid='+imgid,{lock:true,resize: false});
}

//flash callback
function updatePic(imgid,rPath,fileName) {
	//这里是头像保存后的成功提示，你可以刷新当前页面，也可以做些其他操作
	$("#"+imgid).attr("src", "/stageUpload/"+rPath+"/"+fileName+".png?date=" + new Date().getTime());
 }


	function toOrgArtMangeer(){
					art.dialog.open('<%=request.getContextPath()%>/member/orginfo.htm?sign=2',
					{
						width: 750,
				    	height: 650,
				    	title:"企业认证",
						close: function () {
				     		 location.reload();
				  		}
					});
	}

function projectShow(){
		$("#serviceForm").show();

		 if($("#costInfo\\.keywords").val()=="如拍企业微电影/婚礼策划等" || $("#costInfo\\.keywords").val()==""){ 
				  $("#costInfo\\.keywords").val("如拍企业微电影/婚礼策划等");
				  $("#costInfo\\.keywords").css("color","#999999");
		}else{
				$("#costInfo\\.keywords").css("color","#000000");
		}
}

function checkInput(){
		 if($("#costInfo\\.keywords").val()=="如拍企业微电影/婚礼策划等" || $("#costInfo\\.keywords").val()==""){ 
				$("#costInfo\\.keywords").val("");
		} 
		$("#costInfo\\.keywords").css("color","#000000");
}
function checkOutput(){
		 if($("#costInfo\\.keywords").val()==""){ 
				  $("#costInfo\\.keywords").val("如拍企业微电影/婚礼策划等");
				  $("#costInfo\\.keywords").css("color","#999999");
		}
}

function clearAll(){
	$("#serviceForm")[0].reset();
	$("#yulanImg").src='';
	$("#yulanImgLi").hide();
	$("#serviceForm").hide();
}

</script>
  </head>
  <body  style="background: #ffffff;">
  <jsp:include page="../public/head2.jsp">
  <jsp:param value="no" name="titleType"/>
  </jsp:include>

<div style="height:auto !important; width:100%; margin:0;overflow:hidden;" id="main_content">

 <!-- 主内容开始 -->
<table width="980" border="0" align="center" cellpadding="0" cellspacing="0" class="layout_table">
    <tbody><tr>
        <td width="146" valign="top" class="left_menubj">
        <!-- 会员 左导航 开始 
        -->
        <s:action name="menuHyzx" executeResult="true">
        	<s:param name="menuFlag" value="13"></s:param>
        </s:action>

       <!-- 会员 左导航 结束 -->
</td>
        <td height="720">&nbsp;</td>
        <td width="810" align="left" valign="top">


<!-- 导航 结束 -->

<div class="right_tab">
<ul>
<li><a class="change" href="orginfo.htm?sign=1&userId=<%=userSession.getId()%>&orgUserId=<%=userSession.getId()%>">基本信息</a></li>
<li><a  href="<%=request.getContextPath() %>/member/artInfo!toArtInfo.htm?sign=5&userId=<%=userSession.getId()%>&orgUserId=<%=userSession.getId()%>" id="font2" >相关作品（相册）</a></li>
<li><a  href="<%=request.getContextPath() %>/member/artInfo!toArtInfo.htm?sign=2&userId=<%=userSession.getId()%>&orgUserId=<%=userSession.getId()%>" id="font2" >相关作品（视频）</a></li>
<li><a href="<%=request.getContextPath() %>/member/artInfo!toZhaoPin.htm?userId=<%=userSession.getId()%>&orgUserId=<%=userSession.getId()%>">招聘信息</a></li>
<!-- <li><a href="orginfo.htm?sign=4&userId=<%=userSession.getId()%>&orgUserId=<%=userSession.getId()%>">绑定支付宝</a></li> -->

</ul>
</div>
<!-- 基础信息 开始 -->

<div id="TabTab03Con">

<div class="wanzheng" style="margin:20px 0px"> 个人信息完整度：（<span>*</span>为必填项）<img src="<%=request.getContextPath()%>/theme/images/wanzheng.jpg" />80%</div>

<div class="content">
<div class="content_left">
<form name="jcxxForm" id="jcxxForm" action="">
<ul>
<li>
    <div class="name">用户名：</div>
    <div class="xinxi">${userInfo.nickName}</div>
    <a href="javascript:updatePass();" class="zhezhaoLink">修改密码</a>
</li>

<li>
    <div class="name"><span style="color:#ff0000;">*</span> 公司名称：</div>
    <input  name="userInfo.nickName" id="userInfo.nickName" value="${userInfo.nickName}"/>
</li>
<li>
<div class="name"><span style="color:#ff0000;">*</span>企业认证</div>
	<a href="javascript:toOrgArtMangeer();" class="zhezhaoLink">认证</a>　<br>　
    <div class="tishi" >用于提升账号的安全性和信任级别。<br />
认证后的企业能够获得更多合作机会和优先权。</div>
</li>


<li>
    <div class="name"><span style="color:#ff0000;">*</span>  所在地：</div>
            <select  name="userInfo.provice" id="provice" class="sel_jcxx"></select>
            <select   name="userInfo.city" id="city" class="sel_jcxx"></select>
</li>



<li>
    <div class="name"> 详细地址：</div>
	<input type="text" name="userInfo.place" id="userInfo.place"  maxlength="50"  value="${userInfo.place}" style="float:left;width:234px; height:30px; border:solid 1px #c8c8c8; margin-right:15px; outline:none; padding-left:10px; outline:none;font:normal 14px/30px '微软雅黑';" />
</li>
 






<li>

<div class="name" style="margin-top:10px;"><span style="color:#ff0000;">*</span> 公司标签：</div>
<div class="wrap" id="mokoBgID">
	<div class="reg-job-content" style="border:0px">
 				
 					<input type="hidden" name="userInfo.companyTags" id="userInfo.companyTags" value="${userInfo.companyTags}">
					<div class="current-job" id="current-job" style="border:0px">
						<div class="current-jobBox">
                            <div class="current-null" ></div>
                        </div>
						<div class="current-jobBox">
							<div class="current-null"></div>
						</div>
						<div class="current-jobBox">
							<div class="current-null"></div>
						</div>
					</div>
	 


						<div id="vocation_box_2" class="jobBox hot">
							<a href="javascript:void(0);" title="选择这个职业" id="chooseVocation_2" onclick="jQuery1.mk.register.selectVocation(2)">广告/公关</a>
						</div>		
						<div id="vocation_box_14" class="jobBox">
							<a href="javascript:void(0);" title="选择这个职业" id="chooseVocation_14" onclick="jQuery1.mk.register.selectVocation(14)">婚庆/会展</a>
						</div>
						<div id="vocation_box_144" class="jobBox">
							<a href="javascript:void(0);" title="选择这个职业" id="chooseVocation_144" onclick="jQuery1.mk.register.selectVocation(144)">演艺经纪</a>
						</div>
						<div id="vocation_box_3" class="jobBox">						
							<a href="javascript:void(0);" title="选择这个职业" id="chooseVocation_3" onclick="jQuery1.mk.register.selectVocation(3)">剧团</a>
						</div>			
						<div id="vocation_box_4" class="jobBox">
							<a href="javascript:void(0);" title="选择这个职业" id="chooseVocation_4" onclick="jQuery1.mk.register.selectVocation(4)">影视制作</a>
						</div>
						<div id="vocation_box_16" class="jobBox">
							<a href="javascript:void(0);" title="选择这个职业" id="chooseVocation_16" onclick="jQuery1.mk.register.selectVocation(16)">文化传媒</a>
						</div>
						<div id="vocation_box_15" class="jobBox">
							<a href="javascript:void(0);" title="选择这个职业" id="chooseVocation_15" onclick="jQuery1.mk.register.selectVocation(15)">多媒体</a>
						</div>


						<div id="vocation_box_17" class="jobBox">
							<a href="javascript:void(0);" title="选择这个职业" id="chooseVocation_17" onclick="jQuery1.mk.register.selectVocation(17)">幕后制作</a>
						</div>
						<div id="vocation_box_18" class="jobBox">
							<a href="javascript:void(0);" title="选择这个职业" id="chooseVocation_18" onclick="jQuery1.mk.register.selectVocation(18)">动漫</a>
						</div>
						<div id="vocation_box_19" class="jobBox">
							<a href="javascript:void(0);" title="选择这个职业" id="chooseVocation_19" onclick="jQuery1.mk.register.selectVocation(19)">租赁</a>
						</div>
						<div id="vocation_box_20" class="jobBox">
							<a href="javascript:void(0);" title="选择这个职业" id="chooseVocation_20" onclick="jQuery1.mk.register.selectVocation(20)">舞美/布景</a>
						</div>

	</div>
</div>

</li>




<li>
    <div class="name"><span style="color:#ff0000;">*</span>服务范围：</div>
	<input type="text" name="userInfo.seviceScope" id="userInfo.seviceScope"  maxlength="50"  value="${userInfo.seviceScope}" style="float:left;width:234px; height:30px; border:solid 1px #c8c8c8; margin-right:15px; outline:none; padding-left:10px; outline:none;font:normal 14px/30px '微软雅黑';" />
</li>
 

 
 <li>
    <div class="name"> 成立时间：</div>
	<input type="text" name="userInfo.birthday" class="nc_input Wdate" style="width:90px;" value="${userInfo.birthday}"   onClick="WdatePicker()" />
</li>
 


 
 <li>
    <div class="name"><span style="color:#ff0000;">*</span> 手机：</div>
	<div class="xinxi">${userInfo.mobile}</div>
	<a href="javascript:updateEmailOrMobile(2);" class="zhezhaoLink">修改</a>
</li>

<li>
    <div class="name"> <span style="color:#ff0000;">*</span>E-mail：</div>
    <div class="xinxi">${user.email}</div>
	<a href="javascript:updateEmailOrMobile(1);" class="zhezhaoLink">修改</a>
</li>


<li>
    <div class="name"> 公司介绍：</div>
    <textarea name="userInfo.introduction" id="userInfo.introduction" >${userInfo.introduction}</textarea>
</li>
 
</ul>
 </form>

<div class="baocun" id="myinfobaocun">
</div>
<div class="touxiang" style="text-align:center">
<div ><img src="/stageUpload/headImage/${user.id}.png?date=<%=new java.util.Date()%>"  id="pic001"  /></div>
<a href="javascript:uploadPic('pic001','headImage','<%=userSession.getId()%>')"   class="zhezhaoLink">修改头像</a>

</div>


</div>



</div>

 

















<div >
<div class="content_left">
<h3>服务项目</h3><a href='#addProject' class='querenbaocun3' style="float:right" onclick="javascript:projectShow()">添加</a>

<ul id="serviceHistory" ></ul>

<form id='serviceForm' style="display:none">
<a name='addProject'></a>
<ul>

<li><div class='name'> 项目海报：</div><a  style='cursor:pointer;' class='shangchuang' id='J_selectImage2'>上传海报</a></li>

<li id="yulanImgLi" style="display:none"><div class='name'> 海报预览：</div><img src='' id="yulanImg" width='247' height='163'/></li>


<input class='duan'   type='hidden' name='costInfo.bigImage' id='costInfo.bigImage'  value='' />

<li><div class='name'> 项目名称：</div>
<input   size="50"   type='text' name='costInfo.keywords' id='costInfo.keywords'  value='' onclick="javascript:checkInput()" onblur="javascript:checkOutput()"/>
</li>

<li><div class='name'> 价格：</div>
<input class='duan' name='costInfo.bprice' id='costInfo.bprice'  value=''/><div style='float:left;font:normal 14px/32px 微软雅黑; margin-right:10px; height:32px;'>/</div><input  size='2' style='width:30px;'   name='costInfo.unit' id='costInfo.unit'  value=''/><font style='font:normal 12px/32px 微软雅黑; height:32px;'>(单位)场、次、小时、天等</font>
</li>

<li><div class='name'> 项目详情：</div><textarea id='costInfo.detail' name='costInfo.detail'></textarea></li>

<li><a href='javascript:addGrowth()' class='querenbaocun1'>保存</a><a href='javascript:clearAll()' class='querenbaocun3'>取消</a></li>
</form>
			



</ul>


 

</td>
</tr>
</tbody></table>
 
<!-- 主内容结束 -->













<!-- 底部开始 -->
<jsp:include page="/WEB-INF/page/public/bottom2.jsp"></jsp:include>
<!-- 底部结束 --> 




  </body>
</html>