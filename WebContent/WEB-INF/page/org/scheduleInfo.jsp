<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@page import="java.util.List"%>
<%@page import="com.smt.entity.TAppScheduleInfo"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragrma","no-cache");
response.setDateHeader("Expires",0);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    
  <!--    <title><%=StageVariale.title%></title>  -->
    <title>第1舞台</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/data.css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/address.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
	
	<script type="text/javascript">

  //------------------------用来计算阴历---START---------------------
function CnMonthofDate(DateGL){
var CnMonthStr=new Array("零","正","二","三","四","五","六","七","八","九","十","冬","腊");
var Month;
Month = parseInt(CnDateofDate(DateGL)/100);
//if (Month < 0){return "闰" + CnMonthStr[-Month] + "月";}
if (Month < 0){return CnMonthStr[-Month] + "月";}
else{return CnMonthStr[Month] + "月";}
}

function CnDayofDate(DateGL){
var CnDayStr=new Array("零",
    "初一", "初二", "初三", "初四", "初五",
    "初六", "初七", "初八", "初九", "初十",
    "十一", "十二", "十三", "十四", "十五",
    "十六", "十七", "十八", "十九", "二十",
    "廿一", "廿二", "廿三", "廿四", "廿五",
    "廿六", "廿七", "廿八", "廿九", "三十");
var Day;
Day = (Math.abs(CnDateofDate(DateGL)))%100;
return CnDayStr[Day];
}

function DaysNumberofDate(DateGL){
return parseInt((Date.parse(DateGL)-Date.parse(DateGL.getFullYear()+"/1/1"))/86400000)+1;
}

function CnDateofDate(DateGL){
var CnData=new Array(
0x16,0x2a,0xda,0x00,0x83,0x49,0xb6,0x05,0x0e,0x64,0xbb,0x00,0x19,0xb2,0x5b,0x00,
0x87,0x6a,0x57,0x04,0x12,0x75,0x2b,0x00,0x1d,0xb6,0x95,0x00,0x8a,0xad,0x55,0x02,
0x15,0x55,0xaa,0x00,0x82,0x55,0x6c,0x07,0x0d,0xc9,0x76,0x00,0x17,0x64,0xb7,0x00,
0x86,0xe4,0xae,0x05,0x11,0xea,0x56,0x00,0x1b,0x6d,0x2a,0x00,0x88,0x5a,0xaa,0x04,
0x14,0xad,0x55,0x00,0x81,0xaa,0xd5,0x09,0x0b,0x52,0xea,0x00,0x16,0xa9,0x6d,0x00,
0x84,0xa9,0x5d,0x06,0x0f,0xd4,0xae,0x00,0x1a,0xea,0x4d,0x00,0x87,0xba,0x55,0x04
);
var CnMonth=new Array();
var CnMonthDays=new Array();
var CnBeginDay;
var LeapMonth;
var Bytes=new Array();
var I;
var CnMonthData;
var DaysCount;
var CnDaysCount;
var ResultMonth;
var ResultDay;
var yyyy=DateGL.getFullYear();
var mm=DateGL.getMonth()+1;
var dd=DateGL.getDate();
if(yyyy<100) yyyy+=1900;

Bytes[0] = CnData[(yyyy - 1997) * 4];
Bytes[1] = CnData[(yyyy - 1997) * 4 + 1];
Bytes[2] = CnData[(yyyy - 1997) * 4 + 2];
Bytes[3] = CnData[(yyyy - 1997) * 4 + 3];
if ((Bytes[0] & 0x80) != 0) {CnMonth[0] = 12;}
else {CnMonth[0] = 11;}
CnBeginDay = (Bytes[0] & 0x7f);
CnMonthData = Bytes[1];
CnMonthData = CnMonthData << 8;
CnMonthData = CnMonthData | Bytes[2];
LeapMonth = Bytes[3];
for (var I = 15;I >= 0; I--){
    CnMonthDays[15 - I] = 29;
    if (((1 << I) & CnMonthData) != 0 ){
      CnMonthDays[15 - I]++;}
    if (CnMonth[15 - I] == LeapMonth ){
      CnMonth[15 - I + 1] = - LeapMonth;}
    else{
      if (CnMonth[15 - I] < 0 ){CnMonth[15 - I + 1] = - CnMonth[15 - I] + 1;}
      else {CnMonth[15 - I + 1] = CnMonth[15 - I] + 1;}
      if (CnMonth[15 - I + 1] > 12 ){ CnMonth[15 - I + 1] = 1;}
    }
}
DaysCount = DaysNumberofDate(DateGL) - 1;
if (DaysCount <= (CnMonthDays[0] - CnBeginDay)){
    if ((yyyy > 1901) && (CnDateofDate(new Date((yyyy - 1)+"/12/31")) < 0)){
      ResultMonth = - CnMonth[0];}
    else {ResultMonth = CnMonth[0];}
    ResultDay = CnBeginDay + DaysCount;
}
else{
    CnDaysCount = CnMonthDays[0] - CnBeginDay;
    I = 1;
    while ((CnDaysCount < DaysCount) && (CnDaysCount + CnMonthDays[I] < DaysCount)){
      CnDaysCount+= CnMonthDays[I];
      I++;
    }
    ResultMonth = CnMonth[I];
    ResultDay = DaysCount - CnDaysCount;
}
if (ResultMonth > 0){
    return ResultMonth * 100 + ResultDay;}
else{return ResultMonth * 100 - ResultDay;}
}


