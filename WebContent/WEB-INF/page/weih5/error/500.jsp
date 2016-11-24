<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>
<html>
<head> 
	<meta name="viewport" content="width=device-width; initial-scale=1.0,user-scalable=no,maximum-scale=1.0,minimun-scale=1.0">
    <meta charset="utf-8">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/common.css">
    <title>出错啦:(</title>
</head>

<body>
	<div class="nfound">
		<div class="nfound-txt">
			<p class="nf-fs1">Sorry!</p>
			<p class="nf-sorry">抱歉，出错了:(</p>
			<s:if test="#request.errormsg == null || #request.errormsg ==''">
				<p>请检查输入的网址是否正确，或稍候再试。</p>
			</s:if>
			<s:else>
				<p><s:property value="#request.errormsg"/></p>
			</s:else>
<!-- 			<p>或者联系第一舞台客服：400-888-8888</p> -->
		</div>
		<div class="nfound-img">
<!-- 			<img src="images/notfoundimg.png" alt="你访问的页面不存在"> -->
			<!-- <img src="/stage01/h5assets/images/notfoundimg.png" alt="你访问的页面不存在"> -->
			<img src="/h5assets/images/notfoundimg.png" alt="你访问的页面不存在">
		</div>
	</div>
</body>
</html>    