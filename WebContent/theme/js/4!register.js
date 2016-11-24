(function($) {
	if (typeof $.mk == "undefined") {//保证有$.mk
		$.mk = {};
	}

	if (typeof $.mk.register == "undefined") {//保证有$.mk.register
		$.mk.register = {};
	}
	
	var isNameOk,isEmailOK,isPhoneOK="F",isPwdOK,isToPwdOK,isVerifycodeOK,isPhoneCodeOK= "F";
	var okVerifycode;//输入的正确验证码
	var emailReg = /\b(^[_a-zA-Z0-9-]+(\.[_a-zA-Z0-9-]+)*@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)*$)\b/;
	var phoneReg=/^[1][358][0-9]{9}$/;
	
	//检测用户昵称
	$.mk.register.checkNickName = function(obj){
		var nickName = $.trim(obj.value);
		if(nickName.length < 2){
			$("#input_nickname").show();
			$("#input_nickname_s").html("昵称长度需两个字符以上");
			$("#input_nickname").attr("class","reg-check-tip wrong");
			isNameOk = "F";
			return false;
		}
		if(!$.mk.syset.checkNickNameFuHao(nickName)){
			$("#input_nickname").show();
			$("#input_nickname_s").html("含有特殊字符！");
			$("#input_nickname").attr("class","reg-check-tip wrong");
			isNameOk = "F";
			return false;
		}
		//检测是否含有违禁符号或汉字
		$.ajax({
			url:"/register|checkIsForbid.action",
			type:"get",
			data:{"nickName":nickName},
			success:function(response){
				$("#input_nickname").show();
				if(response=="register.error.nickName"){
					$("#input_nickname_s").html("含有违禁符号或汉字");
					$("#input_nickname").attr("class","reg-check-tip wrong");
					isNameOk = "F";
				}else if(response=="register.check.nickName"){
					$("#input_nickname_s").html("此昵称太受欢迎了，换一个试试。");
					$("#input_nickname").attr("class","reg-check-tip wrong");
					isNameOk = "F";
				}else{
					$("#input_nickname").attr("class","reg-check-tip ok");
					isNameOk = "T";
				}
			}
		});
	}
	
	$.mk.register.focusNickName = function(obj){
		$("#input_nickname").show();
	}

	//账号绑定 快速注册 检查昵称
	$.mk.register.checkNickNameFast = function(obj){
		var nickName = $.trim(obj.value);
		if(nickName.length < 2){
			$("#input_nickname").attr("class","reg-check-tip warning");
			isNameOk = "F";
			return false;
		}
		if(!$.mk.syset.checkNickNameFuHao(nickName)){
			$("#input_nickname").attr("class","reg-check-tip warning");
			isNameOk = "F";
			return false;
		}
		//检测是否含有违禁符号或汉字
		$.ajax({
			url:"/register|checkIsForbid.action",
			type:"get",
			data:{"nickName":nickName},
			success:function(response){
				if(response=="register.error.nickName"){
					$("#input_nickname").attr("class","reg-check-tip warning");
					isNameOk = "F";
				}else if(response=="register.check.nickName"){
					$("#input_nickname").attr("class","reg-check-tip warning");
					isNameOk = "F";
				}else{
					$("#input_nickname").attr("class","reg-check-tip ok");
					isNameOk = "T";
				}
			}
		});
	}

	$.mk.register.focusEmail = function(obj){
		$("#input_email").show();
	}

	//账号绑定 快速注册 检查邮箱
	$.mk.register.checkEmailFast = function(obj){
		var email = $.trim(obj.value);

		if(email.length <= 0){
			$("#input_email").attr("class","reg-check-tip warning");
			isEmailOK = "F";
			return false;
		}else if(!emailReg.test(email)){
			$("#input_email").attr("class","reg-check-tip warning");
			isEmailOK = "F";
			return false;
		}
		
		$.ajax({
			url:"/register|checkEmailIsUse.action",
			type:"get",
			data:$.param({"email":email}),
			success:function(response){
				if(response=="register.error.email"){
					$("#input_email").attr("class","reg-check-tip warning");
					isEmailOK = "F";
				}else{
					$("#input_email").attr("class","reg-check-tip ok");
					isEmailOK = "T";
				}
			}
		});
	}
	
	//输入框获取焦点
	$.mk.register.focusPhone=function(obj){
		
		
	      $("#input_phone").show();
	      $("#input_phone").attr("class","reg-check-tip");
	      $("#input_phone_s").html("填入<span class='mC'>有效手机号码</span>,以验证完成注册,<br>此手机就是你登录美空的帐号<br>如:15510488002");
		
	};
	//添加修改手机登录获得焦点
	$.mk.register.focusLoginPhone=function(obj){
		
		var phoneValue=$.trim(obj.value);
		if(phoneValue.length<=0){
			$("#notice_Msg").html("*请输入手机号码").css("color","green");
			 return false;
		 }
		  
		
		
		
	};
	//添加修改手机登录手机号验证
	$.mk.register.checkLoginPhone=function(obj){
		
		
		$("#notice_Msg").empty();
		$("#correctImg").empty();
		
		var phoneValue=$.trim(obj.value);
		
		
		
		 if(phoneValue.length<=0){
			   $("#notice_Msg").html("*手机号码不能为空").css("color","#F09");
			   isPhoneOK = "F";
			 return false;
		 }else if(!phoneReg.test(phoneValue)){
			  $("#notice_Msg").html("*手机格式错误").css("color","#F09");
			  isPhoneOK="F";
			 return false;
		 }else {
			 if(phoneValue.length==11){
				 $.ajax({
						url:"/register|checkPhoneIsUse.action",
						type:"get",
						data:$.param({"phone":phoneValue}),
						success:function(response){
							if(response=="register.error.phone"){
								$("#notice_Msg").html("*手机号格式不对或已使用").css("color","#F09");
								isPhoneOK = "F";
								return false;
							}else{
								 $("#correctImg").html("<img class=\"correct\" src=\""+mokosimg+"/images/n.gif\" />");
								 isPhoneOK = "T";
								return true;
							};
						}
					});
			 	}else{
			 		$("#notice_Msg").html("*手机格式错误").css("color","#F09");
			 		isPhoneOK="F";
					 return false;
			 	};
			};
			if(isPhoneOK =="F" )
				return false;
			return true;
		  
		};
	
	
	
	//帐号绑定  快速注册  检查手机号
	$.mk.register.checkPhone=function(obj){
	   
	    var phone = $.trim(obj.value);
	    if(phone.length <= 0){
			
			$("#input_phone").show();
			$("#input_phone_s").html("手机号不能为空！");
			$("#input_phone").attr("class","reg-check-tip wrong");
			isPhoneOK = "F";
			
			return false;
		}else if(!phoneReg.test(phone)){
			$("#input_phone_s").html("手机格式错误！");
			$("#input_phone").attr("class","reg-check-tip wrong");
			isPhoneOK = "F";
			return false;
		}else{
			var ForgetPassword_phone=$("#ForgetPassword_phone").val();
			if(ForgetPassword_phone=='ForgetPassword_phone'){
				$.ajax({
					url:"/register|checkPhoneIsUse.action",
					type:"get",
					async:false,
					data:$.param({"phone":phone}),
					success:function(response){
						$("#input_phone").show();
						if(response=="register.error.phone"){
							$("#input_phone").attr("class","reg-check-tip ok");
							isPhoneOK = "T";
							return true;
						}else{
							$("#input_phone_s").html("对不起，您没有添加登录手机");
							$("#input_phone").attr("class","reg-check-tip wrong");
							isPhoneOK = "F";
							return false;
						}
					}
				});
				
			}else{
				$.ajax({
					url:"/register|checkPhoneIsUse.action",
					type:"get",
					async:false,
					data:$.param({"phone":phone}),
					success:function(response){
						$("#input_phone").show();
						if(response=="register.error.phone"){
							$("#input_phone_s").html("手机号格式不对或已使用");
							$("#input_phone").attr("class","reg-check-tip wrong");
							isPhoneOK = "F";
							return false;
						}else{
							$("#input_phone").attr("class","reg-check-tip ok");
							isPhoneOK = "T";
							return true;
						}
					}
				});
			}
			
		}
		if(isPhoneOK == "F")
			return false;
		return true;
	};
	  
	  
	  
//账号绑定 快速注册 检查密码
	$.mk.register.checkPasswordFast = function(obj){
		var password = $.trim(obj.value);
		if(password.length == 0){
			$("#input_password").attr("class","reg-check-tip warning");
			isPwdOK = "F";
		}else if(password.indexOf(" ") != -1){
			$("#input_password").attr("class","reg-check-tip warning");
			isPwdOK = "F";
		}else if((password.length<6) || (password.length>24)){
			$("#input_password").attr("class","reg-check-tip warning");
			isPwdOK = "F";
		}else{
			$("#input_password").attr("class","reg-check-tip ok");
			isPwdOK = "T";
		}
	}
	
	//检测email是否已存在
	$.mk.register.checkEmail = function(obj){
		var email = $.trim(obj.value);
		if(!_checkEmailIsIllegal(email))
			return ;
		$.ajax({
			url:"/register|checkEmailIsUse.action",
			type:"get",
			data:$.param({"email":email}),
			success:function(response){
				$("#input_email").show();
				if(response=="register.error.email"){
					$("#input_email_s").html("该登陆邮箱格式不对或已使用");
					$("#input_email").attr("class","reg-check-tip wrong");
					isEmailOK = "F";
				}else{
					$("#input_email").attr("class","reg-check-tip ok");
					isEmailOK = "T";
				}
			}
		});
	}
	
	$.mk.register.phone = function(obj){
		var phone= $.trim(obj.value);
		if(!_checkPhoneIsIllegal(phone))
			return ;
		
	};
	
	
	
	
	
	$.mk.register.showStrengthDiv = function(){
		$("#input_password_s").show();
		$("#input_password_s2").hide();
	}
	
	//用于检测密码的长度
	$.mk.register.checkPw = function(obj){
		var password = $.trim(obj.value);
		$("#input_password").show();
		if(password.length == 0){
			$("#input_password_s").hide();
			$("#input_password_s2").html("请输入密码").show();
			$("#input_password").attr("class","reg-check-tip wrong");
			isPwdOK = "F";
		}else if(password.indexOf(" ") != -1){
			$("#input_password_s").hide();
			$("#input_password_s2").html("密码不能有违禁字符").show();
			$("#input_password").attr("class","reg-check-tip wrong");
			isPwdOK = "F";
		}else if((password.length<6) || (password.length>24)){
			$("#input_password_s").hide();
			$("#input_password_s2").html("密码长度6到24位").show();
			$("#input_password").attr("class","reg-check-tip wrong");
			isPwdOK = "F";
		}else{
			$("#input_password_s").hide();
			$("#input_password_s2").hide();
			$("#input_password").attr("class","reg-check-tip ok");
			isPwdOK = "T";
		}
	}
	
	//当光标在密码输入框时
	$.mk.register.focusPassword = function(obj){
		$("#input_password").show();
		$("#input_password").attr("class","reg-check-tip");
		$.mk.register.showStrengthDiv();
	}
	
	$.mk.register.focusConfirmPwd = function(obj){
		$("#input_passwordConfirm").show();
	}
	
	//核对两次输入密码的一致性判断
	$.mk.register.confirmPw = function(obj) {
		var password = $.trim($("#password").val());
		var passwordConfirm = obj.value;
		if((password.length<6) || (password.length>24)) {
			$("#input_password_s").hide();
			$("#input_password_s2").html("密码长度6到24位").show();
			$("#input_password").show();
			$("#input_password").attr("class","reg-check-tip wrong");
			isToPwdOK = "F";
		}else if(passwordConfirm != password) {
			$("#error_comfirm").html("两次输入的密码不一样,请重新输入!");
			$("#input_passwordConfirm").show();
			$("#input_passwordConfirm").attr("class","reg-check-tip wrong");
			isToPwdOK = "F";
		}else{
			$("#input_passwordConfirm").show();
			$("#input_passwordConfirm").attr("class","reg-check-tip ok");
			isToPwdOK = "T";
		}
	}
	
	//换一张验证码
	$.mk.register.changeVerifyCode = function(){
		$("#verifyImage").attr("src","/kaptcha.jpg?randomp=" + Math.random());
		$("#verifyCode").val("");
		$("#input_verifycode").hide();
	}
	
	//检测验证码是否正确
	$.mk.register.checkVerifyCode = function(obj){
		var validateCode=$.trim(obj.value);
	 	if(validateCode == ""){
	 		$("#verifycodeErrorMsg").html("请输入验证码");
			$("#input_verifycode").attr("class","reg-check-tip wrong");
			$("#input_verifycode").show();
		}else{
			$("#input_verifycode").attr("class","reg-check-tip ok");
			$("#input_verifycode").show();
		}
	}
	
	//提交注册第一步
	$.mk.register.saveRegisterFirst = function(){
		if($.trim($("#nickName").val())=="" || isNameOk == "F"){
			var param = $.param({"content":"请按要求输入昵称。"});
			$.mokoDialog({url:"/jsps/register/RegisterTiShiPop.jsp?"+param});
			return false;
		}
		if(($.trim($("#email").val())=="" || isEmailOK == "F")&&!$("div.reg_email").is(":hidden")){
			var param = $.param({"content":"请按要求输入登陆邮箱。"});
			$.mokoDialog({url:"/jsps/register/RegisterTiShiPop.jsp?"+param});
			return false;
		}
		if(($.trim($("#phone").val())=="" || isPhoneOK == "F")&&!$("div.reg_phone").is(":hidden")){
			var param = $.param({"content":"请按要求输入登陆手机号。"});
			$.mokoDialog({url:"/jsps/register/RegisterTiShiPop.jsp?"+param});
			return false;
		}
		if( isPhoneCodeOK == "F"&&!$("div.reg_phone").is(":hidden")){
			var param = $.param({"content":"请按要求输入手机验证码。"});
			$.mokoDialog({url:"/jsps/register/RegisterTiShiPop.jsp?"+param});
			return false;
		}
		if($.trim($("#password").val())=="" || isPwdOK == "F"){
			var param = $.param({"content":"请按要求输入密码。"});
			$.mokoDialog({url:"/jsps/register/RegisterTiShiPop.jsp?"+param});
			return false;
		}
		if($.trim($("#passwordConfirm").val()) != $.trim($("#password").val())){
			var param = $.param({"content":"请按要求输入确认密码。"});
			$.mokoDialog({url:"/jsps/register/RegisterTiShiPop.jsp?"+param});
			return false;
		}
		if($.trim($("#verifyCode").val())==""){
			var param = $.param({"content":"请输入验证码。"});
			$.mokoDialog({url:"/jsps/register/RegisterTiShiPop.jsp?"+param});
			return false;
		}
		if(!$("#input_isCheck").prop("checked")){
			var param = $.param({"content":"请先阅读并同意<美空网服务条款>。"});
			$.mokoDialog({url:"/jsps/register/RegisterTiShiPop.jsp?"+param});
		    return false;
		}else {
			var cookieName = "REGISTER_NUM";	//注册cookie名称
			var cookieNum = $.mk.checkCookie(cookieName);
			if(cookieNum > 2){
				var param = $.param({"content":"这台电脑已经注册太多账号,过段时间再注册!"});
				$.mokoDialog({url:"/jsps/register/RegisterTiShiPop.jsp?"+param});
				return false;
			}
			
			// 验证 验证码
			if(!_validateVerifyCode($("#verifyCode").val()))
				return false;
			
			$("#btnRegisterSave").attr("disabled",false);
			_checkIp(cookieName, cookieNum, "fmRegisterFirst");
			$("#btnRegisterSave").attr("disabled",true);
		}
	}

	//账号绑定,快速注册
	$.mk.register.saveFastRegister = function(){
		if($.trim($("#nickName").val())=="" || isNameOk == "F"){
			var param = $.param({"content":"请按要求输入昵称。"});
			$.mokoDialog({url:"/jsps/register/RegisterTiShiPop.jsp?"+param});
			return false;
		}
		if($.trim($("#email").val())=="" || isEmailOK == "F"){
			var param = $.param({"content":"请按要求输入登陆邮箱。"});
			$.mokoDialog({url:"/jsps/register/RegisterTiShiPop.jsp?"+param});
			return false;
		}
//		if($.trim($("#phone").val())=="" || isPhoneOK == "F"){
//			var param = $.param({"content":"请按要求输入登陆邮箱。"});
//			$.mokoDialog({url:"/jsps/register/RegisterTiShiPop.jsp?"+param});
//			return false;
//		}
		if($.trim($("#password").val())=="" || isPwdOK == "F"){
			var param = $.param({"content":"请按要求输入密码。"});
			$.mokoDialog({url:"/jsps/register/RegisterTiShiPop.jsp?"+param});
			return false;
		}
		var cookieName = "REGISTER_NUM";	//注册cookie名称
		var cookieNum = $.mk.checkCookie(cookieName);
		if(cookieNum > 2){
			var param = $.param({"content":"这台电脑已经注册太多账号,过段时间再注册!"});
			$.mokoDialog({url:"/jsps/register/RegisterTiShiPop.jsp?"+param});
			return false;
		}
		_checkIp(cookieName, cookieNum, "fmFastRegister");
	}
	
	_checkIp = function(cookieName, cookieNum, formId){
		// 验证 IP 注册限制
		$.ajax({
			url:"/register|checkRegisterNumAjax.action",
			type:"post",
			success:function(response){
				if(response=="dataErr"){	//表示IP当天注册次数超过10次
					var param = $.param({"content":"此IP已经注册太多账号,过段时间再注册!"});
					$.mokoDialog({url:"/jsps/register/RegisterTiShiPop.jsp?"+param});
					return false;
				}else{
					$.setCookie(cookieName,cookieNum+1,1);
					$("#"+formId).submit();
				}
			}
		});
	}
	
	$.mk.register.unSaveAndBack = function() {
		$.location(document.referrer);
	}
	//检查已经选择的职业数据
	$.mk.register.continueVocationList = function(){
		if ($(".current-job .current-jobBox input:checkbox").size() == 0) {
			_vocationCountAlert("请选择职业！");
			return;
		}
		if($(".current-job .current-jobBox input:checkbox").size() > 5) {
			_vocationCountAlert("你最多只能选择5个职业！");
			return;
		}
		if($(".current-job .current-jobBox:first .current-null").size() > 0){
			var description = $(".current-job .current-jobBox a:first").text();
			_vocationCountAlert("<span class=\"mC\">" + description + "</span> 将变为你的主要职业，<br />是否确定保存？", "confirm");
		}else{
			var vocations=$("input[name='vocations']");
			if(vocations.length==1&&vocations.val()=="118")
				_vocationCountAlert("请您选一个不是”其他职业“的职业！");
			else{
				$.ajax({
					url:"/editUserVocation|ajaxEdit.action",
					type:"post",
					data:$("#EditVocation").serialize(),
					success:function(response){
						var resultText='text.update.success';
						if(response.indexOf(resultText)!=-1){
							var phone=$("#phone").val();
							$.location("applyMP.action?phone="+phone);
						}
							
					}
				});
			}
		}
	}
	
	//检查已经选择的职业数据
	$.mk.register.checkVocationList = function(){
		if ($(".current-job .current-jobBox input:checkbox").size() == 0) {
			_vocationCountAlert("请选择职业！");
			return;
		}
		if($(".current-job .current-jobBox input:checkbox").size() > 5) {
			_vocationCountAlert("你最多只能选择5个职业！");
			return;
		}
		if($(".current-job .current-jobBox:first .current-null").size() > 0){
			var description = $(".current-job .current-jobBox a:first").text();
			_vocationCountAlert("<span class=\"mC\">" + description + "</span> 将变为你的主要职业，<br />是否确定保存？", "confirm");
		}else{
				$.mk.register.saveVocationList();
		}
			
	}
	
	//通过Ajax保存所选职业信息
	$.mk.register.saveVocationList = function(){
		$.ajax({
			url:"/editUserVocation|ajaxEdit.action",
			type:"post",
			data:$("#EditVocation").serialize(),
			success:function(response){
				_saveVocationListCallBack(response);
			}
		});
	}
	
	//编辑职业时 选择职业
	$.mk.register.selectVocation = function(vocationId) {
		var $vocation_link = $("#chooseVocation_" + vocationId);

		if ($vocation_link.hasClass("alive")) {
			$vocation_link.removeClass("alive");
			_delVocation(vocationId);
		} else {
			var cc = 0;
			for(var i=0; i<22; i++){
				var $vlink = $("#chooseVocation_" + i);
				
				if ($vlink.hasClass("alive")) {
						cc ++;
				}
			}

			var $vlink = $("#chooseVocation_144");
			if ($vlink.hasClass("alive")) {
					cc ++;
			}
 
			//if($(".current-job .current-jobBox input:checkbox").size() >= 5) {
			if(cc >= 3) {
				art.dialog.alert("你最多只能选择3个职业！");
				return;
			}
			$vocation_link.addClass("alive");
			_addVocation(vocationId);
		}
		
	}
	
	//职业数量超出提示
	_vocationCountAlert = function (alertContent, type) {
		var param = $.param({"content":alertContent, "type":type});
		$.mokoDialog({url:"/jsps/register/RegisterTiShiPop.jsp?"+param});
	}
	
	//添加当前职业
	_addVocation = function (vocationId) {
		//获取当前职业的信息（职业名、图片路径）
		var $vocation_box = $("#vocation_box_" + vocationId);
		var description = $vocation_box.find("a").text();
		var img_src = $vocation_box.find("img").attr("src")
				|| $vocation_box.find("img").attr("src2");
		
		//在当前职业显示的dom
		var html = '<div class="current-jobBox">\
						<a href="javascript:void(0);" title="" hidefocus="true">&nbsp;</a>\
						<input type="button" class="btn" value="删除">\
						<input type="checkbox" name="vocations" value="" checked="checked" style="display: none" />\
					</div>';
		var $html = $(html).attr("id", "current_job_"+vocationId);
		$html.find("img").attr({
					"title" : description,
					"src" : img_src
				});
		$html.find("a").attr("title", description).text(description);
		$html.find("input:button").bind("click", { boxId : vocationId }, function(event) {
					$vocation_box.find("a").removeClass("alive");
					_delVocation(event.data.boxId);
				});
		$html.find("input:checkbox").val(vocationId);
		//找到第一个未选择的dom 替换成 选择的职业dom
		$(".current-job .current-jobBox .current-null:first").parent().replaceWith($html);
	}
	
	//删除当前职业
	_delVocation = function (boxId) {
		$("#current_job_"+boxId).html('<div class="current-null">未选择</div>');
	}
	
	/**
	 * 更改登录邮箱进行必要验证
	 * @return {Boolean}
	 */
	$.mk.register.updateLoginEmail = function(){
		if($("#resultInfo_p").size()!=0)
			$("#resultInfo_p").remove();
		var email = $.trim($("#email").val());
		if(email==""){
			$("#currentEmail").after('<p class="borderOn lesserColor lineheight30 pBackColor_1" id="resultInfo_p">请输入登录邮箱!</p>');
			return false;
		}
	
		if(!emailReg.test(email)){
			$("#currentEmail").after('<p class="borderOn lesserColor lineheight30 pBackColor_1" id="resultInfo_p">邮箱格式错误!</p>');
			return false;
		}
		var password = $.trim($("#password").val());
		if(password==""){
			$("#currentEmail").after('<p class="borderOn lesserColor lineheight30 pBackColor_1" id="resultInfo_p">请输入密码!</p>');
			return false;
		}
		if(password.length<6 || password.length>24){
			$("#currentEmail").after('<p class="borderOn lesserColor lineheight30 pBackColor_1" id="resultInfo_p">密码格式错误!</p>');
			return false;
		}
		var phone = $.trim($("#phone").val());
		if(phone==""){
			$("#currentEmail").after('<p class="borderOn lesserColor lineheight30 pBackColor_1" id="resultInfo_p">请输入手机号!</p>');
			return false;
		}
		if(!phoneReg.test(phone)){
			$("#currentEmail").after('<p class="borderOn lesserColor lineheight30 pBackColor_1" id="resultInfo_p">手机格式错误!</p>');
			return false;
		}
		
		
		
		
		$("#emailSub").attr("disabled",true);
		$("#btnReturn").attr("disabled",true);
		return true;
	}
	
	
	/**
	 * 显示更改登录邮箱层
	 */
	$.mk.register.showUploadLoginEmail = function(){
		var oldEmail = $("#oldEmail").val();
		var updateFlag=$("#updateFlag").val();
		if($("#baseset_email_id").text().length>0){
			oldEmail = $("#baseset_email_id").text();
		}
		var param = $.param({"email":oldEmail,"updateFlag":updateFlag});
		$.mokoDialog({url:"/jsps/emailactivate/EmailUpdateView.jsp?"+param});
	};
	/**
	 * @author yoyo
	 * @显示更改手机登录层
	 */
	var timer_PhoneCode=null;
	$.mk.register.showUploadLoginPhone=function(){
//		clearInterval(timer_PhoneCode);
		$.mokoDialog({url:"/jsps/phoneactivate/PhoneView.jsp"});
	};
	$.mk.register.showUploadUpdataPhone=function(){
		var oldPhone = $("#baseset_oldPhone").val();
		var param = $.param({"oldPhone":oldPhone});
		$.mokoDialog({url:"/jsps/phoneactivate/PhoneUpdateView.jsp?"+param});
		
		
	};
	$.mk.register.showEmailLogin=function(){
		var oldEmail = $("#oldEmail").val();
		var updateFlag=$("#updateFlag").val();
		if($("#baseset_email_id").text().length>0){
			oldEmail = $("#baseset_email_id").text();
		}
		var param = $.param({"email":oldEmail,"updateFlag":updateFlag});
		$.mokoDialog({url:"/jsps/emailactivate/EmailView.jsp?"+param});
		
		
		
	};
	//Mr.long2014-04-16第三方修改邮箱
	$.mk.register.showDiSanFangEmailLogin=function(){
		var oldEmail = $("#oldEmail").val();
		var updateFlag=$("#updateFlag").val();
		if($("#baseset_email_id").text().length>0){
			oldEmail = $("#baseset_email_id").text();
		}
		var param = $.param({"email":oldEmail,"updateFlag":updateFlag});
		$.mokoDialog({url:"/jsps/emailactivate/EmailDiSanFangView.jsp?"+param});
		
		
		
	};
	//	//Mr.long2014-04-16第三方添加手机
	$.mk.register.showDiSanFangUploadLoginPhone=function(){
		$.mokoDialog({url:"/jsps/phoneactivate/PhoneDiSanFangView.jsp"});
	};
	
	//取消登录  改变（邮箱或手机）登录状态
	$.mk.register.cancelLogin=function(loginType){
		var param = $.param({"loginType":loginType});
		$.mokoDialog({url:"/jsps/phoneactivate/cancellogin.jsp?"+param});
		
		
	};
	
	/**
	 * 更改登录邮箱
	 */
	$.mk.register.uploadLoginEmail = function(){
		var password = $("#oldPwssWord").val();
		$("#passWordError").hide();
		$("#newEmailError").hide();
		if(password.length == 0){
			$("#passWordError").show();
			$("#passWordError").html("请输入密码！");
			return ;
		}
		var email = $("#newEmail").val();
		if(!emailReg.test(email)){
			$("#newEmailError").show();
			$("#newEmailError").html("邮箱格式错误!");
			return ;
		}
		 var oldEmail=$("#oldEmail").val();
		 var updateFlag=$("#updateFlag").val();
		$("#email").val(email);
		$("#password").val(password);
		$.ajax({
			url:"/activateShow|updateLoginEmailAjax.action",
			type:"post",
			data:$("#uploadEmailForm").serialize(),
			success:function(response){
				if(response == "dataErr"){
					var param = $.param({"content":"数据错误，请刷新页面！"});
					$.mokoDialog({url:"/jsps/register/RegisterTiShiPop.jsp?"+param});
				}else if(response == "pwdError"){
					$("#passWordError").show();
					$("#passWordError").html("密码错误！");
				}else if(response == "emailError"){
					$("#newEmailError").show();
					$("#newEmailError").html("该邮箱已存在！");
				}else if(response == "activate"){
					$.mokoDialog.close();
					var param = $.param({"content":"你的邮箱已激活！"});
					$.mokoDialog({url:"/jsps/register/RegisterTiShiPop.jsp?"+param});
				}else if(response=="del"){
					$.mokoDialog({url:"/jsps/common/noexist.jsp"});
				}
				else {
					$.mokoDialog.close();
					var param = $.param({"email":email,"codeKey":response,"oldEmail":oldEmail,"updateFlag":updateFlag});
					$.mokoDialog({url:"/jsps/emailactivate/EmailUpdateOk.jsp?"+param});
				}
			}
		});
	}
	
	/**
	 * Mr.long2014-04-17
	 * 第三方添加登录邮箱
	 */
	$.mk.register.uploadDiSanFangLoginEmail = function(){
		var password = $("#oldPwssWord").val();
		var confirmPassword = $("#confirmPassword").val();
		$("#passWordError").hide();
		$("#newEmailError").hide();
		$("#passConfirmWordError").hide();
		var email = $("#newEmail").val();
		if(!emailReg.test(email)){
			$("#newEmailError").show();
			$("#newEmailError").html("邮箱格式错误!");
			return ;
		}
		if(password.length == 0){
			$("#passWordError").show();
			$("#passWordError").html("请输入密码！");
			return ;
		}
		if(confirmPassword.length == 0){
			$("#confirmPassword").show();
			$("#confirmPassword").html("请输入确认密码！");
			return ;
		}
		 var oldEmail=$("#oldEmail").val();
		 var updateFlag=$("#updateFlag").val();
		$("#email").val(email);
		$("#password").val(password);
		$.ajax({
			url:"/activateShow|updateLoginEmailAjax.action",
			type:"post",
			data:$("#uploadEmailForm").serialize(),
			success:function(response){
				if(response == "dataErr"){
					var param = $.param({"content":"数据错误，请刷新页面！"});
					$.mokoDialog({url:"/jsps/register/RegisterTiShiPop.jsp?"+param});
				}else if(response == "pwdError"){
					$("#passWordError").show();
					$("#passWordError").html("密码错误！");
				}else if(response == "pwdConfirmError"){
					$("#confirmPassword").show();
					$("#confirmPassword").html("两次输入的密码不一样,请重新输入!");
				}else if(response == "emailError"){
					$("#newEmailError").show();
					$("#newEmailError").html("该邮箱已存在！");
				}else if(response == "activate"){
					$.mokoDialog.close();
					var param = $.param({"content":"你的邮箱已激活！"});
					$.mokoDialog({url:"/jsps/register/RegisterTiShiPop.jsp?"+param});
				}else if(response=="del"){
					$.mokoDialog({url:"/jsps/common/noexist.jsp"});
				}
				else {
					$.mokoDialog.close();
					var param = $.param({"email":email,"codeKey":response,"oldEmail":oldEmail,"updateFlag":updateFlag});
					$.mokoDialog({url:"/jsps/emailactivate/EmailUpdateOk.jsp?"+param});
				}
			}
		});
	}
	/**
	 * 再次发送激活邮件
	 */
	$.mk.register.sendEmail = function(){
		$.ajax({
			url:"/activateShow|sendActivateEmailAjax.action",
			type:"post",
			data:$.param({"email":$("#oldEmail").val(),"registerId":$("#registerId").val(),"newEmail":$("#newEmail").val(),"updateId":$("#updateId").val()}),
			success:function(response){
				if(response == "success"){
					var param = $.param({"content":"已重新向注册邮箱发送激活邮件！"});
					$.mokoDialog({url:"/jsps/register/RegisterTiShiPop.jsp?"+param});
				}else{
					var param = $.param({"content":"数据错误，请刷新页面！"});
					$.mokoDialog({url:"/jsps/register/RegisterTiShiPop.jsp?"+param});
				}
			}
		});
	}
	
	$.mk.register.goRegisterOk = function(url){
		$("input:checkbox:checked").prop("checked", false);
		$.location(url);
	}
	
	//处理异步调用后的结果:若更新成功刚返回前页并刷新
	_saveVocationListCallBack = function(responseText){
		var resultText='text.update.success';
		if(responseText.indexOf(resultText)!=-1)
			$.mk.register.unSaveAndBack();
	}
	
	//检测email的合法性：通过判断长度及正则表达式对email的匹配
	_checkEmailIsIllegal = function(email) {
		if(email.length <= 0){
			$("#input_email_s").html("请输入登陆邮箱");
			$("#input_email").show();
			$("#input_email").attr("class","reg-check-tip wrong");
			isEmailOK = "F";
			return false;
		}else if(!emailReg.test(email)){
			$("#input_email").show();
			$("#input_email_s").html("该登陆邮箱格式不对或已使用");
			$("#input_email").attr("class","reg-check-tip wrong");
			isEmailOK = "F";
			return false;
		}
		isEmailOK = "T";
		return true;
	}
	
	 //检测phone的合法性
	
	_checkPhoneIsIllegal = function(phone) {
		if(phone.length <= 0){
			$("#input_phone_s").html("请输入登陆手机号");
			$("#input_phone").show();
			$("#input_phone").attr("class","reg-check-tip wrong");
			isEmailOK = "F";
			return false;
		}else if(!phoneReg.test(email)){
			$("#input_phone").show();
			$("#input_phone_s").html("该登陆邮箱格式不对或已使用");
			$("#input_phone").attr("class","reg-check-tip wrong");
			isPhoneOK = "F";
			return false;
		}
		isPhoneOK = "T";
		return true;
	}
	
	
	
	

	_validateVerifyCode = function(validateCode){
		var result = false;
		if($.trim(validateCode) == ""){
			$("#verifycodeErrorMsg").html("请输入验证码");
			$("#input_verifycode").attr("class","reg-check-tip wrong");
			$("#input_verifycode").show();
			return false;
		}
		$.ajax({
			type:"post",
			url:"/register|checkValidate.action",
			data:{j_image_code_response:validateCode},
			async:false,
			success:function(xmlhttp){
				if(xmlhttp == "success"){
					$("#input_verifycode").attr("class","reg-check-tip ok");
					$("#input_verifycode").show();
					result = true;
				}else{
					$.mk.register.changeVerifyCode();
					$("#verifycodeErrorMsg").html("验证码输入有误,请重新输入!");
					$("#input_verifycode").attr("class","reg-check-tip wrong");
					$("#input_verifycode").show();
					result = false;
				}
			}
		});
		return result;
	}
	//发送手机验证码
	$.mk.register.sendCheckPhone=function(){
		var phone=$("#phone");
		if($.mk.register.checkPhone(phone[0])){
			var info="";
			$.ajax({
				type:"post",
				url:"/register|sendCheckPhone.action",
				data:{phone:phone.val()},
				async:false,
				success:function(xmlhttp){
					if(xmlhttp == "success"){
						var time=300;
						timer_PhoneCode=setInterval(function(){
							if(time-->0){
								$("#phoneCode").val(time+"秒内有效");
								$("#phoneCode").attr("disabled","disabled");
							}else{
								$("#phoneCode").val("获取验证码");
								$("#phoneCode").removeAttr("disabled");
								clearInterval(timer_PhoneCode);
							}
					   },1000);
					}else if(xmlhttp == "overNum"){
						info="对不起，请您24小时后获取验证码。";
						$.mokoDialog({
							url : "/jsps/common/alertPop.jsp?tip=79&info=" + encodeURI(info),id:"phoneCode"
						});
					}else{
						info="对不起，发送短信有误。";
						$.mokoDialog({
							url : "/jsps/common/alertPop.jsp?tip=79&info=" + encodeURI(info),id:"phoneCode"
						});
					}
				}
				});
			
			};
			
		  
		
			
		};
		
		
	//获取焦点	
	$.mk.register.focusCheckCodePhone=function(obj){
		
		  var code_value=$.trim(obj.value);
		  
		  if(code_value.length<=0){
			  
			  $("#notice_code").html("*请填写获取到的验证码").css("color","green");
			  
		  
		  };
		
	   };
	   //添加修改手机登录手机验证码验证
	  $.mk.register.onblurCheckCodePhone=function(obj){
		  $("#correct_code").empty();
		  var code_value=$.trim(obj.value);
          if(code_value.length<=0){
			  $("#notice_code").html("*手机验证码不能为空").css("color","#F09");
			  isPhoneCodeOK = "F";
		  }else{
			  if(code_value.length==6){
				  if($.mk.register.checkLoginPhone($("#phone")[0])){
						
							if($.mk.register.checkValideCode(code_value,$("#phone").val())){
								 $("#notice_code").empty();
								 $("#correct_code").html("<img class=\"correct\" src=\""+mokosimg+"/images/n.gif\" />");
								 $(".get_phone_code").hide();
								isPhoneCodeOK = "T";
							}else{
								$("#notice_code").html("*手机验证码不正确").css("color","#F09");
								isPhoneCodeOK = "F";
							}
						
					};
			  }else{
//					$("#notice_code").html("*手机号验证码不正确").css("color","#F09");
					isPhoneCodeOK = "F";
				}
			 
			  
		  };
		  
		  
	  };	 
	   
	//获取焦点手机验证码显示信息
	$.mk.register.focusCheckPhone=function(obj){
		
		
	      $("#input_codeValue").show();
	      $("#input_codeValue").attr("class","reg-check-tip");
	      $("#input_codeValue_s").html("填入<span class='mC'>有效手机验证码</span>,以验证完成注册,<br>此手机验证码会发送到您手机<br>请注意查收");
		
	};
	
	//失去焦点手机验证码显示信息
	$.mk.register.onblurCheckPhone=function(obj){
	   
	    var codeValue = $.trim(obj.value);
	    var phone=$("#phone");
		if(codeValue.length <= 0){
			$("#input_codeValue").show();
			$("#input_codeValue_s").html("手机验证码不能为空！");
			$("#input_codeValue").attr("class","reg-check-tip wrong");
			isPhoneCodeOK = "F";
			return false;
		}else{
			if($.mk.register.checkPhone($("#phone")[0])){
				if(codeValue.length==6){
					if($.mk.register.checkValideCode(codeValue,phone.val())){
						$("#input_codeValue").attr("class","reg-check-tip ok");
						isPhoneCodeOK = "T";
					}else{
						$("#input_codeValue").show();
						$("#input_codeValue_s").html("手机验证码不正确！");
						$("#input_codeValue").attr("class","reg-check-tip wrong");
						isPhoneCodeOK = "F";
					}
				}else{
//					$("#input_codeValue").show();
//					$("#input_codeValue_s").html("手机号验证码不正确！");
//					$("#input_codeValue").attr("class","reg-check-tip wrong");
					isPhoneCodeOK = "F";
				}
			};
			
		};
	};
	$.mk.register.checkValideCode=function(codeValue,phone){
		var checkValideCodeFlag=false;
		$.ajax({
			type:"post",
			url:"/register|checkValideCode.action",
			data:{valideCode:codeValue,phone:phone},
			async:false,
			success:function(xmlhttp){
				if(xmlhttp == "success"){
					clearInterval(timer_PhoneCode);
					checkValideCodeFlag=true;
					$("#phoneCode").remove();
				}
			}
		});
		return checkValideCodeFlag;
	};
	/**
	 * 添加登录电话
	 */
	$.mk.register.uploadLoginPhone = function(){
		var password = $("#oldPwssWord").val();
		$("#passWordError").hide();
		$("#newCodeError").hide();
		$("#newPhoneError").hide();
		if(password.length == 0){
			$("#passWordError").show();
			$("#passWordError").html("请输入密码！");
			return ;
		}
		var phone = $("#phone").val();
		if(!phoneReg.test(phone)){
			$("#newPhoneError").show();
			$("#newPhoneError").html("手机号格式错误!");
			return ;
		}
		if(isPhoneCodeOK=='F'){
			$("#newCodeError").show();
			$("#newCodeError").html("手机验证码不正确!");
			return ;
		}
		$("#password").val(password);
		
		$.ajax({
			url:"/activateShow|insertLoginPhoneAjax.action",
			type:"post",
			data:$("#uploadPhoneForm").serialize(),
			success:function(response){
				if(response == "dataErr"){
					var param = $.param({"content":"数据错误，请刷新页面！"});
					$.mokoDialog({url:"/jsps/register/RegisterTiShiPop.jsp?"+param});
				}else if(response == "pwdError"){
					$("#passWordError").show();
					$("#passWordError").html("密码错误！");
				}else if(response == "phoneError"){
					$("#newPhoneError").show();
					$("#newPhoneError").html("该手机号已存在！");
				}else if(response == "success"){
					$.mokoDialog.close();
					$.reload();
				}
			}
		});
	};
	/**
	 * Mr.long2014-04-16添加第三方登录电话
	 */
	$.mk.register.uploadDiSanFangLoginPhone = function(){
		var password = $("#oldPwssWord").val();
		var confirmpassword=$("#confirmpassword").val();
		$("#passWordError").hide();
		$("#newCodeError").hide();
		$("#newPhoneError").hide();
		$("#confirmPassWordError").hide();
		if(password.length == 0){
			$("#passWordError").show();
			$("#passWordError").html("请输入密码！");
			return ;
		}
		if(confirmpassword.length==0){
			$("#confirmPassWordError").show();
			$("#confirmPassWordError").html("请输入确认密码！");
			return ;
		}
		var phone = $("#phone").val();
		if(!phoneReg.test(phone)){
			$("#newPhoneError").show();
			$("#newPhoneError").html("手机号格式错误!");
			return ;
		}
		if(isPhoneCodeOK=='F'){
			$("#newCodeError").show();
			$("#newCodeError").html("手机验证码不正确!");
			return ;
		}
		$("#password").val(password);
		
		$.ajax({
			url:"/activateShow|insertDiSanFangLoginPhoneAjax.action",
			type:"post",
			data:$("#uploadPhoneForm").serialize(),
			success:function(response){
				if(response == "dataErr"){
					var param = $.param({"content":"数据错误，请刷新页面！"});
					$.mokoDialog({url:"/jsps/register/RegisterTiShiPop.jsp?"+param});
				}else if(response == "pwdError"){
					$("#passWordError").show();
					$("#passWordError").html("密码错误！");
				}else if(response=="confirmpwdError"){
					$("#confirmPassWordError").show();
					$("#confirmPassWordError").html("两次输入的密码不一样,请重新输入!");
				}else if(response == "phoneError"){
					$("#newPhoneError").show();
					$("#newPhoneError").html("该手机号已存在！");
				}else if(response == "success"){
					$.mokoDialog.close();
					$.reload();
				}
			}
		});
	};
	/**
	 * 更新登录电话
	 */
	$.mk.register.updateUploadLoginPhone = function(){
		var password = $("#oldPwssWord").val();
		$("#passWordError").hide();
		$("#newPhoneError").hide();
		$("#newCodeError").hide();
		if(password.length == 0){
			$("#passWordError").show();
			$("#passWordError").html("请输入密码！");
			return ;
		}
		var phone = $("#phone").val();
		if(isPhoneOK=='F'){
			$("#newPhoneError").show();
			$("#newPhoneError").html("手机号错误或已用!");
			return ;
		}
		if(isPhoneCodeOK=='F'){
			$("#newCodeError").show();
			$("#newCodeError").html("手机验证码不正确!");
			return ;
		}
		$("#password").val(password);
		
		$.ajax({
			url:"/activateShow|updateLoginPhoneAjax.action",
			type:"post",
			data:$("#uploadPhoneForm").serialize(),
			success:function(response){
				if(response == "dataErr"){
					var param = $.param({"content":"数据错误，请刷新页面！"});
					$.mokoDialog({url:"/jsps/register/RegisterTiShiPop.jsp?"+param});
				}else if(response == "pwdError"){
					$("#passWordError").show();
					$("#passWordError").html("密码错误！");
				}else if(response == "phoneError"){
					$("#newPhoneError").show();
					$("#newPhoneError").html("该手机号已存在！");
				}else if(response == "success"){
					$.mokoDialog.close();
					$.reload();
				}
			}
		});
	};
	/**
	 * 改变（邮箱或手机）登录状态
	 */
	$.mk.register.updateLoginTyp = function(){
		var password = $("#oldPwssWord").val();
		$("#passWordError").hide();
		if(password.length == 0){
			$("#passWordError").show();
			$("#passWordError").html("请输入密码！");
			return ;
		}
		$("#password").val(password);
		$.ajax({
			url:"/activateShow|updateLoginTypeAjax.action",
			type:"post",
			data:$("#uploadPhoneForm").serialize(),
			success:function(response){
				if(response == "dataErr"){
					var param = $.param({"content":"数据错误，请刷新页面！"});
					$.mokoDialog({url:"/jsps/register/RegisterTiShiPop.jsp?"+param});
				}else if(response == "pwdError"){
					$("#passWordError").show();
					$("#passWordError").html("密码错误！");
				}else if(response == "success"){
					$.mokoDialog.close();
					$.reload();
				}
			}
		});
	};
})(jQuery1);
