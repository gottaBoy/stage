window.onerror = function()
{
return true;//不显示脚本错误信息
}


//调出遮罩层和弹出框
$(function(){
	$("a.zhezhaoLink").click(function(){
		$(".zhezhao").show();
		$(".mask").show();
		})
	})



	
//iframe高度自动适应
function reinitIframe(){
var mainiframe = document.getElementById("mainiframe");
var zhezhaoiframe = document.getElementById("zhezhaoiframe");
try{
		zhezhaoiframe.height =  zhezhaoiframe.contentWindow.document.body.scrollHeight;
		mainiframe.height =  mainiframe.contentWindow.document.body.scrollHeight;
}catch (ex){}
}
//window.setInterval("reinitIframe()",200);
window.setInterval("mainiframe()",200);




//快捷菜单
$(function(){
	$(".quickMenu").click(function(){
		$(this).hide();
		$(".quickMenuOpen").show()
		})
	$(".quickMenuBottom span").click(function(){
		$(".quickMenuOpen").hide();
		$(".quickMenu").show()
		})	
		
		
	})