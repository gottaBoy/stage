<%@page import="com.smt.webapp.util.OnlineUser"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="pg" uri="/page-tags"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.*" %>
<%
	String path = request.getContextPath();
	UserSession userSession=HttpSessionHelper.getUserSession(request);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>
	<%String sign1 = (String)request.getParameter("sign");
	if(sign1 == null) {
		out.print(StageVariale.title);
	} else {
		if(sign1.equals("1")) {
			out.print(StageVariale.title2);
		} else if(sign1.equals("2")) {
			out.print(StageVariale.title3);
		} else if(sign1.equals("3")) {
			out.print(StageVariale.title4);
		} else if(sign1.equals("4")) {
			out.print(StageVariale.title5);
		} else if(sign1.equals("5")) {
			out.print(StageVariale.title6);
		} else if(sign1.equals("6")) {
			out.print(StageVariale.title7);
		} else {
			out.print(StageVariale.title);
		}
	}

String 	keyType = (String)request.getParameter("keyType");
	%>
	</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<style>

.d1{background-color: #CCCCCC; width:400px; font:"宋体"; font-size:12px;position:absolute;display: none;
height: auto;}
.t{ background-color:#FFFFFF; margin-left:2px; margin-right:2px;margin-top:2px;margin-bottom:2px;}
.t1{border-bottom:1px dashed #C7C7C7;}
.t2{width:40px; height:20px; padding:8px 0 0 8px; height:22px;   }
.t2 a{ text-decoration:none;color:#FFFFFF;background-color:#ff5500;}
.t2 a:hover{ color:#FFFFFF;text-decoration: underline;background-color:#ff5500;}
.t3{ margin-left:10px; margin-right:10px}
</style>
	<style>
.black_overlay{display:none;position:absolute;top:0%;left:0%;width:100%;height:4250px;background-color:black;z-index:1001;-moz-opacity:0.8;opacity:.80;filter: alpha(opacity=80);}
.white_content{display:none;position:absolute;top:25%;left:25%;width:630px;height:4250px;z-index:1002;overflow:auto;}
</style>

<%-- 	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/global_layout.css" /> --%>
<%-- 	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/layout.css" /> --%>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/theme/css2/lrtk.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/theme/css2/gd.css" />
    <link href="<%=request.getContextPath() %>/theme/css/page.css" rel="stylesheet" type="text/css" />
    <link href="<%=request.getContextPath() %>/theme/css2/diyiwutai-erjiye.css" rel="stylesheet" type="text/css" />
   	<link href="<%=request.getContextPath() %>/theme/css2/style.css" rel="stylesheet" type="text/css" />
   	<link href="<%=request.getContextPath() %>/theme/css2/area.css" rel="stylesheet" type="text/css" />
	
    <script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/common.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/slides.jquery.js"></script>
	<SCRIPT type=text/javascript src="<%=request.getContextPath() %>/theme/js2/zzsc.js"></SCRIPT>
	<SCRIPT type=text/javascript src="<%=request.getContextPath() %>/theme/js2/areaArr2.js"></SCRIPT>
	<SCRIPT type=text/javascript src="<%=request.getContextPath() %>/theme/js2/jquery.showArea.js"></SCRIPT>
	<script language="javascript" type="text/javascript">
		$(document).ready(function(){
			$(".left-dl").find("li").not(":has(ul)").click(function(){
				$(this).get(0).location.href="'"+$(this).attr("href")+"'";
			});
			if("${place}"!=""){
				$('#_city_val').text("${place}");
			}
			$("#perNative").click({url:'<%=request.getContextPath()%>'},showArea);
//			$('.ejy-rp2 li.jj2 a').each(function(){
// 				$(this).bind("mouseover",{flag:$(this).attr("data")},function(event){
//					if($(this).attr("data") == 1){
//						$(this).css({"background-image":"url('<%=request.getContextPath()%>/theme/images2/tu48.jpg')"});
///					}else{
//						$(this).css({"background-image":"url('<%=request.getContextPath()%>/theme/images2/tu48-2.jpg')"});
//					}
// 				});
//			}); 
			$('.ejy-rp2 li.jj2 a').each(function(){
					if($(this).attr("id") == ("sort_"+'<s:property value="#request.sort"/>')){
						$(this).css({"background-image":"url('<%=request.getContextPath()%>/theme/images2/tu48.jpg')"});
					}else{
						$(this).css({"background-image":"url('<%=request.getContextPath()%>/theme/images2/tu48-2.jpg')"});
						//$(this).onmouseover();
					}
			}); 

			$("#sex").val("<s:property value="#request.sex"/>");

			//$('.ejy-rp2 li.jj2 a').onmouseover();
			//默认展开
			<%String sign = (String)request.getParameter("sign");%>
			$("#<%=sign%>").show();
			$("#<%=sign%>").prev("a").css({background:"url(<%=request.getContextPath() %>/theme/<%=path%>/theme/images2/nav_liimg02.jpg) no-repeat left top;"});
			
			<%String signSub = (String)request.getParameter("signSub");
			if(signSub!=null){%>
				$("#<%=signSub%>").show();
			<%}%>
			$("#area").live("mouseleave",function(){
				var flag = $('#area').is(":visible");
				if(flag)$('#area').hide();		    
					});
		});

		
		function submit(){
			var bprice=parseInt($("#bprice").val());
			var eprice=parseInt($("#eprice").val());
			
			if(bprice>eprice){
				art.dialog.tips("价格区间不正确！");
				return;
			}
			
			
			$("#searchFrom").submit();
		}
		
		function handleImgLoadError(oEvent){
           oEvent.srcElement.src='<%=path%>/theme/images2/rz_imgphoto.jpg';
  	    }
  	    
		function toAdd(){
		    <% 
		    	
		    	if(userSession==null){
		    %>
		    window.open ('<%=request.getContextPath() %>/login.html','_self','height=600,width=980,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no') 

		    <%  }else{%>
		    
			art.dialog.open('<%=request.getContextPath()%>/member/task!toTask.htm',{resize: false});
		  <%  }%>
		}
		function refresh(){
			window.location.reload();
		}

		
		function change(val){
			if(val==0){
				
			}
		}
		
		
		function submitSearchFrom(type, value, orderType) {
//			if(type == 1) {
//				document.getElementById("searchFrom").action = document.getElementById("searchFrom").action + "?sex=" + value+"&place="+$("#_city_val").text();
//			} else if(type == 2) {
//				$("#orderBySign").val(value);
//				if(value == 1) {
//					$("#nl").val(orderType);
//				} else if(value == 2) {
//					$("#hpl").val(orderType);
//				} else if(value == 3) {
//					$("#rq").val(orderType);
//				} else if(value == 5) {
//					$("#jg").val(orderType);
//				}
//			}
			if(type==1){
				$("#sex").val(value);
			}else if(type==2){
				$('#sort').val(value);
			}
			
			document.getElementById("searchFrom").submit();
		}
		
</script>
  </head>
 
 <%
    String menuSign=sign==null||sign.equals("")||sign.equals("null")?"1":Integer.toString(Integer.parseInt(sign)+1);
    menuSign=menuSign.equals("1")?"no":menuSign;
    
    //String headKeywords = "我是中国人"; 
	//headKeywords = URLEncoder.encode(headKeywords,"UTF-8"); 
    %>
<body >

<!-- JiaThis Button BEGIN -->
<script type="text/javascript" >
var jiathis_config={
	siteNum:6,
	sm:"qzone,tsina,tqq,weixin,tieba,tsohu",
	url:window.location.href,
	summary:"第1舞台演艺人才在线交易网",//摘要
	title:"#第1舞台#",//标题#微博话题#
	pic:"http://d15t.cn/stageUpload/headImage/600.png",//图片
	showClose:true,
	shortUrl:false,
	hideMore:false
}
</script>
<script type="text/javascript" src="http://v3.jiathis.com/code_mini/jiathis_r.js?btn=r.gif&move=0" charset="utf-8"></script>
<!-- JiaThis Button END -->

<img id="d1photo" src="<%=request.getContextPath() %>/theme/images2/d1photo.jpg"/>
<a id="QQlink" target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=979961675&site=qq&menu=yes"><img border="0" src="http://wpa.qq.com/pa?p=2:1847791078:53" alt="点击这里给我发消息" title="点击这里给我发消息"/></a>
    <jsp:include page="/WEB-INF/page/public/head2.jsp">
       <jsp:param value="<%=menuSign %>" name="titleType"/>
  </jsp:include>

<!-- 主内容开始 -->

<!-- 主内容开始 -->
<!--banner-->

<div class="nex2">
<!-- 树状开始 -->
<div class="nex-left l">
<div class="left-dh ejy-fd">
          <div class="left-dh2">
           <br/>
           
              <p class="left-rc">人才分类</p>
<table style="margin-left:20px; margin-right:20px; width:208px;">          	 
<s:iterator value="#request.list1" var="talentCategory2">
 <s:if test="#talentCategory2.layer==2 && #talentCategory2.parentId==#request.sign">
 	<tr><td>
      <div style="height:30px; line-height: 30px;font-size:14px;">
      	<a style=" color:#FFF;" href="<%=request.getContextPath() %>/query/queryAction!toQuery.htm?keyType=${keyType}&signSub=<s:property value="#talentCategory2.id"/>&sign=<s:property value="#request.sign"/>&filterValue=<s:property value="#talentCategory2.alias"/>"><s:property value="#talentCategory2.typeName"/></a>
      </div>
     </td></tr>
     <tr> <td>
      <s:iterator value="#request.list1" var="talentCategory3">
      		<s:if test="#talentCategory3.parentId==#talentCategory2.id">
			   <div style="clear:both"></div>
      			<div style="float:left;font-size:12px; margin-left:10px; line-height: 25px;"><a style=" color:#FFF;" href="<%=request.getContextPath() %>/query/queryAction!toQuery.htm?keyType=${keyType}&signSub=<s:property value="#talentCategory3.id"/>&sign=<s:property value="#request.sign"/>&filterValue=<s:property value="#talentCategory3.alias"/>"><s:property value="#talentCategory3.typeName"/></a></div>
					<div style="clear:both"></div>
					  <s:iterator value="#request.list1" var="talentCategory4">
							<s:if test="#talentCategory4.parentId==#talentCategory3.id">
								<div style="float:left;font-size:12px; margin-left:30px; line-height: 25px;"><a style=" color:#FFF;" href="<%=request.getContextPath() %>/query/queryAction!toQuery.htm?keyType=${keyType}&signSub=<s:property value="#talentCategory4.id"/>&sign=<s:property value="#request.sign"/>&filterValue=<s:property value="#talentCategory4.alias"/>"><s:property value="#talentCategory4.typeName"/></a></div>
							</s:if>
						</s:iterator>

      		</s:if>
      	</s:iterator>
      	</td></tr>
      	<tr><td><div style="border-bottom:1px #FFF dotted; height:5px;"></div></td></tr>
 </s:if>
</s:iterator>
</table>

          </div>
 </div>

</div>
<!-- 树状开始 -->

<div class="ejy-banner l">
<iframe src="<%=path %>/index/ejybanner.htm?type=2" name="wank" width="750"  height="345" scrolling="No" frameborder="0"></iframe>
</div>

<!--右边部分-->
<div class="nex-right l">
<div class="ejy-right ">
<%String filterValue=request.getAttribute("filterValue")==null?null:request.getAttribute("filterValue").toString(); %>

  <div class="ejy">
     <p class="ejy-rp l">
     <!--<input  name="sex" id="sex_0" type="radio" value="0" onclick="submitSearchFrom(1,0)"><a href="javascript:submitSearchFrom(1,0)"></input>&nbsp;不限&nbsp;</a>
     <input  name="sex" id="sex_1" type="radio" value="1" onclick="submitSearchFrom(1,1)"><a href="javascript:submitSearchFrom(1,1)"></input>&nbsp;男&nbsp;</a>
     <input  name="sex" id="sex_2" type="radio" onclick="submitSearchFrom(1,2)" value="2"><a href="javascript:submitSearchFrom(1,2)"></input>&nbsp;女&nbsp;</a>-->
<div class="d1" id="area">

<table width="100%" frame="box" class="t" >
  <tr>
    <td class="t1"><div class="t2"><a  href="#">所在地</a></div></td>
    </tr>
  <tr>
    <td class="t1">
    <table width="98%" id="province">
    </table></td>
    </tr>
  <tr>
    <td class="t1">
<table width="98%" id="city">
     
    </table>

&nbsp;</td>
    </tr>
</table>

</div>
     <p class="ejy-rpp l">
    <%
    	if(userSession==null){
    %>
     <a href="javascript:void(0)" onclick="showPop(1,'<%=request.getContextPath() %>/loginHtml.htm')"><img src="<%=path%>/theme/images2/tu55.jpg" width="108" height="40" /></a>&nbsp;
     <a href="javascript:void(0)" onclick="showPop(1,'<%=request.getContextPath() %>/loginHtml.htm')"><img src="<%=path%>/theme/images2/tu56.jpg" width="108" height="40" /></a>
     <% }else{ %>
     <a href="<%=request.getContextPath() %>/member/task.htm" onclick = "document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'"><img src="<%=path%>/theme/images2/tu55.jpg" width="108" height="40" /></a>&nbsp;
     <a href="javascript:toAdd();"><img src="<%=path%>/theme/images2/tu56.jpg" width="108" height="40" /></a>
     <% } %>
     </p>
  </div>
 
  <ul class="ejy-rp2">
      
      <li class="jj2"><a id="sort_2"  href="javascript:submitSearchFrom(2,2)">好评率</a></li>
      <li class="jj2"><a id="sort_3" href="javascript:submitSearchFrom(2,3)">人气</a></li>
<%--       <li class="jj2"><a href="<%=request.getContextPath() %>/query/queryAction!toQuery.htm?keyType=${keyType}&signSub=<%=signSub %>&sign=<%=sign %>&filterValue=<%=filterValue %>&eprice=${eprice }&bprice=${bprice }&pageKeywords=${keywords }&pageHeadKeywords=${headKeywords }&orderBySign=4&orderByDesc=${orderByDesc==0?1:0}">所在地</a></li> --%>
      <li class="jj2"><a id="sort_5"  href="javascript:submitSearchFrom(2,5)">价格</a></li>
      <form id="searchFrom" method="post" action="<%=request.getContextPath() %>/query/queryAction!toQuery.htm">
      <li class="jj">
      <input type="hidden" name="signSub" value="<%=signSub %>" />
      <input type="hidden" name="keyType" value="<%=keyType %>" />
      <input type="hidden" name="sign" value="<%=sign %>" />
      <input type="hidden" name="filterValue" value="<%=filterValue %>" />
      <input type="hidden" name="pageKeywords" value="${keywords }" />
      <input type="hidden" name="pageHeadKeywords" value="${headKeywords }" />
      <input type="hidden" name="orderBySign" id="orderBySign" value="1" />
      <!--<input type="hidden" name="sex" id="sex" value="${sex}" />-->
      <input  type="hidden" id="sort" name="sort" style="display: none;" value="${sort }"/>
      <input  type="hidden" id="place1" name="place1" style="" value="${place}"/>
      <input type="hidden" id="city_id" name="city_id" value="${placeId}"/>
      
      
      <a style="cursor:pointer; padding-left:5px;">价位：
      <input name="bprice" id="bprice" <s:if test="bprice!=0"> value="${bprice }"</s:if>  type="text" class="text3" onkeydown="checkKeyForFloat(this.value,event)" />&nbsp;-&nbsp;
      <input name="eprice" id="eprice" <s:if test="eprice!=0"> value="${eprice }"</s:if> type="text" class="text3" onkeydown="checkKeyForFloat(this.value,event)" />&nbsp;<span onclick="submit()">确定</span></a>
      </li>
      <li class="jj3" style="border-left:1px solid #C1C1C1;"><a style="padding-left:10px;" href="javascript:void(0)" id="perNative"><label id="_city_val" title="${place}" class="comment_title">请选择</label><span id="event" style="color:#09F;">【修改所在地】</span></a></li>
      <li class="jj3" style="border-right:0px solid #C1C1C1;">&nbsp;&nbsp;性别&nbsp;<select name="sex" id="sex" onChange="submitSearchFrom(1,this.value)"><option value="0">不限</option><option value="1">男</option><option value="2">女</option></select>&nbsp;&nbsp;</li>
      </form>
  </ul>
   
  <div class="ejy-rp3">
      <p><img src="<%=path%>/theme/images2/tu49.jpg" width="749" height="6" /></p>
      <div class="ejy-rp4">
<table width="100%" border="0" >
  <tr class="ejy-rp5">
    <th width="284" scope="col">会员信息</th>
    <th width="110" scope="col">能力测评</th>
    <th width="130" scope="col">价格</th>
    <th width="99" scope="col">所在地</th>
    <th width="102" scope="col">成交</th>
  </tr>
<s:iterator value="#request.yrInfoList" var="item" >
  <tr class="ejy-rp6" valign="middle">
    <td>
      <dl class="ejy-dl">
      	<s:if test="#item[0].isOrg==1">
				<dt>&nbsp;<a href="<%=request.getContextPath() %>/orgListAction.htm?id=<s:property value="#item[0].id" />" target="_blank"><img style="padding:2px; border:solid 1px #e3e3e3;" onerror="handleImgLoadError(event);" src="/stageUpload/headImage/<s:property value="#item[0].id" />.png" title="<s:property value="#item[1].introduction" />" width="110" height="100" /></a></dt>
				 <dd style="margin-top:30px;"><a href="<%=request.getContextPath() %>/orgListAction.htm?id=<s:property value="#item[0].id" />" target="_blank">
						 <s:if test="#item[1].nickName.length() > 10">
							<s:property value="#item[1].nickName.substring(0,10)" />...
						</s:if>
						<s:else>
							<s:property value="#item[1].nickName" />
						</s:else>
				 </a></dd>
      	</s:if> 
      	<s:else>
			<dt>&nbsp;<a href="<%=request.getContextPath() %>/presonList.htm?id=<s:property value="#item[0].id" />" target="_blank"><img style="padding:2px; border:solid 1px #e3e3e3;" onerror="handleImgLoadError(event);" src="/stageUpload/headImage/<s:property value="#item[0].id" />.png" title="<s:property value="#item[1].introduction" />" width="110" height="100" /></a></dt>
			 <dd style="margin-top:30px;"><a href="<%=request.getContextPath() %>/presonList.htm?id=<s:property value="#item[0].id" />" target="_blank">
						 <s:if test="#item[1].nickName.length() > 10">
							<s:property value="#item[1].nickName.substring(0,10)" />...
						</s:if>
						<s:else>
							<s:property value="#item[1].nickName" />
						</s:else>
				</a></dd>
          </s:else>

          <dd>人气：<s:property value="#item[1].popularityTotal" /></dd>
         <s:if test="#item[0].rzState==3">
			<img src="<%=request.getContextPath() %>/theme/images/rz_01.jpg" width="28" height="20" />
		</s:if>
      </dl>
    </td>
    <td align="center">LV<s:property value="#item[1].grade" /></td>
    <td align="center" style="color:#ef3b3a">
    	<s:if test="#item[2].isConsult==1">面议</s:if>
    	<s:else><s:property value="#item[2].bprice" /> 
		(元/<s:property value="#item[2].unit" />)</s:else>
    </td>
    <td align="center"><s:property value="#item[1].provice" /><s:property value="#item[1].city" /></td>
    <td align="center">最近成交0次<br/><a href="#" style="color:#09F;display: none;">100条点评</a></td>
  </tr>

</s:iterator>
</table>

      </div>
      <p><img src="<%=path%>/theme/images2/tu50.jpg" width="749" height="6" /></p>
  </div>
  <table width="100%" border="0">
  <tr>
    <td align="right">
    <table width="100%" border="0">
      <tr>
        <td height="20" colspan="3" align="right" valign="middle"></td>
        </tr>
      <tr>
        <td width="77%" align="right" valign="middle"></td>
        <td width="15%" align="right" valign="middle">
        <div class="ejy-fy">
         <pg:pages  pageNo='${pageNum}' rowCount ="10"  url="queryAction!toQuery.htm" params="signSub=${signSub}&placeF=1&city_id=${placeId}&sort=${sort}&sign=${sign}&filterValue=${filterValue}&eprice=${eprice }&bprice=${bprice }&pageHeadKeywords=${pageHeadKeywords}&keyType=${keyType}&orderBySign=${orderBySign }&orderByDesc=${orderByDesc }&sex=${sex}"  total='${game}' ></pg:pages>
        </div>
        
        </td>
        <td width="8%" align="right" valign="middle"></td>
        
      </tr>
    </table>

    </td>
  </tr>
</table>
</div>
</div>
</div>
<!-- 主内容结束 -->

<!-- 我是广告位 -->
<div class="gg">我是广告位</div>


<!-- 底部开始 -->
<jsp:include page="/WEB-INF/page/public/bottom2.jsp"></jsp:include>
<!-- 底部结束 --> 
  
  </body>
</html>
