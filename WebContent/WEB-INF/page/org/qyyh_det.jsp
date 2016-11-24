<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@page import="com.smt.entity.TAppFriendInfo"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="pg" uri="/page-tags"%>  
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragrma","no-cache");
response.setDateHeader("Expires",0);
%>
 <%
UserSession userSession = HttpSessionHelper.getUserSession(request) ;
TAppFriendInfo friendInfo = (TAppFriendInfo)request.getAttribute("friendInfo");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    
    <title><%=StageVariale.title%></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/global_layout.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/layout.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<link href="<%=request.getContextPath() %>/theme/css/page.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/address.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/swfobject.js"></script>
	
	<script language="javascript" type="text/javascript">
		$().ready(function(){
			<s:if test="#request.sign==1">window.location.hash = "#top";</s:if>
			var sex = $("#sexSelect").val()==""?"sex0":$("#sexSelect").val();
			var pro = $("#proSelect").val()==""?"pro0":$("#proSelect").val();
			var pri = $("#priSelect").val()==""?"pri0":$("#priSelect").val();
			$("#"+sex).addClass("change");
			$("#"+pro).addClass("change");
			$("#"+pri).addClass("change");
		});
		function onClickSelect(id){
			var sign = id.substring(0,3);
			$(".change."+sign).removeClass("change");
			$("#"+id).addClass("change");
			$("#"+sign+"Select").val(id);
			var sex = $("#sexSelect").val()==""?"sex0":$("#sexSelect").val();
			var pro = $("#proSelect").val()==""?"pro0":$("#proSelect").val();
			var pri = $("#priSelect").val()==""?"pri0":$("#priSelect").val();
			window.location.href='orgListAction.htm?sign=1&&id=<s:property value="#request.id"/>&&sex='+sex+'&&pro='+pro+'&&pri='+pri;
		}
		
		 function addFriend(friendId){
			$.post('<%=request.getContextPath()%>/friend!addFriend.htm',{friendId:friendId},function(data){
			  if(data==1){
			  
			   		location.reload() ;
			  }else if(data == 2){
			      art.dialog.tips('不能关注自己');
			  }
			},"html");
		 }
		 
		 function sendMessage(){
 			art.dialog.open('<%=request.getContextPath()%>/messageSend!send.htm?id=<s:property value="#request.userInfo.userId"/>',{width:550,height:300,resize: false});
	 	 }
	 	 
	 	 function qianYueTa(userId){
     	<%if(userSession==null){%>
  	    openWindowLogin();
  	    <%  }else{  int loginUserId=userSession.getId();%>
  	    var bqyUserId=userId;
  	    if(bqyUserId==<%=loginUserId %>){
  	    	art.dialog.tips("不能签约自己！");
  	    }else{
		art.dialog.open('<%=request.getContextPath() %>/member/business!toOrder.htm?bqyUserId='+userId,{width:680,height:455,resize: false});
		 }
		  <%  }%>
     }
     
     //打开登录窗口
		function openWindowLogin(){
         	art.dialog.open('<%=request.getContextPath() %>/windowLogin.html',{width:400,height:310,resize: false});
         }
	</script>
  </head>
  <body>
 
  <input id="sexSelect" type="hidden" value="${sex}"/>
  <input id="proSelect" type="hidden" value="${pro}"/>
  <input id="priSelect" type="hidden" value="${pri}"/>
  <jsp:include page="../public/head2.jsp">
  <jsp:param value="no" name="titleType"/>
  </jsp:include>
  <!-- 主内容开始 -->

<!-- 会员 相册 视频 音频 上 信息 开始 -->
<div id="member_introduces_top_box">
<div class="member_left_box_qyxq">
<dl>
<dt><img src="/stageUpload/headImage/<s:property value="#request.user.id"/>.png" width="110" height="100" /></dt>
<dd><span class="member_title_bold"><s:property value="#request.userInfo.nickName"/></span><span class="member_lv">LV：<img src="<%=request.getContextPath() %>/theme/images/xingxing_det.jpg" width="10" height="10" /><img src="<%=request.getContextPath() %>/theme/images/xingxing_det.jpg" width="10" height="10" /><img src="<%=request.getContextPath() %>/theme/images/xingxing_det.jpg" width="10" height="10" /></span>
<%if(userSession == null){ %>
<a href="javascript:openWindowLogin();" class="jiaguanzhu_link_qyxq">+加关注：
<%} else {
	if(friendInfo == null){%>
	<a href="javascript:addFriend(<s:property value="#request.id"/>);" class="jiaguanzhu_link_qyxq">+加关注：
	<%}else{%>
    <a href="#" class="jiaguanzhu_link_qyxq">已关注：

<%}} %>
<span class="gz_sl">（<s:property value="#request.friendSum"/>）</span></a>
</dd>

