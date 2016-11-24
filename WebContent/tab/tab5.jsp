<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<SCRIPT type=text/javascript src="<%=request.getContextPath() %>/theme/js2/jquery-1.7.1.min.js"></SCRIPT>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
<script type="text/javascript" language="javascript" src="<%=path %>/01stageDialog/jquery.artDialog.js"></script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<SCRIPT type=text/javascript src="<%=request.getContextPath() %>/theme/js2/common.js"></SCRIPT>
<title>tab切换</title>
<style type="text/css">
body{margin:0;padding:0;font-size:12px;font-family: "微软雅黑",Arial;}
a{color:#000; text-decoration:none;}
ul{padding:0; margin:0; list-style:none; }
.l{float:left}
img,input{border:0;}
form,ul,li,dl,dd,p,dt,img{margin:0;padding:0;}
img{border:none;}
.bj{width:690px;height:370px;background:#f8f8f8}
#box{width:690px;height:30px;padding:16px 0;}
#box li{float:left;margin-left:5px;margin-top:5px}
#box li a{display:block;line-height:30px;text-align:center;color:#a1a1a1;font-weight:bold;padding:0 15px}
#box .cc a{color:#fff;background:#f86a00 ;font-size:14px;}
.con{width:690px;height:310px;}
#con1,#con2,#con3,#con4,#con5,#con6,#con7,#con8{display:none}
.con-zhong{width:678px;height:293px;background:url(../theme/images2/tu104.jpg) repeat-x;padding:7px 0}
.showCss{
			cursor: pointer;
			background-color: black;
			z-index: 1001;
			position: absolute;
			opacity: 0.65;
		}
</style>
<script type="text/javascript">  
function handleImgLoadError(oEvent)
   	{
       oEvent.srcElement.src='<%=request.getContextPath()%>/theme/images2/tu208-1.png';
  	 }
  	 function changeCss(e,opera,flag){
		if(opera==1){
				document.getElementById("photo").style.display = "";
		}else{
				document.getElementById("photo").style.display = "none";
		}
	}
	function updatePro1(id){
			art.dialog.open('<%=request.getContextPath() %>/member/presonList!updateView.htm?id='+id+'&flag=4',{width:850,height:500,close: function () {
				     		 location.reload();
				  		}});

	}
</script>
</head>

<body>

<div class="bj">
<div id="box">
<ul class="pp2 l">
   <li value="0" class="cc"><a href="javascript:void(0)">相册</a></li>
   <li value="1" ><a href="javascript:void(0)">视频</a></li>
   <li value="2" ><a href="javascript:void(0)">音频</a></li>

</ul>
</div>

 <div align="left"><!--
<div class="con" id="con0">
 <p class="con-left l"><img src="../theme/images2/tu102.jpg" width="6" height="307" /></p>
 
 <div class="con-zhong l" >
 <div class="showCss" style="display:none; width: 672px;height: 320px;" id="photo" onmouseout="changeCss(this,2,4)" onclick='updatePro1(${id})'>
	<table width="100%" style="height: 320px;">
		<tr>
			<td style="font-size: 14px;color: #eeeeee;font-weight: bold;" align="center">编辑</td>
		</tr>
	</table>
 </div>
 
 <s:if test="#request.nowId==#request.userId">
   <img id="index" src="<%=request.getContextPath() %>/${vo.url}" onerror="handleImgLoadError(event);" onmouseover="changeCss(this,1,4);"  title="编辑"  width="672" height="292"></img>
</s:if>
<s:else>
	 <img id="index" src="<%=request.getContextPath() %>/${vo.url}" onerror="handleImgLoadError(event);"  width="672" height="292"></img>
</s:else>
   </div>
 <p class="con-right l"><img src="../theme/images2/tu103.jpg"  width="6" height="307" /></p>
</div>
 --> 
<script language="javascript">
function $(id){return document.getElementById(id)}
 for(i=0;i<3;i++){
   $("box").getElementsByTagName("li")[i].onclick=function(){
		 for(n=0;n<3;n++){
// 			 $("con"+n).style.display="none";
			 $("box").getElementsByTagName("li")[n].style.background="";
			 $("box").getElementsByTagName("li")[n].className="";
		 }
		v=this.value;
// 		$("con"+v).style.display="block";
		this.style.background="#f86a00";
		this.className="cc";
		parent.showList(v+1);
	 }
   }
document.getElementById("box").getElementsByTagName("li")[0].onclick();
</script> 
</div></div>

</body>
</html>
