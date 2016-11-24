<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/idialog.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/artDialog.js"></script>

	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>


              </div>
            </li>
            <li><a href="/"  target="_top">首页</a></li>
            <li><a href="<%=path %>/index/indexAction!toNovice.htm"  target="_top">新手上路</a></li>
            <li><a href="<%=path %>/index/indexAction!toOrg.htm"  target="_top">机构</a></li>
            <li><a href="<%=path %>/index/indexAction!toJobChance.htm"  target="_top">工作机会</a></li>
      	</ul>
      </div>
        <div class="top_c_nav_r fr">
<form action="<%=path %>/user/userAction!doLogin.htm" method="post" id="loginFrom"  target="_top">  
        	<img src="<%=path %>/theme/fenlei/images/login.png" width="16" height="16" />
            <input type="text" name="user.username" id="username"  class="top_c_nav_r_input"  style="height: 20px;width: 165px"/>
            <img src="<%=path %>/theme/fenlei/images/password.png" width="11" height="15" />
            <input type="password" name="user.userPsd" id="userPsd"  class="top_c_nav_r_input"   style="height: 20px;width: 165px" />
            <input type="button" class="top_c_nav_r_submit" value="" onclick="login()"/>
</form>

       	</div>
    </div>
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
							  window.top.location.reload();
							  
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