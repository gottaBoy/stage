<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@page import="com.smt.webapp.util.HttpSessionHelper"%>

<%@ taglib prefix="pg" uri="/page-tags"%>
<%
	String path = request.getContextPath();
	UserSession userSession = HttpSessionHelper.getUserSession(request) ;

	String hasNoMy=(String)session.getAttribute("hasNoMy");
%>
<link rel="stylesheet" href="<%=path%>/theme/job/css/style3.css" />
<script language="javascript">

var pageNum = 0;
var total = 0;


	function pinfen(){
		//动态评分
		/*
		var imgSrc = '<img src=\"theme/images2/tu96.jpg\" />&nbsp;';
		var imgSrc1 = '<img src=\"theme/images2/x2.png\" />&nbsp;';
		var imgSrc2 = '<img src=\"theme/images2/x1x.png\" />&nbsp;';
		var msGradeValue = '<s:property value="#request.userEvaluation.msGradeValue"/>';
		var GradeValue2 = (msGradeValue*10)%10;
		var GradeValue1 = (msGradeValue*10-GradeValue2)/10;
		//alert(msGradeValue+"  ,"+msGradeValue1+"  ,"+msGradeValue2);
			for(var j = 0; j < GradeValue1; j++) {
				$("#msGrade").append(imgSrc);
			}
			if(GradeValue2>=5&&GradeValue2<=9){
				$("#msGrade").append(imgSrc1);
				for(var j = 0; j < 4-GradeValue1; j++) {
					$("#msGrade").append(imgSrc2);
				}
			}else{
				for(var j = 0; j < 5-GradeValue1; j++) {
					$("#msGrade").append(imgSrc2);
				}
			}

		var tdGradeValue = '<s:property value="#request.userEvaluation.tdGradeValue"/>';
		GradeValue2 = (tdGradeValue*10)%10;
		GradeValue1 = (tdGradeValue*10-GradeValue2)/10;
			for(var j = 0; j < GradeValue1; j++) {
				$("#tdGrade").append(imgSrc);
			}
			if(GradeValue2>=5&&GradeValue2<=9){
				$("#tdGrade").append(imgSrc1);
				for(var j = 0; j < 4-GradeValue1; j++) {
					$("#tdGrade").append(imgSrc2);
				}
			}else{
				for(var j = 0; j < 5-GradeValue1; j++) {
					$("#tdGrade").append(imgSrc2);
				}
			}

		var zlGradeValue = '<s:property value="#request.userEvaluation.zlGradeValue"/>';
		GradeValue2 = (zlGradeValue*10)%10;
		GradeValue1 = (zlGradeValue*10-GradeValue2)/10;
			for(var j = 0; j < GradeValue1; j++) {
				$("#zlGrade").append(imgSrc);
			}
			if(GradeValue2>=5&&GradeValue2<=9){
				$("#zlGrade").append(imgSrc1);
				for(var j = 0; j < 4-GradeValue1; j++) {
					$("#zlGrade").append(imgSrc2);
				}
			}else{
				for(var j = 0; j < 5-GradeValue1; j++) {
					$("#zlGrade").append(imgSrc2);
				}
			}

		var grade = '<s:property value="#request.userInfo.grade"/>';
		var sellerGrade = '<s:property value="#request.userInfo.sellerGrade"/>';
		var imgG1 = '<img src=\"theme/images2/m21.gif\" />&nbsp;';
		var imgG2 = '<img src=\"theme/images2/m22.gif\" />&nbsp;';
		var imgG3 = '<img src=\"theme/images2/m23.gif\" />&nbsp;';
		var imgSG1 = '<img src=\"theme/images2/m41.gif\" />&nbsp;';
		var imgSG2 = '<img src=\"theme/images2/m42.gif\" />&nbsp;';
		var imgSG3 = '<img src=\"theme/images2/m43.gif\" />&nbsp;';
		if(grade<=3&&grade!=null){
			for(var j = 0; j < grade; j++) {
				$("#grade").append(imgG1);
			}
		}else if(grade>3&&grade<=6){
			for(var j = 0; j < (grade-3); j++) {
				$("#grade").append(imgG2);
			}
		}else{
			for(var j = 0; j < (grade-6); j++) {
				$("#grade").append(imgG3);
			}
		}
		if(sellerGrade<=3&&sellerGrade!=null){
			for(var j = 0; j < sellerGrade; j++) {
				$("#sellerGrade").append(imgSG1);
			}
		}else if(sellerGrade>3&&sellerGrade<=6){
			for(var j = 0; j < (sellerGrade-3); j++) {
				$("#sellerGrade").append(imgSG2);
			}
		}else{
			for(var j = 0; j < (sellerGrade-6); j++) {
				$("#sellerGrade").append(imgSG3);
			}
		}
		*/
	}
	 function qianYueTa(){
	     	<%if(userSession==null){%>
				//art.dialog.alert("请先登录!");

			<%
				com.smt.entity.TAppUserInfo userInfo1 = (com.smt.entity.TAppUserInfo)request.getAttribute("userInfo");
				String url = "";
				if(userInfo1!=null){
					Integer uId = userInfo1.getUserId();
					url = "?r="+HttpSessionHelper.urlEncode("/member/business!toPreOrder.htm?bqyUserId="+uId.toString());
				}
			%>

	  	    	parent.showPop(2,'<%=request.getContextPath() %>/loginHtml.htm<%=url%>');


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
					   		p.location = '<%=request.getContextPath() %>/member/business!toPreOrder.htm?bqyUserId=<s:property value="#request.userInfo.userId"/>';
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
			parent.showPop(2,'<%=request.getContextPath() %>/loginHtml.htm');
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
	
	function hideTA(userId){
     	<%
			String url2 = "";
			if(userSession==null){
				url2= "?r="+HttpSessionHelper.urlEncode("/member/business!toPreOrder.htm?bqyUserId=");
		%>
				parent.showPop(2,'<%=request.getContextPath() %>/loginHtml.htm<%=url2%>'+userId);
		<%}else{%>
				//art.dialog.tips("本功能正在快速完善中，很快你就可以雇佣TA啦~~");
				window.open('<%=request.getContextPath()%>/member/business!toPreOrder.htm?bqyUserId='+userId);
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

	function jiathis(){
		$("#jia").show();
	}
	function hidehis(){
		$("#jia").hide();
	}



$(function(){
		$("#tcc").mouseover(function(){
			$("#open").fadeIn();
		}).mouseout(function(){
			$("#open").fadeOut();	
		});



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

</script>




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

 

<div class="top_b">
  <div class="top_b_c mian Layout">
  		<div class="top_b_c_Tleft">
		<s:if test="#request.preUserId!=null"><a href="<%=request.getContextPath() %>/index/orgListAction.htm?id=${preUserId}&actionName=orgBaseInfo"></s:if>
		<s:else><a href="#" title="没有上一页了"></s:else>
		<img src="/theme/org/images/Tleft.png" width="31" height="56" /></a></div>

    	<div class="top_b_c_l fl" style="clear:both">
   	  		<a href="<%=request.getContextPath() %>/index/orgListAction.htm?id=${id}"  id="tcc"><img src='/stageUpload/headImage/${user.id}.png?date=<%=new java.util.Date()%>' width="131" height="115" onerror="javascript:this.src='<%=request.getContextPath() %>/theme/images/tu03.jpg'" /></a>
            <div class="top_b_c_l_c Layout">
				<a href='javascript:hideTA("${user.id}")' ><img src="/theme/org/images/gyta.png" width="131" height="43" /></a>
            </div>


          <ul class="top_b_c_l_b Layout">
            <li><a href="<%=request.getContextPath() %>/index/orgListAction.htm?id=${id}&actionName=orgFriends&sign=1#orgTab" ><strong>${friendGZTotal}</strong><span>关注</span></a></li>
            <li><a href="<%=request.getContextPath() %>/index/orgListAction.htm?id=${id}&actionName=orgFriends&sign=2#orgTab" ><strong>${friendFSTotal}</strong><span>粉丝</span></a></li>
          </ul>


          <div class="top_b_c_l_tc" id="open">
          	<h2>动态评分</h2>
            <h2>好评率：<span><s:property value="#request.goodRate"/></span></h2>
            <ul>
            	<li><p>描述相符：</p><span>&nbsp;<s:property value="#request.totalMsRemarksStr"/></span>
				<!-- <em>老板等级：</em><b><span id="grade"></span></b> --></li>
                <li><p>演出态度：</p><span>&nbsp;<s:property value="#request.totalTdRemarksStr"/></span>
				<!-- <em>艺人等级：</em><b><span id="sellerGrade"></b> --></li>
                <li><p>完成质量：</p><span>&nbsp;<s:property value="#request.totalZlRemarksStr"/></span></li>
            </ul>
          </div>
  	  	</div>



   		<div class="top_b_c_c fl">
       	  <div class="top_b_c_c_t">
           	<h2><a><s:property value="#request.userInfo.nickName"/></a>

			</h2><s:if test="#request.userInfo.orgCard!=null"><img src="/theme/org/images/zj.png" width="32" height="25" title="认证企业"/></s:if>
					<a class="jiathis_button_weixin" href="javascript:fenxian()"><img src="/theme/org/images/ewm2.gif" width="25" height="25" /></a>
					<div class="jiathis_style" id="fenxiang"></div>
					<script type="text/javascript" >

					function 	fenxian(){
						if($("#fenxiang").style.display=="none"){
							$("#fenxiang").show().css({'top':$(e).offset().top+20,'left':$(e).offset().left});
						}else{
							$("#fenxiang").hide();
							 yrname = '<s:property value="#request.userInfo.nickName"/>';
							 yrurl = 'http://www.d15t.cn/index/orgListAction.htm?id=<s:property value="#request.userInfo.userId"/>';
							 yrpic = 'http://www.d15t.cn/stageUpload/headImage/<s:property value="#request.userInfo.userId"/>.png';
							 jiathis_config={
								url:yrurl,
								sm:"weixin",
								summary:"我在第一舞台发现了ta，非常棒！",
								title:"超喜欢 #"+yrname+"#",
								pic:yrpic,
								shortUrl:false,
								hideMore:false
							}
						}	
					}
					</script>
					<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
          </div>


          <div class="top_b_c_c_Address">
          	<p><s:property value="#request.userInfo.provice"/></p><span>|</span><p><s:property value="#request.userInfo.city"/></p>
          </div>


          <div class="top_b_c_c_rq Layout">
          	<!--<p>签约次数：<span><s:property value="#request.userInfo.signNumber"/></span></p>-->
			<p>人气指数：<span><s:property value="#request.userInfo.popularityTotal"/></span></p>
          </div>



          <div class="top_b_c_c_rq Layout">
          	<p>公司名称：<s:property value="#request.userInfo.nickName"/></p>
          </div>
          <div class="top_b_c_c_rq Layout">
          	<p>服务范围：<i><s:property value="#request.userInfo.seviceScope"/></i></p>
          </div>
          <div class="top_b_c_c_jj Layout">
          	<dl>
            	<dd>机构简介：</dd>
                <dt style="width:570px;height:40px;overflow:hidden;"><s:if test="#request.userInfo.introduction.length() > 100"><s:property escape="false"  value='#request.userInfo.introduction.substring(0,100).replaceAll("\n", "<br>")' />...</s:if><s:else><s:property escape="false"  value='#request.userInfo.introduction.replaceAll("\n", "<br>")' /></s:else></dt>
            </dl>
            <p><a href="<%=request.getContextPath() %>/index/orgListAction.htm?id=${id}&actionName=orgBaseInfo#orgTab" >更多信息.....</a></p>
          </div>




        </div>
        <div class="top_b_c_r fr">

        	<dl>
            	<dd></dd>
				<dd>  <img src="/theme/org/images/fx.png" width="72" height="24" onclick='javascript:jiathis()'/>
								<div class="jiathis_style" id="jia" onclick='javascript:hidehis()'  style="position:absolute;display:none;margin-top:-25px;margin-left:50px;zIndex:1;background:#EEEEED;height:25px;"><a class="jiathis_button_icons_1"></a>
								<a class="jiathis_button_icons_2"></a>
								<a class="jiathis_button_icons_3"></a>
								<a class="jiathis_button_icons_4"></a>
								<a class="jiathis_button_icons_5"></a>

								</div>
								<script type="text/javascript">

								 yrname2 = '<s:property value="#request.userInfo.nickName"/>';
								 yrurl2 = 'http://www.d15t.cn/index/orgListAction.htm?id=<s:property value="#request.userInfo.userId"/>';
								 yrpic2 = 'http://www.d15t.cn/stageUpload/headImage/<s:property value="#request.userInfo.userId"/>.png';
								 jiathis_config={
									url:yrurl2,
									sm:"qzone,tsina,tqq,weixin,tieba,tsohu",
									summary:"我在第一舞台发现了ta，非常棒！",
									title:"超喜欢 #"+yrname2+"#",
									pic:yrpic2,
									shortUrl:false,
									hideMore:true
								}

 
								</script>
								<script type="text/javascript" src="http://v3.jiathis.com/code/jia.js" charset="utf-8"></script>
						
			 
				
				
				
				</dd>
                <dt><a href='javascript:addFriend("${id}")' ><img src="/theme/org/images/gz.jpg" width="89" height="35" /></a></dt>
                <dt><a href="javascript:sendMessage()" ><img src="/theme/org/images/lxta.jpg" width="89" height="35" /></a></dt>
            </dl>
 
        </div>
    <div class="top_b_c_Tright">
		<s:if test="#request.postUserId!=null"><a href="<%=request.getContextPath() %>/index/orgListAction.htm?id=${postUserId}&actionName=orgBaseInfo"></s:if>
		<s:else><a href="#" title="没有下一页了"></s:else>

	<img src="/theme/org/images/Tright.png" width="31" height="56" /></a></div>
  </div>
</div>






<div class="nav" id="nav">
	<div class="nav_c mian">
	<a name="orgTab"></a>
      <dl>
      	<dd<%if("orgBaseInfo".equals(request.getParameter("actionName"))){ out.print(" class='on'"); }%> ><a href="<%=request.getContextPath() %>/index/orgListAction.htm?id=${id}&actionName=orgBaseInfo#orgTab"  ><p class="grxx"></p><span>基本信息</span></a></dd>

        <dd<%if(request.getParameter("actionName")==null || "orgService".equals(request.getParameter("actionName"))){ out.print(" class='on'"); }%>><a href="<%=request.getContextPath() %>/index/orgListAction.htm?id=${id}&actionName=orgService#orgTab"  ><p class="xgzp"></p><span>服务项目</span></a></dd>

        <dd<%if("orgZuopin".equals(request.getParameter("actionName"))){ out.print(" class='on'"); }%>><a href="<%=request.getContextPath() %>/index/orgListAction.htm?id=${id}&actionName=orgZuopin#orgTab"  ><p class="xgzp"></p><span>相关作品</span></a></dd>

        <dd <%if("orgZhaoPin".equals(request.getParameter("actionName"))){ out.print(" class='on'"); }%>><a href="<%=request.getContextPath() %>/index/orgListAction.htm?id=${id}&actionName=orgZhaoPin#orgTab"  ><p class="jypj"></p><span>招聘信息</span></a></dd>


        <dd <%if("orgFriends".equals(request.getParameter("actionName"))){ out.print(" class='on'"); }%>><a href="<%=request.getContextPath() %>/index/orgListAction.htm?id=${id}&actionName=orgFriends#orgTab"  ><p class="tadhy"></p><span>TA的好友</span></a></dd>

         
      </dl>
    </div>
</div>

 