<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    
    <title><%=StageVariale.title%></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/layout.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/common.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<style type="text/css">
	.btn1 {
		width:300px; 
		height:36px; 
		border:0px; 
		cursor:pointer;
		background-image:url(<%=request.getContextPath() %>/theme/images2/user_share_btn3.png);
		margin-left:5px;
		font-size:20px;
		font-weight:bold;
		color:#000;
		line-height:36px;
	}
	.btn2 {
		width:300px; 
		height:36px; 
		border:0px; 
		cursor:pointer;
		background-image:url(<%=request.getContextPath() %>/theme/images2/user_share_btn4.png);
		margin-left:5px;
		font-size:20px;
		font-weight:bold;
		line-height:36px;
	}
	</style>
	
<script type="text/javascript">

$(document).ready(function(){
	
	$("#jcxxTd1").css("display", "block");
});

function setIsShare() {
	var isShare = 1;
	if($("#isShare").attr("checked")) {
		isShare = 2;	
	}
	$.ajax({
		url:"<%=request.getContextPath() %>/member/userinfo!setIsShare.htm?isShare="+isShare,
	 	type:'POST',
	   	success:function(data){
		   	
	   	}
	});
}

function openUserInfo() {
	window.open("<%=request.getContextPath() %>/presonList.htm?id=${request.user.userId}");
}
</script>
  </head>
  <body>

<table border="0" cellpadding="0" cellspacing="0" width="600" style="margin-top:10px;margin-left:10px;margin-right:10px;">
  <tr height="50">
    <td align="left"><div style="font-size:14px; font-weight:bold; height:50px; line-height:50px; float:left;">个人资料完整度已达到<s:property value='#request.wzd'/>%</div><div style="float:left; font-size:28px; font-weight:bold; color:#ff6600; margin-left:65px;height:50px; line-height:50px;">恭喜!</div>
    </td>
  </tr>
  <tr height="230">
    <td align="left">
      <div style="float:left;"><img height="86" width="97" src="<%=request.getContextPath() %>/theme/images2/u6_normal.png" /></div>
      <div style="float:left; font-size:28px; font-weight:bold; color:#ff6600; margin-left:10px; width:470px;">
        <s:if test="#request.wzd==50">
        您在第1舞台初步展现了自己的魅力!
        <div style="margin-top:20px;">
          <div class="btn1" onclick="art.dialog.close()" onmouseover="this.className='btn2'" onmouseout="this.className='btn1'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A：继续添加</div>
          <div style="margin-top:10px;" class="btn1" onclick="openUserInfo()" onmouseover="this.className='btn2'" onmouseout="this.className='btn1'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;B：进入我的个人主页</div>
        </div>
        </s:if>
        <s:elseif test="#request.wzd>=60 && #request.wzd<100">
        您的资料完成度已超过60%快被世人所知了！加油！
        <div style="margin-top:20px;">
          <div class="btn1" onclick="art.dialog.close()" onmouseover="this.className='btn2'" onmouseout="this.className='btn1'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A：继续添加</div>
          <div style="margin-top:10px;" class="btn1" onclick="openUserInfo()" onmouseover="this.className='btn2'" onmouseout="this.className='btn1'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;B：进入我的个人主页</div>
        </div>
        </s:elseif>
        <s:elseif test="#request.wzd==100">
        您已完成第一舞台的所有资料，您将向世界展现您的魅力！
        <div style="margin-top:20px;">
          <div class="btn1" onclick="openUserInfo()" onmouseover="this.className='btn2'" onmouseout="this.className='btn1'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;B：进入我的个人主页</div>
          </div>
        </s:elseif>
      </div>
    </td>
  </tr>
  <tr height="30">
    <td align="center">
      <div class="jiathis_style"><span class="jiathis_txt">分享到：</span>
        <a class="jiathis_button_icons_1"></a>
        <a class="jiathis_button_icons_2"></a>
        <a class="jiathis_button_icons_3"></a>
        <a class="jiathis_button_icons_4"></a>
        <a class="jiathis_button_icons_5"></a>
        <a href="http://www.jiathis.com/share" class="jiathis jiathis_txt jiathis_separator jtico jtico_jiathis" target="_blank"></a>
        <a class="jiathis_counter_style"></a>
      </div>
        <script type="text/javascript" >
        var yrname = "${request.user.nickName}";
		//http://d15t.com/member
        var yrurl = "http://d15t.com/presonList.htm?id=${request.user.userId}";
        var jiathis_config={
            url:yrurl,
            summary:"我在第一舞台发现了ta，非常棒！",
            title:"超喜欢 #"+yrname+"#",
            shortUrl:false,
            hideMore:false
        }
        </script>
		<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
    </td>
  </tr>
  <tr height="30">
    <td align="left">
      <div style="font-size:20px; font-weight:bold; color:#ff6600; margin-left:5px;">
        点击以上分享功能将我的喜悦分享给小伙伴们！
      </div>
    </td>
  </tr>
  <tr height="50">
    <td align="center">&nbsp;
    </td>
  </tr>
</table>
          
  </body>
</html>