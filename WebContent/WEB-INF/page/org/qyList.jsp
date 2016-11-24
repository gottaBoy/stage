<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="pg" uri="/page-tags"%>  
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    
    <title><%=StageVariale.title%></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="description" content="<%=StageVariale.description%>">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css"></link>
	<link href="<%=request.getContextPath() %>/theme/css/page.css" rel="stylesheet" type="text/css" />
	<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/theme/css2/lrtk.css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/address.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/swfobject.js"></script>
	<style type="text/css">
	.current_span {
		background-color:#66C1FF;
		cursor:pointer;
		font-size:12px;
	}
	.span {
		cursor:pointer;
		color:color: #5C5C5C;
		font-size:12px;
	
	}
	.qy-list{width:1003px;background:#fff;border:1px solid #ccc;margin:0 auto;}
	.qy-s2{width:993px;height:30px;background:#3a3e41;margin:0 auto}
	.qy-s2 dt{position:relative;margin-left:10px;color:#FFF;height:20px;top:5px}
	.qy-s3{width:983px;height:40px;margin:0 auto;border-bottom:1px dashed #c0c0c0;padding-top:10px}
	.qy-search{width:1003px;height:150px;background:#fff;border:1px solid #ccc;margin:0 auto}
	.qy-banner{width:1003px;height:30px;margin:0 auto}
.qy-bzhong{
	width: 985px;
	height: 30;
	line-height: 20px;
	background: url(<%=request.getContextPath() %>/theme/images2/qylist02.jpg) repeat-x;
	padding: 5px 5px;
	position: relative}
.qy-bleft{width:4px;height:30px;margin:0 auto}
.qy-bright{width:4px;height:30px;margin:0 auto}
.qymc{width:205px;color:#808080}
.qymc dt{position:relative;margin-left:5px;}
.qymc dd{position:relative;margin-left:5px;line-height:28px;float:left;}

.qymc .dd1{width:195px;float:left;}
.qymc .dd2 a{color:#0195c3;font-size:15px;}
.qymc .dd2 a:hover{color:#cd0001;}
.qymc .dtn{position:relative;margin-left:90px;}
.qytj{width:88px; height:29px;line-height:29px;background-image:url(<%=request.getContextPath() %>/theme/images2/qylist06.jpg);text-align:right;}
.qygz{width:88px; height:29px;line-height:29px;background-image:url(<%=request.getContextPath() %>/theme/images2/qylist07.jpg);text-align:right;}
.ejy-rp2{width:423px;height:44px;border:1px solid #c1c1c1;background:url(../images2/tu43.jpg) repeat-x;line-height:44px;margin-bottom:15px;}
.ejy-rp2 li{float:left;border-right:1px solid #c1c1c1;line-height:44px;}
.ejy-rp2 li.jj{border-right:none;background:none;padding-left:8px;}
.ejy-rp2 li a{display:block;padding:0 25px;}
.ejy-rp2 li.jj2 a{color: black;}
.ejy-rp2 li.jj a span{color:#09F}
	</style>
	<script type="text/javascript">

	function toSearch(){
		//var keywords =$("#keywords").val();	
		//window.location.href="userinfo!getUserInfoList.htm?keywords="+encodeURI(keywords);	
		var form  = $("#searchForm"); 
        form.submit(); 
	}
	
	function toView(userId){
		art.dialog.open('<%=request.getContextPath() %>/member/userinfo!toUserInfoView.htm?type=2&&userId='+userId,{width:750,height:570,resize: false});
	}
	function alertInfo(content){
				art.dialog({
					content:content,
					width:300
				});
			}
	function view(indexImgUrl){
			art.dialog({
		    padding: 0,
		    title: '照片',
		    content: '<img onerror="handleImgLoadError(event);" src="/images/indexImg/'+indexImgUrl+'?id=<%=new Date() %>" />',
		    lock: true
		});
	}
	
	function handleImgLoadError(oEvent){
           oEvent.srcElement.src='<%=request.getContextPath() %>/theme/images/rz_imgphoto.jpg';
  	    }
  	    
  	    function sendMessage(id){
 			art.dialog.open('<%=request.getContextPath()%>/messageSend!send.htm?id='+id,{width:550,height:300,resize: false});
	 	 }
  	
  	$().ready(function(){
		
			var loc1Value = '<s:property value="#request.loc1"/>';
			$("#provice").val(loc1Value);
			var html = "<span id='locality1_span0' onclick='setSearchValue(this,1,0)' class='current_span' style='margin-left:3px;'>&nbsp;不限&nbsp;&nbsp;</span>";
			if(loc1Value=="1"){
				for(var i=0;i<address.length;i++){
					var j=address[i];
					if(j[2]=="江苏"){		
					html+="<span id='locality1_span"+j[0]+"' onclick='setSearchValue(this,1,\""+j[0]+"\",\""+j[3]+"\")'  class='span'>&nbsp;"+j[3]+"&nbsp;</span>&nbsp;&nbsp;";
					}	
				}
				if(loc1Value != 0) {
					var html1 = "<div id='selected_div_1_"+loc1Value+"' style='float:left;background-color: #ffffff; cursor:pointer; border:#FF6600 1px solid; color:#999999; margin-left:3px; margin-top:3px; margin-bottom:3px;' onclick='$(this).remove();deleteSelected(1,"+loc1Value+")'><span id='selected_span_1_"+loc1Value+"'>江苏</span>&nbsp;<span style='background:url(<%=request.getContextPath()%>/theme/images2/fixed-filter.png) no-repeat; background-position:-18px 0px;' >&nbsp;&nbsp;&nbsp;</span>&nbsp;</div>";
					$("#selected_div").html($("#selected_div").html() + html1);
				}
			}else if(loc1Value==2){
				for(var i=0;i<address.length;i++){
					var j=address[i];
					if(j[2]=="浙江"){		
					html+="<span id='locality1_span"+j[0]+"' onclick='setSearchValue(this,1,\""+j[0]+"\",\""+j[3]+"\")'  class='span'>&nbsp;"+j[3]+"&nbsp;</span>&nbsp;&nbsp;";
					}	
				}
				if(loc1Value != 0) {
					var html1 = "<div id='selected_div_1_"+loc1Value+"' style='float:left;cursor:pointer;background-color: #ffffff; border:#FF6600 1px solid; color:#999999; margin-left:3px; margin-top:3px; margin-bottom:3px;' onclick='$(this).remove();deleteSelected(1,"+loc1Value+")'><span id='selected_span_1_"+loc1Value+"'>浙江</span>&nbsp;<span style='background:url(<%=request.getContextPath()%>/theme/images2/fixed-filter.png) no-repeat; background-position:-18px 0px;' >&nbsp;&nbsp;&nbsp;</span>&nbsp;</div>";
					$("#selected_div").html($("#selected_div").html() + html1);
				}
			}else if(loc1Value==3){
				for(var i=0;i<address.length;i++){
					var j=address[i];
					if(j[2]=="安徽"){		
					html+="<span id='locality1_span"+j[0]+"' onclick='setSearchValue(this,1,\""+j[0]+"\",\""+j[3]+"\")'  class='span'>&nbsp;"+j[3]+"&nbsp;</span>&nbsp;&nbsp;";
					}	
				}
				if(loc1Value != 0) {
					var html1 = "<div id='selected_div_1_"+loc1Value+"' style='float:left; cursor:pointer;background-color: #ffffff; border:#FF6600 1px solid; color:#999999; margin-left:3px; margin-top:3px; margin-bottom:3px;' onclick='$(this).remove();deleteSelected(1,"+loc1Value+")'><span id='selected_span_1_"+loc1Value+"'>安徽</span>&nbsp;<span style='background:url(<%=request.getContextPath()%>/theme/images2images/fixed-filter.png) no-repeat; background-position:-18px 0px;' >&nbsp;&nbsp;&nbsp;</span>&nbsp;</div>";
					$("#selected_div").html($("#selected_div").html() + html1);
				}
			}else if(loc1Value==4){
				for(var i=0;i<address.length;i++){
					var j=address[i];
					if(j[2]=="上海"){		
					html+="<span id='locality1_span"+j[0]+"' onclick='setSearchValue(this,1,\""+j[0]+"\",\""+j[3]+"\")'  class='span'>&nbsp;"+j[3]+"&nbsp;</span>&nbsp;&nbsp;";
					}	
				}
				if(loc1Value != 0) {
					var html1 = "<div id='selected_div_1_"+loc1Value+"' style='float:left; cursor:pointer;background-color: #ffffff; border:#FF6600 1px solid; color:#999999; margin-left:3px; margin-top:3px; margin-bottom:3px;' onclick='$(this).remove();deleteSelected(1,"+loc1Value+")'><span id='selected_span_1_"+loc1Value+"'>上海</span>&nbsp;<span style='background:url(<%=request.getContextPath()%>/theme/images2/fixed-filter.png) no-repeat; background-position:-18px 0px;' >&nbsp;&nbsp;&nbsp;</span>&nbsp;</div>";
					$("#selected_div").html($("#selected_div").html() + html1);
				}
			}
			var loc2Value = '<s:property value="#request.loc2"/>';
			var loc2id = '<s:property value="#request.cityid"/>';
			if(loc2Value!=0){
				var html1 = "<div id='selected_div_2_"+loc2id+"' style='float:left; cursor:pointer;background-color: #ffffff; border:#FF6600 1px solid; color:#999999; margin-left:3px; margin-top:3px; margin-bottom:3px;' onclick='$(this).remove();deleteSelected(2,"+loc2id+")'><span id='selected_span_2_"+loc2id+"'>"+loc2Value+"</span>&nbsp;<span style='background:url(<%=request.getContextPath()%>/theme/images2/fixed-filter.png) no-repeat; background-position:-18px 0px;' >&nbsp;&nbsp;&nbsp;</span>&nbsp;</div>";
				$("#selected_div").html($("#selected_div").html() + html1);
			}
				
			$("#locality1_div").html(html);
			$("#locality_div span").attr("class", "span");
			$("#locality_span"+loc1Value).attr("class", "current_span");
			$("#locality1_div span").attr("class", "span");
			$("#locality1_span"+loc2id).attr("class", "current_span");
			$('.ejy-rp2 li.jj2 a').each(function(){
					if($(this).attr("id") == ("sort_"+'<s:property value="#request.sort"/>')){
						$(this).css({"background-image":"url('<%=request.getContextPath()%>/theme/images2/tu48.jpg')"});
					}else{
						$(this).css({"background-image":"url('<%=request.getContextPath()%>/theme/images2/tu48-2.jpg')"});
						//$(this).onmouseover();
					}
			}); 
			//$('.ejy-rp2 li.jj2 a').onmouseover();
		});
  	function setSearchValue(e, type,id, value) {
     	if(type==1){//区域
     		 $('#city').val(value);
     		 $('#cityid').val(id);
     	}else if(type==2){//排序
     		 $('#sort').val(value);
     	}
     
     	searchStar();
     }
     function setSearchValue1(e, type, value) {
     //$("#locality_div span").attr("class", "span");$(e).attr("class", "current_span");
     $('#provice').val(value);
     searchStar();
     }
    function searchStar(){
    	
	     var form = $(document.getElementById('searchForm'));
         form.submit();   
        //var locality = $("#provice").val()+"_"+$('#city').val();
	    //var sort = $('#sort').val();
 		//var tmp = form.attr('action')+'?locality='+locality+'&sort='+sort;
		//$.post(tmp, form.serialize());

	   // var locality = $("#provice").val()+"_"+$('#city').val();
	   // var sort = $('#sort').val();
	   // window.location.href='qyList.htm?locality='+locality+'&sort='+sort;
     }
    function deleteSelected(type,id) {
    	if(type==1){
    		$('#provice').val(0);
    	}else if(type==2){
    		$('#city').val(0);
    		$('#cityid').val(0);
    	}
    	searchStar();
    }

</script>		
</head>
  <body>
 <!-- JiaThis Button BEGIN -->
<script type="text/javascript" >
var jiathis_config={
	siteNum:6,
	sm:"qzone,tsina,tqq,weixin,tieba,tsohu",
	url:"http://d15t.cn/qyList1.htm",
	summary:"第一舞台，演艺人才的淘宝网！",//摘要
	title:"企业商城#第一舞台#",//标题#微博话题#
	pic:"http://d15t.cn/stageUpload/headImage/600.png",//图片
	showClose:true,
	shortUrl:false,
	hideMore:false
}
</script>
<script type="text/javascript" src="http://v3.jiathis.com/code_mini/jiathis_r.js?btn=r.gif&move=0" charset="utf-8"></script>
<!-- JiaThis Button END -->
 <img id="d1photo" src="<%=request.getContextPath() %>/theme/images2/d1photo.jpg" style="z-index:1000;position:fixed; bottom:120px; _margin-bottom:120px;"/>
 <a id="QQlink" target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=979961675&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:1847791078:53" alt="点击这里给我发消息" title="点击这里给我发消息"/></a>
  <jsp:include page="../public/head2.jsp">
  <jsp:param value="no" name="titleType"/>
  </jsp:include>
  <!-- 主内容开始 -->
  <form name="searchForm" id="searchForm" method="post" action='qyList1.htm'>
  <input  type="hidden" id="provice" name="provice" style="display: none;" value="${loc1 }"/>
  <input  type="hidden" id="city" name="city" style="display: none;" value="${loc2 }"/>
  <input  type="hidden" id="cityid" name="cityid" style="display: none;" value="${cityid }"/>
  <input  type="hidden" id="sort" name="sort" style="display: none;" value="${sort }"/>
  <input  type="hidden" id=popularityTotal name="popularityTotal" style="display: none;" value="${popularityTotal }"/>
  <input  type="hidden" id=attention name="attention" style="display: none;" value="${attention }"/>
 
<table width="980" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td width="100%">
			<div class="qy-banner">
			  <div class="qy-bleft l"><img src="<%=request.getContextPath() %>/theme/images2/qylist01.jpg" width="4" height="30" /></div>
			  <div class="qy-bzhong l">热门商城:</div>
			  <div class="qy-bright l"><img src="<%=request.getContextPath() %>/theme/images2/qylist03.jpg" width="4" height="30" /></div>
			</div>
		</td>
	</tr>
	<tr>
		<td height="5">&nbsp;</td>
	</tr>
	<tr>
		<td>
			 <table width="100%" border="0" cellspacing="0" cellpadding="0" style="padding-left: 10px;">
			  <tr>
			  	<td width="90%" align="center"  bgcolor="" style="font-size: 15px;"  >
			      <div id="search_list_div" style=" background-color:#FFF; height:auto;">
					<table style="color: #5C5C5C" width="100%" border="0" class="qy-search">
						<tr valign="top">
							<td style="font-size:12px;width: 55px;padding-top: 5px;"><table width="100%"><tr><td>&nbsp;&nbsp;&nbsp;区域:</td></tr></table></td>
							<td align="left" style="padding-top: 5px;">
								<div id="locality_div">
						            <span id="locality_span0" onclick="setSearchValue1(this, 1, 0)" class="current_span" style="margin-left:3px;">&nbsp;不限&nbsp;&nbsp;</span>
						            <span id="locality_span1" onclick="setSearchValue1(this, 1, 1)" class="span">&nbsp;江苏省&nbsp;</span>&nbsp;&nbsp;
						            <span id="locality_span2" onclick="setSearchValue1(this, 1, 2)" class="span">&nbsp;浙江省&nbsp;</span>&nbsp;&nbsp;
						            <span id="locality_span3" onclick="setSearchValue1(this, 1, 3)" class="span">&nbsp;安徽省&nbsp;</span>&nbsp;&nbsp;
						            <span id="locality_span4" onclick="setSearchValue1(this, 1, 4)" class="span">&nbsp;上海市&nbsp;</span>&nbsp;&nbsp;
			         	 		</div>
							</td>
						</tr>
						<tr><td></td><td style="padding-top: 5px;" align="left"><div style='background-image:url(<%=request.getContextPath() %>/theme/images2/dot2.gif); background-repeat:repeat; height:1px; width:96%;'></div></div></td></tr>
						<tr valign="top">
							<td style="font-size:12px;width: 55px;padding-top: 5px;"><div ><table width="100%"><tr><td>&nbsp;&nbsp;&nbsp;地区:</td></tr></table></div></td>
							<td align="left" style="padding-top: 5px;">
								<div id="locality1_div">
									
					       	 	</div>
							</td>
						</tr>
						<tr><td></td><td style="padding-top: 5px;" align="left"> <div style='background-image:url(<%=request.getContextPath() %>/theme/images2/dot2.gif); background-repeat:repeat; height:1px; width:96%'></div></div></td></tr>
						<tr>
							<td>
							</td><td>
							<table><tr></tr> <td width="145" height="24" align="left" style="line-height:38px; vertical-align: middle; padding-top:6px;">
						         <input name="keywords" type="text" class="znrz_input" id="keywords" value="${keywords}" /></td>
						        <td width="585" align="left" style="line-height:38px; vertical-align: middle; padding-top:6px;"><a href="javascript:searchStar();" ><img src="<%=request.getContextPath() %>/theme/images/znrz_search.jpg" width="50" height="26" /></a></td>
							 </table></td> 		
						</tr>	
					</table>
				 </div>
				 </td>
				 </tr></table>	
		</td>
	</tr>
	
    <tr>
        <td width="100%" align="left" valign="top">
        <div class="qy-s2">
		<dt><div style="float:left;">您已经选择：</div> <div style="float:left; text-align:left; margin-left:10px; width:600px; height:auto;" class="clearfix" id="selected_div"></div></dt>
		</div> 
    </td></tr>
    <tr>
    <td>
    
    <div class="qy-list">
    	<table width="100%" >
    		<tr>
    		<td width="10">&nbsp;</td>
    			<td style="height: 44px;padding-top: 10px;">
    				<ul class="ejy-rp2">
				      <li class="jj2"><a id="sort_0" href="javaScript:setSearchValue(this,2,0,0)">默认排序</a></li>
				      <li class="jj2"><a  id="sort_1" href="javaScript:setSearchValue(this,2,1,1)">等级</a></li>
				      <li class="jj2"><a id="sort_2"  href="javaScript:setSearchValue(this,2,2,2)">人气</a></li>
				      <li class="jj2"><a id="sort_3"  href="javaScript:setSearchValue(this,2,3,3)">收藏</a></li>
				      <li class="jj2"><a id="sort_4"  href="javaScript:setSearchValue(this,2,4,4)">签约次数</a></li>
				     </ul>
    			</td>
    		</tr>
    	</table>
    	<!--  
		<table width="100%">
			<tr>
			<td ><div style="width:983px;height:5px; margin:0 auto;border-bottom:1px dashed #c0c0c0;"></div>
			</td>
		</tr>
		<tr>
			<td hight="10">&nbsp;</td>
		</tr>
		</table>-->
		<table width="97%" border="0" align="center" cellpadding="0" cellspacing="0" background="<%=request.getContextPath() %>/theme/images2/qylist05.jpg">
		    <tr>
		      <th height="36" scope="col">名称</th>
		      <th width="90" scope="col">等级</th>
		      <th width="90" scope="col">所在地</th>
		      <th width="90" scope="col">签约艺人</th>
		      <th width="130" scope="col">人气</th>
		      <th width="130" scope="col">关注</th>
		      <th width="120" scope="col">成交</th>
		    </tr>
		  </table>
		  <table width="97%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#f9f9f9">
		  	<s:iterator value="#request.list" var="item" status="st">
			    <tr class="ejy-rp6" valign="middle">
			      <td width="115" height="80" align="center" valign="middle"><dl class="ejy-dl">
			        <dt><a href="orgListAction.htm?id=<s:property value="#item[0].id"/>"><img src="/stageUpload/headImage/<s:property value="#item[0].id"/>.png" onerror="handleImgLoadError(event);"  height="60" /></a></dt>
			      </dl></td>
			      <td>
			      <div class="qymc dt l">
			        <dl class="qymc l">
			         <dd class="dd1"><a href="orgListAction.htm?id=<s:property value="#item[0].id"/>" class="czjl_title_link"><s:property value="#item[1].nickName"/></a>&nbsp;</dd>
			         <dd class="dd2"><a href="javascript:alertInfo('<s:property value="#item[1].introduction"/>')">企业介绍</a></dd> 
			         <dt class="dtn"><a href="javascript:sendMessage(<s:property value="#item[0].id"/>)"><img src="<%=request.getContextPath() %>/theme/images2/qylist08.png"/></a></dt> 
			        </dl>
			      </div>
			      </td>
			      <td width="90" align="center" valign="middle">LV<s:property value="#item[1].grade"/>&nbsp;</td>
			      <td width="90" align="center" valign="middle"><s:property value="#item[1].provice"/>&nbsp;<s:property value="#item[1].city"/></td>
			      <td width="90" align="center" valign="middle">
			      		<s:iterator value="#request.yrinfoList" var="yrinfoList" >
			         		<s:if test="#yrinfoList.id==#item[0].id">
			         			<s:property value="#yrinfoList.yrSun"/>
			         		</s:if>
			         	</s:iterator>
			      </td>
			      <td width="130" align="center" valign="middle">
			      	<div class="qytj" style="cursor: pointer" onclick="$('#popularityTotal').val(<s:property value="#item[0].id"/>);searchStar();"><s:property value="#item[1].popularityTotal"/>&nbsp;</div></td>
			      <td width="130" align="center" valign="middle">
			      <div class="qygz"  style="cursor: pointer" onclick="$('#attention').val(<s:property value="#item[0].id"/>);searchStar();"><s:property value="#item[1].attention"/>&nbsp;</div></td>
			      <td width="120" align="center" valign="middle">最近成交<s:property value="#item[1].SignNumber"/>次<br/>
			      </td>
			    </tr>
			    <tr>
			      <td colspan="8" background="<%=request.getContextPath() %>/theme/images2/qylist-dot.jpg"><img src="<%=request.getContextPath() %>/theme/images2/qylist-dot.jpg" width="4" height="1" /></td>
			    </tr>
			 </s:iterator>
		  </table>
		  
		<table width="790" border="0" align="center" cellpadding="0" cellspacing="0" class="page">
		    <tr>
		        <td align="center"><pg:pages  pageNo='${pageNum}' rowCount ="8"  url="qyList1.htm" params='keywords=${pageKeywords}&&provice=${loc1}&&city=${loc2}&&sort=${sort}'  total='${game}' ></pg:pages></td>
		    </tr>
		</table>
		
	</div>	

</td>
    </tr>
</table>

</td>
</tr>
</table>


</td>
</tr>
</table>
 </form>
<!-- 主内容结束 -->
<jsp:include page="../public/bottom2.jsp"></jsp:include>

<script type="text/javascript">

//用户名框鼠标焦点移进，文字消失
 $("#keywords").click(function () {
 var check1 = $(this).val();
 if (check1 == "搜索其他地区") {
 $(this).val("");
 }
 });
//用户名框鼠标焦点移出，默认文字显示
 $("#keywords").blur(function () {
 var check1 = $(this).val();
 if (check1 == "") {
 $(this).val("搜索其他地区");
 }
 });


		

 </script>
  </body>
</html>