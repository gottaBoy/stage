$(function(){
		
		
		$("#tcc").mouseover(function(){
			$("#open").fadeIn();
		}).mouseout(function(){
			$("#open").fadeOut();	
		})
		
		
		
		//所在地
		$(".Type_c_More").toggle(function(){
	 		  $(".Type_c_r").removeClass("Type_c_r_height");
			  $(".Type_c_More").html("收起∧")
 		},function(){
			  $(".Type_c_r").addClass("Type_c_r_height");
	 		  $(".Type_c_More").html("更多∨")
 		})
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
