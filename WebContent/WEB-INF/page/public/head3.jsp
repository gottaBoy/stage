<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.webapp.util.UserSession" %>
<%@page import="java.net.URLEncoder"%> 
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%String titleType = (String)request.getParameter("titleType");  
String style="class='change'";
String path = request.getContextPath();
String hasNoMy=(String)session.getAttribute("hasNoMy");

%>
<link href="<%=request.getContextPath() %>/theme/css2/style.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath() %>/theme/css2/hg.css" rel="stylesheet" type="text/css" />
<SCRIPT type=text/javascript src="<%=request.getContextPath() %>/theme/js2/zzsc.js"></SCRIPT>
<SCRIPT type=text/javascript src="<%=request.getContextPath() %>/theme/js2/common.js"></SCRIPT>
<script src="http://tjs.sjs.sinajs.cn/open/api/js/wb.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
		
	  $().ready(function(){
		  $('#webmenu li').hover(function(){
				$(this).children('ul').stop(true,true).show();
			},function(){
				$(this).children('ul').stop(true,true).hide();
			});
		  
		  //$('.first-menu a').hover(function(){
			  //$(this).css({"background-image":"url(<%=request.getContextPath()%>/theme/images2/tu61.jpg)"});
		  //},function(){
			  //$(this).css({"background-image":"none"});
		  //});
			
			$('#webmenu li').hover(function(){
				$(this).children('div').stop(true,true).show();
			},function(){
				$(this).children('div').stop(true,true).hide();
			});
			
		  $('#light').hide();
	   if($("#headKeywords").val()=="请输入关键词"||$("#headKeywords").val()==""){ 
	      $("#headKeywords").val("请输入关键词");
       	  $("#headKeywords").css("color","#999999");
       }else{
 	      	$("#headKeywords").css("color","#000000");
       }
       
       //没有登录不执行此方法，否则post方法返回data的值是一个登录页面，登录页面也包含此head.jsp故会造成死循环
      	<% UserSession userSession =  HttpSessionHelper.getUserSession(request) ;
			if(userSession != null){    %>
	        //getMyCarCount();
	        getUnreadMessageCount();
	        //window.setInterval("getUnreadMessageCount();",10000);
        <%}%>
  		
	  });
	  function openShow(){
			var url = "<%=request.getContextPath()%>/register/registerAction!toRegProtocol.htm";
			window.open(url);
		}
	  
	  function subForm(){
	  }

	  function headSubmit(){
		if($("#headKeywords").val()=="请输入关键词"){ 
			$("#headKeywords").val("");
			return;
		}
			$("#headSearchFrom").submit();
		}
		
	//显示未读短信条数
	function getUnreadMessageCount(){
		$.post('<%=request.getContextPath()%>/member/message!getUnreadMessageCount.htm?dfdf=<%=new Date()%>',function(data){
				$("#unreadMessageCount").html(data);				
		},"html");
		
	}
	
	//有art.dialog弹出窗口中《加入到购物车》方法执行后调用此方法调转到我的购物车
	 function toMyCar(){
	 		<%if(userSession != null){    %>
	        	var myCar=art.dialog.list["myCar"];
	 			if(myCar!=null){myCar.close();}
  	    		art.dialog.open('<%=request.getContextPath() %>/member/business!toMyCar.htm?dfdf=<%=new Date()%>',{id:'myCar',width:820,height:555,resize: false});
        	<%}else{%>
        		window.open ('<%=request.getContextPath() %>/login.html','_self','height=600,width=980,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no'); 
        	<%}%>
	 }
 	
 	
 	//显示购物车条数
	function getMyCarCount(){
		$.post('<%=request.getContextPath()%>/member/business!getMyCarCount.htm?dfdf=<%=new Date()%>',function(data1){
				$("#myCarCount").html(data1);				
		},"html");
	}


$(document).ready(function(e) {
	$('#weixin').hover(function(){
			$('#weixin_img').css("left", $("#weixin").offset().left);
			$('#weixin_img').show();
		},function(){
			$('#weixin_img').hide();
	})
	
});
</script>
 
 
 

