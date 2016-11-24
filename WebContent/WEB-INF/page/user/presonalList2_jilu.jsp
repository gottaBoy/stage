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
  <!-- page/user/presonalList2_jilu.jsp -->

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
		getJiLuList(1,0,<%=length%>); 
});
 
function getJiLuList(currentPage,begin,length) {
	$.ajax({
		url:"<%=request.getContextPath()%>/index/presonList!getRecordList.htm?actionName=${actionName}&id=${id}&currentPage="+currentPage+"&length="+length+"&begin="+begin,
		type:'POST',
		dataType:'json',  
		success:function(data){
			$("#list").empty("");

			var total = data.total;

			var currentPage = parseInt(data.currentPage);
			var d = eval(data.list);
			var htmls = "";
			
			htmls += "<table width='100%' border='0' cellspacing='0' cellpadding='0' id='saleTable'>";
			htmls += "  <tr>";
			htmls += "    <th width='18%'>买家</th>";
			htmls += "    <th width='28%'>服务内容</th>";
			htmls += "    <th width='18%'>数量</th>";
			htmls += "    <th width='18%'>成交时间</th>";
			htmls += "    <th width='18%'>成交价格</th>";
			htmls += "  </tr>";

			for(var i = 0; i < d.length; i++) {
				var obj = d[i][0];

				htmls += "  <tr>";
				htmls += "    <td>"+ d[i][1]+"</td>";
				htmls += "    <td>"+obj.content+"</td>";
				htmls += "    <td>1</td>";
				htmls += "    <td>"+obj.createTimeStr+"</td>";
				htmls += "    <td>"+obj.price+"元</td>";
				htmls += "  </tr>";
			}
			htmls += "</table>";



			var pageLength = length;
			var pages = Math.ceil(total/pageLength);
			var pagesCont = "";
			if(pages>0){
				htmls += "<div class='Paging'>";

				if(currentPage>1){
					pagesCont += "<a href='javascript:getJiLuList("+(currentPage-1)+","+((currentPage-2)*pageLength)+","+pageLength+")' class='Opage'><img src='/theme/user/images/Opage.png' width='15' height='15' /></a>";
				}
				if(pages>1){
					for(var i=1;i<=pages;i++){
						pagesCont += "<a "+(i==currentPage?'class="on"':'')+"href='javascript:getJiLuList("+i+","+((i-1)*pageLength)+","+pageLength+")'>"+i+"</a>";
					}
				}
				if(currentPage<pages){
					pagesCont += "<a href='javascript:getJiLuList("+(currentPage+1)+","+((currentPage)*pageLength)+","+pageLength+")' class='Opage'><img src='/theme/user/images/Npage.png' width='15' height='15' /></a>";
				}
				pagesCont += "</div>";

				htmls += pagesCont;
			}
				

			$("#list").append(htmls);
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


<div class="jyjl_c mian Layout"  id="list">


</div>


<!-- main -->


<jsp:include page="/WEB-INF/page/public/footer.jsp"></jsp:include>

</body>
</html>
