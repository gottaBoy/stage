<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="pg" uri="/page-tags"%>  
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	UserSession userSession = HttpSessionHelper.getUserSession(request) ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
  <!-- page/org/orgList2_zuopin.jsp -->

    <script src="http://tjs.sjs.sinajs.cn/open/api/js/wb.js" type="text/javascript" charset="utf-8"></script>
    <title><%=StageVariale.title%></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<META HTTP-EQUIV="Cache-Control" CONTENT="no-store, must-revalidate"> 
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">

	<link rel="stylesheet" href="<%=request.getContextPath() %>/theme/org/css/style2.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/idialog.css">
 	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />

	<script type="text/javascript" src="<%=request.getContextPath() %>/theme/js2/common.js"></script>

	<script type="text/javascript" src="<%=request.getContextPath() %>/theme/user/js/jquery-1.7.2.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/theme/user/js/select.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/theme/user/js/jquery.SuperSlide.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/swfobject.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>

<script language="javascript">

$(document).ready(function(){
		getList(1); 
});

function openMovie(swfurl, type){
	var title = "";
	if(type == 2) {
		title = "视频播放";
	} else {
		title = "音频播放";
	}
	if(swfurl != ''){
		art.dialog({
			padding: 0,
			title: title,
			lock: true,
			content: "<embed src=\""+swfurl+"\" quality=\"high\" width=\"560\" height=\"480\" align=\"middle\" allowNetworking=\"all\" allowScriptAccess=\"always\" type=\"application/x-shockwave-flash\"></embed>"
		});
	}
}

function loadMovie(artId){
 	$.ajax({
		url:"<%=request.getContextPath()%>/index/presonList!getMovie.htm?artId="+artId,
		type:'POST',
		dataType:'json',  
		success:function(data){
			
			$("#imgList").empty("");
			var obj = eval(data.tAppArtInfo);
			var htmls = "<div style='width: 900px; height: 100%; clear: both;'><div style='width: 900px; text-align: center; padding-top: 150px; position: absolute; z-index: 4; left: 215px;'><a href='javaScript:openMovie(\""+obj.url+"\",2);' class='czjl_title_link'><img src='/theme/images/play.png'></a></div><div  style='position:relative; z-index:3;'>";
			htmls += "<img src='"+obj.img+"'  style='text-align:center;width:600px;'/></div></div>";

			$("#imgList").append(htmls);
			
		}
	});
}


function loadImg(artId){
 	$.ajax({
		url:"<%=request.getContextPath()%>/index/presonList!getImgList.htm?actionName=${actionName}&id=${id}&artId="+artId,
		type:'POST',
		dataType:'json',  
		success:function(data){
			$("#imgList").empty("");
			var d = eval(data.imgList);
			var htmls = "";
			if(d){
				for(var i = 0; i < d.length; i++) {
					//alert(json2str(d[i]));
					var obj = d[i];
					htmls += "   <p><img src="+obj.url+" width='600'  /></p>";
				}
			}

			$("#imgList").append(htmls);
		}
	});
}
 
function initTab(type){
	$("#typeDiv").empty("");
	var typeHtml = "";
	typeHtml += "<a href='javascript:getList(1)'"+(type==1?'class=\"on\"':'')+"><p class='xc'></p><span>相 册</span></a>";
	typeHtml += "<a href='javascript:getList(2)'"+(type==2?'class=\"on\"':'')+"><p class='sp'></p><span>视 频</span></a>";
	typeHtml += "<a href='javascript:getList(3)'"+(type==3?'class=\"on\"':'')+"><p class='yp'></p><span>音 频</span></a>";

	$("#typeDiv").append(typeHtml);
}

function getList(type) {
 	$("#list").empty("");
	$("#imgList").empty("");
	initTab(type);
 	$.ajax({
		url:"<%=request.getContextPath()%>/index/presonList!getZuoPinList.htm?actionName=${actionName}&id=${id}&type="+type,
		type:'POST',
		dataType:'json',  
		success:function(data){
 			var d = eval(data.artInfoList);
			var htmls = "<ul>";

			for(var i = 0; i < d.length; i++) {
				//alert(json2str(d[i]));
				var obj = d[i];
				if(data.type==1){
					htmls += "   <li>";
					htmls += "     <a href='javascript:loadImg("+obj[0]+")'>";
					htmls += "         <div class='xcsl'>"+obj[3]+"</div>";
					htmls += "           <div class='bd_c'>";
					htmls += "              <div class='bd_c_t'>";
					htmls += "                 <img src='"+obj[2]+"' width='172' height='164' /> ";
					htmls += "             </div>";
					htmls += "             <p>"+obj[1]+"</p>";
					htmls += "         </div>";
					htmls += "      </a>";
					htmls += "    </li>"; 
				}else if(data.type==2){
					htmls += "   <li>";
					htmls += "     <a href='javascript:loadMovie("+obj.id+")'>";
					htmls += "         <div class='xcsl'>1</div>";
					htmls += "           <div class='bd_c'>";
					htmls += "              <div class='bd_c_t'>";
					htmls += "                 <img src='"+obj.img+"' width='172' height='164' /> ";
					htmls += "             </div>";
					htmls += "             <p>"+obj.title+"</p>";
					htmls += "         </div>";
					htmls += "      </a>";
					htmls += "    </li>"; 
				}
			}
			htmls += "</ul>";

			$("#list").append(htmls);

			if(type==2){
				$("#imgList").empty("");
				var obj = eval(data.tAppArtInfo);
				var htmls = "<div style='width: 900px; height: 100%; clear: both;'><div style='width: 900px; text-align: center; padding-top: 150px; position: absolute; z-index: 4; left: 215px;'><a href='javaScript:openMovie(\""+obj.url+"\",2);' class='czjl_title_link'><img src='/theme/images/play.png'></a></div><div  style='position:relative; z-index:3;'><img src='"+obj.img+"'  style='text-align:center;width:600px;'/></div>";

				$("#imgList").append(htmls);
			}else if(type==1){
				$("#imgList").empty("");
				var d = eval(data.imgList);
				var htmls = "";

				if(d){
					for(var i = 0; i < d.length; i++) {
						var obj = d[i];
						htmls += "   <p><img src="+obj.url+"   width='600'/></p>";
					}
				}
				$("#imgList").append(htmls);
			}

			//内容初始化后再加下面代码，否则不动
			jQuery("#autoPage").slide({ titCell:".hd ul", mainCell:".bd ul",effect:"left",vis:5,scroll:5,autoPlay:false,autoPage:true});
		}
	});
}

</script>


  </head>
<body>
<div class="top Layout">
	<jsp:include page="/WEB-INF/page/public/org_header.jsp"></jsp:include>
</div>

<!-- main -->
 

<div class="xgzp_t Layout" id="typeDiv">
	
	
	
</div>
<div class="xgzp_c Layout">
  <div class="xgzp_c_xc Layout" id="autoPage">
        <div class="hd">
            <a class="next"></a>
            <!--<ul></ul>-->
            <a class="prev"></a>
        </div>
        <div class="bd" id="list">

        </div>
    </div>
    <div class="xgzp_c_zs" id="imgList">

    </div>
<div style="position: fixed;right: 0px;top: 100px;width: 20px;height: 100px;"><a href="#">回到顶部</a></div>	
</div>



<!-- main -->


<jsp:include page="/WEB-INF/page/public/footer.jsp"></jsp:include>

</body>
</html>
