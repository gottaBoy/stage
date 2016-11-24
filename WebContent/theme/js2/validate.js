/**
Last Modified: 2008-07-17

这个JS针对字符串的一系列验证.
常用的验证都在里面了,还不够用的自己添加.

	验证函数的用法:
	假如你要验证一个字符串是否为空(这里说的空不是NULL,但包括""、一个或多个空格都算空)?
	var str = "";
	if(DoWell.Valid.isEmpty(str)){
		alert("is empty");
	}else{
		alert("not empty");
	}

*/
if(!window.DoWell){
	var DoWell = {};
}
if(!DoWell.Valid){
	DoWell.Valid = {};
}
if(!DoWell.Valid.valid){
	DoWell.Valid.valid = {};
}

DoWell.Valid.valid.empty_reg = /^\s*$/g;	//验证为空
DoWell.Valid.valid.integer_unsigned_reg= /^\+?\d+$/g;
DoWell.Valid.valid.integer_reg = /^[+-]?\d+$/g;	//验证整数
DoWell.Valid.valid.float_reg = /^[+-]?\d+(.\d+)?$/g;	//验证浮点
DoWell.Valid.valid.float_unsigned_reg = /^\+?\d+(.\d+)?$/g;	//验证正浮点数
DoWell.Valid.valid.email = /^[\w-][.\w-]+@[-\w]+(\.[-\w]+){1,3}$/g;	//验证邮箱

DoWell.Valid.valid.telephone = /^\+?[0-9 ]+(\-[0-9 ]+)*$/g;	//验证电话
DoWell.Valid.valid.date = /^\d{4}-\d{1,2}-\d{1,2}( \d{1,2}:\d{1,2}(:\d{1,2})?)?$/g;	//验证日期
DoWell.Valid.valid.timeSimple = /^(([01][0-9])|([2][0-3])):[0-5][0-9]$/g;	///验证time类型 HH:mm 
DoWell.Valid.valid.time = /^(([01][0-9])|([2][0-3])):[0-5][0-9]:[0-5][0-9]$/g;	//验证time类型 HH:mm:ss 

//20012-05-08 更新部分验证
DoWell.Valid.valid.chinese = /[\u4E00-\u9FA5]/i;	//验证含有中文
DoWell.Valid.valid.digit_letter =  /[^0-9a-zA-Z]/i;//验证数字 字母
DoWell.Valid.valid.digit_letter_chinese = /[^0-9a-zA-Z\u4E00-\u9FA5]/; //验证数字字母中文(无字符)
DoWell.Valid.valid.mobile = /^1[0-9][0-9]\d{4,8}$/;	//验证手机
DoWell.Valid.valid.url = /^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/;	//url

/** validate value is empty */
DoWell.Valid.isEmpty = function(value){
	if(value && value.match && !value.match(DoWell.Valid.valid.empty_reg)){
		return false;
	}else{
		return true;
	}
};

/** validate value is integer 整数 */
DoWell.Valid.isInteger = function(value){
	if(value && value.match && value.match(DoWell.Valid.valid.integer_reg)){
		return true;
	}else{
		return false;
	}
};

/** validate value is isNature 自然数*/ 
DoWell.Valid.isNature = function(value){
	if(value && value.match && value.match(DoWell.Valid.valid.integer_unsigned_reg)){
		return true;
	}else if(value&&value==0){
	 return true;
	}else
	{
	return false;
	}
};

/** validate value is float 浮点 */
DoWell.Valid.isFloat = function(value){
	if(value && value.match && value.match(DoWell.Valid.valid.float_reg)){
		return true;
	}else{
		return false;
	}
};

/** validate value is unsigned integer 正整数*/
DoWell.Valid.isIntegerUnsigned = function(value){
	if(value && value.match && value.match(DoWell.Valid.valid.integer_unsigned_reg) && value >= 0){
		return true;
	}else{
		return false;
	}
};

/** validate value is unsigned float 正浮点数*/
DoWell.Valid.isFloatUnsigned = function(value){
	if(value && value.match && value.match(DoWell.Valid.valid.float_unsigned_reg) && value > 0){
		return true;
	}else{
		return false;
	}
};

/**
	validate the email 
*/
DoWell.Valid.isEmail = function(value){
	if(value && value.match && value.match(DoWell.Valid.valid.email)){
		return true;
	}else{
		return false;
	}
};

/**
	validate the telephone number
*/
DoWell.Valid.isTelephone = function(value){
	if(value && value.match && value.match(DoWell.Valid.valid.telephone)){
		return true;
	}else{
		return false;
	}
};

/**
	validate the date
*/
DoWell.Valid.isDate = function(value){
	if(value && value.match && value.match(DoWell.Valid.valid.date)){
		return true;
	}else{
		return false;
	}
};

/**
validate the time is style  HH:mm
**/
DoWell.Valid.isTimeSimple = function(value){
	if(value && value.match && value.match(DoWell.Valid.valid.timeSimple)){
		return true;
	}else{
		return false;
	}
};

/**
validate the time is style  HH:mm:ss
**/
DoWell.Valid.isTime = function(value){
	if(value && value.match && value.match(DoWell.Valid.valid.time)){
		return true;
	}else{
		return false;
	}
};

//20012-05-08 更新部分验证
/**
validate the chinese
**/
DoWell.Valid.chinese = function(value){
	if(value && value.match && value.match(DoWell.Valid.valid.chinese)){
		return true;
	}else{
		return false;
	}
};

/**
validate the digit_letter
**/
DoWell.Valid.digit_letter = function(value){
	if(value && value.match && value.match(DoWell.Valid.valid.digit_letter)){
		return true;
	}else{
		return false;
	}
};

/**
validate the digit_letter_chinese
**/
DoWell.Valid.digit_letter_chinese = function(value){
	if(value && value.match && value.match(DoWell.Valid.valid.digit_letter_chinese)){
		return true;
	}else{
		return false;
	}
};

/**
validate the telephone number
*/
DoWell.Valid.isMobile = function(value){
	if(value && value.match && value.match(DoWell.Valid.valid.mobile)){
		return true;
	}else{
		return false;
	}
};

/**
validate the telephone url
*/
DoWell.Valid.isurl = function(value){
	if(value && value.match && value.match(DoWell.Valid.valid.url)){
		return true;
	}else{
		return false;
	}
};

//获取光标所在的位置，包括起始位置和结束位置
function getInputCursor(textBox){
	var obj = new Object();
	var start = 0,end = 0;
	if ($.browser.mozilla) {
		start = textBox.selectionStart;
		end = textBox.selectionEnd;
	}
	if ($.browser.msie) {
		var range=textBox.createTextRange();
		var selrange = document.selection.createRange();
		while(selrange.compareEndPoints("StartToStart",range)>0){ 
			selrange.moveStart("character",-1); 
			start ++;
		}
		while(selrange.compareEndPoints("EndToStart",range)>0){ 
			selrange.moveEnd("character",-1); 
			end ++;
		}
	}
	obj.start = start;
	obj.end = end;
	return obj;
};

