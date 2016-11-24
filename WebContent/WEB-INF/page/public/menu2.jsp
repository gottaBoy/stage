<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/idialog.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/artDialog.js"></script>

	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
 <style>
	 #indexhead a{display:inline; margin:0 20px; font-size:14px; color:#FFF;}
 </style>
<div class="top_c_nav_l fl" id="indexhead" style=" line-height:45px; margin-left:-60px;">
	<a>全部服务分类</a>
	<a href="/" title="首页">首页</a>
	<a href="<%=path %>/index/indexAction!toNovice.htm" >新手上路</a>
	<a href="<%=path %>/index/indexAction!toOrg.htm" >机构</a>
	<a href="<%=path %>/index/indexAction!toJobChance.htm" >工作机会</a>
</div>

<div class="top_c_nav_r fr">
	<form action="<%=path %>/user/userAction!doLogin.htm" method="post" id="loginFrom" >  
				<img src="<%=path %>/theme/fenlei/images/login.png" width="16" height="16" />
				<input type="text" name="user.username" id="username"  class="top_c_nav_r_input" />
				<img src="<%=path %>/theme/fenlei/images/password.png" width="11" height="15" />
				<input type="password" name="user.userPsd" id="userPsd"  class="top_c_nav_r_input" />
				<input type="button" class="top_c_nav_r_submit" value="" onclick="login()"/>
	</form>
</div>
    </div>
</div>
</div>
   