<!--top3-->
<div class="top3 top33" style="margin:0px;height:51px">
  <div style="width:1003px; margin:0px auto;">

    <ul id="webmenu" class="first-menu top3-d l">
      <li><a href="<%=request.getContextPath() %>/index.html" <%if("1".equals(titleType)) {out.print(style);}%>>首页&nbsp;<img src="<%=request.getContextPath() %>/theme/images2/tu09.jpg" width="35" height="19" /></a></li>
      <li><a target="_blank" href="<%=request.getContextPath() %>/query/queryAction!toQuery.htm?sign=1&filterValue=yanyuan" <%if("2".equals(titleType)) {out.print(style);}%>>找演员&nbsp;</a>
        <ul style="display: none;z-index:10" id="subMusic" class="second-menu">
       	  <div><a target="_blank" target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=49&sign=1&filterValue=zhuchi" class="arrow" >主持司仪</a> </div>
          <div><a target="_blank" href="<%=request.getContextPath() %>/query/queryAction!toQuery.htm?signSub=7&sign=1&filterValue=pyyy" class="arrow" >配音演员</a></div>
          <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=8&sign=1&filterValue=ysyy" class="arrow" >影视演员</a> </div>
          <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=9&sign=1&filterValue=wtjyy" class="arrow">舞台剧演员</a></div>
          <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=10&sign=1&filterValue=qyyy" class="arrow" >曲艺演员</a>  </div>
          <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=11&sign=1&filterValue=txyy" class="arrow" >特型演员</a></div>
          <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=53&sign=1&filterValue=moshu" class="arrow" >魔术</a> </div>
          <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=54&sign=1&filterValue=zaji" class="arrow" >杂技</a> </div>
        </ul>
      </li>
      <li><a target="_blank" href="<%=request.getContextPath() %>/query/queryAction!toQuery.htm?sign=2&filterValue=yinyue" <%if("3".equals(titleType)) {out.print(style);}%> class="arrow">找音乐</a>
          <ul style="display: none;z-index:10" id="subMusic" class="second-menu">
        <!-- <div><a href="<%=path %>/query/queryAction!toQuery.htm?signSub=15&sign=2&filterValue=mzyq" class="arrow" >民族乐器</a></div>
        <div><a href="<%=path %>/query/queryAction!toQuery.htm?signSub=16&sign=2&filterValue=xyyq" class="arrow" >西洋乐器</a> </div>
        <div><a href="<%=path %>/query/queryAction!toQuery.htm?signSub=17&sign=2&filterValue=mzgs" class="arrow">民族歌手</a></div>
        <div><a href="<%=path %>/query/queryAction!toQuery.htm?signSub=18&sign=2&filterValue=tsgs" class="arrow" >通俗歌手</a>  </div>
        <div><a href="<%=path %>/query/queryAction!toQuery.htm?signSub=19&sign=2&filterValue=yggs" class="arrow" >摇滚歌手</a></div>
        <div><a href="<%=path %>/query/queryAction!toQuery.htm?signSub=20&sign=2&filterValue=jsgs" class="arrow" >爵士歌手</a> </div>
        <div><a href="<%=path %>/query/queryAction!toQuery.htm?signSub=39&sign=2&filterValue=msgs" class="arrow" >美声歌手</a> </div>
        <div><a href="<%=path %>/query/queryAction!toQuery.htm?signSub=40&sign=2&filterValue=scgs" class="arrow" >说唱歌手</a> </div>
        <div><a href="<%=path %>/query/queryAction!toQuery.htm?signSub=41&sign=2&filterValue=dlgs" class="arrow" >独立歌手</a> </div>
        <div><a href="<%=path %>/query/queryAction!toQuery.htm?signSub=42&sign=2&filterValue=xzc" class="arrow" >小组唱</a> </div> -->
        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=12&sign=2&filterValue=yueqi" class="arrow" >乐器</a> </div>
        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=13&sign=2&filterValue=geshou" class="arrow" >歌手</a> </div>
        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=14&sign=2&filterValue=yuedui" class="arrow" >乐队</a> </div>
      </ul>
      </li>
      <li><a target="_blank" href="<%=request.getContextPath() %>/query/queryAction!toQuery.htm?sign=3&filterValue=wudao" <%if("4".equals(titleType)) {out.print(style);}%> class="arrow">找舞蹈</a>
           <ul style="display: none;z-index:10" id="subMusic" class="second-menu">
        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=21&sign=3&filterValue=gjw" class="arrow" >拉丁舞</a></div>
        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=70&sign=3&filterValue=mdw" class="arrow" >摩登舞</a></div>
        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=69&sign=3&filterValue=gdw" class="arrow" >古典舞</a></div>
        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=71&sign=3&filterValue=mjw" class="arrow" >民间舞</a></div>
        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=72&sign=3&filterValue=ttw" class="arrow" >踢踏舞</a></div>

        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=22&sign=3&filterValue=blw" class="arrow" >芭蕾舞</a> </div>
        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=23&sign=3&filterValue=mzw" class="arrow">民族舞</a></div>
        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=24&sign=3&filterValue=xdw" class="arrow" >现代舞</a>  </div>
        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=43&sign=3&filterValue=jsw" class="arrow" >爵士舞</a></div>
        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=44&sign=3&filterValue=sswd" class="arrow" >时尚舞蹈 </a> </div>
      </ul>
      </li>
      <li><a target="_blank" href="<%=request.getContextPath() %>/query/queryAction!toQuery.htm?sign=4&filterValue=mote" <%if("5".equals(titleType)) {out.print(style);}%> class="arrow">找模特</a>
           <ul style="display: none;z-index:10" id="subMusic" class="second-menu">
        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=26&sign=4&filterValue=ttmt" class="arrow" >T台模特 </a> </div>
        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=25&sign=4&filterValue=pmmt" class="arrow" >广告模特 </a></div>
        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=46&sign=4&filterValue=txmt" class="arrow" >特型模特 </a></div>
        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=73&sign=4&filterValue=tsnlmt" class="arrow" >特殊年龄模特 </a>  </div>
      </ul>
      </li>
      <li><a target="_blank" href="<%=request.getContextPath() %>/query/queryAction!toQuery.htm?sign=5&filterValue=daren" <%if("6".equals(titleType)) {out.print(style);}%> class="arrow">找达人</a>
          <ul style="display: none;z-index:10" id="subMusic" class="second-menu">
        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=28&sign=5&filterValue=jixian" class="arrow" >极限达人  </a></div>
        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=29&sign=5&filterValue=wushu" class="arrow" >武术达人  </a> </div>
        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=30&sign=5&filterValue=niuren" class="arrow">牛人  </a></div>

      </ul>
      </li>
      <li><a target="_blank" href="<%=request.getContextPath() %>/query/queryAction!toQuery.htm?sign=6&filterValue=muhou" <%if("7".equals(titleType)) {out.print(style);}%> class="arrow">找幕后</a>
          <ul style="display: none;z-index:10" id="subMusic" class="second-menu">
        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=32&sign=6&filterValue=dengguang" class="arrow" >舞美/灯光  </a></div>
        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=33&sign=6&filterValue=fuzhuang" class="arrow" >服装  </a> </div>
        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=35&sign=6&filterValue=huazhuang" class="arrow" >化妆/造型  </a>  </div>
        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=34&sign=6&filterValue=daoju" class="arrow">道具  </a></div>
        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=74&sign=6&filterValue=bd" class="arrow" >编导  </a></div>
        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=37&sign=6&filterValue=biannju" class="arrow">编剧   </a></div>
        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=36&sign=6&filterValue=daoyan" class="arrow" >导演  </a></div>
        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=75&sign=6&filterValue=zp" class="arrow" >制片 </a></div>
        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=48&sign=6&filterValue=cehua" class="arrow" >策划   </a></div>
        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=48&sign=6&filterValue=liyin" class="arrow" >录音 </a></div>
        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=47&sign=6&filterValue=sheying" class="arrow" >摄影 </a>  </div>
        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=48&sign=6&filterValue=shexiang" class="arrow" >摄像 </a></div>
         <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=76&sign=6&filterValue=hqzz" class="arrow" >后期制作 </a></div>
        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=48&sign=6&filterValue=sbzl" class="arrow" >设备租赁 </a></div>
        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=77&sign=6&filterValue=cdzl" class="arrow" >场地租赁 </a></div>
        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=78&sign=6&filterValue=zczq" class="arrow" >作词/作曲 </a></div>
        <div><a target="_blank" href="<%=path %>/query/queryAction!toQuery.htm?signSub=48&sign=6&filterValue=dmt" class="arrow" >多媒体 </a></div>
      </ul>
      </li>
 	</ul>
    <div class="top2-s l">
      
      <form id="headSearchFrom" method="post" action="<%=request.getContextPath() %>/query/queryAction!toQuery.htm">
        <div class="top2-ss l">
          <input name="headKeywords" type="text" class="text" style="width:80px" id="headKeywords" onclick='javascript:this.value=""' value="${headKeywords!=null?headKeywords:'请输入关键词' }" />
        </div>
        <div class="top2-s2 l"><a href="javascript:headSubmit();"><img src="<%=request.getContextPath() %>/theme/images2/ss2.png" width="52" height="34" /></a></div>
        <div class="top2-s3 l" onclick="$('#headKeywords').val('平面模特');headSubmit();">热门：平面模特</div>
      </form>
    </div>
    
  </div>
</div>
<!-- 导航 结束 -->


<script type="text/javascript">
function myFirst(){
	window.location.href="<%=request.getContextPath() %>/member/userinfo!getUserForManager.htm";
}
  
  //用户名框鼠标焦点移进，文字消失
 $("#headKeywords").click(function () {
 var check1 = $(this).val();
 if (check1 == "请输入关键词") {
 $(this).val("");
 $("#headKeywords").css("color","#000000");
 }
 });
//用户名框鼠标焦点移出，默认文字显示
 $("#headKeywords").blur(function () {
 var check1 = $(this).val();
 if (check1 == "") {
 
 $(this).val("请输入关键词");
 $("#headKeywords").css("color","#999999");
 }
 });
 
  

</script>
