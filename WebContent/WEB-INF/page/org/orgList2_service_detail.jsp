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

	String hasNoMy=(String)session.getAttribute("hasNoMy");
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

<link rel="stylesheet" href="<%=path%>/theme/job/css/style3.css" />

<style>

.jyjl_c {
	margin-top: 7px;
}

.jyjl_c table {
	width: 680px;
	border-collapse: separate;
	border-spacing: 2px;
}

.jyjl_c table th {
	background: #EFEFEF;
	font-size: 16px;
	padding: 5px;
	font-weight: normal;
}
.jyjl_c  tr {
	display: table-row;
	vertical-align: inherit;
	border-color: inherit;
}

.jyjl_c table td {
	font-size: 14px;
	padding: 8px;
	border-bottom: 1px dashed lightGrey;
	text-align: center;
	color: #8D8D8D;
}
</style>
<script language="javascript">

var pageNum = 0;
var total = 0;

 
	 function qianYueTa(){
	     	<%if(userSession==null){%>
				//art.dialog.alert("请先登录!");
	  	    	parent.showPop(2,'<%=request.getContextPath() %>/loginHtml.htm');
	  	    	//openWindowLogin();
	  	    <%  }else{  int loginUserId=userSession.getId();%>
	  	    var bqyUserId=<s:property value="#request.userInfo.userId"/>;
	  	    if(bqyUserId==<%=loginUserId %>){
	  	    	art.dialog.tips("不能预约自己！");
	  	    }else{
				var p=window.open("about:blank"); 
		  	    $.ajax({
				   url:"<%=request.getContextPath() %>/member/business!checkUserCost.htm?bqyUserId=<s:property value='#request.userInfo.userId'/>",
				   type:'POST',
				   success:function(data){
							
					   if(data=="2"){
						   	p.close();
							art.dialog.tips("该用户未添加职业，不能预约!");
					   } else {
					   		p.location = '<%=request.getContextPath() %>/member/business!toPreOrder.htm?bqyUserId=<s:property value="#request.userInfo.userId"/>'; //toOrder
					   }
				   }
				});
				//art.dialog.open('<%=request.getContextPath() %>/member/business!toPreOrder.htm?bqyUserId=<s:property value="#request.userInfo.userId"/>',{width:680,height:455,resize: false});
			 }
			  <%  }%>
	     }



	  function headSubmit(){
		if($("#headKeywords").val()=="请输入关键词"){ 
			$("#headKeywords").val("");
			return;
		}
			$("#headSearchFrom").submit();
		}
		
		function showHelp(){
			art.dialog({
					icon: 'help',
					content: '艺人职业价格为参考价，具体价格可与艺人协商。',
					ok: true,
					cancel: false
				});
		}


	function addFriend(friendId){
       <%if(userSession == null){%>
		   	//art.dialog.alert("请先登录!");
		   var url = '<%=HttpSessionHelper.urlEncode("index/orgListAction.htm?id=")%>'+'<s:property value="#request.userInfo.userId"/>';
		   parent.showPop(2,'<%=request.getContextPath() %>/loginHtml.htm?r='+url);
		   //parent.showPop(2,'<%=request.getContextPath() %>/loginHtml.htm');
		<%}else{%>
			$.post('<%=request.getContextPath()%>/friend!addFriend.htm?friendId='+friendId,{},function(data){
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
	


	function sendMessage(){
       <%if(userSession == null){%>
		   	//art.dialog.alert("请先登录!");
		   parent.showPop(2,'<%=request.getContextPath() %>/loginHtml.htm');
		<%}else{%>
				art.dialog.open('<%=request.getContextPath()%>/messageSend!send.htm?id=<s:property value="#request.userInfo.userId"/>',{width:550,height:300,resize: false});
		<%}%>
	}


$(function(){
		baseIntro();
		//商品分类
			
		$(".fwfl").hover(function(){
			$(this).find(".arrow_Downward").removeClass().addClass("arrow_Upward")
			$(this).find("#fwfl_c").show()
		},function(){
			$(this).find(".arrow_Upward").removeClass().addClass("arrow_Downward")
			$(this).find("#fwfl_c").hide()
		})
		
		
			
		$('.Cnav .item').hover(function(){
			$(this).addClass('active').find('.product span').attr("class","product_Arrow2");
			$(this).find('.product_wrap').show();
		},function(){
			$(this).removeClass('active').find('.product span').attr("class","product_Arrow")
			$(this).find('.product_wrap').hide();
		});


});



	
	function hideTA(userId,serviceId){
     	<%
			String url2 = "";
			String url3 = "";
			if(userSession==null){
				url2= "?r="+HttpSessionHelper.urlEncode("/member/business!toPreOrder.htm?bqyUserId=");
				url3=HttpSessionHelper.urlEncode("&serviceId=");
		%>
				parent.showPop(2,'<%=request.getContextPath() %>/loginHtml.htm<%=url2%>'+userId+"<%=url3%>"+serviceId);
		<%}else{%>
				//art.dialog.tips("本功能正在快速完善中，很快你就可以雇佣TA啦~~");
				window.open('<%=request.getContextPath()%>/member/business!toPreOrder.htm?bqyUserId='+userId+"&serviceId="+serviceId);
		<%}%>
	}



var s = '';


function baseIntro(){
	$("#recordsDiv").hide();
	$("#li2").addClass("on");
	$("#sss").html(s);
	$("#sss").show();

	$("#li3").removeClass("on");
	$("#li4").removeClass("on");
}
function remarks(){
	$("#recordsDiv").show();
	$("#sss").html("");
	$("#sss").hide();
	getPinJiaList(2,1,0,10,1); 


	$("#li3").addClass("on");
	$("#li2").removeClass("on");
	$("#li4").removeClass("on");
}
function records(){
	$("#recordsDiv").hide();
	$("#sss").html("");
	getJiLuList(1,0,10); 
	$("#sss").html("");
	$("#sss").show();

	$("#li4").addClass("on");
	$("#li2").removeClass("on");
	$("#li3").removeClass("on");
}


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
				

			$("#sss").append(htmls);
		}
	});
}











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
				htmls += "<a href='<%=request.getContextPath() %>/index/presonList.htm?id="+userId+"'  ><img src='/stageUpload/headImage/"+userId+".png' width='64' height='64' /></a>";
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
				

			$("#sss").append(htmls);

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


