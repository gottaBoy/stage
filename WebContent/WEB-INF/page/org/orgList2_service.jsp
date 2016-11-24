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
  <!-- page/org/orgList2_service.jsp -->

    <script src="http://tjs.sjs.sinajs.cn/open/api/js/wb.js" type="text/javascript" charset="utf-8"></script>
    <title><%=StageVariale.title%></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<META HTTP-EQUIV="Cache-Control" CONTENT="no-store, must-revalidate"> 
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">

	<link rel="stylesheet" href="<%=request.getContextPath() %>/theme/org/css/style2.css" />
	<script type="text/javascript" src="<%=request.getContextPath() %>/theme/user/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/theme/user/js/select.js"></script>
	<SCRIPT type=text/javascript src="<%=request.getContextPath() %>/theme/js2/common.js"></SCRIPT>

	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/idialog.css">
 	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />

	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>

<script language="javascript">
$(document).ready(function(){
		//getServices(1,0,8); 
		getArtUsers(1,0,24,0,0,0)
});
function replaceImg(obj){
	obj.src = '<%=request.getContextPath() %>/theme/images/tu03.jpg';
	obj.onerror=null;  
}
function getArtUsers(currentPage,begin,length,sex,pro,pri) {
	$.ajax({
		url:"<%=request.getContextPath()%>/index/presonList!getArtUserList.htm?actionName=${actionName}&id=${id}&currentPage="+currentPage+"&length="+length+"&begin="+begin+"&sex="+sex+"&pro="+pro+"&pri="+pri,
		type:'POST',
		dataType:'json',  
		success:function(data){
			$("#list").empty("");

			var total = data.total;
			var currentPage = parseInt(data.currentPage);
			var d = eval(data.list);

			var htmls = '<div class="fwxm_tab">';
				htmls += '<a href="#" onmouseover="getArtUsers(1,0,'+length+',0,0,0)" class="on">艺人资源</a>';
				htmls += '<a href="#" onmouseover="getServices(1,0,24)">服务项目</a>';
				htmls +='</div>';

				htmls += '<div class="fwxm_xx">';
				htmls += '<dl>';
				htmls += '<dd>性别：</dd>';
				
				if(sex==2){
					htmls += '<dt><a href="javascript:getArtUsers(1,0,'+length+',0,'+pro+','+pri+')">全部</a></dt>';
					htmls += '<dt><a href="javascript:getArtUsers(1,0,'+length+',1,'+pro+','+pri+')">男</a></dt>';
					htmls += '<dt class="on"><a href="javascript:getArtUsers(1,0,'+length+',2,'+pro+','+pri+')">女</a></dt>';
				}else if(sex==1){
					htmls += '<dt><a href="javascript:getArtUsers(1,0,'+length+',0,'+pro+','+pri+')">全部</a></dt>';
					htmls += '<dt class="on"><a href="javascript:getArtUsers(1,0,'+length+',1,'+pro+','+pri+')">男</a></dt>';
					htmls += '<dt><a href="javascript:getArtUsers(1,0,'+length+',2,'+pro+','+pri+')">女</a></dt>';
				}else{
					htmls += '<dt class="on"><a href="javascript:getArtUsers(1,0,'+length+',0,'+pro+','+pri+')">全部</a></dt>';
					htmls += '<dt><a href="javascript:getArtUsers(1,0,'+length+',1,'+pro+','+pri+')">男</a></dt>';
					htmls += '<dt><a href="javascript:getArtUsers(1,0,'+length+',2,'+pro+','+pri+')">女</a></dt>';
				}
				

				htmls += '</dl>';
				htmls += '</div>';

				htmls += '<div class="fwxm_xx">';
				htmls += '<dl>';
				htmls += '<dd>职业：</dd>';

				var proArr = new Array("全部","演员","音乐","舞蹈","模特","达人","幕后");
				for(var i=0; i<proArr.length; i++){
					htmls += '<dt '+((i==pro)?'class="on"':' ')+'><a href="javascript:getArtUsers(1,0,'+length+','+sex+','+i+','+pri+')">'+proArr[i]+'</a></dt>';
				}

				htmls += '</dl>';
				htmls += '</div>';

				htmls += '<div class="fwxm_xx">';
				htmls += '<dl>';
				htmls += '<dd>职业：</dd>';

				var priArr = new Array("全部","小于500","500-999","1000-1999","2000-2999","大于等于3000");
				for(var i=0; i<priArr.length; i++){
					htmls += '<dt '+((i==pri)?'class="on"':' ')+'><a href="javascript:getArtUsers(1,0,'+length+','+sex+','+pro+','+i+')">'+priArr[i]+'</a></dt>';
				}
				htmls += '</dl>';
				htmls += '</div>';



				htmls += '<div class="fwxm_yrzy_c Layout">';
				htmls += '<div class="fwxm_yrzy_c_hidden">';
				htmls += '<ul>';
			
			for(var i = 0; i < d.length; i++) {
				var obj = d[i];

				htmls += '<li>';
				htmls += '<div class="fwxm_yrzy_c_img"><a href="<%=request.getContextPath()%>/index/presonList.htm?id='+obj.id+'"><img src="/stageUpload/indexHeadImage/'+obj.id+'.png" width="140" height="140"  onerror="javascript:replaceImg(this)" /></a></div>';
				htmls += '<div class="fwxm_yrzy_c_name"><a href="" >'+obj.nickName+'</a></div>';
				htmls += '<div class="fwxm_yrzy_c_zy"><p>职业：<span>'+obj.profession+'</span></p></div>';

				if(!obj.popularityTotal){
					obj.popularityTotal = 0;
				}

				htmls += '<div class="fwxm_yrzy_c_dj">人气：<span>'+obj.popularityTotal+'次</span></div>';
				htmls += '</li>';
			}
			htmls += '</ul>';

			var pageLength = length;
			var pages = Math.ceil(total/pageLength);
			var pagesCont = "";
			if(pages>0){
				htmls += "<div class='Paging'  style='clear:both;float:left'>";

				if(currentPage>1){
					pagesCont += "<a href='javascript:getArtUsers("+(currentPage-1)+","+((currentPage-2)*pageLength)+","+pageLength+","+sex+","+pro+","+pri+")' class='Opage'><img src='/theme/user/images/Opage.png' width='15' height='15' /></a>";
				}
				if(pages>1){
					for(var i=1;i<=pages;i++){
						pagesCont += "<a "+(i==currentPage?'class="on"':'')+"href='javascript:getArtUsers("+i+","+((i-1)*pageLength)+","+pageLength+","+sex+","+pro+","+pri+")'>"+i+"</a>";
					}
				}
				if(currentPage<pages){
					pagesCont += "<a href='javascript:getArtUsers("+(currentPage+1)+","+((currentPage)*pageLength)+","+pageLength+","+sex+","+pro+","+pri+")' class='Opage'><img src='/theme/user/images/Npage.png' width='15' height='15' /></a>";
				}
				pagesCont += "</div>";

				htmls += pagesCont;
			}
				

			$("#list").append(htmls);

		}
	});
}
 
