<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	UserSession userSession = HttpSessionHelper.getUserSession(request) ;

	String hasNoMy=(String)session.getAttribute("hasNoMy");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--  public/jobChance.jsp-->
<title><%=StageVariale.title%></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
<META HTTP-EQUIV="Cache-Control" CONTENT="no-store, must-revalidate"> 
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">

<link rel="stylesheet" href="<%=path%>/theme/job/css/style2.css" />
<script type="text/javascript" src="<%=path%>/theme/job/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=path%>/theme/job/js/common.js"></script>
<script type="text/javascript" src="<%=path%>/theme/job/js/Focus.js"></script>
<script type="text/javascript" src="<%=path%>/theme/job/js/xsgd.js"></script>
<script type="text/javascript" src="<%=path%>/theme/job/js/select.js"></script>
<script type="text/javascript" src="<%=path%>/theme/job/js/select2.js"></script>

<script type="text/javascript" src="<%=path%>/theme/js2/common.js"></script>

<script type="text/javascript" src="<%=path%>/theme/fenlei/js/common.js"></script>
</head>
<body>


<script language="javascript">
var currentTab = 0;

function publishTask(){
	<%if(userSession != null){%>
		this.location = "<%=request.getContextPath()%>/member/task.htm?userId=<%=userSession.getId() %>";
	<%}else{
		//art.dialog.alert("请先登录！");

			
		String url ="?r="+HttpSessionHelper.urlEncode("/member/task.htm?userId=@{loginUserId}");
		%>
		parent.showPop(2,'<%=request.getContextPath() %>/loginHtml.htm<%=url%>');
	<%}%>
}
function searchForm(){
	if(currentTab==0){
		getTaskList(1,0,10,$("#keyType2").val(),$("#searchContent").val(),"1");
	}else if(currentTab==1){
		getTaskList(1,0,10,$("#keyType2").val(),$("#searchContent").val(),"");
	}else{
		getZhaoPinList(1,0,10,$("#keyType2").val(),$("#searchContent").val());
	}
}

$(document).ready(function(){
	<%if(request.getParameter("getZP")!=null){%>
		currentTab = 2;
		getZhaoPinList(1,0,10,'','');
	<%}else{%>

	<%if("1".equals(request.getParameter("fromWeb"))){%>
		currentTab = 0;
	<%}else{%>
		currentTab = 1;
	<%}%>

		getTaskList(1,0,10,'','<%=(request.getParameter("searchContent")==null)?"":request.getParameter("searchContent") %>','<%=(request.getParameter("fromWeb")==null)?"":request.getParameter("fromWeb") %>')
	<%}%>
});

function replaceImg(obj){
		obj.src = '<%=request.getContextPath() %>/theme/images/tu03.jpg';
		obj.onerror=null;  
}

function pinfen(){
}
function removeThis(obj){
	$(obj).html('');
}

