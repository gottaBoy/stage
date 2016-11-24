$(function(){
	$("#options").hover(function(){
		$("#options dd").show();
	}, function() {
		$("#options dd").hide();
	});
	
	$("#options").hover(function(){
		$(this).find("dl dt b").addClass("on")
	},function(){
		$(this).find("dl dt b").removeClass("on")
	});
	
	$("#keyType").val(this.id);
	
	$("#options div").click(function(){
		$("#text").attr("value",$(this).html());
		$("#keyType").val(this.id);
		$("#text").attr("value",$(this).html());
		$("#options dd").hide();
	});
	
	//keywords text
	var keyword = "请输入关键词";
    $(".birds").val(keyword).bind("focus",function(){
		if(this.value == keyword){
			this.value = "";
			this.className = "focus_text"
		}
	}).bind("blur",function(){
		if(this.value == ""){
			this.value = keyword;
			this.className = "blur_text"
		}
	});
	
});