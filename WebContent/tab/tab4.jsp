<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="pg" uri="/page-tags"%>  
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>tab切换</title>
<SCRIPT type=text/javascript src="<%=request.getContextPath() %>/theme/js2/jquery-1.7.1.min.js"></SCRIPT>
<style type="text/css">
body{margin:0;padding:0;font-size:12px;font-family: "微软雅黑",Arial;}
ul{padding:0; margin:0; list-style:none; }
a{color:#000; text-decoration:none;}
form,ul,li,dl,dd,p,dt,img{margin:0;padding:0;}

img,input{border:0;}
.bj{width:1003px;height:412px; background:#f4f4f4;}
.l{float:left}
.left{width:745px; height:410px;background:#FFF;}
.right{height:410px;width:241px;border:1px solid #CCC; margin-left:15px; background:#FFF;}
.top-1 {
	padding-left:10px;
	padding-right:10px;
	padding-top:10px;
}
.top-2 {
	padding-left:10px;
	padding-top:10px;
	height:60px;
}

.top-2 div {
	
}

#box{width:743px;height:38px;border:1px solid #9b9b9b;margin-bottom:5px;}
.pp{width:137px;height:55px;color:#fff;text-align:center;font-size:14px;font-weight:bold;line-height:40px;position: absolute;top:0px;left:0px;}
.pp2{position: relative;margin-left:137px}
#box li{float:left;margin-left:5px;margin-top:5px}
#box li a{display:block;line-height:27px;text-align:center;color:#a1a1a1;font-weight:bold;padding:0 15px}
#box .cc a{color:#fff;background:#f86a00 ;font-size:14px;}

.con{width:743px;height:365px;border:1px solid #ccc;background:#fff}
.left1{width:185px;border-right:1px solid #CCC;height:345px;background:#f4f4f4;padding:10px 10px;}


.left2 li.left-ll{font-weight:bold;font-size:20px;line-height:40px;color:#000}
.left2 li.left-ll2{color:#000}
.left2 li{line-height:25px;color:#666}

.left3{height:345px;width:505px;padding:10px 10px;}
.left3-dd dt {width:236px;height:310px;border:1px solid #c3c3c3;padding:5px 5px;}
.left3-dd dt:hover{width:236px;height:310px;padding:5px 5px;cursor: pointer;}
.left3-dd dd{text-align:center;line-height:22px;}
.left3-dd2{margin-left:8px}
</style>
</head>

<body>

<div class="bj">
  <div class="l left">
  
  <div id="box">
  <p class="pp l" style="background: url('<%=request.getContextPath() %>/theme/images2/sss.png') no-repeat;">TOP排行榜</p>
  <ul class="l" style="margin-left:137px;">
    <s:iterator value="#request.list" var="item" status="st">
    <s:if test="#st.index==0">
        <li id="liName<s:property value='#st.index' />" class="cc" style="margin-left: 250px;"><a href="javascript:void(0)"><s:property value="#item.name"/></a></li>
    </s:if>
       <s:else>
        <li id="liName<s:property value='#st.index' />" style="display:none;margin-left: 250px;" class="cc" ><a href="javascript:void(0)"><s:property value="#item.name"/></a></li>
       </s:else>
    </s:iterator>
     
  </ul>
  </div>
  
  <s:iterator value="#request.list" var="item" status="st">
    <div class="con" id="con<s:property value="#st.index" />">
     <div class="left1 l">
        <ul class="left2">
          <li class="left-ll"><s:property value="#item.userid.nickName"/></li>
          <li>工作地点:&nbsp <s:property value="#item.userid.provice"/>&nbsp;-&nbsp; <s:property value="#item.userid.city"/></li>
          <li>等级:&nbsp</li>
          <li>第一职业:&nbsp;<s:property value="#request.costList[#st.index][0][1].typeName" /></li>
          <li>第二职业:&nbsp;<s:property value="#request.costList[#st.index][1][1].typeName" /></li>
          <li class="left-ll2">小编点评：</li>
          <li><s:property value="#item.comment"/></li>
        </ul>
     </div>
    
     <div class="left3 l">
     <s:set var="sn" value="0"></s:set>  
      <s:iterator value="#request.imgs" var="img" status="st">
      <s:if test="#item.tid==#img.tpid.tid">
          <s:set var="sn" value="#sn + 1"></s:set>  
          <s:if test="#sn == 1">
            <dl class="left3-dd l">
          </s:if>
          <s:else>
          <dl class="left3-dd left3-dd2 l">
          </s:else>
           <dt><a href="javascript:parent.openPerson(<s:property value="#item.userid.userId"/>)"><img src="<%=request.getContextPath() %>/<s:property value="#img.turl"/>" width="236" height="312" /></a></dt>
           <dd><s:property value="#img.tmemo"/></dd>
          </dl>
        </s:if>
        </s:iterator>
     </div>
    </div>
  </s:iterator>
  
  
  
  
  </div>
  <div class="l right">
    <s:iterator value="#request.list" var="item" status="st">
    <div class="rightDiv" onmouseover="showContent(<s:property value='#st.index'/>)" >
      <div class="l top-1">
        <a href="<%=request.getContextPath() %>/presonList.htm?id=<s:property value='#item.userid.userId'/>" target="_blank">
          <img height="60" width="60" src="/stageUpload/headImage/<s:property value='#item.userid.userId'/>.png" onerror="javascript:this.src='<%=request.getContextPath() %>/theme/images/no_img.jpg'" />
        </a>
      </div>
      <div class="top-2">
        <div style="color:#000;"><s:property value="#item.userid.nickName.length()>10?#item.userid.nickName.substring(0,10)+'...':#item.userid.nickName"/></div>
        <div>职业：<s:property value="#request.costList[#st.index][0][1].typeName" />
        </div>
        <div>人气：<s:property value="#item[0].popularityTotal" /></div>
      </div>
      <div style="border-bottom:dotted 1px #ccc; height:5px; margin:5px;"></div>
      </div>
      </s:iterator>
  </div>
</div>














<script language="javascript">

function showContent(value) {
	$(".con").css("display", "none");
	$("#con" + value).css("display", "block");
	$(".cc").css("display", "none");
	$("#liName" + value).css("display", "block");
}

</script>
</div>
</body>
</html>
