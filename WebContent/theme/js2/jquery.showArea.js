
	
	//-----------------------
//作者：亮亮
//邮件：ljlyy[@]126.com
//博客：www.94this.com.cn
//欢迎修改，有什么问题请到博客留言或邮件交流
//-----------------------
	function showArea(event) {
		$("#addr").remove();
		var iptName = $(this).attr("id");
		var iptOffSet = $(this).offset();
		var iptLeft = iptOffSet.left + 78;
		var iptTop = iptOffSet.top + 20;
		//var str = "<div id='addr'><span class='span'>请选择地点<a id='fh'></a><a id='gb'>[&nbsp;关闭&nbsp;]</a></span><ul></ul></div>";
		var str = "<table id='addr'><tr><td style='border-bottom:1px dotted #a6a6a6;'>" +
													"<table width='100%' ><tr><td style='padding:10px;'><span style='background:#ff5500;color:#ffffff;'>&nbsp;请选择地点&nbsp;</span></td><td align='right' style='padding:10px;'><a id='gb' style='cursor:pointer;' onclick='$(\"#addr\").remove()'>[&nbsp;关闭&nbsp;]</a></td></tr></table>" +
												"</td></tr>" +
												"<tr ><td id='place' style='border-bottom:1px dotted #a6a6a6;'></td></tr>" +
												"<tr ><td style='padding-left:10px;padding-top:10px;padding-bottom:10px;'><input id='inputCity' class='addrSelet' type='text' onmousedown='chance(this)' />&nbsp;&nbsp<input type='button' value='确定' onclick='getVal()' style='border:1px solid #a6a6a6;cursor:pointer;color:#666666' /></td></tr>" +
												"<tr ><td id='cityValue'></td></tr>" +
												"</table>"
		window.url = event.data.url;
		$.ajaxSetup({async:false});
		var str2 = "<table width='100%' ><tr>";
		$.post(window.url+"/presonList!getArea.htm",{},function(data){
			$.each(data,function(index,value){
				//str2 = str2 + "<li name='area' data='"+this.isdept+"' id='" + this.aid + "'>"+ this.areaname + "</li>";
				if(index==0){
					str2 = str2 +"</tr><tr><td style='padding-left:10px;padding-top:10px;padding-bottom:10px;padding-right:10px;'><div id='"+this.aid+"' name='area' style='background:#ff5500;color:#ffffff;cursor:pointer;' title='"+this.areaname+"' onclick='setVal(\""+this.areaname+"\",\""+this.aid+"\")'>"+ this.areaname.substring(0,4) + "</div></td>";
					
				}
				else if((index)%4==0){
					str2 = str2 +"</tr><tr><td style='padding-left:10px;padding-top:10px;padding-bottom:10px;padding-right:10px;'><div id='"+this.aid+"' name='area' style='cursor:pointer;' title='"+this.areaname+"' onclick='setVal(\""+this.areaname+"\",\""+this.aid+"\")'>"+ this.areaname.substring(0,4) + "</div></td>";
					
				}else{
					str2 = str2 +"<td style='padding-left:10px;padding-top:10px;padding-bottom:10px;padding-right:10px;'><div id='"+this.aid+"' name='area' style='cursor:pointer;' title='"+this.areaname+"' onclick='setVal(\""+this.areaname+"\",\""+this.aid+"\")'>"+ this.areaname.substring(0,4) + "</div></td>";
				}
				
			});
		},"json");
		str2+="</tr></table>"
		$("body").append(str);
		$("#place").html(str2);
		
		$("#inputCity").val("如：上海市");
		$("#inputCity").css("color","#999999");
		//$("#addr ul").append(str2);
		//$("#addr ul").append("<hr size='1' noshade='noshade' style='border:1px #cccccc dotted;width=300px'>");
		//$("#addr").append("<ul id='city'></ul>");
		
		$("div[name='area']").bind("mouseover",function(){
			$("div[name='area']").not(this).css('background', 'none');
			$("div[name='area']").not(this).css("color","#666666");
			$(this).css({"background":"#ff5500"});
			$(this).css({"color":"#ffffff"});
			getCity(this.id);
		});
//		.bind("mouseout",function(){
//			$(this).css({"background":"none"});
//		});
		//$("#addr ul li[name='area']:eq(0)").mouseover();
		getCity(3);
		//$("#addr").append("<hr size='1' noshade='noshade' style='border:1px #cccccc dotted;width=300px'><br />");
		//$("#addr").append("<div><span>其他地区</span><br /><input id='inputCity' class='addrSelet' type='text' />" +
		//		"&nbsp;&nbsp<input type='button' value='确定' onclick='getVal()' style='border:1px solid black;cursor:pointer' /></div>");
		
		
		$("#addr").css({
			left : iptLeft + "px",
			top : iptTop + "px"
		});
	
	}
