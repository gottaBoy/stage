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
<!--  public/toOrg.jsp-->
<title><%=StageVariale.title%></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	
<META HTTP-EQUIV="Cache-Control" CONTENT="no-store, must-revalidate"> 
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">

<link rel="stylesheet" href="<%=path%>/theme/fenlei/css/style2.css" />
<script type="text/javascript" src="<%=path%>/theme/fenlei/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=path%>/theme/fenlei/js/common.js"></script>
<script type="text/javascript" src="<%=path%>/theme/fenlei/js/Focus.js"></script>
<script type="text/javascript" src="<%=path%>/theme/fenlei/js/xsgd.js"></script>
<script type="text/javascript" src="<%=path%>/theme/fenlei/js/select.js"></script>
</head>
<body>


<script language="javascript">
 
$(document).ready(function(){
		getOrgList(1,0,30,'','',0,'','','')
});

function nofind(){  
     var img=event.srcElement;  
     img.src='<%=request.getContextPath() %>/theme/images/tu03.jpg';
     img.onerror=null;      // 控制不要一直跳动  
}  

function replaceImg(obj){
	obj.src = obj.src.replace('indexHeadImage','headImage');
	obj.onerror=function(){
		obj.src = '<%=request.getContextPath() %>/theme/images/tu03.jpg';
		obj.onerror=null;  
	}
	//event.srcElement.onerror=nofind();
	//obj.src = '<%=request.getContextPath() %>/theme/images/tu03.jpg';
}

var orgTypeArr = new Array("不限","广告/公关","婚庆/会展","演艺经纪","剧团","影视制作","文化传媒","多媒体","幕后制作","动漫","租赁","舞美/布景");

var cityArr = new Array("不限"<s:iterator value="#request.cityList" var="city" status="st">,"${city}"</s:iterator>);

var renZhenArr = new Array("不限","企业认证","个人认证");

var sortArr = new Array("人气最旺","好评最多","签约最多");

