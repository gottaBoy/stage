var isFlag = false;

var remix = {
	waitTime : 60,
	wTimer : null,
	jTime : 60,
	jTimer : null,
	cTime : 60,
	cTimer : null,
		
	json : {
		"name" : "",
		"sDate" : "",
		"eDate" : "",
		"address" : "",
		"city" : ""
	},

	works : {
		"name" : "",
		"price" : ""
	},

	//保存创建艺人的资料
	saveWorks : {
		"name" : "",
		"sex" : "",
		"brith" : "",
		"address" : "",
		"tel" : "",
		"email" : "",
		"height" : "",
		"weight" : "",
		"bust" : "",
		"waist" : "",
		"hipline" : "",
		"intro" : "",
		"role_0" : {
			"role" : "",
			"price" : ""
		},

		"role_1" : {
			"role" : "",
			"price" : ""
		},

		"role_2" : {
			"role" : "",
			"price" : ""
		},

		"role_3" : {
			"role" : "",
			"price" : ""
		},

		"role_4" : {
			"role" : "",
			"price" : ""
		}	
	},

	arr : [], 

	isTrueVal : "",

	init : function(){
		this._render();
	},

	_render : function(){
		var _this = this;
		$(".nextPage").on("click",function(){
			_this.isNull();
		});

		$(".add").on("click",function(){
			_this.showSet();
		});

		$(".close-btn").on("click",function(){
			_this.hideSet();
		});

		$(".save-btn").on("click",function(){
			_this.saveMessage();
		});

		$(".role-mess").on("click",function(){
			var currPage = this;
			$(".role-mess").attr("bClick","false");
			var spanContent = $(this).find("span").attr("added");
			if("true" === spanContent){
				var btnArray = ["重新编辑","删除","取消"];
				mui.confirm('', "请选择您对此角色的操作：", btnArray,
					function(e) {
						if (e.index == 0) {
							//display pop page;
							$(currPage).attr("bClick","true");
							$(document).scrollTop(0);
							_this.showSet(this);
						}else if(e.index ==1){
							$(currPage).html("<span>请添加角色..<span> <a href='javascript:void(0);'>+</a>");
						}
					});
				$(".mui-popup").css("position","fixed");	
			}else{
				//display pop page;
				$(document).scrollTop(0);
				_this.showSet(this);
			}
		});

		$(".publish").on("click",function(){
			_this.publish(this);
		});

//		$(".wt-btn").on("click",function(){
//			_this.entrust();
//		});

		$(".tel").on("blur",function(){
			_this.checkPhone(this);
		});

		$(".act-type span").on("click",function(){
			_this.typeSelcet(this);
		});

		$(".yz").on("click",function(){
			_this.recruited(this);
		});

		$(".refuse").on("click",function(){
			_this.refuse(this);
		});
		
		$(".closeTask").on("click",function(){
			_this.closeTask(this);
		});

		$(".close").on("click",function(){
			_this.confirmBox();
		});

		$(".list-type span").on("click",function(){
			_this.spanTab(this);
		});
		
		$(".menu-biz-home").on("tap", function(){
			_this.jumpByMenu('.menu-biz-home','h5IndexPage.htm');
		})
		
		$(".menu-biz-task").on("tap", function(){
			_this.jumpByMenu('.menu-biz-task','createH5BizTask.htm');
		})

		$(".menu-task").on("tap", function(){
			_this.jumpByMenu('.menu-task','createH5Task.htm');
		})
		
		$(".menu-profile").on("tap", function(){
			_this.jumpByMenu('.menu-profile','myProfile.htm');
		})
		
//		$(".create-com").on("click",function(){
//			_this.workAdd();
//		});
		
		$(".rowList").find("span").on("click",function(){
			_this.changeColorForBiz(this);
		}),

		$(document).on("click",".gz-pub",function(){
			var self = $(this);
			_this.setInter(self,remix.wTimer,remix.waitTime);
		});

		$(document).on("click",".jjr-pub",function(){
			var self = $(this);
			_this.setInter(self,remix.jTimer,remix.jTime);
		});


		$(document).on("click",".com-pub",function(){
			var self = $(this);
			
			//validation
			if($(".com-pub").hasClass('wait_gray')){
				return;
			}
			
			var phoneNo = $('.h-tel').val();
			var regTel = /^1[3|5|7|8|9]\d{9}$/; 
			
			if(!regTel.test(phoneNo)){
				mui.alert("请输入正确的手机号码，再获取验证码。");
				return;
			}
			
			mui.toast("处理中...");
			
			var param = {
				"phoneNo":phoneNo
			}
			
			$.ajax({
				url:"weih5/validCode.htm",
				type:'POST',
				dataType:'json',
				data: param,
				success: function(data){
					if(data == null){
						mui.alert("参数错误，请稍候再试。");
					}
					
					var result = data["result"];
					var message = data["message"];
					if(result == "error"){
						if(message != ""){
							mui.alert(message);
						}else{
							mui.alert("参数错误，请稍候再试。");
						}
					}else{
						mui.toast("验证码已发送。");
						_this.setInter(self,remix.cTimer,remix.cTime);
					}
				},
				error: function(data){
					mui.alert("网络错误，请稍候再试。");
				}
			});
		});
		
		$(document).on("click",".com-pub-retrieve",function(){
			var self = $(this);
			
			//validation
			if($(".com-pub").hasClass('wait_gray')){
				return;
			}
			
			var phoneNo = $('.h-tel').val();
			var regTel = /^1[3|5|7|8|9]\d{9}$/; 
			
			if(!regTel.test(phoneNo)){
				mui.alert("请输入正确的手机号码，再获取验证码。");
				return;
			}
			
			mui.toast("处理中...");
			
			var param = {
				"phoneNo":phoneNo
			}
			
			$.ajax({
				url:"weih5/validCodeRetrieve.htm",
				type:'POST',
				dataType:'json',
				data: param,
				success: function(data){
					if(data == null){
						mui.alert("参数错误，请稍候再试。");
					}
					
					var result = data["result"];
					var message = data["message"];
					if(result == "error"){
						if(message != ""){
							mui.alert(message);
						}else{
							mui.alert("参数错误，请稍候再试。");
						}
					}else{
						mui.toast("验证码已发送。");
						_this.setInter(self,remix.cTimer,remix.cTime);
					}
				},
				error: function(data){
					mui.alert("网络错误，请稍候再试。");
				}
			});
		});

		$(document).on("tap",".delete-btn",function(){
			var item = $(this);
			var btnArray = ["确定","取消"];
			mui.confirm('确定要删除此角色？', "", btnArray,
					function(e) {
						if (e.index == 0) {
							item.parent().parent().parent().parent().remove();
						}
					});
			$(".mui-popup").css("position","fixed");
		});

		$(document).on("click",".yuyue",function(){
			$(".task-role").show();
			$(".mask").show();
		});

		$(document).on("tap",".list-radio p",function(){
			var $em = $(this).find("em").eq(0);
			var $parent = $(this).parent();
			var $len = $parent.find("p").size();
			for(var i=0; i<$len; i++){
				$parent.find("p").eq(i).find("em").eq(0).removeClass("radio-act");
			}
			if($em.hasClass("radio-act")){
				$em.removeClass("radio-act");
			}else{
				$em.addClass("radio-act");
			}
		});
		
		_this.getValue();
		_this.getTimer();
		_this.disable();
		_this.isTrue();
		_this.checkNumber();
		_this.initImgList();
	},
	
	setInter : function(self,timer,wtime){
		var _this = this;
		if(self.attr("data-flag") == 'true'){
			_this.timerTab(self,timer,wtime);
			self.attr("data-flag","false");
			self.addClass("wait_gray");
			timer = setInterval(function(){
				wtime--;
				_this.timerTab(self,timer,wtime);
			},1000);
		}
	},

	timerTab : function(self,timer,wtime){
		if(wtime > 0){
			self.text('等待'+wtime+'秒');
		} else{
			self.text('发送验证码').removeClass("wait_gray");
			self.attr("data-flag","true");
			clearInterval(timer);
		}
	},

	initImgList : function(){
		$(".h-img-list").css("height",$(".h-img-list").width());
	},
	
//	workAdd : function(){
//		var _this = this;
//		var $name = $(".cname").val();
//		var $sex = $(".csex").text();
//		var $brith = $(".cbrith").text();
//		var $tel = $(".ctel").val();
//		var $email = $(".cmail").val();
//		var videoList = [];
//		
//		if($name == "" || $sex == "" || $brith == "" || $tel == "" || $email == ""){
//			alert("*为必填项!");
//			return false;
//		}
//
//		_this.saveWorks['name'] = $name;
//		_this.saveWorks['sex'] = $sex;
//		_this.saveWorks['brith'] = $brith;
//		_this.saveWorks['address'] = $(".caddress").text();
//		_this.saveWorks['tel'] = $tel;
//		_this.saveWorks['email'] = $email;
//		_this.saveWorks['height'] = $(".cheight").val();
//		_this.saveWorks['weight'] = $(".cweight").val();
//		_this.saveWorks['bust'] = $(".cbust").val();
//		_this.saveWorks['waist'] = $(".cwaist").val();
//		_this.saveWorks['hipline'] = $(".chipline").val();
//		_this.saveWorks['intro'] = $(".cintro").val();
//		var $len = $(".rle-A").size();
//		for(var i = 0; i < $len; i++){
//			if(!$(".rle-A").eq(i).find("div")){
////				_this.saveWorks["role_"+i+""]['role'] = "";
////				_this.saveWorks["role_"+i+""]['price'] = "";
//				
//				var emptyRole = {
//					role : "",
//					price : ""
//				};
//				_this.saveWorks["role_" + i + ""] = JSON.stringify(emptyRole);
//			}
//			
//			var curRole = {
//				role : $(".rle-A").eq(i).find("div").find("span").eq(0).html(),
//				price : $(".rle-A").eq(i).find("div").find("span").eq(1).html()
//			}; 
//			_this.saveWorks["role_"+i+""] = JSON.stringify(curRole);
//			
////			_this.saveWorks["role_"+i+""]['role'] = $(".rle-A").eq(i).find("div").find("span").eq(0).html();
////			_this.saveWorks["role_"+i+""]['price'] = $(".rle-A").eq(i).find("div").find("span").eq(1).html();
//		}
//		
//		var $vdfinda = $(".videoListAdd").find("a");
//		for(var i=0; i<$vdfinda.size(); i++){
//			var $vTitle = $vdfinda.eq(i).find("i").eq(0);
//			var $vAddress = $vdfinda.eq(i).find("i").eq(1);
//			videoList.push({"videoTitle":$vTitle,"videoLink":$vAddress});
//		}
//		
//		//videoList存放的是上传视频的标题和地址
//		console.log(videoList);
//
//		//console.log(_this.saveWorks["role_0"]['role'] + " | "+_this.saveWorks["role_0"]['price']);
//		
//		var image = $("#uploadedImg").data("image");
//		
//		_this.saveWorks["proImg"] = image;
//		
//		$.ajax({
//			url:"weih5/saveOrUpdateArtist.htm",
//			type:'POST',
//			dataType:'json',
//			data: _this.saveWorks,
//			success:function(data){
//				console.info("success post 200=====");
//				console.info(data);	
//				var result = data["result"];
//				var message = data["message"];
//				console.info(result);
//				console.info(message);
//			}
//		});
//		
//	},

	spanTab : function(obj){
		var $obj = $(obj);
		$(".list-type span").removeClass("active");
		$obj.addClass("active");
	},
	

	jumpByMenu : function(currMenuClass, url) {
		
		var currMenu = $(currMenuClass);
		if (currMenu.hasClass('mui-active')) {
			var btnArray = [ '刷新本页', '取消' ];
			mui.confirm('注：本页面中未保存的数据将丢失。', '是否要刷新？', btnArray,
					function(e) {
						if (e.index == 0) {
							window.location.href = url;
						}
					});
			$(".mui-popup").css("position","fixed");

		} else if (currMenu.hasClass('jump-alert')) {

			var btnArray = [ '确定跳转', '取消' ];
			mui.confirm('注：本页面中未保存的数据将丢失。', '是否要继续跳转？', btnArray,
					function(e) {
						if (e.index == 0) {
							window.location.href = url;
						}else{
							currMenu.removeClass('mui-active');
						}
					});
			$(".mui-popup").css("position","fixed");
		} else {
			window.location.href = url;
		}
	},

	isTrue : function(){
		$(".confirm-btn").on("click",function(){
			if($(this).html() == "确定"){
				$(".mask").hide();
				$(".comfirm").hide();
				return isTrueVal = true;
			} else {
				$(".mask").hide();
				$(".comfirm").hide();
				return isTrueVal = false;
			}
		});
	},

	checkNumber : function(){
		var _this = this;
		$(".perNum").on("blur",function(){
			_this.checkNum(this);
		});

		$(".yen").on("blur",function(){
			_this.checkNum(this);
		});

		$(".activeNumber").on("blur",function(){
			_this.checkNum(this);
		});
	},

	checkNum : function(obj){
		var $obj = $(obj);
		if($obj.val() != ""){

			if($obj.val() <= 0){
				alert("不能输入小于或为0的数");
				$obj.val("");
			}

		}
	},

	confirmBox : function(){
		$(".mask").show();
		$(".comfirm").show();
	},

	recruited : function(obj){
		var $obj = $(obj);
		var taskId = $obj.attr("data-task-id");
		var roleId = $obj.attr("data-role-id");
		var _this = this;
		
		if ($obj.hasClass('disable')) {
			return;
		}
		
		//check role and get artist list for biz and bro
		var artistList = null;
		var checkParam = {
			"taskId":taskId
		};
		$.ajax({
			url:"weih5/checkRoleForInvite.htm",
			type:'POST',
			dataType:'json',
			data:checkParam,
			success: function(data){
				if (data == null) {
					mui.alert("通信错误，请稍候再试。");
				}
				var result = data["result"];
				var message = data["message"];
				var list = data["data"];
				
				if(result == "error"){
					if( message != "" ){
						
						if("needlogin"==message){
							var btnArray = ['登录','取消'];
							mui.confirm('点击“登录”按钮，跳转到登录页面','请先登录', btnArray, function(e){
								if(e.index == 0){
									window.location.href="h5login.htm";
								}
							});
							$(".mui-popup").css("position","fixed");
						}else{
							mui.alert(message);
						}
					} else {
						mui.alert("参数错误，请稍候再试。");
					}
				}else{
					// su action
					artistList = list;
					if(artistList == null || artistList.length == 0){
						// apply as a user;
						_this.doApply($obj, 0, taskId, roleId, null);
					}else{
						// apply as a biz／bro: list all artists;
						var artistListHtml = "";
						$.each(artistList, function(index, artist){
							if(artist.applied){
								var artistListItem = "<div class='mui-input-row mui-checkbox' style='text-align: left; color:#888888'><label>"+artist.name+"</label><span style='position:absolute; top:10px; width: 50px; right: 20px; display:inline-block;'>已应征</span></div>";
							}else{
								var artistListItem = "<div class='mui-input-row mui-checkbox' style='text-align: left; color:#888888'><label>"+artist.name+"</label><input name='checkbox' class='artistItem4Task' value='"+artist.id+"' type='checkbox'></div>";
							}
							artistListHtml = artistListHtml + artistListItem;
						})	

						var btnArray = ['发送邀请','取消'];
						mui.confirm(artistListHtml,'请选择通告的角色', btnArray, function(e){
							if(e.index == 0){
								var artistItems = [];
								$('.artistItem4Task:checkbox:checked').each(function(){
									var artistItem = $(this).val()
									artistItems.push(artistItem);
								});

								if(artistItems.length == 0){
									mui.alert('请最少选择1个艺人来应征','参数错误');
									return;
								}

								_this.doApply($obj, 1, taskId, roleId, artistItems);
							}
						});
						$(".mui-popup").css("position","fixed");
						
					}
				}
			},
			error: function(data){
				mui.alert('请稍后再试。','参数错误');
				$(".mui-popup").css("position","fixed");
			}
		});		
	},
	
	doApply: function(obj, sign, taskId, roleId, artistItems){
		
		var $obj = $(obj);

		if (0 == sign) {
			// apply as common user role
			
			var btnArray = ['确定应征', '取消'];
			mui.confirm('确定应征此角色？<br>您的联系方式将会发送给对方。','',btnArray, function(e){
				if(e.index == 0){
					var param = {
							"taskId" : taskId,
							"roleId" : roleId
						};
					// lock
					$obj.off("click");
					$obj.html("应征中...");
					mui.toast("正在处理应征请求...");
					
					$.ajax({
						url:"weih5/applyTask.htm",
						type:'POST',
						dataType:'json',
						data: param,
						success:function(data){
							var result = data["result"];
							var message = data["message"];
							
							if(result == "error"){
								// error action
								
								if( message != "" ){
									mui.alert(message);
								} else {
									mui.alert("参数错误，请稍候再试。");
								}
								
								// unlock
								$obj.html("应征");
								$obj.on("click",function(){
									_this.recruited(this);
								});
								
							} else {
								// success action
								mui.alert('您的联系方式已发送到通告发布人，请等待TA与你联系。','应征成功',function(){
									$obj.html("等待");
									$obj.addClass('disable');
								})
							}
						}
					});
				}
			});
		} else {
			// apply as a biz/bro, so apply with artistList
			
			var param = {
					"taskId" : taskId,
					"roleId" : roleId,
					"artistItems" : JSON.stringify(artistItems)
				};
			// lock
			$obj.off("click");
			$obj.html("应征中...");
			mui.toast("正在处理应征请求...");
			
			$.ajax({
				url:"weih5/applyTask.htm",
				type:'POST',
				dataType:'json',
				data: param,
				success:function(data){
					var result = data["result"];
					var message = data["message"];
					
					if(result == "error"){
						// error action
						
						if( message != "" ){
							mui.alert(message);
						} else {
							mui.alert("参数错误，请稍候再试。");
						}
						
						// unlock
						$obj.html("应征");
						$obj.on("click",function(){
							_this.recruited(this);
						});
						
					} else {
						// success action
						mui.alert('您的请求已发送到通告发布人，请等待TA与你联系。','应征成功',function(){
							$obj.html("等待");
							$obj.addClass('disable');
						})
					}
				}
			});
		}
	},

	refuse : function(obj){
		
		var $obj = $(obj);
		var _this = this;
		
		var taskId = $obj.attr("data-task-id");
		var roleId = $obj.attr("data-role-id");
		var userId = $obj.attr("data-user-id");
		
		var btnArray = [ '确定拒绝', '取消' ];
		mui.confirm('确定要拒绝TA吗？', '', btnArray, function(e) {
			if (e.index == 0) {
				
				// get param
				
				// lock
				$obj.off("click");
				$obj.html("处理中");
				mui.toast("处理中...");

				var param = {
					"userId" : userId,
					"roleId" : roleId,
					"taskId" : taskId
				};
				$.ajax({
					url:"weih5/refuseApplicantInTask.htm",
					type:'POST',
					dataType:'json',
					data: param,
					success:function(data){
						var result = data["result"];
						var message = data["message"];
						
						if(result == "error"){
							// error action

							if (message = "") {
								mui.alert(message);
							} else {
								mui.toast("参数错误，请稍候再试.");
							}
							$(".mui-popup").css("position","fixed");
							
							// add click event
							$(obj).on("click",function(){
								_this.refuse;
							});
							$obj.html("拒绝");
							
						}else{
							// success action
							$obj.html("已拒绝");
							mui.toast("已拒绝。");
						}
					},
					error:function(data){
						mui.toast("网络连接错误，请稍候再试.");
						$(".mui-popup").css("position","fixed");
						// add click event
						$(obj).on("click",function(){
							_this.refuse;
						});
						$obj.html("拒绝");
					}
				});
				$obj.css("background-color","lightgray");
			} else {
			}
		});
//		$obj = $(".mui-popup");
//		$obj.css("position","fixed");
		$(".mui-popup").css("position","fixed");
	},

	closeTask : function(obj){
		
		var $obj = $(obj);
		var _this = this;
		var taskId = $obj.attr("data-task-id");
		
		var btnArray = ['确定关闭', '取消'];
		mui.confirm('通告关闭后将无法恢复，确定关闭此通告？', '', btnArray, function(e) {
			if (e.index == 0) {

				$obj.css("background-color", "lightgray");
				$obj.off("click");

				var param = {
					"taskId" : taskId
				};
				$.ajax({
					url : "weih5/updateTaskStatus.htm",
					type : 'POST',
					dataType : 'json',
					data : param,
					success : function(data) {
						var result = data["result"];
						var message = data["message"];
						if (result == "error") {
							// error action
							if (message != "") {
								mui.alert(message);
							} else {
								mui.alert("参数错误，请稍候再试.");
							}
							$(".mui-popup").css("position", "fixed");

							// add click event
							$obj.on('click', function() {
								_this.closeTask(this);
							});
							$obj.css("background-color", "#f63");

						} else {
							// success action
							mui.toast("该通告已关闭");
							// fixme disable 拒绝
						}
					},
					error : function(data) {
						mui.alert("参数错误，请稍候再试.");
						// add click event
						$obj.on('click', function() {
							_this.closeTask(this);
						});
						$obj.css("background-color", "#f63");
					}
				});
			} else {
			}
		});
//		 $obj = $(".mui-popup");
//		 $obj.css("position","fixed");
		$(".mui-popup").css("position","fixed");
	},
	
	typeSelcet : function(obj){
		var $obj = $(obj);
		$(".act-type span").removeClass("active");
		$obj.addClass("active");
	},

	rnd : function(n,m){
		return parseInt(Math.random()*(m-n)+n);
	},

	disable : function(){
		var $oDisable = $(".refuse");
		for(var i = 0; i < $oDisable.size(); i++){
			if($oDisable.eq(i).hasClass("disable")){
				$oDisable.eq(i).off("click");
			}
		}
	},

	isNull : function(){
		
		var _this = this;
		var $val1 = $("#x-name").val();
		var $val2 = $("#s-date").text();
		var $val3 = $("#e-date").text();
		var $val4 = $("#x-address").val();
		var $val5 = $("#showCityPicker3").text();
//		var $val6 = $("#e-date2").text();

		if($val2 == null || $val2 == "" || $val3 == null || $val3 == ""){
			mui.alert("参数错误。请选择通告时间和应征时间。");
			return;
		}
		
		var taskDateStr = $val2.replace("-","/") + ":00";
		var taskDate = new Date(taskDateStr);
		
		var applyStr = $val3.replace("-","/") + ":00";
		var applyDate = new Date(applyStr);
		
//		var endStr = $val6.replace("-","/") + ":00";
//		var endDate = new Date(endStr);
		
		if(taskDate == null || applyDate == null){
			mui.alert("参数错误。时间格式不正确。");
			return;
		}
		
//		if(startDate >= endDate){
//			mui.alert("应征开始时间应早于结束时间。");
//		}
		
		if(applyDate > taskDate){
			mui.alert("应征时间应早于通告时间。");
			return;
		}
		
		if($val1 != "" && $val2 != "" && $val3 != "" && $val4 != ""){
			localStorage.aname = $val1;
			localStorage.sDate = $val2;
			localStorage.eDate = $val3;
			localStorage.address = $val4;
			localStorage.city = $val5;
//			localStorage.yzDate = $val6;
			window.location.href="createH5TaskStep2.htm";
		} else {
			mui.alert("*为必填项！");
			return;
		}
	},

	addSpan : function(obj){
		var $obj = $(obj);
		$obj.attr("bClick","true");
		var _this = this;
		for(var i = 0; i < role.length; i++){
			var $val = role[i]["role"];
			var $span = $("<span>");
			$span.html($val);	
			$(".t1").append($span);
		}

		!isFlag && actioned(_this); 

		function actioned (th) {
			isFlag = true;
			var _this = th;
//			$(document).on("click", ".t1 span",function(){
			$(document).on("touchstart",".t1 span",function(){
				_this.changeColor(this);
			});

			$(".create-btn").on("click",function($obj){
				var $size = $(".role-a").find("span").size();
				var temporary = "";
				for(var i = 0; i < $size; i++){
					if($(".role-a").find("span").eq(i).hasClass("active")){
						temporary = $(".role-a").find("span").eq(i).html();
						if(temporary == "其他"){
							if($(".ourset").val() == ""){
								alert("请填写自定义项!");
								return false;
							} else {
								_this.works['name'] = $(".ourset").val();
							}
						} else {
							if($(".ourset").val() != ""){
								_this.works['name'] = $(".ourset").val();
							} else {
								_this.works['name'] = temporary;
							}
						}
					} else{
						if($(".ourset").val() != ""){
							_this.works['name'] = $(".ourset").val();
						}
					} 
				}

				_this.works['price'] = $(".yen").val() + '元/' +$(".ptype").val();
				//console.log(_this.works['name'] + " | " + _this.works['price']);
				var $html = '<div><span added=true>'+_this.works['name']+'</span> <span>'+_this.works['price']+'</span></div>';
				
				var $len = $(".role-mess").size();
				for(var j = 0; j < $len; j++){
					if($(".role-mess").eq(j).attr("bClick") == "true"){
						if(($(".yen").val()!="" && $(".ptype").val() !="") && ($(".ourset").val() != "" ||  _this.works['name']!="")){
							$(".role-mess").eq(j).html($html);
						}else{
							alert("信息填写不完整");
							return false;
						}
					}
				}

				_this.hideSet();
			});
		}
	},

	showSet : function(obj){
		var $obj = $(obj);
		var _this = this;
		$(".mask").show();
		$(".popbox").show();
		$(".t1").html("");

		_this.addSpan($obj);
	},

	hideSet : function(){
		$(".mask").hide();
		$(".popbox").hide();
		$(".t2").hide();
		$(".t3").hide();
	},

	changeColor : function(obj){
		
		//clean t3 level categories
		$(".t3").html("");
		
		var _this = this;
		var $obj = $(obj);
		$(".t1 span").removeClass("active");
		$(".t1 span").addClass("unselected");
		$obj.removeClass("unselected");
		$obj.addClass("active");
		$(".t2").show();
		$(".t2").html("");
		for(var i = 0; i < role.length; i++){
			if(role[i]["role"] == $obj.html()){
				for(var k in role[i]["rList"]){
					var $val = k;
					var $span = $("<span>");
					$span.html($val);	
					$(".t2").append($span);
				}
			}
		}
		
		_this.isSelect();

		$(".t2 span").on("click",function(){
			_this.t3Hide(this);
		});
	},
	

	changeColorForBiz : function(obj) {
		
		var $obj = $(obj);
		if ($obj.hasClass("active")) {
			$obj.removeClass("active");
		} else {
			$obj.addClass("active");
		}
	},

	isSelect : function(){
		var $spanSelect = $(".role-a").find("span");
		for(var i = 0; i < $spanSelect.size(); i++){
			if($spanSelect.eq(i).hasClass("active")){
				if($spanSelect.eq(i).html() == "其他"){
					// show
					$(".otherRoleInput").show();
					$(".ourset").attr("disabled",false);
				}
			} else {
				// hide
				$(".otherRoleInput").hide();
				$(".ourset").attr("disabled",true);
				$(".ourset").val("");
			}
		}
	},

	t3Hide : function(obj){
		var _this = this;
		var $obj = $(obj);
		$(".t2 span").removeClass("active");
		$(".t2 span").addClass("unselected");
		$obj.removeClass("unselected");
		$obj.addClass("active");
		$(".t3").show();
		$(".t3").html("");
		for(var i = 0; i < role.length; i++){
			for(var k in role[i]["rList"]){
				if($obj.html() == k){
					for(var x = 0; x < role[i]["rList"][k].length; x++){
						var $val = role[i]["rList"][k][x];
						var $span = $("<span>");
						$span.html($val);	
						$(".t3").append($span);
					}
				}
			}
		}
		
		_this.isSelect();

		$(".t3 span").on("click",function(){
			$(".t3 span").removeClass("active");
			$(".t3 span").addClass("unselected");
			$(this).removeClass("unselected");
			$(this).addClass("active");
			_this.isSelect();
		});
	},

	saveMessage : function(){
		var _this = this;
		var $span = $(".role-a div span");
		var $ourTxt = "";

		// console.log($ourTxt);
		var $aTxt = $(".ourset").val();
		$aTxt = $aTxt.replace(/(^\s*)/g, "");
		var $roleVal1;

		// if($ourTxt == "其他"){
		// 	//console.log($ourTxt);
		// 	if($aTxt == ""){
		// 		alert("请填写自定义项！");
		// 		return false;
		// 	}
		// } else {
		// 	if($aTxt == ""){
		// 		$roleVal1 = $ourTxt;
		// 	} else {
		// 		$roleVal1 = $aTxt;
		// 	}
		// }

		var $s1 = $(".t1").find("span");
		var $s2 = $(".t2").find("span");
		var $s3 = $(".t3").find("span");
		var $role_TXT1 = "";
		var $role_TXT2 = "";
		var $role_TXT3 = "";
		var $bFlag = $v1 = $v2 = $v3 = false;

		for(var i = 0; i < $s1.size(); i++){
			if($s1.eq(i).hasClass("active")){
				$v1 = true;
				$role_TXT1 = $s1.eq(i).html();
			}
		}
		for(var i = 0; i < $s2.size(); i++){
			if($s2.eq(i).hasClass("active")){
				$v2 = true;
				$role_TXT2 = $s2.eq(i).html();
			}
		}
		
		if($s3.size() == 0){
			$v3 = true;
		}else{
			for(var i = 0; i < $s3.size(); i++){
				if($s3.eq(i).hasClass("active")){
					$v3 = true;
					$role_TXT3 = $s3.eq(i).html();
				}
			}
		}
		
		if($v1 && $v2 && $v3){
			$bFlag = true;
		}
		
		if($aTxt == ""){
			$ourTxt = $role_TXT1 + " " + $role_TXT2 + " " + $role_TXT3;
			$roleVal1 = $ourTxt;
		} else {
			if($role_TXT2 == "其它"){
				$ourTxt = $role_TXT1 + " " + $aTxt;
			} else {
				$ourTxt = $role_TXT1 + " " + $role_TXT2 + " " + $aTxt;
			}

			$roleVal1 = $ourTxt;
		}

		var $roleVal2 = $("#showUserPicker").text();
		var $roleVal3 = $(".perNum").val();
		var $roleVal4 = $(".yen").val();
		var $roleVal5 = $(".bz-1").val();

		if($roleVal3 != "" && $roleVal4 != "" && $bFlag){
//			var html = '<table width="100%" id="tab'+_this.rnd(1,100)+_this.rnd(1,500000)+'" cellpadding="0" cellspacing="0" border="0"><tr><td width="20%" align="right">角色：</td><td width="30%" class="r1">'+$roleVal1+'</td><td width="20%" align="right">性别：</td><td width="30%" class="r2">'+$roleVal2+'</td></tr><tr><td width="15%" align="right">人数：</td><td width="35%" class="r3">'+$roleVal3+'</td><td width="20%" align="right">预算：</td><td width="30%" class="r4">'+$roleVal3*parseFloat($roleVal4)+'</td></tr><tr><td width="15%" align="right" valign="top">备注：</td><td width="85%" colspan="3" class="pr20 mar0 r5">'+$roleVal5+'</td></tr></table>';
			
			if($aTxt == ""){
				//var html = '<table width="100%" id="tab'+_this.rnd(1,100)+_this.rnd(1,500000)+'" cellpadding="0" cellspacing="0" border="0"><tr><td width="20%" align="right">角色：</td><td width="30%" class="r1" roleName=true roleDesc=false>'+$roleVal1+'</td><td width="20%" align="right">性别：</td><td width="30%" class="r2">'+$roleVal2+'</td></tr><tr><td width="15%" align="right">人数：</td><td width="35%" class="r3">'+$roleVal3+'</td><td width="20%" align="right">预算：</td><td width="30%" class="r4">'+$roleVal3*parseFloat($roleVal4)+'</td></tr><tr><td width="26%" align="right" valign="top">角色要求：</td><td width="85%" colspan="3" class="pr20 mar0 r5">'+$roleVal5+'</td></tr></table>';
				var html = '<table width="100%" id="tab'+_this.rnd(1,100)+_this.rnd(1,500000)+'" cellpadding="0" cellspacing="0" border="0"><tr><td width="20%" align="right">角色：</td><td width="30%" class="r1" roleName=true roleDesc=false>'+$roleVal1+'</td><td width="20%" align="right">性别：</td><td width="30%" class="r2">'+$roleVal2+'</td></tr><tr><td width="15%" align="right">人数：</td><td width="35%" class="r3">'+$roleVal3+'</td><td width="20%" align="right">预算：</td><td width="30%" class="r4">'+$roleVal3*parseFloat($roleVal4)+'</td></tr><tr><td width="26%" align="right" valign="top">角色要求：</td><td width="85%" colspan="3" class="pr20 mar0 r5">'+$roleVal5+'</td></tr><tr><td><span class="mui-icon mui-icon-trash delete-btn"></span></td></tr></table>';
			} else {
				//var html = '<table width="100%" id="tab'+_this.rnd(1,100)+_this.rnd(1,500000)+'" cellpadding="0" cellspacing="0" border="0"><tr><td width="20%" align="right">角色：</td><td width="30%" class="r1" roleName=false roleDesc=true>'+$roleVal1+'</td><td width="20%" align="right">性别：</td><td width="30%" class="r2">'+$roleVal2+'</td></tr><tr><td width="15%" align="right">人数：</td><td width="35%" class="r3">'+$roleVal3+'</td><td width="20%" align="right">预算：</td><td width="30%" class="r4">'+$roleVal3*parseFloat($roleVal4)+'</td></tr><tr><td width="26%" align="right" valign="top">角色要求：</td><td width="85%" colspan="3" class="pr20 mar0 r5">'+$roleVal5+'</td></tr></table>';
				var html = '<table width="100%" id="tab'+_this.rnd(1,100)+_this.rnd(1,500000)+'" cellpadding="0" cellspacing="0" border="0"><tr><td width="20%" align="right">角色：</td><td width="30%" class="r1" roleName=false roleDesc=true>'+$roleVal1+'</td><td width="20%" align="right">性别：</td><td width="30%" class="r2">'+$roleVal2+'</td></tr><tr><td width="15%" align="right">人数：</td><td width="35%" class="r3">'+$roleVal3+'</td><td width="20%" align="right">预算：</td><td width="30%" class="r4">'+$roleVal3*parseFloat($roleVal4)+'</td></tr><tr><td width="26%" align="right" valign="top">角色要求：</td><td width="85%" colspan="3" class="pr20 mar0 r5">'+$roleVal5+'</td></tr><tr><td><span class="mui-icon mui-icon-trash delete-btn"></span></td></tr></table>';
			}
			
			$(".role").append(html);
			_this.hideSet();
		} else {
			if($bFlag){
				mui.alert("请填写 人数 和 预算","请继续补充");
			} else {
				mui.alert("请继续选择角色的子分类","请继续补充");
			}
			$(".mui-popup").css("position", "fixed");
		}
	},

	publish : function(obj){
		
		var totleMemo = $("#totleMemo").val();
		var _this = this;
		var $tab = $(".role").find("table");
		for(var i = 0; i < $tab.size(); i++){
			_this.arr.push({
				"id" : $tab.eq(i).attr("id"),
				"role" : $tab.eq(i).find(".r1").html(),
				"sex" : $tab.eq(i).find(".r2").html(),
				"perNum" : $tab.eq(i).find(".r3").html(),
				"total" : $tab.eq(i).find(".r4").html(),
				"bz" : $tab.eq(i).find(".r5").html()
			});
		}
//		console.log(_this.arr); //返回值第2步
//		console.log(localStorage.aname + ","+localStorage.sDate+","+localStorage.eDate+","+localStorage.address + ","+localStorage.city + ","+ localStorage.yzDate);//返回值第1步
		
//		console.info("------------");
//		console.info("localStorage.aname: " + localStorage.aname);
//		console.info("localStorage.sDate: " + localStorage.sDate);
//		console.info("localStorage.eDate: " + localStorage.eDate);
//		console.info("localStorage.yzDate: " + localStorage.yzDate);
//		console.info("localStorage.address: " + localStorage.address);
//		console.info("localStorage.city: " + localStorage.city);
//		console.info("roleList:");
//		console.info(_this.arr);
		
		// memo field?
		
		/**
		 * validate param
		 */
		
		/**
		 * ajax query
		 */
		var savingTask = {
				"title":localStorage.aname,
				"startDate":localStorage.sDate,
				"applyStartDate":localStorage.eDate,
//				"applyEndDate":localStorage.yzDate,
				"provinceCity":localStorage.city,
				"place":localStorage.address,
				"content":totleMemo,
				"roleList":JSON.stringify(_this.arr)
		}

		// lock publish btn
		var $obj = $(obj);
		$obj.off("click");
		$obj.html("发布中...");
		mui.toast("正在发布通告...");
		
		$.ajax({
			url:"weih5/saveOrUpdateTask.htm",
			type:'POST',
			dataType:'json',
			data: savingTask,
			success:function(data){
				var result = data["result"];
				var message = data["message"];
				
				if (result == "error") {
					// error action
					
					if (message != "") {
						mui.alert(message);
					} else {
						mui.alert("参数错误");
					}
					
					// add click event back again, rename btn to normal
					$(".publish").on("click",function(){
						_this.publish(this);
					});
					$obj.html("发布");
					
				} else {
					// success action
					mui.alert('管理员正在审核','发布成功',function(){
						window.location.href="myTaskList.htm";// go to myTaskList page;
					});
				}
			}
		});
	},

	checkPhone : function(obj){
		var $obj = $(obj);
		if($obj.val() != ""){

			if (!/^1[3578][0-9]{9}$/.test($obj.val())) {
	            alert("请输入正确的手机号码！");
	            $obj.val(""); 
	        }

		}
	},

	getValue : function(){
		setInterval(function(){
			 $("#s-date").val($("#date-x1").val());
			 $("#e-date").val($("#date-x2").val());
		},30);
	},

	getTimer : function(){
		setInterval(function(){
			$(".activeTime").val($(".time-x").val());
		},30);
	},
	
};

