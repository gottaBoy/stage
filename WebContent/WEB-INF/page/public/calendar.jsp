<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<style type="text/css">
.Calendar {
	font-family: Verdana;
	font-size: 12px;
	/* background-color:#fff;  */
	text-align: center;
	width: 250px;
	height: 200px;
	margin-top: 20px;
	padding: 10px;
	line-height: 1.5em;
}

.Calendar a {
	color: #fff;
	background-color: #D12127;
	width: 20px;
	height: 20px;
	display: block;
	text-align: center;
	vertical-align: middle;
	font-weight: bold;
	text-decoration: none;
}

.Calendar table {
	width: 100%;
	border: 0;
}

.Calendar table thead {
	color: #acacac;
}

.Calendar table td {
	font-size: 12px;
	padding: 1px;
}

#idCalendarPre {
	cursor: pointer;
	float: left;
	padding-right: 5px;
}

#idCalendarNext {
	cursor: pointer;
	float: right;
	padding-right: 5px;
}

#idCalendar td.onToday {
	font-weight: bold;
	color: #C60;
}

#idCalendar td.onSelect {
	font-weight: bold;
}

.calendar_tit {
	background-color: #E4E4E4;
	color: #333;
}
</style>
<script type="text/javascript"> 
var cal = function (id) { 
return "string" == typeof id ? document.getElementById(id) : id; 
}; 
var Class = { 
create: function() { 
return function() { 
this.initialize.apply(this, arguments); 
} 
} 
} 
Object.extend = function(destination, source) { 
for (var property in source) { 
destination[property] = source[property]; 
} 
return destination; 
} 
var Calendar = Class.create(); 
Calendar.prototype = { 
initialize: function(container, options) { 
this.Container = cal(container);//容器(table结构) 
var Days = [];//日期对象列表 
this.SetOptions(options); 
this.Year = this.options.Year; 
this.Month = this.options.Month; 
this.SelectDay = this.options.SelectDay ? new Date(this.options.SelectDay) : null; 
this.onSelectDay = this.options.onSelectDay; 
this.handlerOut = this.options.handlerOut;
this.onToday = this.options.onToday; 
this.onFinish = this.options.onFinish; 
this.Draw(); 
}, 
//设置默认属性 
SetOptions: function(options) { 
this.options = {//默认值 
Year: new Date().getFullYear(),//显示年 
Month: new Date().getMonth() + 1,//显示月 
SelectDay: null,//选择日期 
onSelectDay: function(){},//在选择日期触发 
handlerOut:function(){},
onToday: function(){},//在当天日期触发 
onFinish: function(){}//日历画完后触发 
}; 
Object.extend(this.options, options || {}); 
}, 
//上一个月 
PreMonth: function() { 
//先取得上一个月的日期对象 
var d = new Date(this.Year, this.Month - 2, 1); 
//再设置属性 
this.Year = d.getFullYear(); 
this.Month = d.getMonth() + 1; 
//重新画日历 
this.Draw(); 
}, 
//下一个月 
NextMonth: function() { 
var d = new Date(this.Year, this.Month, 1); 
this.Year = d.getFullYear(); 
this.Month = d.getMonth() + 1; 
this.Draw(); 
}, 
//画日历 
Draw: function() { 
//用来保存日期列表 
var arr = []; 
//用当月第一天在一周中的日期值作为当月离第一天的天数 
for(var i = 1, firstDay = new Date(this.Year, this.Month - 1, 1).getDay(); i <= firstDay; i++){ arr.push(" "); } 
//用当月最后一天在一个月中的日期值作为当月的天数 
for(var i = 1, monthDay = new Date(this.Year, this.Month, 0).getDate(); i <= monthDay; i++){ arr.push(i); } 
var frag = document.createDocumentFragment(); 
Days = []; 
while(arr.length > 0){ 
//每个星期插入一个tr 
var row = document.createElement("tr"); 
//每个星期有7天 
for(var i = 1; i <= 7; i++){ 
var cell = document.createElement("td"); 
cell.innerHTML = " "; 
//cell.onclick=this.onSelectDay;
//$(cell).mouseenter(onSelectDay).mouseleave(handlerOut);
$(cell).hover(this.onSelectDay, this.handlerOut);
if(arr.length > 0){ 
var d = arr.shift(); 

cell.innerHTML = d; 
$
if(d > 0){ 
	Days[d] = cell; 
	//判断是否今日 
	if(this.IsSame(new Date(this.Year, this.Month - 1, d), new Date())){ this.onToday(cell); } 
	//判断是否选择日期 
	if(this.SelectDay && this.IsSame(new Date(this.Year, this.Month - 1, d), this.SelectDay)){ this.onSelectDay(cell); } 
} 
} 
row.appendChild(cell); 
} 
frag.appendChild(row); 
} 
//先清空内容再插入(ie的table不能用innerHTML) 
while(this.Container.hasChildNodes()){ this.Container.removeChild(this.Container.firstChild); } 
this.Container.appendChild(frag); 
this.onFinish(); 
}, 
//判断是否同一日 
IsSame: function(d1, d2) { 
return (d1.getFullYear() == d2.getFullYear() && d1.getMonth() == d2.getMonth() && d1.getDate() == d2.getDate()); 
} 
}; 
//var dd =this.Days;
</script>
<!--把下面代码加到<body>与</body>之间-->
<div class="Calendar">
	<div class="calendar_tit">
		<div id="idCalendarPre" class="calendar_tit"><<</div>
		<div id="idCalendarNext" class="calendar_tit">>></div>
		<span id="idCalendarYear" class="calendar_tit">2008</span>年 <span
			id="idCalendarMonth" class="calendar_tit">8</span>月
	</div>
	<table cellspacing="0">
		<thead>
			<tr>
				<td class="calendar_tit">日</td>
				<td class="calendar_tit">一</td>
				<td class="calendar_tit">二</td>
				<td class="calendar_tit">三</td>
				<td class="calendar_tit">四</td>
				<td class="calendar_tit">五</td>
				<td class="calendar_tit">六</td>
			</tr>
		</thead>
		<tbody id="idCalendar">
		</tbody>
	</table>
