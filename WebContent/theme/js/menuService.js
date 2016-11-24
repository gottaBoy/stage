var keyGoods = [];
var dyncSearchToolkit = {
	dyncSearchDiv:null,
	currentFocuIndex:-1,
	currentResultArray:null,
	currentInputEL:null,
	hiddenValueObj:null,
	divWidth:"140px",
	initial:function(divname, divwidth){
		this.dyncSearchDiv = document.createElement("div"); //创建层   
		this.dyncSearchDiv.id = divname; 
		this.initialParam = "";
		this.url = "";
		document.body.appendChild(this.dyncSearchDiv);
		this.dyncSearchDiv.style.position = "absolute";
		this.dyncSearchDiv.style.border = "solid 1px #000000";
		//this.dyncSearchDiv.style.fontWeight="bold";
		this.dyncSearchDiv.style.backgroundColor = "#FFFFFF";
		if(divwidth != undefined)
			this.dyncSearchDiv.style.width = divwidth; //绝对宽度
		else
			this.dyncSearchDiv.style.width = "140px"; //绝对宽度
		$(this.dyncSearchDiv).hide();
	},
	isValid:function(){
		return ($(this.dyncSearchDiv).html())!="";
	},
	focuItem:function(index){
		this.currentFocuIndex = index;
		var tr_el = $(this.dyncSearchDiv).find("table").find(".search_record_hot_line");
		if(tr_el){
			tr_el.removeClass("search_record_hot_line");
		}
		$(this.dyncSearchDiv).find("table").find("tr:eq("+ index +")").addClass("search_record_hot_line");	
	},
	cleanToolkit:function(){
		$(this.dyncSearchDiv).empty();
		$(this.dyncSearchDiv).hide();
		this.currentFocuIndex = -1;
		this.currentResultArray = null;

	},

	setSelectLine:function(){
		$(this.currentInputEL).val(this.currentResultArray[this.currentFocuIndex].label);
		$(this.hiddenValueObj).val(this.currentResultArray[this.currentFocuIndex].id);
		if(this.currentResultArray[this.currentFocuIndex].wordsId != null) {
			var thisId = $(this.currentInputEL).attr("id");
			var id = thisId.substring(thisId.lastIndexOf("_")+1, thisId.length);
			document.getElementById("wordsId"+id).value = record.wordsId;
		}
		$(this.currentInputEL).focus();
	},

	setSelectLineWithClean:function(){
		var record = this.currentResultArray[this.currentFocuIndex];
		/*if(isGoodsNumber(record)){
			this.cleanToolkit();
			alertDialog("提示", "该产品已经选择过,不能重复选择");
			return;
		}*/
		
		$(this.currentInputEL).val(this.currentResultArray[this.currentFocuIndex].label);
		$(this.hiddenValueObj).val(this.currentResultArray[this.currentFocuIndex].id);
		
//		
//		if(this.currentResultArray[this.currentFocuIndex].wordsId != null) {
//			var thisId = $(this.currentInputEL).attr("id");
//			var id = thisId.substring(thisId.lastIndexOf("_")+1, thisId.length);
//			document.getElementById("wordsId"+id).value = record.wordsId;
//		}
		$(this.currentInputEL).focus();
		
		this.cleanToolkit();
//
		if(this.currentInputEL.config.afterCall){
			this.currentInputEL.config.afterCall(record,this.currentInputEL.config,this.currentInputEL);
		}
	},
	createSearchDiv:function(inputEL){
		this.currentInputEL = inputEL;
		this.hiddenValueObj  = inputEL.config.hiddenValueObj;
		var inputWidth = 140;
		var div_width = this.dyncSearchDiv.style.width;
		inputWidth = div_width.substring(0, div_width.length - 2);
		//alert(inputWidth);
		/*if(parseInt(inputEL.style.width) !=0){
			inputWidth = parseInt(inputEL.style.width); 	
		}*/
		if(dyncSearchToolkit.currentResultArray.length!=0){
			var html = "<table border=0 cellspacing=0 style='border:0px solid #000;width=100%' class='noclass'>";
			for(var i=0;i<dyncSearchToolkit.currentResultArray.length;i++){
				html+="<tr height='20' onmouseover=\"dyncSearchToolkit.focuItem("+ i +")\" onMouseDown=\"dyncSearchToolkit.setSelectLineWithClean()\"  >";
				html+="<td width=\""+inputWidth+"\" style=\"font-size:16px\">&nbsp;"+dyncSearchToolkit.currentResultArray[i].label+
//				"--"+
//				dyncSearchToolkit.currentResultArray.provice+"-"+dyncSearchToolkit.currentResultArray.city+"--"+
//				dyncSearchToolkit.currentResultArray.profession+
				"</td>";
				
				html+="</tr>";
			}
			html+="</table>";
			if(!this.isValid()){//2011-12-11张恒修改，能源项目用
				var textBox = $(inputEL);
				this.dyncSearchDiv.style.left = ($(inputEL).position().left +10)+"px";
				this.dyncSearchDiv.style.top = ($(inputEL).position().top + $(inputEL).height()) + "px";
				$(this.dyncSearchDiv).show();
			}
			$(this.dyncSearchDiv).html(html);
			
		}else{
			this.cleanToolkit();
		}	
	},
	catchKeyBoard:function(inputEL,keyNumber){
		if(keyNumber=='40'){
			if(this.isValid()){					
				if (this.currentFocuIndex==-1){//当焦点在文本框中间时，按向下跳到第一个主体
					this.focuItem(0);
					
					this.setSelectLine();
				} else if(this.currentFocuIndex==((this.currentResultArray.length)-1)){//当焦点超出界限时跳转到第一个主体
					this.focuItem(0);
					this.setSelectLine();
				}else{
					this.focuItem(this.currentFocuIndex+1);
					this.setSelectLine();
				}
			}else{
				this.loadMatchInfo(inputEL);
			}
		}else if(keyNumber=='38'){//向上
			if(this.isValid()){
				if(this.currentFocuIndex==-1){
					this.focuItem(this.currentResultArray.length-1);
					this.setSelectLine();
				}else if(this.currentFocuIndex==0){
					this.focuItem(this.currentResultArray.length-1);
					this.setSelectLine();
				}else{
					this.focuItem(this.currentFocuIndex-1);
					this.setSelectLine();
					
				}
			}
		}else if(keyNumber=='13'){
			//alert(this.isValid());
			if(this.isValid()){
				if(this.currentFocuIndex!=-1){
					this.setSelectLineWithClean();
					return;
				}/*else{
					PressKey();
				}*/
				this.cleanToolkit();
			}/*else{
				PressKey();
			}*/
			inputEL.blur();
		}
	},
	loadMatchInfo:function(inputEL){
		var keyword =$(inputEL).val();
		var label_field = "numberName";
		if(inputEL.config.labelField){
			label_field = inputEL.config.labelField;
		}
		keyword = $.trim(keyword);
		if(keyword!=""){
			
			var url = inputEL.config.url;
			url += "?keyword="+keyword;
			$.ajax({
			       url:url,
			       type:'POST',
			       data:$("#searchForm").serialize(),
			       success:function(data){
			       		eval("var array="+data);
			          if(array.length != 0) {
							dyncSearchToolkit.currentResultArray = [];
							for(var i = 0; i < array.length; i++) {
								dyncSearchToolkit.currentResultArray.push({label:array[i].nickname,name:array[i].name,
									id:array[i].userId,provice:array[i].provice,city:array[i].city,profession:array[i].profession,popularityTotal:array[i].popularityTotal});
							}
							
							dyncSearchToolkit.currentFocuIndex =-1;
									
							dyncSearchToolkit.createSearchDiv(inputEL);
						} else {
							dyncSearchToolkit.cleanToolkit();	
						}
			       }
			   });
		}else{
		  this.cleanToolkit();
		  
		} 	
	},
	processKeyup:function(event, input){
		var keyNumber = event.keyCode;
		if(keyNumber=='40'||keyNumber=='38'||keyNumber=='13'){
			dyncSearchToolkit.catchKeyBoard(event.data.inputEL,keyNumber);
		}else{
			if(event.data == null) {
				input.focus();
				dyncSearchToolkit.loadMatchInfo(input);
			} else {
				dyncSearchToolkit.loadMatchInfo(event.data.inputEL);
			}
		}	
	},
	processBlur:function(){
		dyncSearchToolkit.cleanToolkit();
	}
};
function bindQueryToolkit(inputEL,config){
	inputEL.config = config;
	$(inputEL).bind("keyup",{inputEL:inputEL},dyncSearchToolkit.processKeyup);
	$(inputEL).bind("blur",{inputEL:inputEL},dyncSearchToolkit.processBlur);
	
}

function unbindQueryToolkit(inputEL){
	inputEL.config = null;
	$(inputEL).unbind("keyup",dyncSearchToolkit.processKeyup);
	$(inputEL).unbind("blur",dyncSearchToolkit.processBlur);
}