<dd><s:property value="#request.userInfo.provice"/>&nbsp;<span class="shu_line">|</span>&nbsp;<s:property value="#request.userInfo.city"/>&nbsp;<span class="shu_line">|</span>&nbsp;&nbsp;已签约：<span class="member_det_no"><s:property value="#request.qySum"/> </span> 次 &nbsp;&nbsp;
</dd> 
<dd style="line-height:20px; height:76px; overflow:hidden;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<s:if test="#request.userInfo.introduction.length()>=155">
<s:property value='#request.userInfo.introduction.substring(0,155)'/><b>...</b><a href="#" style="color:red" title="<s:property value="#request.userInfo.introduction"/>">详细</a></s:if>     
<s:else><s:property value="#request.userInfo.introduction"/></s:else>
</dd>
</dl>
</div>

<div class="member_center_box_qyxq">
<ul>
<li>
<%if(userSession == null){ %>
<a href="javascript:openWindowLogin();"><img src="<%=request.getContextPath() %>/theme/images/lx_ta.jpg" width="118" height="91" /></a>
<%} else{%>
<a href="javascript:sendMessage();"><img src="<%=request.getContextPath() %>/theme/images/lx_ta.jpg" width="118" height="91" /></a>
<%}%>

</li>
<li></li>
</ul>
</div>


<div class="member_right_box">
<ul>
<li>旗下艺人</li>
<li><span><s:property value="#request.yrSun"/></span></li>
</ul>
</div>

</div><!-- 会员 相册 视频 音频 上 信息 结束 -->

<div style=" width:980px; margin:0px auto">

<table width="980" border="0" align="center" cellpadding="0" cellspacing="0" style=" margin:6px auto;">
    <tr>
        <td width="298" valign="middle" bgcolor="#800000" style="vertical-align:top"><table width="293" border="0" cellspacing="0" cellpadding="0" style="margin-top:4px;">
            <tr>
                <td width="45" height="186"><img src="<%=request.getContextPath() %>/theme/images/qyxq_xingji.jpg" width="42" height="186" /></td>
                <td width="258" height="190" align="center" valign="top" bgcolor="#FFFFFF"><img src="<%=request.getContextPath() %>/theme/images/qyxq_xingji_img.jpg" width="240" height="180" style="margin:3px;" /></td>
            </tr>
        </table></td>
        <td height="198">&nbsp;</td>
        <td width="675" align="left" valign="top" bgcolor="#F0F0F0" style=" vertical-align:top"><table width="660" border="0" align="center" cellpadding="0" cellspacing="0" class="qyxq_xingji">
            <tr>
                <td colspan="4" style="line-height:26px; height:26px;" class="qyxq_line_bor zxqy_text">最新签约</td>
            </tr>
            <s:iterator value="#request.zxqy" var="item">
            <tr>
                <td width="260" align="left" class="qyxq_line_bor">                <div class="fuck_photo_img"><dl>
                <dt><a href="presonList.htm?id=<s:property value="#item[0].id"/>" target="_blank"><img src="/stageUpload/headImage/<s:property value="#item[0].id" />.png" width="38" height="38" /></a></dt>
                <dd class="zxqy_text"><s:property value="#item[3].nickName" /></dd>
                <dd><span class="qytx_conbox_title">能力：</span><s:property value="#item[1].profession" /></dd>
                 </dl></div></td>
                <td width="104" align="center" valign="middle" class="qyxq_line_bor czjz_text"> LV</td>
                <td width="196" align="center" class="qyxq_line_bor czjz_text"><s:property value="#item[1].bprice" />-<s:property value="#item[1].eprice" /></td>
                <td width="100" align="center" class="qyxq_line_bor czjz_text"><s:property value="#item[3].provice" /> <s:property value="#item[3].city" /></td>
            </tr>
			</s:iterator>

        </table></td>
    </tr>
</table>

</div>


<!-- 最活跃艺人 开始 -->
<div class="xrjr_box">
<h2>
<span class="home_title_fh">最活跃艺人</span></h2>
<ul>
<s:iterator value="#request.zhy" var="item">
<li>
<div class="img_box">

<ul>
<li>
<a href="presonList.htm?id=<s:property value="#item[0]"/>" target="_blank"><img src="/stageUpload/indexHeadImage/<s:property value="#item[3]"/>.png" width="240" height="175" /></a>
<p><span class="qycs_qyxq">签约次数：<span class="user_ok02" ><s:property value="#item[1]"/>次</span></span>&nbsp; </p>
<p><span class="qycs_qyxq">签约收入：<span class="user_ok02">&yen;<s:property value="#item[2]" />元</span></span></p>
</li>

</ul>

</div>
</li>
</s:iterator>
</ul></div>
<a name="top"></a>
<div class="tjss_search"><h2>
<span class="home_title_fh_02">预约艺人</span></h2>

