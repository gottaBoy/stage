function sc(id,id2,id3){
	var result = "";

	$(id).localResizeIMG({
	//width: 600,
		quality: 0.8,
		maxsize: 5000000, //5M
		init: function() {
		  popupDiv("pop_div");
		},

		before: function(that, blob) {
		  $(id2).attr("src", blob).show();
		  if (blob) {
		    $(id3).css("color", "#5A7505").html("").show();
		    //$(".fileinput-button").find("span").html("重新选择文件")
		    console.log(g); // 文件名称
		    $(id).data("imagename",g);
		  } else {
		    $(id3).css("color", "#5A7505").html("加载失败").show();
		    $(".fileinput-button").find("span").html("重新选择文件")
		  }
		  //hideDiv("pop_div");
		  $(".imgview").removeClass("adDWXBgIMG")
		},

		success: function(result) {
//		  var imagedata = encodeURIComponent(result.clearBase64);
			var imagedata = result.clearBase64;
			var data = {
		    imagename: "myImage.png",
		    imagedata: imagedata
		  }
		  $(id).data("imagedata",imagedata);
		}
	});
	
	function popupDiv(div_id) {
		var div_obj = $("#" + div_id);
		$(".shadow-bg").show();
		div_obj.show()
	}

	/*function hideDiv(div_id) {
		$(".shadow-bg").animate({opacity: "hide"},600);

		$("#" + div_id).animate({opacity: "hide"},600);
		return false
	};*/
}