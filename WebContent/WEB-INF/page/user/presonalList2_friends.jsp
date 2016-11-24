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
	int sign = 2;
	if(request.getParameter("sign")!=null){
		sign = Integer.parseInt(request.getParameter("sign"));
	}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
  <!-- page/user/presonalList2_friends.jsp -->

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
		getFriendList(<%=sign%>,1,0,<%=length%>); 
});



function addFriend(friendId){
   <%if(userSession == null){%>
		art.dialog.alert("请先登录!");
	<%}else{%>
		$.post('<%=request.getContextPath()%>/friend!addFriend.htm',{friendId:friendId},function(data){
		  if(data==1){
				location.reload() ;
		  }else if(data == 2){
			  art.dialog.tips('不能关注自己');
		  }else if(data == 3){
			  art.dialog.tips('登陆后才能关注！');
		  }else if(data == 4){
			  art.dialog.tips('已关注TA！');
		  }
		},"html");
	<%}%>
 }



function getFriendList(sign,currentPage,begin,length) {

	$.ajax({
		url:"<%=request.getContextPath()%>/index/presonList!getFriendList.htm?actionName=${actionName}&id=${id}&currentPage="+currentPage+"&length="+length+"&begin="+begin+"&sign="+sign,
		type:'POST',
		dataType:'json',  
		success:function(data){
			$("#list").empty("");

			var total = data.friendTotal;

			var currentPage = parseInt(data.currentPage);
			var d = eval(data.listFriendList);
			var htmls = "";
			
			for(var i = 0; i < d.length; i++) {
				var obj = d[i];
				var friendObj = obj[0];
				var friendUserObj = obj[1];
				htmls += "<div class='tadhy_c_c Layout'>";
				htmls += "<div class='tadhy_c_c_vip fl'>";
				htmls += "<a href='<%=request.getContextPath() %>/presonList.htm?id="+friendUserObj.userId+"' title=''>";
				
				if(friendUserObj.isOrg!=100){
					htmls += "<img src='/theme/user/images/tadhy_c_c_vip.png' width='25' height='12' />";
				}

				htmls += "</a>";
				htmls += "</div>";
				htmls += "<div class='tadhy_c_c_Head fl'>";
				htmls += "<a href='<%=request.getContextPath() %>/presonList.htm?id="+friendUserObj.userId+"' ><img src='/stageUpload/headImage/"+friendUserObj.userId+".png?date="+new Date()+"' width='64' height='64' /></a>";
				htmls += " </div>";
				htmls += "<div class='tadhy_c_c_zl fl'>";
				htmls += "<div class='tadhy_c_c_zl_name'>";
				htmls += "<a href='<%=request.getContextPath() %>/presonList.htm?id="+friendUserObj.userId+"' >"+friendUserObj.nickName+"</a>";
				htmls += "</div>";
				htmls += "<div class='tadhy_c_c_zl_b'>";
				htmls += "<p>"+(friendUserObj.provice?friendUserObj.provice:'')+"</p><p>粉丝<span>"+friendUserObj.totalFriends+"</span> 人</p>";
				htmls += "</div>";
				htmls += "</div>";
				htmls += "<div class='tadhy_c_c_gz fr'>";
				htmls += "<a href='javascript:addFriend("+friendUserObj.userId+")' title=''><img src='/theme/user/images/tadhy_c_c_gz.png' width='132' height='38' /></a>";
				htmls += "</div>";
				htmls += "</div>";

			}

			var pageLength = length;
			var pages = Math.ceil(total/pageLength);
			var pagesCont = "";
			if(pages>0){
				htmls += "<div class='Paging'>";

				if(currentPage>1){
					pagesCont += "<a href='javascript:getFriendList("+sign+","+(currentPage-1)+","+((currentPage-2)*pageLength)+","+pageLength+")' class='Opage'><img src='/theme/user/images/Opage.png' width='15' height='15' /></a>";
				}
				if(pages>1){
					for(var i=1;i<=pages;i++){
						pagesCont += "<a "+(i==currentPage?'class="on"':'')+"href='javascript:getFriendList("+sign+","+i+","+((i-1)*pageLength)+","+pageLength+")'>"+i+"</a>";
					}
				}
				if(currentPage<pages){
					pagesCont += "<a href='javascript:getFriendList("+sign+","+(currentPage+1)+","+((currentPage)*pageLength)+","+pageLength+")' class='Opage'><img src='/theme/user/images/Npage.png' width='15' height='15' /></a>";
				}
				pagesCont += "</div>";

				htmls += pagesCont;
			}
				

			$("#list").append(htmls);

			if(data.sign=='2'){
				$("#fensi").addClass("on");
				$("#guanzhu").removeClass("on");
				$("#totals").html('<span id="count">${friendFSTotal}</span>人关注TA');
			}else{
				$("#fensi").removeClass("on");
				$("#guanzhu").addClass("on");
				$("#totals").html('TA关注<span id="count">${friendGZTotal}</span>人');
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
<div class="Content Layout">
 




<div class="tadhy_t mian">
	<ul>
    	<li id='fensi'><a href="javascript:getFriendList(2,1,0,<%=length%>)" title="TA的粉丝">TA的粉丝</a></li>
        <li id='guanzhu'><a href="javascript:getFriendList(1,1,0,<%=length%>)" title="TA关注的人">TA关注的人</a></li>
    </ul>
  <div class="tadhy_t_b" id="totals">
    	
    </div>
</div>

<div class="tadhy_c Layout mian" id="list">


</div>




</div>
<!-- main -->


<jsp:include page="/WEB-INF/page/public/footer.jsp"></jsp:include>

</body>
</html>