function CnDateofDateStr(DateGL){//此计算方法的开口.只要调用些方法传进Date对像就OK!!!
 return  CnDayofDate(DateGL);
}

//------------------------用来计算阴历---END---------------------
  function  montharr(m0,   m1,   m2,   m3,   m4,   m5,   m6,   m7,   m8,   m9,   m10,   m11){   //分别代表12个月
	  this[0]=m0;//画日历的外观   
	  this[1]=m1;   
	  this[2]=m2;   
	  this[3]=m3;   
	  this[4]=m4;   
	  this[5]=m5;   
	  this[6]=m6;   
	  this[7]=m7;   
	  this[8]=m8;   
	  this[9]=m9;   
	  this[10]=m10;   
	  this[11]=m11;
	}   
  function calendar(today){
	 	  var  monthname=new Array("一月",   "二月",   "三月",   "四月",   "五月",   "六月",   "七月",   "八月",   "九月",   "十月",   "十一月",   "十二月");   
	  var  thisDay;   
	  var  monthDays=new montharr(31,   28,   31,   30,   31,  30,   31,   31,  30, 31,   30,   31);   //每个月的总天数
	  year=today.getYear();   
	  thisDay=new Date().getDate();   //取到当前日期

	  if (((year %  4==0) && (year % 100 !=  0)) || (year % 400==0))//闰年   
	  monthDays[1]=29; 
		
	  nDays=monthDays[today.getMonth()];   //得到当月的总天数

	  firstDay=today;   
	  firstDay.setDate(1);   //  设置当前月的第一天


	  testMe=firstDay.getDate(); 
	 
	  if  (testMe==2)   
	  firstDay.setDate(0);  
	  
	  startDay=firstDay.getDay();  //返回当前是星期几0-6
	  
	  var cYear=today.getFullYear();
	  var cMonth=today.getMonth()+1;
	  if(cMonth<10)
		cMonth=0+""+cMonth;


	  //用来比较是整是当前月
	  var cuDate=new Date();
	  var cuValue=cuDate.getFullYear()+""+cuDate.getMonth()+1;
	  var prValue=today.getFullYear()+""+today.getMonth()+1;

		
	  content=" <div id='content' scroll=no> ";

	  content+="<table  id=ta onclick=getData(event) class='D_table' cellspacing=1   cellpadding=0 onmouseover= voerData(event) onmouseout=outData(event) >";   
	  content+="<tr><td  colspan=6 class='D_bt'>";   
	  content+="&nbsp;<A title=上一年 href='javascript:PreYear()'><IMG src='<%=request.getContextPath() %>/theme/images/main_2.gif'></A>&nbsp;&nbsp;";  
		
	  content+="<A title=上一月 href='javascript:PreMonth()'>上一月</A>&nbsp;&nbsp;&nbsp;";   
	  
	  content+="<span id='cyear'>"+cYear+"</span>年<span id='cmonth'>"+cMonth+"</span>月&nbsp;&nbsp;&nbsp;"; 

	  content+="<A title=下一月 href='javascript:NextMonth()'>下一月</A>&nbsp;&nbsp;&nbsp;"; 

	  content+="<A title=下一年 href='javascript:NextYear()'><IMG src='<%=request.getContextPath() %>/theme/images/main_1.gif'></A> &nbsp;&nbsp;&nbsp;"; 

      content+="<A href='javascript:NowMonth()'><b>本月</b></A> <td class='D_bt'><a href='javaScript:toAddSchedule();' title='添加档期'><img src='<%=request.getContextPath() %>/theme/images/add_nav.jpg' align='absmiddle'></a>"; 

	  content+="<tr class='week'><td width=130><b>星期日</b><td width=130>星期一<td width=130>星期二<td width=130>星期三<td width=130>星期四<td width=130>星期五<td width=130><em>星期六</em>";   
	  content+="<tr>";   
	  column=0; 
	 
	  for   (i=0;   i<startDay;   i++){  //画出前面空白的日期
		  content+="<td class='kb'>";    
		  column++;
	  }   
	 
	  for   (i=1;   i<=nDays;  i++){   //画出主体部分的日期

		var tday=today;
		tday.setDate(i);
		current=tday.getDay();//当前是本周的第几天

		if (cuValue==prValue&&i==thisDay)//今天 
		{
			if(current==0)
				content+="<td class='today'>"; 
			else if(current==6)
				content+="<td class='today'>"; 
			else
				content+="<td class='today'>"; 
		}
		else
		{
			if(current==0)
				content+="<td id='d"+i+"' target=1 background='<%=request.getContextPath() %>/theme/images/putong.png' class='dd red'>"; 
			else if(current==6)
				content+="<td id='d"+i+"' target=1 background='<%=request.getContextPath() %>/theme/images/putong.png' class='dd green'>"; 
			else
				content+="<td id='d"+i+"' target=1 background='<%=request.getContextPath() %>/theme/images/putong.png' class='dd1'>"; 
		}

			content+="<div class='db'>";

			content+="<span class='yl'>"+i+"</span>";

			if (cuValue==prValue&&i==thisDay)//今天
				content+="<span class='nl'></span>";
			else
				content+="<span id='md"+i+"'  class='nl'></span>";

			content+="</div>"
            
               <%List scheduleInfoList=(List)request.getAttribute("scheduleInfoList");
               for(int i=0;i< scheduleInfoList.size();i++){ 
               	 TAppScheduleInfo scheduleInfo=(TAppScheduleInfo)scheduleInfoList.get(i);
               	 int id=scheduleInfo.getId();
               	 String title=scheduleInfo.getTitle();
               	 String titleWrite=title;
               	 if(title.length()>5){
               	 	titleWrite=title.substring(0,5)+"...";
               	 }
               	 String startDateTime=scheduleInfo.getStartDate();
               	 String startDate=startDateTime.substring(0,10);
                 String endDateTime=scheduleInfo.getEndDate();
                 String endDate=endDateTime.substring(0,10);
  
               %>
               //var today=new Date(cYear,cMonth,i);
               var todayDate=""+cYear+cMonth+i;
               if(i<10){
               		todayDate=""+cYear+cMonth+"0"+i;
               }
               var starDate='<%=startDate%>';
               var endDate='<%=endDate%>';
               var starDateArr=starDate.split('-');
               var endDateArr=endDate.split('-');
               var startDateResult=""+starDateArr[0]+starDateArr[1]+starDateArr[2];
               var endDateResult=""+endDateArr[0]+endDateArr[1]+endDateArr[2];
               //var startDateResult=new Date(starDateArr[0],starDateArr[1],starDateArr[2]);
               //var startDateResult=new Date(endDateArr[0],endDateArr[1],endDateArr[2]);

               if(todayDate>=startDateResult&&todayDate<=endDateResult){
   				   content+="<p><a href='javaScript:toUpdateSchedule(<%=id %>);' title='查看、修改、删除' class='date_sj'><IMG src='<%=request.getContextPath() %>/theme/images/sj_ico.gif'>&nbsp;<%=titleWrite %></a>"
			   }
			   <%
			    }
                %>
			

		  column++;   
		  
		  if(column==7){//画下一行
			  content+="<tr>";   
			  column=0;
			 
		   }
	    
		}
		if((42-startDay-nDays)%7!=0)
			if (column<7)//画出结束的空白日期
			{	
				   for (j=1;j<(7-column+1);j++){   
					   content+="<td class='kb' id=d"+i+">";    
				   }
			}
			

		  content+="</table>";   
	}//画日历外观结束   


	function getData(e){
	// var node=e.target?e.target: window.event.srcElement;
	//if(node.tagName!='TD')return;
	//var target = node.getAttribute('target');
	//if(target==1)
	//	node.innerHTML=node.innerHTML+"<div style='height:20px;'><ul><li>aaaaa</li></ul><ul><li>aaaaa</li></ul></div>";
	}

 function NowMonth() {
	calendar(new Date());
	//document.body.innerHTML=content;
	document.getElementById('date_month').innerHTML=content;
  }
  //上一月
  function PreMonth() {
	var objY=document.getElementById('cyear');
	var objM=document.getElementById('cmonth');
	var year=objY.innerHTML;
	var month=objM.innerHTML;
	var y = new Number(year);
    var m = new Number(month);
	calendar(new Date(y, m-2, 1));
	//document.body.innerHTML=content;
	document.getElementById('date_month').innerHTML=content;
  }
  //下一月
   function NextMonth() {
	var objY=document.getElementById('cyear');
	var objM=document.getElementById('cmonth');
	var year=objY.innerHTML;
	var month=objM.innerHTML;
	var y = new Number(year);
    var m = new Number(month);
	calendar(new Date(y, m,1));
	//document.body.innerHTML=content;
	document.getElementById('date_month').innerHTML=content;
  }
  //上一年
   function PreYear() {
   	var objY=document.getElementById('cyear');
	var objM=document.getElementById('cmonth');
	var year=objY.innerHTML;
	var month=objM.innerHTML;
	var y = new Number(year);
    var m = new Number(month);
	calendar(new Date(y-1,m-1,1));
	//document.body.innerHTML=content;
	document.getElementById('date_month').innerHTML=content;
  }
  //下一年
   function NextYear() {
    var objY=document.getElementById('cyear');
	var objM=document.getElementById('cmonth');
	var year=objY.innerHTML;
	var month=objM.innerHTML;
	var y = new Number(year);
    var m = new Number(month);

	calendar(new Date(y+1, m-1,1));
	//document.body.innerHTML=content;
	document.getElementById('date_month').innerHTML=content;
  }
	
   function changeContent()
   {
    calendar(new Date());  
	//document.body.innerHTML=content;
	document.getElementById('date_month').innerHTML=content;
   }
	/*function getdata(e){
	
	e = getEvent();
	var srcElement = e.srcElement || e.target;
	alert(srcElement.innerHTML);
	
	}*/
	var mid=null;
   function voerData(e)
   {
		var node=e.target?e.target: window.event.srcElement;
		
		if (node.tagName=='DIV')
			node=node.parentNode;
		if (node.tagName=='SPAN')
			node=node.parentNode.parentNode;
		if (node.tagName=='IMG')
			node=node.parentNode.parentNode.parentNode;

		if(node.tagName!='TD')return;

		var target = node.getAttribute('target');
		if(target==1)
		{
			var nid=node.getAttribute('id');
			
			if(mid!=null&&mid!=nid)
			{
				var oldNode =document.getElementById(mid);
				oldNode.setAttribute('background','<%=request.getContextPath() %>/theme/images/putong.png');
				var changeTd =document.getElementById('m'+mid);
				changeTd.innerHTML=changeTd.innerHTML.substring(0,2);

				node.setAttribute('background','<%=request.getContextPath() %>/theme/images/mouseOver.png');
				
			}else
			{
				node.setAttribute('background','<%=request.getContextPath() %>/theme/images/mouseOver.png');
			}
		}

	
	
   }
   function outData(e)
   {
		var node=e.target?e.target: window.event.srcElement;
		if (node.tagName=='DIV')
			node=node.parentNode;
		if (node.tagName=='SPAN')
			node=node.parentNode.parentNode;
		if (node.tagName=='IMG')
			node=node.parentNode.parentNode.parentNode;
		if(node.tagName!='TD')return;

		var target = node.getAttribute('target');
		if(target==1)
		{
			
			var nid=node.getAttribute('id');
			mid=nid;
		}

   }

   function toAddSchedule(){
  		art.dialog.open('<%=request.getContextPath() %>/member/scheduleInfo!toAddScheduleInfo.htm?id=<s:property value="#request.userId"/>',{resize: false});
   }

	function toUpdateSchedule(id){
	  	art.dialog.open('<%=request.getContextPath() %>/member/scheduleInfo!toUpdateScheduleInfo.htm?uid=<s:property value="#request.userId"/>&&id='+id,{resize: false});
   }
   
   function tishi(content){
   		alert(content);
   		window.location.href=window.document.location;
	}
  
</script>
  </head>
  <body onload="changeContent()">
  <!-- 主内容开始 -->
<table width="810" border="0" align="center" cellpadding="0" cellspacing="0" class="layout_table">
    <tr>
        <td width="810" align="left" valign="top">



<!-- 按月查询 开始 -->
<div style="height: 20px">&nbsp;</div>
<div id="date_month" ></div>
</td>
</tr>
</table>

<!-- 主内容结束 -->
  </body>
</html>