function chance(e){
	if($(e).val()=="如：上海市"){
		$(e).val("");
		$(e).css("color","#000000");
	}
}
function getCity(id){
	//$('#addr #city').empty();
	var str3 = "<table width='100%' ><tr>";
	$.post(window.url+"/presonList!getCity.htm",{id:id},function(data){
		$.each(data,function(index,value){
			//str3 = str3 + "<li id='" + this.aid + "'>"+ this.areaname + "</li>";
			if((index)%4==0){
				str3 = str3 +"</tr><tr><td style='padding-left:10px;padding-top:5px;padding-bottom:5px;padding-right:5px;'><div style='cursor:pointer;' title='"+this.areaname+"' onclick=\"setVal('"+this.areaname+"',"+this.aid+")\">"+ this.areaname.substring(0,4) + "</div></td>";
			}else{
				str3 = str3 +"<td style='padding-left:10px;padding-top:5px;padding-bottom:5px;padding-right:5px;'><div style='cursor:pointer;' title='"+this.areaname+"' onclick='setVal(\""+this.areaname+"\")' >"+ this.areaname.substring(0,4) + "</div></td>";
			}
		});
	},"json");
		str3+="</tr></table>"
 		$("#cityValue").html(str3);
	//$("#addr #city").append(str3);
	//$("#addr #city li").bind("click",setVal);
}
//Function.prototype.binding = function() {
//	if (arguments.length < 2 && typeof arguments[0] == "undefined")
//		return this;
//	var __method = this, args = jQuery.makeArray(arguments), object = args
//			.shift();
//	return function() {
//		return __method.apply(object, args.concat(jQuery.makeArray(arguments)));
//	}
//}
function getVal(){
	if($('#inputCity').val()=="如：上海市"){
		$('#inputCity').val("");
	}
	var inputCity = $('#inputCity').val();
	$("#_city_val").text(inputCity);
	$("#place1").val(inputCity);
	$("#addr").css("display", "none");
	document.getElementById("searchFrom").submit();
}
function setVal(areaName,id) {
	$("#_city_val").text(areaName);
	$('#city_id').val(id);
	$("#place1").val(areaName);
	//queryByPlace($(this).text());
	$("#addr").css("display", "none");
	document.getElementById("searchFrom").submit();
}
(function($){
	$.getUrlParam = function(name)
	{
	var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
	var r = window.location.search.substr(1).match(reg);
	if (r!=null) return unescape(r[2]); return null;
	}
	})(jQuery);
/**
 * http://stackoverflow.com/a/10997390/11236
 */
function updateURLParameter(url, param, paramVal){
    var newAdditionalURL = "";
    var tempArray = url.split("?");
    var baseURL = tempArray[0];
    var additionalURL = tempArray[1];
    var temp = "";
    if (additionalURL) {
        tempArray = additionalURL.split("&");
        for (i=0; i<tempArray.length; i++){
            if(tempArray[i].split('=')[0] != param){
                newAdditionalURL += temp + tempArray[i];
                temp = "&";
            }
        }
    }

    var rows_txt = temp + "" + param + "=" + paramVal;
    return baseURL + "?" + newAdditionalURL + rows_txt;
}
function queryByPlace(place){
	window.location.href = updateURLParameter(window.location.href,"place",place);
}
function liBind(event) {
	alert(this.id);
//	return;
//	//如果是省会城市 直接显示并返回
//	if(this.data == 3){
//		$('#_city_val').text($(this).text());
//		$('#city_id').val(this.id);
//		$("#addr").css("display", "none");
//		return;
//	}
//	var str2 = "";
//	$.post(window.url+"/presonList!getCity.htm",{id:this.id},function(data){
//		$.each(data,function(index,value){
//			str2 = str2 + "<li id='" + this.aid + "'>"
//			+ this.areaname + "</li>";
//		});
//	},"json");
//	$("#addr ul").empty();
//	$("#addr ul").append(str2);
//	$("#addr ul li").bind("click", {
//		ipt2 : "_city_val"
//	}, setVal);
}