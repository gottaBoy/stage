<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="pg" uri="/page-tags"%>  
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	int length = 10;
	String path = request.getContextPath();
	UserSession userSession = HttpSessionHelper.getUserSession(request) ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
  <!-- page/user/presonalList2_pinjia.jsp -->

    <script src="http://tjs.sjs.sinajs.cn/open/api/js/wb.js" type="text/javascript" charset="utf-8"></script>
    <title><%=StageVariale.title%></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<META HTTP-EQUIV="Cache-Control" CONTENT="no-store, must-revalidate"> 
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">

	<link rel="stylesheet" href="<%=request.getContextPath() %>/theme/user/css/style.css" />
	<script type="text/javascript" src="<%=request.getContextPath() %>/theme/user/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/theme/user/js/select.js"></script>
	<SCRIPT type=text/javascript src="<%=request.getContextPath() %>/theme/js2/common.js"></SCRIPT>

	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/idialog.css">
 	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />

	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>

<script language="javascript">
$(document).ready(function(){
		getPinJiaList(2,1,0,<%=length%>,1); 
});
 
function getPinJiaList(sign,currentPage,begin,length,starLevel) {

	$.ajax({
		url:"<%=request.getContextPath()%>/index/presonList!getEvaluateList.htm?actionName=${actionName}&id=${id}&currentPage="+currentPage+"&length="+length+"&begin="+begin+"&sign="+sign+"&starLevel="+starLevel,
		type:'POST',
		dataType:'json',  
		success:function(data){
			$("#list").empty("");

			var total = data.total;

			var currentPage = parseInt(data.currentPage);
			var d = eval(data.list);
			var htmls = "";
			
			for(var i = 0; i < d.length; i++) {
				var obj = d[i];
				var businessEvaluateObj = obj[0];
				//var userName = obj[1];
				var nickName = obj[2];
				var userId = obj[4];

				var price = obj[5];
				var content = obj[6];

				htmls += "<div class='jypj_c_c Layout'>";
				htmls += "<div class='jypj_c_c_Head fl'>";
				htmls += "<a href='<%=request.getContextPath() %>/index/presonList.htm?id="+userId+"'  ><img src='<%=request.getContextPath() %>/stageUpload/headImage/"+userId+".png' width='64' height='64' /></a>";
				htmls += "</div>";
				htmls += "<div class='jypj_c_c_zl'>";
				htmls += "<div class='jypj_c_c_zl_t Layout'>";
				htmls += " <a href='<%=request.getContextPath() %>/index/presonList.htm?id="+userId+"'  class='name'>"+nickName+"</a><span>"+content+"</span><!-- <span>平面模特</span> --><span>成交价格："+price+"元</span><em class='time'>"+businessEvaluateObj.creatTime+" </em>";
				htmls += "</div>";
				htmls += "<div class='jypj_c_c_zl_b Layout'>";


				if(businessEvaluateObj.pjContent=="系统自动评价"){
					if(starLevel==1){
						htmls += "<i>评价：</i><p>系统默认好评。 </p>";
					}else{
						htmls += "<i>评价：</i><p>"+businessEvaluateObj.pjContent+" </p>";
					}
				}else if(businessEvaluateObj.pjContent==""){
					if(starLevel==1){
						htmls += "<i>评价：</i><p>系统默认好评。 </p>";
					}else{
						htmls += "<i>评价：</i><p>系统自动评价 </p>";
					}
				}else{
					htmls += "<i>评价：</i><p>"+businessEvaluateObj.pjContent+" </p>";
				}

				
				htmls += "</div>";
				htmls += "</div>";
				htmls += "</div>";

			}

			var pageLength = length;
			var pages = Math.ceil(total/pageLength);
			var pagesCont = "";
			if(pages>0){
				htmls += "<div class='Paging'>";

				if(currentPage>1){
					pagesCont += "<a href='javascript:getPinJiaList("+sign+","+(currentPage-1)+","+((currentPage-2)*pageLength)+","+pageLength+","+starLevel+")' class='Opage'><img src='/theme/user/images/Opage.png' width='15' height='15' /></a>";
				}
				if(pages>1){
					for(var i=1;i<=pages;i++){
						pagesCont += "<a "+(i==currentPage?'class="on"':'')+"href='javascript:getPinJiaList("+sign+","+i+","+((i-1)*pageLength)+","+pageLength+","+starLevel+")'>"+i+"</a>";
					}
				}
				if(currentPage<pages){
					pagesCont += "<a href='javascript:getPinJiaList("+sign+","+(currentPage+1)+","+((currentPage)*pageLength)+","+pageLength+","+starLevel+")' class='Opage'><img src='/theme/user/images/Npage.png' width='15' height='15' /></a>";
				}
				pagesCont += "</div>";

				htmls += pagesCont;
			}
				

			$("#list").append(htmls);

			if(data.sign=='1'){
				$("#sale").removeClass("on");
				$("#buy").addClass("on");

				var html = "<label><input type='radio'  name='evalRadio' id='good' value='1'  "+(starLevel==1?'checked=\"checked\"':'')+" onclick='javascript:getPinJiaList(1,1,0,<%=length%>,1)' />好评（<span>"+data.goodTotal+"</span>）</label>";

				html += "<label><input type='radio' name='evalRadio' "+(starLevel==0?'checked=\"checked\"':'')+"id='general' value='0' onclick='javascript:getPinJiaList(1,1,0,<%=length%>,0)' />中评（<span>"+data.generalTotal+"</span>）</label>";
				
				html += "<label><input type='radio' "+(starLevel==-1?'checked=\"checked\"':'')+"name='evalRadio' id='poor' value='-1' onclick='javascript:getPinJiaList(1,1,0,<%=length%>,-1)' />差评（<span>"+data.badTotal+"</span>）</label>";

				$("#totals").html(html);
			}else{
				$("#sale").addClass("on");
				$("#buy").removeClass("on");


				var html = "<label><input type='radio'  name='evalRadio' id='good' value='1'  "+(starLevel==1?'checked=\"checked\"':'')+" onclick='javascript:getPinJiaList(2,1,0,<%=length%>,1)' />好评（<span>"+data.goodTotal+"</span>）</label>";

				html += "<label><input type='radio' name='evalRadio' id='general' "+(starLevel==0?'checked=\"checked\"':'')+" value='0' onclick='javascript:getPinJiaList(2,1,0,<%=length%>,0)' />中评（<span>"+data.generalTotal+"</span>）</label>";

				html += "<label><input type='radio' "+(starLevel==-1?'checked=\"checked\"':'')+"name='evalRadio' id='poor' value='-1' onclick='javascript:getPinJiaList(2,1,0,<%=length%>,-1)' />差评（<span>"+data.badTotal+"</span>）</label>";

				$("#totals").html(html);
			}

		}
	});
}


</script>



  </head>
<body>
<div class="top Layout">
	<jsp:include page="/WEB-INF/page/public/persnal_header.jsp"></jsp:include>
</div>

<!-- main -->
 


<div class="tadhy_t mian">
	<ul>
    	<li id="sale"><a href="javascript:getPinJiaList(2,1,0,<%=length%>,1)" title="买家给我的评价">买家给我的评价</a></li>
        <li id="buy"><a href="javascript:getPinJiaList(1,1,0,<%=length%>,1)" title="卖家给我的评价">卖家给我的评价</a></li>
    </ul>
  	<div class="tadhy_t_b" id="totals">
   	 
    </div>
</div>



<div class="jypj_c Layout mian"  id="list">
 
</div>



<!-- main -->


<jsp:include page="/WEB-INF/page/public/footer.jsp"></jsp:include>

</body>
</html>