function getTaskList(currentPage,begin,length,city,searchContent,fromWeb) {
	if(fromWeb=="1"){
		currentTab = 0;
	}else{
		currentTab = 1;
	}

 	$.ajax({
		url:"<%=request.getContextPath()%>/query/queryAction!findTask.htm",
		type:'POST',
		data:{
			currentPage:currentPage,
			begin:begin,
			length:length,
			city:city,
			fromWeb:fromWeb,
			searchContent:searchContent
		},
		dataType:'json',  
		success:function(data){

			$("#list").empty("");
  			var total = data.total;
			var currentPage = parseInt(data.currentPage);
			var d = eval(data.list);

			var htmls = '<div class="Searchgz_list_t">';
				htmls += '<a  onclick="javascript:getTaskList(1,0,10,\'\',\'\',\'1\')"   id="a0" '+((fromWeb=="1")? "class=\"on\"":""  )+' >通告市集</a><a  onclick="javascript:getTaskList(1,0,10,\'\',\'\',\'\')"  id="a1" '+((fromWeb!="1")? "class=\"on\"":""  )+'>演艺机会</a><a  onclick="javascript:getZhaoPinList(1,0,10,\'\',\'\')" id="a2" >企业招聘</a>';
				htmls += '</div>'
				htmls += '<div class="Searchgz_list_yyjh Layout" id="con_a_1" style="display:block">';

			for(var i = 0; i < d.length; i++) {
				var obj = d[i];

				htmls += '<div class="Searchgz_list_c Layout">';
				htmls += '    <div class="Searchgz_list_c_l fl">';
				htmls += '        <div class="Searchgz_list_c_l_c">';
				htmls += '            <a href="<%=path%>/orgListAction.htm?id='+obj.id+'" ><img src="'+obj.img+'" onerror="javascript:replaceImg(this)"/></a> ';
				htmls += '        </div>';
				htmls += '    </div>';
				htmls += '<div class="Searchgz_list_c_r Layout fl">';
				htmls += '<div class="Searchgz_list_c_r_time"><span><a href="<%=path%>/orgListAction.htm?id='+obj.id+'">'+obj.nickName+'</a>';
				htmls += '</span><span style="float:right;margin-right:100px;">'+obj.taskPublishTime+'发布</span></div>';
				htmls += '    <div class="Searchgz_list_c_r_c"><p class="Searchgz_list_c_r_c_zp" >';
				htmls += '         <a href="<%=path%>/taskMore/taskMore!toTaskMoreDetail.htm?fromWeb='+fromWeb+'&id='+obj.taskId+'">'+obj.taskTitle+'</a></p><a class="Searchgz_list_c_r_c_Address">'+obj.city+'</a></div>';

				if(fromWeb!="1"){
					htmls += '    <div class="Searchgz_list_c_r_Price"><span>'+obj.taskPrice+'</span> 元</div>';
				}

				htmls += '    <div class="Searchgz_list_c_r_kk">';
				htmls += '    <a href="<%=path%>/taskMore/taskMore!toTaskMoreDetail.htm?fromWeb='+fromWeb+'&id='+obj.taskId+'" >去看看</a>';
				htmls += '    </div>';
				htmls += '    </div>';
				htmls += '    </div>';

			}

			var pageLength = length;
			var pages = Math.ceil(total/pageLength);
			var pagesCont = "";
			if(pages>0){
				htmls += "<div class='Paging'  style='clear:both;float:left'>";

				if(currentPage>1){
					pagesCont += "<a href=\"javascript:getTaskList("+(currentPage-1)+","+((currentPage-2)*pageLength)+","+pageLength+",'"+city+"','"+searchContent+"','"+fromWeb+"')\" class='Opage'><img src='/theme/user/images/Opage.png' width='15' height='15' /></a>";
				}
				if(pages>1){
					
					for(var i=1;i<=pages;i++){
						pagesCont += "<a "+(i==currentPage?'class="on" ':'')+"href=\"javascript:getTaskList("+i+","+((i-1)*pageLength)+","+pageLength+",'"+city+"','"+searchContent+"','"+fromWeb+"')\">"+i+"</a>";
					}
				}
				if(currentPage<pages){
					pagesCont += "<a href=\"javascript:getTaskList("+(currentPage+1)+","+((currentPage)*pageLength)+","+pageLength+",'"+city+"','"+searchContent+"','"+fromWeb+"')\"  class='Opage'><img src='/theme/user/images/Npage.png' width='15' height='15' /></a>";
				}
				pagesCont += "</div>";

				htmls += pagesCont;
			}
			

			$("#list").append(htmls);
 


		}
	});
}
 

function getZhaoPinList(currentPage,begin,length,city,searchContent) {//findWork
	currentTab = 2;
 	$.ajax({
		url:"<%=request.getContextPath()%>/query/queryAction!findWork.htm",
		type:'POST',
		data:{
			currentPage:currentPage,
			begin:begin,
			length:length,
			city:city,
			searchContent:searchContent
		},
		dataType:'json',  
		success:function(data){

			$("#list").empty("");
  			var total = data.total;
			var currentPage = parseInt(data.currentPage);
			var d = eval(data.list);

			var htmls = '<div class="Searchgz_list_t">';
				htmls += '<a   onclick="javascript:getTaskList(1,0,10,\'\',\'\',\'1\')"  id="a0" >通告市集</a><a  onclick="javascript:getTaskList(1,0,10,\'\',\'\',\'\')"  id="a1">演艺机会</a><a    class="on" id="a2" >企业招聘</a>';
				htmls += '</div>'
				htmls += '<div class="Searchgz_list_yyjh Layout" id="con_a_1" style="display:block">';

			if(d.length==0){
				htmls += '<div class="Searchgz_list_c Layout" style="height:200px"></div>';
			}
			for(var i = 0; i < d.length; i++) {
				var obj = d[i];

				htmls += '<div class="Searchgz_list_c Layout">';
				htmls += '    <div class="Searchgz_list_c_l fl">';
				htmls += '        <div class="Searchgz_list_c_l_c">';
				htmls += '            <a href="<%=path%>/orgListAction.htm?id='+obj.id+'" ><img src="'+obj.img+'"/></a> ';
				htmls += '        </div>';
				htmls += '    </div>';
				htmls += '<div class="Searchgz_list_c_r Layout fl">';
				htmls += '<div class="Searchgz_list_c_r_time"><span><a href="">'+obj.nickName+'</a></span><span style="float:right;margin-right:100px;">'+obj.taskPublishTime+'发布</span></div>';
				htmls += '    <div class="Searchgz_list_c_r_c"><p class="Searchgz_list_c_r_c_zp" >';
				htmls += '         <a href="'+obj.taskId+'" >'+obj.taskTitle+'</a></p><a class="Searchgz_list_c_r_c_Address">'+obj.city+'</a></div>';
				htmls += '    <div class="Searchgz_list_c_r_Price"><span>'+obj.taskPrice+'</span> </div>';
				htmls += '    <div class="Searchgz_list_c_r_kk">';
				htmls += '    <a href="<%=path%>/orgListAction.htm?id='+obj.id+'&actionName=orgZhaoPin"  target="_blank">去看看</a>';
				htmls += '    </div>';
				htmls += '    </div>';
				htmls += '    </div>';

			}
 


			var pageLength = length;
			var pages = Math.ceil(total/pageLength);
			var pagesCont = "";
			if(pages>0){
				htmls += "<div class='Paging'  style='clear:both;float:left'>";

				if(currentPage>1){
					pagesCont += "<a href=\"javascript:getZhaoPinList("+(currentPage-1)+","+((currentPage-2)*pageLength)+","+pageLength+",'"+city+"','"+searchContent+"')\" class='Opage'><img src='/theme/user/images/Opage.png' width='15' height='15' /></a>";
				}
				if(pages>1){
					
					for(var i=1;i<=pages;i++){
						pagesCont += "<a "+(i==currentPage?'class="on" ':'')+"href=\"javascript:getZhaoPinList("+i+","+((i-1)*pageLength)+","+pageLength+",'"+city+"','"+searchContent+"')\">"+i+"</a>";
					}
				}
				if(currentPage<pages){
					pagesCont += "<a href=\"javascript:getZhaoPinList("+(currentPage+1)+","+((currentPage)*pageLength)+","+pageLength+",'"+city+"','"+searchContent+"')\"  class='Opage'><img src='/theme/user/images/Npage.png' width='15' height='15' /></a>";
				}
				pagesCont += "</div>";

				htmls += pagesCont;
			}
			

			$("#list").append(htmls);
 


		}
	});
}
</script>