var effects = {
		artUlHeight : $("#artistList").find("ul").eq(0).outerHeight(),
		artFlag : false,		
		init : function(){
			this.render();
		},
		render : function(){
			var _this = this;

			$(".telescopic").on("click",function(){
				_this.telescopic();
			});

			$(".vlAdd").on("click",function(){
				_this.addVideoList();
			});
			
			$(".circle_open").on("click",function(){
				_this.openClose($(this));
			});

			_this.bgAutoHeight();
		},

		telescopic : function(){
			var $aLi = $("#artistList").find("li").eq(0).outerHeight();
			if(effects.artFlag){
				//$(".telescopic").html("...");
				$(".telescopic").html("显示更多");
				$(".list_outer").animate({height:$aLi*3});
				effects.artFlag = false;
			} else {
				$(".telescopic").html("⌃");
				$(".list_outer").animate({height:effects.artUlHeight});
				effects.artFlag = true;
			}
		},

		bgAutoHeight : function(){
			var $imgWidth = $(".art-tab-img").width();
			$(".art-tab-img").css("height",$imgWidth*0.66);
		},

		addVideoList : function(){
			var _this = this;
			var btnArray = ['添加', '取消'];
			mui.confirm("<section><input type='text' class='mui-input-clear mui-input videoTitle' placeholder='请输入视频标题'></div><div class='mui-input-row'><input type='text' class='mui-input-clear mui-input videoAddress' placeholder='请输以http://开始的完整地址'></section>",
					"添加视频",
					btnArray,
					function(e){
						if(e.index == 0){
							var $vtitle = $(".videoTitle").val();
							var $vAddress = $(".videoAddress").val();
							var $contentHtml = $(".videoListAdd").html();
							if($vtitle!="" && $vAddress!=""){
								$contentHtml += '<a href="javascript:void(0);"><em class="mui-icon mui-icon-videocam"></em><span><i>'+$vtitle+'</i><i>'+$vAddress+'</i></span><div></div></a>';
								$(".videoListAdd").html($contentHtml);
								$(".videoAddress").val("");
								$(".videoTitle").val("");
							} else{
								mui.alert("视频标题或视频地址不完整，请重新填写。","添加失败");
								$(".mui-popup").css("position", "fixed");
							}
						}
					});
			$(".mui-popup").css("position", "fixed");
		},
		
		openClose : function(obj){
			if(obj.html() == "+"){
				$(".wt-1").animate({right:100,bottom:20},{duration:200});
				$(".wt-2").animate({right:75,bottom:75},{duration:200});
				$(".wt-3").animate({right:18,bottom:100},{duration:200});
				obj.html("-");
			} else {
				$(".wt-3").animate({right:20,bottom:30},{duration:200,complete:function(){
					$(".wt-2").animate({right:20,bottom:30},{duration:200,complete:function(){
						$(".wt-1").animate({right:20,bottom:30},{duration:200});
					}});
				}});
				obj.html("+");
			}
		}
	};

effects.init();
remix.init();