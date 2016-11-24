<%@page import="com.smt.webapp.util.CommonUtil"%>
<%@page import="com.smt.common.StageVariale"%>
<%@page import="com.smt.webapp.util.OnlineUser"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@page import="com.smt.entity.TAppUser"%>
<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.*" %>
<%
	String path = request.getContextPath();
	String urlRewriteUrl = CommonUtil.getIsnullReturnString((String)request.getParameter("urlRewriteUrl"), "0");
	String urlRewriteParam = CommonUtil.getIsnullReturnString((String)request.getParameter("urlRewriteParam"), "0");

	Integer artId = (Integer)session.getAttribute("artId");

	String nickName = "";
	TAppUser step1_tappUser = (TAppUser)session.getAttribute("step1_tappUser");
 	if(step1_tappUser != null){
		nickName = step1_tappUser.getUsername();
 	}
	//java.util.Random r = new java.util.Random();
	//String dateRandomStr = org.apache.commons.httpclient.util.DateUtil.formatDate(new Date(), "yyyyMMddHHmmss")+(1000+r.nextInt(1000));
	UserSession userSession = HttpSessionHelper.getUserSession(request);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title><%=StageVariale.title%></title>
	<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="X-UA-Compatible" content="IE=7" />

	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="description" content="<%=StageVariale.description%>">
	

	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/layout.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/idialog.css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/zhezhao.css">


	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/43!register.css" />

	

	<script type="text/javascript" src="<%=request.getContextPath() %>/theme/js/main.js"></script>
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/css/main.css" id="pagestyle"/>	

	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/address.js"></script>

 
 
 	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/theme/css/main.css" id="pagestyle"/>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/information.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/followButton.css">

	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/login.css">

	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/common.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js2/jquery.cookie.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/address.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/swfobject.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/imagerManager.js"></script>
<link href="<%=request.getContextPath() %>/theme/css2/style.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/theme/css2/hg.css" rel="stylesheet" type="text/css" />
<SCRIPT type=text/javascript src="<%=request.getContextPath() %>/theme/js2/zzsc.js"></SCRIPT>
<SCRIPT type=text/javascript src="<%=request.getContextPath() %>/theme/js2/common.js"></SCRIPT>



 	
		<link rel="stylesheet" href="<%=request.getContextPath() %>/theme/kindeditor/themes/default/default.css" />
	<link rel="stylesheet" href="<%=request.getContextPath() %>/theme/kindeditor/plugins/code/prettify.css" />
	<script type="text/javascript" language="javascript"  src="<%=request.getContextPath() %>/theme/kindeditor/kindeditor.js"></script>
	<script type="text/javascript" language="javascript"  src="<%=request.getContextPath() %>/theme/kindeditor/lang/zh_CN.js"></script>


	<style type="text/css" media="screen">
		#html, body { height:auto !important; background-color: #ffffff;}
		#flashContent { width:100%; height:100%; }
	</style>	