function getServices(currentPage,begin,length) {

	$.ajax({
		url:"<%=request.getContextPath()%>/index/presonList!getServiceProjectList.htm?actionName=${actionName}&id=${id}&currentPage="+currentPage+"&length="+length+"&begin="+begin,
		type:'POST',
		dataType:'json',  
		success:function(data){
			$("#list").empty("");

			var total = data.total;

			var currentPage = parseInt(data.currentPage);
			var d = eval(data.list);

			var htmls = '<div class="fwxm_tab">';
				htmls += '<a href="#" onmouseover="getArtUsers(1,0,'+length+',0,0,0)">艺人资源</a>';
				htmls += '<a href="#" onmouseover="getServices(1,0,'+length+')" class="on">服务项目</a>';
				htmls +='</div>';
				htmls += '<div class="fwxm_fwxm_c Layout">';

			for(var i = 0; i < d.length; i++) {
				var obj = d[i];
				htmls += '<dl>';
				htmls += '<dd><a href="<%=request.getContextPath()%>/index/orgListAction.htm?id=${id}&serviceId='+obj.id+'&actionName=orgServiceDetail#orgTab"><img src="'+obj.bulletinImg+'" width="165" height="110" /></a></dd>';
				htmls += '<dt>';
				htmls += '<h2><a href="<%=request.getContextPath()%>/index/orgListAction.htm?id=${id}&serviceId='+obj.id+'&actionName=orgServiceDetail#orgTab">'+obj.title+'</a></h2>';
				htmls += '<div class="fwxm_fwxm_c_jg"><span>'+obj.price+'</span>元/'+obj.unit+'<i>起</i></div>';
				//htmls += '<div class="fwxm_fwxm_c_b Margin Layout"><a href="">已成交：（<span>200</span>次）</a><a href="">评论：（<span>60</span>）</a></div>';
				htmls += '<div class="fwxm_fwxm_c_b Layout"><!-- <a href=""><img src="images/gmfw.png" width="96" height="30" /></a> --><a href="#" class="fwxm_fwxm_c_b_fx">分享</a></div>';
				htmls += '</dt>';
				htmls += '</dl>';

			}
 
			var pageLength = length;
			var pages = Math.ceil(total/pageLength);
			var pagesCont = "";
			if(pages>0){
				htmls += "<div class='Paging' style='clear:both;float:left'>"; 

				if(currentPage>1){
					pagesCont += "<a href='javascript:getServices("+(currentPage-1)+","+((currentPage-2)*pageLength)+","+pageLength+")' class='Opage'><img src='/theme/user/images/Opage.png' width='15' height='15' /></a>";
				}
				if(pages>1){
					for(var i=1;i<=pages;i++){
						pagesCont += "<a "+(i==currentPage?'class="on"':'')+"href='javascript:getServices("+i+","+((i-1)*pageLength)+","+pageLength+")'>"+i+"</a>";
					}
				}
				if(currentPage<pages){
					pagesCont += "<a href='javascript:getServices("+(currentPage+1)+","+((currentPage)*pageLength)+","+pageLength+")' class='Opage'><img src='/theme/user/images/Npage.png' width='15' height='15' /></a>";
				}
				pagesCont += "</div>";

				htmls += pagesCont;
			}
			htmls += '</div>';

			

			$("#list").append(htmls);
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
 




<div class="fwxm mian Layout" id="list">

</div>



<!-- main -->


<jsp:include page="/WEB-INF/page/public/footer.jsp"></jsp:include>

</body>
</html>