<div class="mian2 Layout">
	<div class="main_content Layout">
    	<div class="Cnav fl">
				  <div class="item">

          <div class="product">
            <h3>找演员</h3>
            <p class="Cnav_Column"><a href="<%=path%>/index/indexAction!toFenlei.htm?signSub=49&sign=1&filterValue=zhuchi" >主持司仪</a><a href="<%=path%>/index/indexAction!toFenlei.htm?signSub=8&sign=1&filterValue=ysyy">影视演员</a><a href="<%=path%>/index/indexAction!toFenlei.htm?signSub=7&sign=1&filterValue=pyyy" >配音演员</a></p>
            <span class="product_Arrow"></span>
          </div>
          <div class="product_wrap posOne"> 
            <div class="product_wrap_c">
            	<h2><a style="color:#E20822" href="<%=path %>/index/indexAction!toFenlei.htm?signSub=1&sign=0&filterValue=yanyuan">找演员</a></h2>
                <ul>
                    <li><a href="<%=path%>/index/indexAction!toFenlei.htm?signSub=49&sign=1&filterValue=zhuchi" >主持司仪</a></li>
                    <li><a href="<%=path%>/index/indexAction!toFenlei.htm?signSub=7&sign=1&filterValue=pyyy" >配音演员</a></li>
                    <li><a href="<%=path%>/index/indexAction!toFenlei.htm?signSub=8&sign=1&filterValue=ysyy" >影视演员</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=9&sign=1&filterValue=wtjyy" >舞台剧演员</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=10&sign=1&filterValue=qyyy" >曲艺演员</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=11&sign=1&filterValue=txyy" >特型演员</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=53&sign=1&filterValue=moshu" >魔术</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=54&sign=1&filterValue=zaji" >杂技</a></li>
                </ul>
            </div>
          </div>

                  </div>
                  <div class="item">
  
          <div class="product">
            <h3>找音乐</h3>
            <p class="Cnav_Column"><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=12&sign=2&filterValue=yueqi"  class="Cnav_Column_margin">乐器</a><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=13&sign=2&filterValue=geshou"  class="Cnav_Column_margin">歌手</a><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=14&sign=2&filterValue=yuedui"  class="Cnav_Column_margin">乐队</a></p>
            <span class="product_Arrow"></span>
          </div>
          <div class="product_wrap posTwo"> 
            <div class="product_wrap_c">
            	<h2><a style="color:#E20822" href="<%=path %>/index/indexAction!toFenlei.htm?signSub=12&sign=2&filterValue=yueqi">乐器</a></h2>
                <h3><a style="color:#E20822" href="<%=path %>/index/indexAction!toFenlei.htm?signSub=15&sign=12&filterValue=mzyq">民族乐器</a></h3>
                <ul>
                	<li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=65&sign=2&filterValue=czyq" >吹奏乐器</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=66&sign=2&filterValue=tbyq" >弹拨乐器</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=67&sign=2&filterValue=djyq" >打击乐器</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=68&sign=2&filterValue=lxyq" >拉弦乐器</a></li>
                </ul>
                <h3><a style="color:#E20822" href="<%=path %>/index/indexAction!toFenlei.htm?signSub=16&sign=12&filterValue=xyyq">西洋乐器</a></h3>
                <ul>
                	<li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=60&sign=2&filterValue=xyyq" >弦乐乐器</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=61&sign=2&filterValue=mgyq" >木管乐器</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=62&sign=2&filterValue=tgyq" >铜管乐器</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=63&sign=2&filterValue=jpyq" >键盘乐器</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=64&sign=2&filterValue=djyq" >打击乐器</a></li>
                </ul>
            </div>
            <hr class="product_wrap_hr" />
            <div class="product_wrap_c">
            	<h2><a style="color:#E20822" href="<%=path %>/index/indexAction!toFenlei.htm?signSub=13&sign=2&filterValue=geshou">歌手</a></h2>
                <ul>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=18&sign=2&filterValue=tsgs" >流行歌手</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=19&sign=2&filterValue=yggs" >摇滚歌手</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=39&sign=2&filterValue=msgs" >美声歌手</a></li>
                	<li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=17&sign=2&filterValue=mzgs" >民族歌手</a></li>
                	<li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=100&sign=2&filterValue=gdgs" >古典歌手</a></li>

                	<li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=101&sign=2&filterValue=myxcgs" >民谣/乡村歌手</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=20&sign=2&filterValue=jsgs" >爵士歌手</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=40&sign=2&filterValue=scgs" >说唱歌手</a></li>

                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=102&sign=2&filterValue=dzgs" >电子歌手</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=103&sign=2&filterValue=xsjyygs" >世界音乐/新世纪音乐歌手</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=42&sign=2&filterValue=xzc" >合唱歌手</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=41&sign=2&filterValue=dlgs" >独立歌手</a></li>
 
                </ul>
            </div>
            <hr class="product_wrap_hr" />
            <div class="product_wrap_c">
            	<h2><a style="color:#E20822" href="<%=path %>/index/indexAction!toFenlei.htm?signSub=14&sign=2&filterValue=yuedui">乐队</a></h2>
                <ul>
                	<li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=104&sign=2&filterValue=gxyd">管弦乐队</a></li> 
                	<li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=105&sign=2&filterValue=ygyd">摇滚乐队</a></li> 
                	<li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=106&sign=2&filterValue=jsyd">爵士乐队 </a></li> 
                	<li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=107&sign=2&filterValue=lxyd">流行乐队</a></li> 
                	<li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=108&sign=2&filterValue=dsyd">电声乐队</a></li> 


                </ul>
            </div>
          </div>


                  </div>
                  <div class="item">
                 

         <div class="product">
            <h3>找舞蹈</h3>
            <p class="Cnav_Column"><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=69&sign=3&filterValue=gdw" >古典舞</a><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=21&sign=3&filterValue=gjw" >拉丁舞</a><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=70&sign=3&filterValue=mdw" >摩登舞</a></p>
            <span class="product_Arrow"></span>
          </div>
          <div class="product_wrap posThree"> 
            <div class="product_wrap_c">
            	<h2><a style="color:#E20822" href="<%=path %>/index/indexAction!toFenlei.htm?signSub=3&sign=0&filterValue=wudao">找舞蹈</a></h2>
                <ul>
                	<li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=69&sign=3&filterValue=gdw" >古典舞</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=21&sign=3&filterValue=gjw" >拉丁舞</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=70&sign=3&filterValue=mdw" >摩登舞</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=22&sign=3&filterValue=blw" >芭蕾舞</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=23&sign=3&filterValue=mzw" >民族舞</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=71&sign=3&filterValue=mjw" >民间舞</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=24&sign=3&filterValue=xdw" >现代舞</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=72&sign=3&filterValue=ttw" >踢踏舞</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=43&sign=3&filterValue=jsw" >爵士舞</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=44&sign=3&filterValue=sswd" >时尚舞</a></li>
                </ul>
            </div>
          </div>


                  </div>
                  <div class="item">
                 
         <div class="product">
            <h3>找模特</h3>
            <p class="Cnav_Column"><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=26&sign=4&filterValue=ttmt">T台模特</a><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=25&sign=4&filterValue=pmmt">广告模特</a><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=46&sign=4&filterValue=txmt">特型模特</a></p>
            <span class="product_Arrow"></span>
          </div>
          <div class="product_wrap posFour"> 
            <div class="product_wrap_c">
            	<h2><a style="color:#E20822" href="<%=path %>/index/indexAction!toFenlei.htm?signSub=4&sign=0&filterValue=mote">找模特</a></h2>
                <ul>
                	<li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=26&sign=4&filterValue=ttmt" >T台模特</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=25&sign=4&filterValue=pmmt" >广告模特</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=46&sign=4&filterValue=txmt" >特型模特</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=73&sign=4&filterValue=tsnlmt" >特殊年龄模特</a></li>
                </ul>
            </div>
          </div>


                  </div>
                  <div class="item">
                  
          <div class="product">
            <h3>找达人</h3>
            <p class="Cnav_Column"><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=28&sign=5&filterValue=jixian" >极限达人</a><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=29&sign=5&filterValue=wushu" >武术达人</a><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=30&sign=5&filterValue=niuren" >牛人</a></p>
            <span class="product_Arrow"></span>
          </div>
          <div class="product_wrap posFive"> 
            <div class="product_wrap_c">
            	<h2><a style="color:#E20822" href="<%=path %>/index/indexAction!toFenlei.htm?signSub=5&sign=0&filterValue=daren">找达人</a></h2>
                <ul>
                	<li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=28&sign=5&filterValue=jixian" >极限达人</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=29&sign=5&filterValue=wushu" >武术达人</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=30&sign=5&filterValue=niuren" >牛人</a></li>
                </ul>
            </div>
          </div>

                  </div>
                  <div class="item">

         <div class="product">
            <h3>找幕后</h3>
            <p class="Cnav_Column"><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=32&sign=6&filterValue=dengguang">舞美/灯光</a><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=33&sign=6&filterValue=fuzhuang">服装</a><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=35&sign=6&filterValue=huazhuang">化妆/造型</a></p>
            <span class="product_Arrow"></span>
          </div>
          <div class="product_wrap posSix"> 
            <div class="product_wrap_c">
            	<h2><a style="color:#E20822" href="<%=path %>/index/indexAction!toFenlei.htm?signSub=6&sign=0&filterValue=muhou">找幕后</a></h2>
                <ul>
                	<li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=32&sign=6&filterValue=dengguang" >舞美/灯光</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=33&sign=6&filterValue=fuzhuang" >服装</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=35&sign=6&filterValue=huazhuang" >化妆/造型</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=34&sign=6&filterValue=daoju" >道具</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=74&sign=6&filterValue=bd" >编导</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=37&sign=6&filterValue=biannju" >编剧</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=36&sign=6&filterValue=daoyan" >导演</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=75&sign=6&filterValue=zp" >制片</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=48&sign=6&filterValue=cehua" >策划</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=48&sign=6&filterValue=liyin" >录音</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=47&sign=6&filterValue=sheying">摄影 </a>  </li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=48&sign=6&filterValue=shexiang" >摄像</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=76&sign=6&filterValue=hqzz" >后期制作</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=48&sign=6&filterValue=sbzl" >设备租赁</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=77&sign=6&filterValue=cdzl" >场地租赁</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=78&sign=6&filterValue=zczq" >作词/作曲</a></li>
                    <li><a href="<%=path %>/index/indexAction!toFenlei.htm?signSub=48&sign=6&filterValue=dmt" >多媒体</a></li>
                </ul>
            </div>
     </div>

 

<script language="javascript">

function login(){
		var userName= $("#username").val();
		var userPsd=$("#userPsd").val();
		if(userName==""){
			art.dialog.tips("请输入用户名！");
			return;
		}
		if(userPsd==""){
			art.dialog.tips("请输入密码！");
			return;
		}
		
		$.ajax({
		   url:"/user/userAction!check.htm",
		   type:'POST',
		   data:$("#loginFrom").serialize(),
		   success:function(data2){
			   if(data2 == "2"){
				  $.ajax({
					 url:"/user/userAction!doLogin.htm",
					 type:'POST',
					 data:$("#loginFrom").serialize(),
					 success:function(data1){
						 if(data1=="1"){
							  //parent.hide(null);
							  window.parent.location.reload();
							  
							  //window.location.href ="/index.html";
						
							  //history.go(-1);
						 }
					 }
				  });
				  //$("#loginFrom").submit();
				  
			  }else if(data2=="1"){
				  art.dialog.tips("用户名不存在！");
			  }else if(data2=="0"){
				  art.dialog.tips("密码错误！");
			  }
		   }
		});
		
		
		
}

</script>