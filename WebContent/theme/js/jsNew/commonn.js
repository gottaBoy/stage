window.onerror = function()
{
return true;//不显示脚本错误信息
}
$(function(){
	$("input.sear").click(function(){
		$(".result").show();
		})
	})
	
function iFrameHeight() { 
var ifm= window.parent.document.getElementById("iframepage"); 
var subWeb = window.parent.document.frames ? document.frames["iframepage"].document : ifm.contentDocument; 
if(ifm != null && subWeb != null) { 
ifm.height = subWeb.body.scrollHeight; 

$(".contentLeft").height(subWeb.body.scrollHeight + 20);
if (($.browser.msie) && ($.browser.version == "6.0")){
$(".contentLeft").height(subWeb.body.scrollHeight + 4);
}
//if ( subWeb.body.scrollHeight < 400){
	//ifm.height = 450;
    //$(".contentLeft").height(470);
	//}
} 
} 

//隔行变色加选中变色
$(document).ready(function(){
        $(".tab2 tr:odd").addClass("odd");     //奇数行设定为 "odd" 样式
        $(".tab2 tr:even").addClass("even");   //偶数行设定为 "even" 样式
        $(".tab2 tr").mouseover(function(){$(this).addClass("over");})     //当 mouseover 时加入 "over" 样式
                          .mouseout(function(){$(this).removeClass("over");})   //当 mouseout 时移除 "over" 样式
                        .click(function(){$(this).toggleClass("tr_chouse");}) //当 click 加入或移除 "tr_chouse" 样式，实现数据列选取
     });
 
 $(document).ready(function(){
        $(".tab3 tr:odd").addClass("odd");     //奇数行设定为 "odd" 样式
        $(".tab3 tr:even").addClass("even");   //偶数行设定为 "even" 样式
        $(".tab3 tr").mouseover(function(){$(this).addClass("over");})     //当 mouseover 时加入 "over" 样式
                          .mouseout(function(){$(this).removeClass("over");})   //当 mouseout 时移除 "over" 样式
                        .click(function(){$(this).toggleClass("tr_chouse");}) //当 click 加入或移除 "tr_chouse" 样式，实现数据列选取
     });
 
 
 //关闭遮罩层和弹出框
$(function(){
	$(".zhezhao span.zhezhaoClose").click(function(){
		window.parent.$(".zhezhao").hide();
		window.parent.$(".mask").hide();
		window.parent.$("#mainiframe").contents().find("select").show();
		})
	$("input.zhezhaoSave").click(function(){
		window.parent.$(".zhezhao").hide();
		window.parent.$(".mask").hide();
		window.parent.$("#mainiframe").contents().find("select").show();
		})
	})
	
	
//调出遮罩层和弹出框
$(function(){
	$("input.zhezhaoBtLink").click(function(){
		window.parent.$(".zhezhao").show();
		window.parent.$(".mask").show();
		window.parent.$("#mainiframe").contents().find("select").hide();
		})
	})

//去掉链接和按钮等的虚线框
$(function(){
$("a").focus( function() { this.blur(); } );
("input").focus( function() { this.blur(); } );
})