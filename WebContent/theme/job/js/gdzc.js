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

$(function(){
		$("#tcc").mouseover(function(){
			$("#open").fadeIn();
		}).mouseout(function(){
			$("#open").fadeOut();	
		})
	})