<div class="top Layout">
<div class="top_t">

<%@include file= "/WEB-INF/page/public/top3.jsp"%>

</div>
<div class="top_c">
	<div class="top_c_nav mian Layout">
   	  <div class="top_c_nav_l fl" style="margin-left:-34px;">
      	<ul>
        	<li class="fwfl"><a >全部服务分类</a><div class="arrow_Downward"></div>
              <div class="Cnav" id="fwfl_c">


<%@include file= "/WEB-INF/page/public/menu.jsp"%>


 

<div class="mian4 Layout">
	<div class="Searchgz_l fl">
		<div class="Searchgz_Search">
        <form method="post" name="">
            <div class="searchbox">
            <div id="options2">
            <dl>
            <dt>
            <input type="text" value="全国"  id="text2" />
            <input id="keyType2" type="hidden" value=""  />
            <b></b>
            </dt>
            <dd>
            <div class="Hot">
            <strong>热门：</strong>
            <span id="上海">上海</span>
            <span id="宁波">宁波</span>
			<span id="乌镇">乌镇</span>
            <span id="杭州">杭州</span>
            <span id="嘉兴">嘉兴</span>
            <span id="苏州">苏州</span>
            <span id="其他">其他</span>
            </div>
            </dd>
            </dl>
            </div>
            <div id="inputbox"><input type="text" name="" id='searchContent' value="请输入关键词" class="birds2" /></div>
            <input type="button" id="" onclick="javascript:searchForm()" value="搜 索" name="" class="sreachbtn" />
            </div>
            <div class="Searchgz_Search_Label">热门：<a href="javascript:getTaskList(1,0,2,'','歌手','')" >歌手</a><a href="javascript:getTaskList(1,0,2,'','广告女主角','')" >广告女主角</a><a href="javascript:getTaskList(1,0,2,'','舞蹈','')" >舞蹈</a><a href="javascript:getTaskList(1,0,2,'','演员','')" >演员</a><a href="javascript:getTaskList(1,0,2,'','小提琴演奏','')" >小提琴演奏</a></div>
        </form>
    </div>













    	<div class="Searchgz_list Layout" id="list">
 
 
        </div>
    </div>












<div class="Searchgz_r">
  <div class="Searchgz_fbrw">
	  <p class="Searchgz_fbrw_t">我也要发布任务，<br />坐等艺人上门服务。</p>
	  <a href="javascript:publishTask()"  class="Searchgz_fbrw_b"><img src="<%=path%>/theme/job/images/Searchgz_fbrw_b.jpg" width="121" height="40" /></a>
	</div>
  <div class="Searchgz_dh">
	  <p class="Searchgz_dh_t">发布任务嫌麻烦？<br />交给第一舞台，为您提供高<br />效、优质的项目解决方案</p>
	  <div class="Searchgz_dh_b">021-52902120</div>
	</div>
<!-- 	<div class="Searchgz_gg">
		<a href=""  target="_blank"><img src="<%=path%>/theme/job/images/Searchgz_gg.jpg" width="259" height="125" /></a>
	</div> -->
</div>
</div>



<!-- foot  -->
<jsp:include page="/WEB-INF/page/public/footer.jsp"></jsp:include>

</body>
</html>