</head>
  <body style="background: #ffffff;">

  

  <jsp:include page="../public/head2.jsp">
  <jsp:param value="no" name="titleType"/>
  </jsp:include>
 


  <!-- 主内容开始 -->     
  <form id="jcxxForm" name="jcxxForm" method="post">
  <input type="hidden" name="sign" id="sign" value="1">
  <input type="hidden" name="headImage" id="headImage" value="true">


 <div class="content_login">
     <div class="content_loginbt">
       <a href="#" class="hong">专业会员</a>
     </div>
     

     <div class="content_logincont">
       <div style=" height:40px; width:1000px;"></div>
       <ul>
         <li>
           <div>昵称：</div>
           <input name="userInfo.nickName" id="userInfo.nickName" value="<%=nickName%>"/>


           <p>给自己取个艺名！红遍大江南北！</p>
         </li>
         <li>
           <div>所在地：</div>
                  <select onchange="getSubCityValue('provice','city')" name="userInfo.provice" id="provice" class="sel_jcxx"></select>
                  <select   name="userInfo.city" id="city" class="sel_jcxx"></select>

 
         </li>
       </ul>
       <div style=" height:30px; width:1000px; border-bottom:solid 2px #bfbfbf; margin-bottom:20px;"></div>
    
     
     
     
   <!-- 职业选择开始 -->  
     		<div class="wrap" id="mokoBgID">
			<div class="reg-job-content">

					<div class="current-job">
						<h1>你当前的职业</h1>
						<div class="current-jobBox" id="div_1">
                            <input class="current-null" value="+第一职业" type="button" onclick="toAddCost('1')"/>
                        </div>
						<div class="current-jobBox" id="div_2">
							<input class="current-null" value="+第二职业" type="button" onclick="toAddCost('2')"/>
						</div>
						<div class="current-jobBox" id="div_3">
							<input class="current-null" value="+第三职业" type="button" onclick="toAddCost('3')"/>
						</div>
                        <div class="current-jobBox" id="div_4">
							<input class="current-null" value="+第四职业" type="button" onclick="toAddCost('4')"/>
						</div>
                        <div class="current-jobBox" id="div_5">
							<input class="current-null" value="+第五职业" type="button" onclick="toAddCost('5')"/>
						</div>
					</div>
					<span style="margin:5px 0px 0px 30px;line-height:30px;height:30px;padding:10px 0px;font-size:12px;">亲，请合理填写您的职业价格，这将直接影响到客户与您的交易意向哦。</span>


					
                        
                        
			</div>
		</div>
</form>
<!-- 职业选择结束 -->

 
  <div class="login_shangchuang">
       <div class="login_shangchuanga">
         <p>上传一张头像照，有助于增加关注度。</p>
         <a href="javascript:uploadPic('pic001','headImage','<%=userSession.getId()%>','FaustCplus')" style="color:white;">上传头像</a>
       </div>
       
       <div class="login_shangchuangb">
          <img src="<%=request.getContextPath() %>/theme/images/no_img.jpg" id="pic001" width="275" height="275" />
       </div>

  </div>
  
    
  <div class="login_shangchuang">
       <div class="login_shangchuanga">
         <p>请上传一张你的演出照片或作品照片。</p>
         <a    style="cursor: pointer;color:white;" class="chuang" id="J_selectImage">上传照片</a>
       </div>
       
       <div class="login_shangchuangb">
          <img src="<%=request.getContextPath() %>/theme/images/no_img.jpg"  id="pic002" width="275" height="275" />
       </div>
       
       <div  class="login_shangchuangc">
         <a href="javascript:jcxx_submit();"  class="zhezhaoLink">提交</a>
       </div>
   
  </div>  
    

     
 </div>
</div>

<!-- 主内容结束 -->
<jsp:include page="../public/bottom2.jsp"></jsp:include>
<form name="artInfoForm"  id="artInfoForm" style="width:0px;height:0px;visibility:hidden">
	<input type="hidden" name="artInfo.id" value="<%=artId%>"/> 
	<input type="hidden" name="artInfo.userId" value="<%=step1_tappUser.getId()%>"/> 
	<input type="hidden" name="artInfo.type" value="1"/> 
	<input type="hidden" name="artInfo.title" value="我的相册"/> 
	<input type="hidden" name="artInfo.intro" value="我的相册"/> 

	<input type="hidden" name="artInfo.imgCount" value="1"/> 
</form>
 
<script language="javascript">
 /*
 function saveXiangce(id){
		$.ajax({
		   url:"<%=request.getContextPath() %>/member/artInfo!saveOrUpdateArtInfo.htm?sign=1",
		   type:'POST',
		   data:{
				artInfo.type:"1"
		   },
		   success:function(data){
			   if(data == "1"){
					window.location.href ="<%=request.getContextPath()%>/member/artInfo!doShowImg.htm?id="+id+"&userId=<s:property value='#request.userId'/>";
			   }
		   }
		});
}
*/
function file_dialog_complete_handler(){
	//flash 传完后的
//	alert(10);
}


 function toInfo(){
	window.location = "<%=request.getContextPath()%>/member/userinfo.htm";
  }
 function toViewInfo(){
	window.location = "<%=request.getContextPath()%>/member/userinfo.htm";
  }


