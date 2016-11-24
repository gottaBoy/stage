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
<!--  public/fenlei.jsp-->
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
		getFenLeiUserList(1,0,50,'','',0,'<%=(request.getParameter("filterValue")==null)?"":request.getParameter("filterValue") %>','','')
});

//检查图片是否存在  
function CheckImgExists(imgurl) {  
    var ImgObj = new Image(); //判断图片是否存在  
    ImgObj.src = imgurl;  
    //没有图片，则返回-1  
	alert(ImgObj.fileSize);
    if (ImgObj.fileSize > 0 || (ImgObj.width > 0 && ImgObj.height > 0)) {  
		alert(ImgObj.fileSize);
        return true;
    } else {  
		alert(imgurl);
        return false;
    }  
}  
 

function replaceImg(obj){
	var imgSrc = obj.src.replace('indexHeadImage','headImage');
	obj.src = imgSrc;
	obj.onerror=function(){
		obj.src = '<%=request.getContextPath() %>/theme/images/tu03.jpg';
		obj.onerror=null;  
	}

}

function publishTask(){
	<%if(userSession != null){%>
		this.location = "<%=request.getContextPath()%>/member/task.htm?userId=<%=userSession.getId() %>";
	<%}else{
		//art.dialog.alert("请先登录！");

			
		String url ="?r="+HttpSessionHelper.urlEncode("/member/task.htm?userId=${loginUserId}");

		%>
		parent.showPop(2,'<%=request.getContextPath() %>/loginHtml.htm<%=url%>');
	<%}%>
}

	      
var sexArr = new Array("不限","男","女","组合");

var cityArr = new Array("不限"<s:iterator value="#request.cityList" var="city" status="st">,"${city}"</s:iterator>);

var priceArr = new Array("不限","500元以下","500-1000元","1000-2000元","2000-3000元","3000元以上");

var renZhenArr = new Array("不限","实名认证");

var sortArr = new Array("人气最旺","价格最低","好评最多","最新加入");

