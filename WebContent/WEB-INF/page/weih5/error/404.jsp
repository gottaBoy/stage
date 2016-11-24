<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>
<html>
<head> 
	<meta name="viewport" content="width=device-width; initial-scale=1.0,user-scalable=no,maximum-scale=1.0,minimun-scale=1.0">
    <meta charset="utf-8">
<!--     <link rel="stylesheet" href="css/common.css"> -->
    <link type="text/css" rel="stylesheet" href="<%=request.getContextPath() %>/h5assets/css/common.css" />
    <title>找不到:(</title>
</head>

<body>
	<div class="nfound">
		<div class="nfound-txt">
			<p class="nf-fs1">Sorry!</p>
			<p class="nf-sorry">抱歉，你访问的页面不存在或者已删除！</p>
			<p>请检查输入的网址是否正确。</p>
<!-- 			<p>或者联系第一舞台客服：400-888-8888</p> -->
		</div>
		<div class="nfound-img">
			<!-- <img src="images/notfoundimg.png" alt="你访问的页面不存在"> -->
			<!-- <img src="/stage01/h5assets/images/notfoundimg.png" alt="你访问的页面不存在"> -->
			<img src="/h5assets/images/notfoundimg.png" alt="你访问的页面不存在">
		</div>
	</div>
</body>
</html>    