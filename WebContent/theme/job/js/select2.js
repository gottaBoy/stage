$(function(){
	$("#options2").hover(function(){
		$("#options2 dd").slideDown(200)
	}, function() {
		$("#options2 dd").slideUp(200);
	});
	
	$("#options2").hover(function(){
		$(this).find("dl dt b").addClass("on")
	},function(){
		$(this).find("dl dt b").removeClass("on")
	});
	
	$("#keyType2").val(this.id);
	
	$("#options2 span").click(function(){
		$("#text2").attr("value",$(this).html());
		$("#keyType2").val(this.id);
		$("#text2").attr("value",$(this).html());
		$("#options2 dd").hide();
	});
	
	//keywords text
	var keyword = "请输入关键词";
    $(".birds2").val(keyword).bind("focus",function(){
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