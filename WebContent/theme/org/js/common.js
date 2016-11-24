$(function(){
	    //幻灯片
		$("#slideshow").slideshow();
		({
		pauseSeconds: 4,
		height: 200,
		caption: false
		});	
		
		
		$("#tcc").mouseover(function(){
			$("#open").fadeIn();
		}).mouseout(function(){
			$("#open").fadeOut();	
		})
		
		//商品分类
		$('.Cnav .item').hover(function(){
			$(this).addClass('active').find('.product span').attr("class","product_Arrow2");
			$(this).find('.product_wrap').show();
		},function(){
			$(this).removeClass('active').find('.product span').attr("class","product_Arrow")
			$(this).find('.product_wrap').hide();
		});
})

/*固定左侧*/
$(window).scroll(function(){
    var h_num=$(window).scrollTop();
	  if(h_num>449){
	  $('#nav').addClass('fixer');
	  $("#gyta").css("display","block");
	  }else{
	  $('#nav').removeClass('fixer');
	  $("#gyta").css("display","none");
	  }
});

/*TAB切换*/
function setTab(name,cursel,n){
 for(i=1;i<=n;i++){
  var menu=document.getElementById(name+i);
  var con=document.getElementById("con_"+name+"_"+i);
  var c="rw_t_li"+i+" on";
  menu.className=i==cursel?c:"rw_t_li"+i;
  con.style.display=i==cursel?"block":"none";
 }
}

function set(name,cursel,n){
 for(i=1;i<=n;i++){
  var menu=document.getElementById(name+i);
  var con=document.getElementById("con_"+name+"_"+i);
  menu.className=i==cursel?"on":"";
  con.style.display=i==cursel?"block":"none";
 }
}
