$(function(){

	var ChkTrue = true,ChkTrue2 = true;
	function initVal(){
		window.localStorage.jjrTel = $(".h-tel").val();
		window.localStorage.jjrChk = $(".h-chk").val();
		window.localStorage.jjrPsw = $(".h-psw").val();
		window.localStorage.jjrCpsw = $(".h-cpsw").val();
		window.localStorage.jjrMail = $(".h-mail").val();
	}

	function companyVal(){
		window.localStorage.companyTel = $(".company-tel").val();
		window.localStorage.companyChk = $(".company-chk").val();
		window.localStorage.companyPsw = $(".company-psw").val();
		window.localStorage.companyCpsw = $(".company-cpsw").val();
		window.localStorage.companyMail = $(".company-mail").val();
	}

	var regTel = /^1[3|5|7|8|9]\d{9}$/; 
	var regMail =  /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;

//	$(".h-tel").on("blur",function(){
//		var _this = $(this);
//		initVal();
//		chkTel(_this,window.localStorage.jjrTel);
//	});

//	$(".company-tel").on("blur",function(){
//		var _this = $(this);
//		companyVal();
//		chkTel(_this,window.localStorage.companyTel);
//	});


	function chkTel(obj,val){
		console.log(val);
		var $obj = $(obj);
		if(!$obj.val() == ""){
			if(!regTel.test(val)){
				alert("你输入的手机号码不正确!");
				$obj.val("");
			}
		}
	}

	function chkMail(obj,val){
		var $obj = $(obj);
		if(!$obj.val() == ""){
			if(!regMail.test(val)){
				mui.alert("您输入的邮箱不正确!");
//				$obj.val("");
			}
		}
	}

	$(".h-mail").on("blur",function(){
		var _this = $(this);
		initVal();
		chkMail(_this,window.localStorage.jjrMail);
	});

	$(".company-mail").on("blur",function(){
		var _this = $(this);
		companyVal();
		chkMail(_this,window.localStorage.companyMail);
	});


	$(".company-cpsw").on("blur",function(){;
		companyVal();
		//alert(window.localStorage.jjrPsw + "|" + window.localStorage.jjrCpsw);
		if(window.localStorage.companyPsw != window.localStorage.companyCpsw){
			ChkTrue2 = false;
			alert("输入的密码不一致!");
		} else{
			ChkTrue2 = true;
		}
	});


	$(".h-cpsw").on("blur",function(){;
		initVal();
		//alert(window.localStorage.jjrPsw + "|" + window.localStorage.jjrCpsw);
		if(window.localStorage.jjrPsw != window.localStorage.jjrCpsw){
			ChkTrue = false;
			alert("输入的密码不一致!");
		} else{
			ChkTrue = true;
		}
	});


	$(".regjjr").on("click",function(){
		if($(this).hasClass("no")){
			return false;
		}

		if(window.localStorage.jjrTel && window.localStorage.jjrChk && window.localStorage.jjrPsw && window.localStorage.jjrCpsw && window.localStorage.jjrMail){
			if(ChkTrue){
				window.open("reg_jjr2.html");
			} else {
				alert("两次输入的密码不一致!");
			}
		} else {
			alert("请将信息填写完整!");
			return false;
		}
	});

	$("#huo-chk").on("click",function(){
		var _this = $(this);
		act(_this,".regjjr");
	});

	$("#company-chk").on("click",function(){
		var _this = $(this);
		act(_this,".regcompany");
	});

	function act(obj,aBtn){
		var $obj = $(obj);
		if($obj.attr("flag") == "false"){
			$obj.attr("flag","true");
		} else {
			$obj.attr("flag","false");
		}

		if($obj.attr("flag") == "true"){
			$(aBtn).removeClass("no");
		} else {
			$(aBtn).addClass("no");
		}
	}


//	//经纪人注册提交
//	$(".jjr-btn").on("click",function(){
//		var $nc = $(".jjr-nc").val();
//		var $name = $(".jjr-name").val();
//		var $mail = $(".jjr-mail").val();
//		var $intro = $(".txt_area").val();
//
//		if($nc != "" && $name != "" && $mail != ""){
//			// 输出填写的值
//			console.log($nc+"|"+$name+"|"+$mail+"|"+$intro+"|"+window.localStorage.jjrTel+"|"+window.localStorage.jjrChk+"|"+window.localStorage.jjrPsw+"|"+window.localStorage.jjrCpsw+"|"+window.localStorage.jjrMail);
//		} else{
//			alert("请将信息填写完整!");
//		}
//	});




	$(".regcompany").on("click",function(){
		if($(this).hasClass("no")){
			return false;
		}
		if(window.localStorage.companyTel && window.localStorage.companyChk && window.localStorage.companyPsw && window.localStorage.companyCpsw && window.localStorage.companyMail){
			if(ChkTrue2){
				window.open("reg_company2.html");
			} else {
				alert("两次输入的密码不一致!");
			}
		} else {
			alert("请将信息填写完整!");
			return false;
		}
	});


	//企业注册完成提交数据
	$(".company-com").on("click",function(){
		var $nc = $(".nc").val();
		var $name = $(".name").val();
		var $mail = $(".caddress").val();
		var $aSpan = $(".rowList").find("span");
		var $aList = "";
		for(var i=0; i<$aSpan.size(); i++){
			if($aSpan.eq(i).hasClass("active")){
				$aList += $aSpan.eq(i).html() + " ";
			}
		}

		if($nc != "" && $name != "" && $mail != "" && $aList != ""){
			// 输出填写的值
			console.log($nc+"|"+$name+"|"+$mail+"|"+$aList+"|"+window.localStorage.companyTel+"|"+window.localStorage.companyChk+"|"+window.localStorage.companyPsw+"|"+window.localStorage.companyCpsw+"|"+window.localStorage.companyMail);
		} else{
			alert("请将信息填写完整!");
		}
	});
});