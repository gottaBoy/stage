window.onerror = function()
{
return true;//不显示脚本错误信息
}

//选项卡模块
$(function(){
		$(".tab1Content:first").show();
		$(".title1 ul li").each(function(index){
		$(this).click(
			function(){
				$(".title1 ul li.on").removeClass("on");
				$(this).addClass("on");
				$(".tab1Content:visible").hide();
				$(".tab1Content:eq(" + index + ")").fadeIn();
				})
		})
})

//账户滑动模块
		$(function(){
			// Set starting slide to 1
			var startSlide = 1;
			// Get slide number if it exists
			if (window.location.hash) {
				startSlide = window.location.hash.replace('#','');
			}
			// Initialize Slides
			$('#slides').slides({
				preload: true,
				preloadImage: 'img/loading.gif',
				generatePagination: true,
				play: 5000,
				pause: 2500,
				hoverPause: true,
				// Get the starting slide
				//start: startSlide,
				animationComplete: function(current){
					// Set the slide number as a hash
					window.location.hash = '#' + current;
				}
			});
		});

//推荐选项卡模块
$(function(){
		//$(".tab2Content:first").show();
		$(".title2 ul li").each(function(index){
		$(this).click(
			function(){
				$(".title2 ul li.on").removeClass("on");
				$(this).addClass("on");
				$(".tab2Content:visible").hide();
				$(".tab2Content:eq(" + index + ")").fadeIn();
				})
		})
})

//去掉链接和按钮等的虚线框
$(function(){
$("a").focus( function() { this.blur(); } );
("input").focus( function() { this.blur(); } );
})