<!-- main -->
 






<div class="gytxx Layout">
			<s:iterator value="#request.resultList" var="item">
			<s:if test="#request.serviceId==#item.id">

<script language="javascript">
		s = "<p><s:property escape='false'  value='#item.content.replaceAll("\n", "<br>")' /></p>";
</script>

				<div class="gytxx_l fl">
					<div class="spxx_t Layout">
						<div class="spxx_t_l fl">
							<img src="${item.bulletinImg}" width="280" /> 
						</div>
						<div class="spxx_t_r fl">
							<h2 style="width: 330px;">${item.title}</h2>
							<p>价格：<span>${item.price}</span> 元 / ${item.unit} <i>起</i></p>
							<div class="spxx_t_r_cjpl Layout">
								<div class="spxx_t_r_cjpl_cj fl">已成交：<span> ${hasSold}</span></div>
								<div class="spxx_t_r_cjpl_pl fl">评论：<span> ${hasRemarks}</span></div>
							</div> 
							<div class="spxx_t_r_b">
								<a href="javascript:hideTA('${userInfo.userId}','${item.id}')" title=""><img src="/theme/org/images/lkgm.png" width="141" height="44" /></a>
							</div> 
						</div>
					</div>

					<div class="spxx_tab Layout" style="margin: 20px 0px 10px 0px;">
					<ul>
						<li id="li2" class="on"><a href="javascript:baseIntro()">服务介绍</a></li>
		                <li id="li3"><a href="javascript:remarks()" title="交易评价">交易评价</a></li>
						<li id="li4"><a href="javascript:records()" title="交易记录">交易记录</a></li>
					</ul>
				</div>
				<div id="sss" class="jyjl_c spxx_fwjs Layout" style="padding: 0 10px 0 0px;">
				</div>

				<div id="recordsDiv">
					<div class="tadhy_t mian" style="width: 680px;">
						<ul>
							<li id="sale"><a href="javascript:getPinJiaList(2,1,0,10,1)" title="买家给我的评价">买家给我的评价</a></li>
							<!-- <li id="buy"><a href="javascript:getPinJiaList(1,1,0,10,1)" title="卖家给我的评价">卖家给我的评价</a></li> -->
						</ul>
						<div class="tadhy_t_b" id="totals">
						 
						</div>
					</div>

					<div class="jypj_c Layout mian"  id="list">
					 
					</div>
				</div>

			</div>
		</s:if>
	</s:iterator>

 

  <div class="gytxx_r fr">
    	<h2 class="gytxx_r_fwsxx">服务商信息</h2>
        <div class="gytxx_r_fwsxx_c">
          <div><a href="<%=request.getContextPath()%>/index/orgListAction.htm?id=${userInfo.userId}"><img src="/stageUpload/headImage/${user.id}.png?date=<%=new java.util.Date()%>" width="179" height="157" /></a></div>
          <h3><a href="<%=request.getContextPath()%>/index/orgListAction.htm?id=${userInfo.userId}"><s:property value="#request.userInfo.nickName"/></a></h3>
          <p><span><s:property value="#request.userInfo.provice"/> </span>|<span><s:property value="#request.userInfo.city"/></span></p>
          <p>交易次数：<em><s:property value="#request.userInfo.signNumber"/></em></p>
          <p>旗下艺人：<em>${yrSum}</em></p>
            <div class="gytxx_r_fwsxx_c_b">
       	    	<a href='javascript:addFriend("${userInfo.userId}")' ><img src="/theme/org/images/gz.jpg" width="89" height="35" /></a>
				<a href="javascript:sendMessage()" ><img src="/theme/org/images/lxta.jpg" width="89" height="35" /></a>
            </div>
        </div>


        <h2 class="gytxx_r_fwsxx">TA的其他服务</h2>



		<s:iterator value="#request.resultList" var="item">
			<s:if test="#request.serviceId != #item.id">
				<div class="gytxx_r_fwsxx_c">
					<div><a href="<%=request.getContextPath()%>/index/orgListAction.htm?id=${item.userId}&serviceId=${item.id}&actionName=orgServiceDetail#orgTab" title=""><img src="${item.bulletinImg}" width="255" height="170" /></a></div>
					<h4>${item.title}</h4>
					<p><i>${item.price}</i>元/${item.unit}<strong>起</strong></p>
				</div>
			</s:if>
		</s:iterator>
 
 
    </div>


</div>




<!-- main -->


<jsp:include page="/WEB-INF/page/public/footer.jsp"></jsp:include>

</body>
</html>