KindEditor.ready(function(K) {
				var editor = K.editor({
					uploadJson : '<%=request.getContextPath()%>/servlet/Upload?id=<%=artId%>&userId=<%=step1_tappUser.getId()%>',
					allowFileManager : true,
					imageUploadLimit:1
					//,queueSizeLimit:1
					//,afterChange: function() {					}
					//,afterUpload: function() {					}
				});
				K('#J_selectImage').click(function() {
					editor.loadPlugin('multiimage', function() {
						editor.plugin.multiImageDialog({
							//插入
							clickFn : function(urlList) {
								
								var div = K('#J_imageView');
								div.html('');
								K.each(urlList, function(i, data) {
									//alert(data.url );
									$("#pic002").attr("src", data.url +"?date=" + new Date().getTime());

									//div.append('<img src="' + data.url + '">');
								});
								editor.hideDialog();
							}
						});
					});
				});
			});

		

	function handleImgLoadError(oEvent)
   	{
       oEvent.srcElement.src='<%=request.getContextPath()%>/theme/images/no_img.jpg';
  	 }
	function toAdd(sign){
		art.dialog.open('<%=request.getContextPath()%>/page/imgUp.jsp?sign='+sign,{width:744,height:533,resize: false,lock :true ,close:function(){location.reload();}});
	}
	
	function view(obj){
	//alert(obj.src);
		art.dialog({
		    padding: 0,
		    title: '照片',
		    content: '<img src="'+obj.src+'" />',
		    lock: true
		});
	}
	function toDel(id){
		art.dialog({
		        icon: 'warning',
				content: '您确定删除当前图片吗？',
				ok: function () {
				
				    $.post('<%=request.getContextPath()%>/member/artInfo!delImg.htm?id='+id,
						function(data){
							if(data=="1"){
							//art.dialog.tips("删除成功!");
							window.location.reload();
						}
					},"html");

					
				},
				cancel: true
		});
	
	}
	
 
		






 function openXiangce(){
		art.dialog.open('<%=request.getContextPath()%>/member/artInfo!toAddArtInfo.htm?sign=1&userId=-1');
		//window.location.href ="<%=request.getContextPath()%>/member/artInfo!doShowImg.htm?id=-1&userId=<s:property value='#request.userId'/>";
}

function showContent(id,price,unit,keywords,costId){
		var html='<div class="current-null">'+keywords+'</div>';

		html += '<input type="hidden" id="profession_'+id+'" name="profession_'+id+'" value="'+costId+'">';
		html += '<input type="hidden" id="bprice'+id+'" name="bprice'+id+'" value="'+price+'">';
		html += '<input type="hidden" id="eprice'+id+'" name="eprice'+id+'" value="'+price+'">';
		html += '<input type="hidden" id="unit'+id+'" name="unit'+id+'" value="'+unit+'">';
		html += '<input type="hidden" id="keywords'+id+'" name="keywords'+id+'" value="'+keywords+'">';

		html += '<div class="current-nulll">'+price+'(元/'+unit+')</div>';
		html += '<input type="button" class="btn" value="修改" onclick=\'toEditCost("'+id+'")\'>';
		html += '<input type="button" class="btn" value="删除" onclick=\'toDeleteCost("'+id+'")\'>';
		$('#div_'+id).html(html);
}

function toDeleteCost(id){
		var index = 0;
 		if(id){
			index = parseInt(id)-1;
		}
		var idName = new Array('一','二','三','四','五');
		var html='<input class="current-null" value="+第'+idName[index]+'职业" type="button" onclick=\'toAddCost("'+id+'")\'/>';
		$('#div_'+id).html(html);
}