</div>
<input type="hidden" id="zjkj"
	value="<s:property value="#request.userIdParam"/>">
<script language="JavaScript"> 
var heigth = 124;
var width = 240;
var flag = false;
var html = $('div#pop-up').html();
	var cale = new Calendar("idCalendar", { 
		onSelectDay: function(o)
		{
			var obj = this;
			var year = $('#idCalendarYear').text();
			var month = $('#idCalendarMonth').text();
			month = month.length==2?month:"0"+month;
			var day = $(this).text();
			day = day.length==2?day:"0"+day;
			$.ajaxSetup({  
			    async : false
			});       
<%-- 			<%=request.getContextPath()%>/presonList!getActionForUser.htm --%>
			$.post('<%=request.getContextPath()%>/schedule!getScheinfoByYm.htm',
					{
						id:$('#zjkj').val(),
						yy:year,
						mm:month,
						dd:day
				    }, 
				    
					function(data) {
				    	if(data != null && data !=""){
				    		 $('div#pop-up').html(data).show()
					  			.css({'top':$(obj).offset().top-heigth,'left':$(obj).offset().left-18});
				    	}else{
				    		return;
				    	}
				},"html");
		}, 
		handlerOut: function()
		{
			$('div#pop-up').html(html);
			$('div#pop-up').hide();
		}, 
		onToday: function(o){ o.className = "onToday"; }, 
		onFinish: function(){ 
			cal("idCalendarYear").innerHTML = this.Year; cal("idCalendarMonth").innerHTML = this.Month; 
			var flag = [];
			var yy = this.Year;
			var mm = this.Month;
// 			$.ajax({
// 				dataType:"html",
// 				type: "get",
<%-- 				url: '<%=request.getContextPath()%>/schedule!getScheByYm.htm?yy='+yy+"&&mm="+mm+"&&id="+<s:property value="#request.userIdParam"/>+"&&date="+new Date(), --%>
// 				success: function(data, textStatus){
// 					flag = data.split(',');
// 		 			for(var i = 0, len = flag.length; i < len; i++){ 
// 						Days[flag[i]].innerHTML = "<a href='javascript:void(0);' onclick=\"getInfo("+yy+","+mm+","+flag[i]+","+<s:property value="#request.userIdParam"/>+");return false;\">" + flag[i] + "</a>"; 
// 					}
// 				}		
// 			});
		} 
	}); 
	cal("idCalendarPre").onclick = function(){ cale.PreMonth(); } 
	cal("idCalendarNext").onclick = function(){ cale.NextMonth(); } 
	function getInfo(yy,mm,dd,id){
// 	    $.ajax({
// 		    dataType:"html",
// 		    type: "get",
<%-- 		    url: '<%=request.getContextPath()%>/schedule!getScheinfoByYm.htm?yy='+yy+"&&mm="+mm+"&&id="+id+"&&dd="+dd+"&&date="+new Date(), --%>
// 		    success: function(data, textStatus){
// 				 art.dialog({
// 			    	 content: data,
// 			   		 lock: true
// 				 });
// 			}
// 		});
	}
</script>