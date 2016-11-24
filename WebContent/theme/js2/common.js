 	//弹出登录框或者注册框 flag=1时 弹出登录框 flag=2时注册框
 	function showPop(flag,url){
 		//$(document).scrollTop(0);
		if(url.indexOf("?")>0)
	 		window.location.href =url+"&flag="+flag;
		else
 			window.location.href =url+"?flag="+flag;
 	}
 	//弹窗式登陆框
 	function showPop1(flag,url){
 		//$(document).scrollTop(0);
 		var width = document.documentElement.clientWidth;//浏览器可用区域的宽度
 		var height = document.documentElement.clientHeight;//浏览器可用区域的高度
 		
 		if(flag == 1) {
 			document.getElementById('light').style.top=(height-350)/2+$(window).scrollTop() + "px";
 		} else if(flag == 2) {
 			document.getElementById('light').style.top=(height-500)/2+$(window).scrollTop() + "px";
 		}
 		document.getElementById('light').style.left=(width-630)/2 + "px";
 		document.getElementById('light').style.display='block';
 		document.getElementById('fade').style.display='block';
 		common.get("top-pop").src = url;
 	}
 	$(window).resize(function() { 
 		var width = document.documentElement.clientWidth;//浏览器可用区域的宽度
 		var height = document.documentElement.clientHeight;//浏览器可用区域的高度
 		try{
 			document.getElementById('light').style.left=(width-630)/2 + "px";
 			document.getElementById('light').style.top=(height-500)/2+$(window).scrollTop() + "px";
 		} catch(e){}
 	});
 	//取消登录框或者注册框
 	function hide(obj){
// 		var doc = document.getElementById("top-pop").contentWindow.document;
 		var doc = $(window.frames["top-pop"].document).contents();
 		for(var i=0;i<2;i++){
 			doc.find("box").find("li eq("+i+")").unbind("mouseover");
 		}
 		document.getElementById('light').style.display='none';
 		document.getElementById('fade').style.display='none';
 	}
 	var common = {
 		get : function(id){
 			return document.getElementById(id);
 		}
 	};