<table width="940" border="0" align="center" cellpadding="0" cellspacing="0" class="yyyr_box">
    <tr>
        <td width="48" align="right" class="yyyr_box_title">性别：</td>
        <td width="60" align="center"><a id="sex0" class="sex" href="javascript:onClickSelect('sex0')">不限</a></td>
        <td width="60" align="center"><a id="sex1" class="sex" href="javascript:onClickSelect('sex1')">男</a></td>
        <td width="60" align="center"><a id="sex2" class="sex" href="javascript:onClickSelect('sex2')">女</a></td>
        <td width="80" align="center">&nbsp;</td>
        <td width="80" align="center">&nbsp;</td>
        <td width="80" align="center">&nbsp;</td>
        <td width="80" align="center">&nbsp;</td>
        <td width="80" align="center">&nbsp;</td>
        <td width="324" align="center">&nbsp;</td>
    </tr>
    <tr>
        <td align="right" class="yyyr_box_title">职业：</td>
        <td align="center"><a id="pro0" class="pro" href="javascript:onClickSelect('pro0')">不限</a></td>
        <td align="center"><a id="pro1" class="pro" href="javascript:onClickSelect('pro1')">演员</a></td>
        <td align="center"><a id="pro2" class="pro" href="javascript:onClickSelect('pro2')">音乐</a></td>
        <td align="center"><a id="pro3" class="pro" href="javascript:onClickSelect('pro3')">舞蹈 </a></td>
        <td align="center"><a id="pro4" class="pro" href="javascript:onClickSelect('pro4')">模特</a></td>
        <td align="center"><a id="pro5" class="pro" href="javascript:onClickSelect('pro5')">达人</a></td>
        <td align="center"><a id="pro6" class="pro" href="javascript:onClickSelect('pro6')">幕后</a></td>
        <td align="center"><a id="pro7" class="pro" href="javascript:onClickSelect('pro7')">其他</a></td>
        <td align="center">&nbsp;</td>
    </tr>
    <tr>
        <td align="right" class="yyyr_box_title">价格：</td>
        <td align="center"><a id="pri0" class="pri" href="javascript:onClickSelect('pri0')">不限</a></td>
        <td align="center"><a id="pri1" class="pri" href="javascript:onClickSelect('pri1')">0-500</a></td>
        <td align="center"><a id="pri2" class="pri" href="javascript:onClickSelect('pri2')">500-2000</a></td>
        <td align="center"><a id="pri3" class="pri" href="javascript:onClickSelect('pri3')">2000-5000</a></td>
        <td align="center"><a id="pri4" class="pri" href="javascript:onClickSelect('pri4')">5000-10000</a></td>
        <td align="center"><a id="pri5" class="pri" href="javascript:onClickSelect('pri5')">10000-20000</a></td>
        <td align="center"><a id="pri6" class="pri" href="javascript:onClickSelect('pri6')">20000以上</a></td>
        <td align="center">&nbsp;</td>
        <td align="center">&nbsp;</td>
    </tr>
</table>
</div>
<div class="xrjr_box2">
<ul>
<s:if test="#request.yrxxs.size()==0">
<li style="height: 20px;"><font style="color:red ;font-size:14px; font-weight:bold;">没有要显示的结果！</font></li>
</s:if>
<s:iterator value="#request.yrxxs" var="item">
<li>
<div class="img_box">
<ul>
<li><a href="presonList.htm?id=<s:property value="#item[1].userId"/>" target="_blank"><img src="/stageUpload/indexHeadImage/<s:property value="#item[1].userId"/>.png" width="240" height="175" /></a>
<p><span class="user_zy">职业：<s:property value="#item[1].profession"/></span><span class="img_username"><a href="presonList.htm?id=<s:property value="#item[1].userId"/>" target="_blank"><s:property value="#item[1].nickName"/></a></span>&nbsp;<span class="user_ok "><s:if test="#item[1].rzState==3">（已认证）</s:if></span>  </p>
<p><span class="user_yy"><a href="javascript:qianYueTa(<s:property value="#item[1].userId"/>)">预约</a></span>人气：<s:property value="#item[1].popularityTotal"/>次</p>
</li>
</ul>
</div>
</li>
</s:iterator>
</ul></div>
<div style="margin-right: 150px;">
<pg:pages  pageNo='${pageNum}' rowCount ="16"  url="orgListAction.htm" params='id=${id}&&sex=${sex}&&pro=${pro}&&pri=${pri}'  total='${total}' ></pg:pages>
</div>
<div class="clear"></div>


<div class="clear"></div>





<!-- 主内容结束 -->
<jsp:include page="../public/bottom2.jsp"></jsp:include>
  </body>
</html>