//修改头像
function uploadPic(imgid,rPath,fileName,swfFile){
		art.dialog.open('<%=request.getContextPath()%>/member/userinfo.htm?sign=100&rPath='+rPath+'&dateRandomStr='+fileName+'&imgid='+imgid+"&swfFile="+swfFile,{lock:true,resize: false});
}
var myDate = new Date();
//flash callback
function updatePic(imgid,rPath,fileName) {
	//这里是头像保存后的成功提示，你可以刷新当前页面，也可以做些其他操作
	$("#"+imgid).attr("src", "/stageUpload/"+rPath+"/"+fileName+".png?date=" + myDate.getTime());
 }



$(function(){
	initAddress("provice","city","上海","上海");
});

function toAddCost(index){
	art.dialog.open("<%=request.getContextPath()%>/member/cost!toAddOrUpdateByJs.htm?add=true&index="+index,{width:700,height:450,lock:true,resize: false});
}

function toEditCost(index){
	art.dialog.open("<%=request.getContextPath()%>/member/cost!toAddOrUpdateByJs.htm?index="+index,{width:700,height:450,lock:true,resize: false});
}


 function setUpImgForDefault(){
		 $.ajax({
		   url:"<%=request.getContextPath() %>/member/artInfo!setUpImgForDefault.htm?artId=<%=artId%>",
		   type:'POST',
		   success:function(data){
			    if(data == "1"){
					art.dialog.open('<%=request.getContextPath()%>/register/registerAction!success3.htm',{width:620,height:400,lock:true,resize: false,fixed:true,close: function () {
				     		 window.location = "<%=request.getContextPath()%>/member/userinfo.htm";
				  		}
						});
					//window.location = "<%=request.getContextPath()%>/register/registerAction!success3.htm";
					//window.location = "<%=request.getContextPath()%>/member/userinfo.htm";
				}
		   }
		});
}

function submitXC(){
			 $.ajax({
			   url:"<%=request.getContextPath() %>/member/artInfo!saveOrUpdateArtInfo.htm?id=<%=step1_tappUser.getId()%>&sign="+1,
			   type:'POST',
			   data:$("#artInfoForm").serialize(),
			   success:function(data){
				    if(data == "1"){
					 setUpImgForDefault();
					}
			   }
			});
}



function jcxx_submit(){
	if(checknull()){
			$.ajax({
			   url:"<%=request.getContextPath() %>/member/userinfo!saveOrUpdate.htm?norSign=<%=request.getParameter("norSign")%>",
			   type:'POST',
			   data:$("#jcxxForm").serialize(),
			   success:function(data){
				   if(data == "1"){
						submitXC();
					   art.dialog.tips("保存成功！请等待页面跳转……", 3);
				   }
			   }
			});
	}
}

//swfobject.embedSWF("<%=request.getContextPath() %>/theme/flex/headImage.swf", "altContent", "650", "500", "9.0.0", "expressInstall.swf", flashvars, params, attributes);

function checknull(){
	var nickName=$("#userInfo\\.nickName").val();
	if(nickName==""){
		art.dialog.tips("昵称不能为空！", 2);
		return false;
	}
	var hasZhiYe = false;
	for(var i=1;i<=5;i++){
		if($("#div_"+i).html().indexOf("toDeleteCost")>0){
			hasZhiYe = true;
			break;
		}
	}
	if(hasZhiYe==false){
		art.dialog.tips("亲，请填写您的职业价格，这将直接影响到客户与您的交易意向哦。", 2);
		return false;
	}

	if($("#pic001").attr("src").indexOf("no_img")>0){
		art.dialog.tips("请上传头像照！", 2);
		return false;
	}
	if($("#pic002").attr("src").indexOf("no_img")>0){
		art.dialog.tips("请上传演出照或作品照！", 2);
		return false;
	}
	return true;
}

 
</script>


  </body>
</html>