function pinfen(){
}
function removeThis(obj){
	$(obj).html('');
}
function getFenLeiUserList(currentPage,begin,length,sex,place,pri,type,sort,renZheng) {
	if(place=="") place = "不限";
	if(renZheng=="") renZheng = "不限";
	$.ajax({
		url:"<%=request.getContextPath()%>/query/queryAction!toFenLeiQuery.htm",
		type:'POST',
		data:{
			currentPage:currentPage,
			length:length,
			begin:begin,
			sex:sex,
			place:place,
			priceIndex:pri,
			filterValue:type,
			sort:sort,
			headKeywords:'${headKeywords}',
			renZheng:renZheng
		},
		dataType:'json',  
		success:function(data){
			$("#list").empty("");
			$("#businessList").empty("");
			var businessList = data.businessList;
			//var finalTypeName = "新加入";//data.talentCategory.typeName;
			var finalTypeName = "";
			if(data.talentCategory && data.talentCategory.typeName){
				finalTypeName = data.talentCategory.typeName;
			}

			var businessHtmls = "";
			for(var j=0;j<businessList.length; j++){
					var businessArr = businessList[j];
					businessHtmls += '<li class="gzjh_r_gs fl pellips2">恭喜用户';
					if(businessArr[9]==1){
						businessHtmls += "<a  target='_blank' href='<%=path%>/index/orgListAction.htm?id="+businessArr[8]+"'>"+businessArr[7]+"</a>";
					}else{
						businessHtmls += "<a  target='_blank' href='<%=path%>/index/presonList.htm?id="+businessArr[8]+"'>"+businessArr[7]+"</a>";
					}
					businessHtmls += '成功签约'+finalTypeName+'艺人';

					if(businessArr[6]==1){
						businessHtmls += "<a href='<%=path%>/index/orgListAction.htm?id="+businessArr[2]+"'>"+businessArr[1]+"</a>";
					}else{
						businessHtmls += "<a href='<%=path%>/index/presonList.htm?id="+businessArr[2]+"'>"+businessArr[1]+"</a>";
					}
					businessHtmls += "</li>";
			}
			$("#businessList").append(businessHtmls);

			var total = data.total;
			var currentPage = parseInt(data.currentPage);
			var d = eval(data.list);


			var htmls = '';

				htmls += '<div class="Type_lx Layout">';
				if(finalTypeName != ""){
					htmls += '<div class="Type_lx_l fl">'+finalTypeName+'</div>';
				}

				htmls += '<div class="Type_lx_r fr">您现在的位置：<a href="/">首页</a> > ';
				var categoryList =  data.categoryList;
				for(var x=0;x<categoryList.length; x++){
					var categoryObj = categoryList[x];
					htmls += '<a href="<%=request.getContextPath()%>/index/indexAction!toFenlei.htm?filterValue='+categoryObj.alias+'">'+categoryObj.typeName+'</a>';
					if(x<categoryList.length-1){
						htmls += '> ';
					}
				}
				htmls += '</div>';
				htmls += '</div>';


				htmls += '<div class="Type_yxz">';
				htmls += '<div class="Type_yxz_l fl">已选择：</div>';
				htmls += '<div class="Type_yxz_r fl">';
				
				if(place != '不限'){
					for(var i=0; i<cityArr.length; i++){
						if(cityArr[i]==place){ 
							htmls += '<a href="javascript:getFenLeiUserList('+(0)+','+0+','+length+',\''+sex+'\',\'\',\''+pri+'\',\''+type+'\',\''+sort+'\',\''+renZheng+'\')"'; 
							htmls += '>所在地：<em>'+cityArr[i];
							htmls += '</em><span></span></a>';
						}
					}
				}

				if(sex >= 1 ){
					for(var i=0; i<sexArr.length; i++){
						if(i==sex){ 
							htmls += '<a href="javascript:getFenLeiUserList('+(0)+','+0+','+length+',\'\',\''+place+'\',\''+pri+'\',\''+type+'\',\''+sort+'\',\''+renZheng+'\')"'; 
							htmls += '>性别：<em>'+sexArr[i];
							htmls += '</em><span></span></a>';
						}
					}
				}

				if(pri >= 1 ){
					for(var i=0; i<priceArr.length; i++){
						if(i==pri){ 
							htmls += '<a href="javascript:getFenLeiUserList('+(0)+','+0+','+length+',\''+sex+'\',\''+place+'\',\'0\',\''+type+'\',\''+sort+'\',\''+renZheng+'\')"'; 
							htmls += '>价格：<em>'+priceArr[i];
							htmls += '</em><span></span></a>';
						}
					}
				}

				if(renZheng != '不限' ){
					htmls += '<a href="javascript:getFenLeiUserList('+(0)+','+0+','+length+',\''+sex+'\',\''+place+'\',\''+pri+'\',\''+type+'\',\''+sort+'\',\'\')"'; 
					htmls += '>认证：<em>'+renZheng;
					htmls += '</em><span></span></a>';
				}


				htmls += '</div>';
				htmls += '</div>';

				htmls += '<div class="Type_c">';
				htmls += '<div class="Type_c_l fl">所在地：</div>';
				htmls += '<div class="Type_c_r Type_c_r_height">';

				for(var i=0; i<cityArr.length; i++){
					htmls += '<a href="javascript:getFenLeiUserList('+(0)+','+0+','+length+',\''+sex+'\',\''+cityArr[i]+'\',\''+pri+'\',\''+type+'\',\''+sort+'\',\''+renZheng+'\')"'; 
					if(cityArr[i]==place){ 
						htmls += ' class="on"  ';
					}					
					htmls += '>'+cityArr[i]+'</a>';
				}

				htmls += '</div>';
				htmls += '<span class="Type_c_More">更多∨</span>';
				htmls += '</div>';

				htmls += '<div class="Type_c">';
				htmls += '<div class="Type_c_l fl">性&emsp;别：</div>';
				htmls += '<div class="Type_c_r">';

				
				for(var i=0; i<sexArr.length; i++){
					htmls += '<a href="javascript:getFenLeiUserList('+(0)+','+0+','+length+',\''+i+'\',\''+place+'\',\''+pri+'\',\''+type+'\',\''+sort+'\',\''+renZheng+'\')"';
					if(i==sex){
						htmls += ' class="on"  ';
					}					
					htmls += '>'+sexArr[i]+'</a>';
				}
				  
				htmls += '</div>';
				htmls += '</div>';

				htmls += '<div class="Type_c">';
				htmls += '<div class="Type_c_l fl">价&emsp;格：</div>';
				htmls += '<div class="Type_c_r">';

				for(var i=0; i<priceArr.length; i++){
					htmls += '<a href="javascript:getFenLeiUserList('+(0)+','+0+','+length+',\''+sex+'\',\''+place+'\',\''+i+'\',\''+type+'\',\''+sort+'\',\''+renZheng+'\')"';
					if(i==pri){
						htmls += ' class="on"  ';
					}					
					htmls += '>'+priceArr[i]+'</a>';
				}
				  

				htmls += '</div>';
				htmls += '</div>';

				htmls += '<div class="Type_c">';
				htmls += '<div class="Type_c_l fl">认&emsp;证：</div>';
				htmls += '<div class="Type_c_r">';

				if(renZheng == '实名认证'){
					htmls += '<a href="javascript:getFenLeiUserList('+(0)+','+0+','+length+',\''+sex+'\',\''+place+'\',\''+pri+'\',\''+type+'\',\''+sort+'\',\'\')">不限</a>';
					htmls += '<a  class="on"  href="javascript:getFenLeiUserList('+(0)+','+0+','+length+',\''+sex+'\',\''+place+'\',\''+pri+'\',\''+type+'\',\''+sort+'\',\'实名认证\')">实名认证</a>';
				}else{
					htmls += '<a  class="on"  href="javascript:getFenLeiUserList('+(0)+','+0+','+length+',\''+sex+'\',\''+place+'\',\''+pri+'\',\''+type+'\',\''+sort+'\',\'\')">不限</a>';
					htmls += '<a href="javascript:getFenLeiUserList('+(0)+','+0+','+length+',\''+sex+'\',\''+place+'\',\''+pri+'\',\''+type+'\',\''+sort+'\',\'实名认证\')">实名认证</a>';
				}
				htmls += '</div>';
				htmls += '</div>';

				htmls += '<div class="Type_pxlx">';


				for(var i=0; i<sortArr.length; i++){
					htmls += '<a href="javascript:getFenLeiUserList('+(0)+','+0+','+length+',\''+sex+'\',\''+place+'\',\''+pri+'\',\''+type+'\',\''+i+'\',\''+renZheng+'\')"';
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

				var nickName = "";
				if(obj.nickName.length > 8){
					nickName = obj.nickName.substring(0,8);
				}else{
					nickName = obj.nickName;
				}

				htmls += '<li>';
				htmls += '<a target="_blank" href="<%=request.getContextPath()%>/index/presonList.htm?id='+obj.id+'"><img src="'+obj.img+'" width="180" height="178"  onerror="javascript:replaceImg(this)" />';
				htmls += '<h2><strong>'+nickName+'</strong><font>'+obj.province+'</font></h2>';
				htmls += '<p><i>'+obj.profession+'</i> </p>';
				htmls += '<p><em>'+obj.bprice+'</em>元/ '+obj.unit+'</p>';
				//htmls += '<p>成交 <span>'+obj.signAmount+'</span> 次</p>';
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
					pagesCont += "<a href='javascript:getFenLeiUserList("+(currentPage-1)+","+((currentPage-2)*pageLength)+","+pageLength+",\""+sex+"\",\""+place+"\",\""+pri+"\",\""+type+"\",\""+sort+'\",\"'+renZheng+"\")' class='Opage'><img src='/theme/user/images/Opage.png' width='15' height='15' /></a>";
				}
				if(pages>1){
					for(var i=1;i<=pages;i++){
						pagesCont += "<a "+(i==currentPage?'class="on"':'')+"href='javascript:getFenLeiUserList("+i+","+((i-1)*pageLength)+","+pageLength+",\""+sex+"\",\""+place+"\",\""+pri+"\",\""+type+"\",\""+sort+'\",\"'+renZheng+"\")'>"+i+"</a>";
					}
				}
				if(currentPage<pages){
					pagesCont += "<a href='javascript:getFenLeiUserList("+(currentPage+1)+","+((currentPage)*pageLength)+","+pageLength+",\""+sex+"\",\""+place+"\",\""+pri+"\",\""+type+"\",\""+sort+'\",\"'+renZheng+"\")' class='Opage'><img src='/theme/user/images/Npage.png' width='15' height='15' /></a>";
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
  	<div class="Type_t Layout">
    	<div class="Type_t_l fl">
        	<h2><p><img src="<%=path %>/theme/fenlei/images/fl_t_l_H2.png" width="23" height="30" /><span>签约榜</span></p></h2>
        	<ul class="gzjh_r_ul4" id="businessList">


 
            </ul>
        </div>
        <div class="Focus2 fl">
            	<div id="slideshow" style=" width:648px;height:323px">

				<s:iterator value="#request.posterList" var="vo" status="st">
                    <a href='<s:property value="#vo.plink"/>' ><img src='<s:property value="#vo.purl"/>' width="648" height="323" /></a>
                </s:iterator> 
 
                </div>
            </div>
    </div>






 

    <div class="Type Layout"   id="list">

 

    </div>


    <div class="Type_Float_fbrw">
    	<h2>发布任务</h2>
      <div class="Type_Float_fbrw_c" style="padding: 5px 8px 8px 8px;">
       	<p>一键公布你的需求坐等艺人上门应征</p>
          <a href="javascript:publishTask()" title="发布任务"><img src="<%=path %>/theme/fenlei/images/Type_Float_fbrw_c_fbrw.jpg" width="112" height="31" /></a>
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