function pinfen(){
}
function removeThis(obj){
	$(obj).html('');
}
function getOrgList(currentPage,begin,length,sex,place,pri,orgType,sort,renZheng) {
	if(place=="") place = "不限";
	
	if(renZheng=="") renZheng = "不限";
	if(orgType=="") orgType = "不限";

	$.ajax({
		url:"<%=request.getContextPath()%>/query/queryAction!toOrgQuery.htm",
		type:'POST',
		data:{
			currentPage:currentPage,
			length:length,
			begin:begin,
			sex:sex,
			place:place,
			priceIndex:pri,
			orgType:orgType,
			sort:sort,
			headKeywords:'${headKeywords}',
			renZheng:renZheng			
		},
		dataType:'json',  
		success:function(data){
			$("#list").empty("");

			var total = data.total;

			var currentPage = parseInt(data.currentPage);
			var d = eval(data.list);


			var htmls = '';

				htmls += '<div class="Type_yxz">';
				htmls += '<div class="Type_yxz_l fl">已选择：</div>';
				htmls += '<div class="Type_yxz_r fl">';
				

				if(orgType != '不限'){
					for(var i=0; i<orgTypeArr.length; i++){
						if(orgTypeArr[i]==orgType){ 
							htmls += '<a href="javascript:getOrgList('+(0)+','+0+','+length+',\''+sex+'\',\'\',\''+pri+'\',\'\',\''+sort+'\',\''+renZheng+'\')"'; 
							htmls += '>机构类型：<em>'+orgTypeArr[i];
							htmls += '</em><span></span></a>';
						}
					}
				}

				if(place != '不限'){
					for(var i=0; i<cityArr.length; i++){
						if(cityArr[i]==place){ 
							htmls += '<a href="javascript:getOrgList('+(0)+','+0+','+length+',\''+sex+'\',\'\',\''+pri+'\',\''+orgType+'\',\''+sort+'\',\''+renZheng+'\')"'; 
							htmls += '>所在地：<em>'+cityArr[i];
							htmls += '</em><span></span></a>';
						}
					}
				}

				if(sex >= 1 ){
					for(var i=0; i<sexArr.length; i++){
						if(i==sex){ 
							htmls += '<a href="javascript:getOrgList('+(0)+','+0+','+length+',\'\',\''+place+'\',\''+pri+'\',\''+orgType+'\',\''+sort+'\',\''+renZheng+'\')"'; 
							htmls += '>性别：<em>'+sexArr[i];
							htmls += '</em><span></span></a>';
						}
					}
				}

				if(renZheng != '不限' ){
					htmls += '<a href="javascript:getOrgList('+(0)+','+0+','+length+',\''+sex+'\',\''+place+'\',\''+pri+'\',\''+orgType+'\',\''+sort+'\',\'\')"'; 
					htmls += '>认证：<em>'+renZheng;
					htmls += '</em><span></span></a>';
				}


				htmls += '</div>';
				htmls += '</div>';


				htmls += '<div class="Type_c">';
				htmls += '<div class="Type_c_l fl">机构类型：</div>';
				htmls += '<div class="Type_c_r">';
				for(var i=0; i<orgTypeArr.length; i++){
					htmls += '<a href="javascript:getOrgList('+(0)+','+0+','+length+',\''+sex+'\',\''+place+'\',\''+pri+'\',\''+orgTypeArr[i]+'\',\''+sort+'\',\''+renZheng+'\')"'; 
					if(orgTypeArr[i]==orgType){ 
						htmls += ' class="on"  ';
					}					
					htmls += '>'+orgTypeArr[i]+'</a>';
				}
				htmls += '</div>';
				htmls += '</div>';


				htmls += '<div class="Type_c">';
				htmls += '<div class="Type_c_l fl">所在地：</div>';
				htmls += '<div class="Type_c_r Type_c_r_height">';

				for(var i=0; i<cityArr.length; i++){
					htmls += '<a href="javascript:getOrgList('+(0)+','+0+','+length+',\''+sex+'\',\''+cityArr[i]+'\',\''+pri+'\',\''+orgType+'\',\''+sort+'\',\''+renZheng+'\')"'; 
					if(cityArr[i]==place){ 
						htmls += ' class="on"  ';
					}					
					htmls += '>'+cityArr[i]+'</a>';
				}

				htmls += '</div>';
				htmls += '<span class="Type_c_More">更多∨</span>';
				htmls += '</div>';
 

				htmls += '<div class="Type_c">';
				htmls += '<div class="Type_c_l fl">认&emsp;证：</div>';
				htmls += '<div class="Type_c_r">';

				for(var i=0; i<renZhenArr.length; i++){
					htmls += '<a href="javascript:getOrgList('+(0)+','+0+','+length+',\''+sex+'\',\''+place+'\',\''+pri+'\',\''+orgType+'\',\''+sort+'\',\''+renZhenArr[i]+'\')"';
					if(renZhenArr[i]==renZheng){
						htmls += ' class="on"  ';
					}					
					htmls += '>'+renZhenArr[i]+'</a>';
				}

				htmls += '</div>';
				htmls += '</div>';

				htmls += '<div class="Type_pxlx">';


				for(var i=0; i<sortArr.length; i++){
					htmls += '<a href="javascript:getOrgList('+(0)+','+0+','+length+',\''+sex+'\',\''+place+'\',\''+pri+'\',\''+orgType+'\',\''+i+'\',\''+renZheng+'\')"';
					if(i==sort){
						htmls += ' class="on"  ';
					}
					htmls += '>'+sortArr[i]+'</a>';
				}


				htmls += '</div>';


				htmls += '<div class="Type_list">';
				htmls += '<ul>';
			
			for(var i = 0; i < d.length; i++) {
				var obj = d[i];

				htmls += '<li style="height: 237px;">';
				htmls += '<a style="height: 227px;" href="<%=request.getContextPath()%>/index/orgListAction.htm?id='+obj.id+'"><img src="'+obj.img+'" width="180" height="178"  onerror="javascript:replaceImg(this)" />';
				if(obj.nickName.length>6){
					htmls += '<h2><strong>'+obj.nickName.substring(0,6)+'</strong><font>'+obj.province+'</font></h2>';
				}else{
					htmls += '<h2><strong>'+obj.nickName+'</strong><font>'+obj.province+'</font></h2>';
				}


				//htmls += '<p>成交量： <span>'+obj.signAmount+'</span> 次</p>';
				htmls += '<p>好评率： <span>'+(obj.goodRate?obj.goodRate+'%':'暂无评论')+'</span> </p>';

				htmls += '</a>';
				htmls += '</li>';
			}
			htmls += '</ul>';
			htmls += '</div>';
  
			var pageLength = length;
			var pages = Math.ceil(total/pageLength);
			var pagesCont = "";
			if(pages>1){
				htmls += "<div class='Paging'  style='clear:both;float:left'>";

				if(currentPage>1){
					pagesCont += "<a href='javascript:getOrgList("+(currentPage-1)+","+((currentPage-2)*pageLength)+","+pageLength+",\""+sex+"\",\""+place+"\",\""+pri+"\",\""+orgType+"\",\""+sort+'\",\"'+renZheng+"\")' class='Opage'><img src='/theme/user/images/Opage.png' width='15' height='15' /></a>";
				}
				if(pages>1){
					for(var i=1;i<=pages;i++){
						pagesCont += "<a "+(i==currentPage?'class="on"':'')+"href='javascript:getOrgList("+i+","+((i-1)*pageLength)+","+pageLength+",\""+sex+"\",\""+place+"\",\""+pri+"\",\""+orgType+"\",\""+sort+'\",\"'+renZheng+"\")'>"+i+"</a>";
					}
				}
				if(currentPage<pages){
					pagesCont += "<a href='javascript:getOrgList("+(currentPage+1)+","+((currentPage)*pageLength)+","+pageLength+",\""+sex+"\",\""+place+"\",\""+pri+"\",\""+orgType+"\",\""+sort+'\",\"'+renZheng+"\")' class='Opage'><img src='/theme/user/images/Npage.png' width='15' height='15' /></a>";
				}
				pagesCont += "</div>";

				htmls += pagesCont;
			}
				

			$("#list").append(htmls);


			$(".Type_c_More").toggle(function(){
				  $(this).prev().removeClass("Type_c_r_height");
				  $(this).html("收起∧")
			},function(){
				  $(this).prev().addClass("Type_c_r_height");
				  $(this).html("更多∨")
			})

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



<div class="mian3 Layout">


    <div class="Type Layout"   id="list">

 

    </div>


    <div class="Type_Float_fbrw">
    	<h2>发布任务</h2>
      <div class="Type_Float_fbrw_c" style="padding: 5px 8px 8px 8px;">
       	<p>一键公布你的需求坐等艺人上门应征</p>
          <a href="" title="发布任务"><img src="<%=path %>/theme/fenlei/images/Type_Float_fbrw_c_fbrw.jpg" width="112" height="31" /></a>
        </div>
    </div>
    <div class="Type_Float_bdt" style="top: 335px;">
    	<h2>包打听</h2>
      <div class="Type_Float_fbrw_c" style="padding: 5px 8px;">
       	<p>大项目、活动整包、找人嫌麻烦，交给第1舞台。为您提供高效、优质的项目解决方案。</p>
          <span>021-52902120</span>
        </div>
    </div>
</div>


<!-- foot  -->
<jsp:include page="/WEB-INF/page/public/footer.jsp"></jsp:include>

</body>
</html>
