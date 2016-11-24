<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="org.apache.struts2.ServletActionContext"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
<!-- cost/toAddCostByJs.jsp -->
<%
String costPrimaryKey = request.getParameter("costId");
String save = request.getParameter("save");
String index = request.getParameter("index");
String add = request.getParameter("add");
String addUser = request.getParameter("addUser");
if(addUser==null){
	addUser = "";
}

if(add != null){
		//clear session
		session.removeAttribute("costValueSession_"+index);
		session.removeAttribute("costInfo_"+index);
}
//out.println("................................index="+index);

    String price =  "";
    String typeName =  "";
    String flag =  "";
    String keywords =  "";
    String unit = "";

int cost1=0,cost2=0,cost3=0,cost4=0;
if(index != null){
    com.smt.entity.CostValueSession costValueSessionIndex = (com.smt.entity.CostValueSession)session.getAttribute("costValueSession_"+index);
    if(costValueSessionIndex!=null){
        cost1 = costValueSessionIndex.getCost1();
        cost2 = costValueSessionIndex.getCost2();
        cost3 = costValueSessionIndex.getCost3();
        cost4 = costValueSessionIndex.getCost4();
    }

    com.smt.entity.TAppCostInfo costInfo = (com.smt.entity.TAppCostInfo)    session.getAttribute("costInfo_"+index);
    if(costInfo!=null){
        price =     ""+costInfo.getBprice();
        com.smt.entity.TAppTalentCategory  category = costInfo.getCategory();
        typeName = "";//category.getTypeName();
        flag = "";//category.getFlag();
        keywords = costInfo.getKeywords();
        unit = costInfo.getUnit();

        //out.println("................................price="+price+" cost1="+cost1+" cost2="+cost2+" cost3="+cost3+" keywords="+keywords+" unit="+unit);
    }
}
%>

    <title><%=StageVariale.title%></title>
    <style>
html,body {
    margin: 0; /* Remove body margin/padding */
    padding: 0;
    overflow: auto; /* Remove scroll bars on browser window */
    font: 12px "Lucida Grande", "Lucida Sans Unicode", Tahoma, Verdana;
}
</style>
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">    
    <meta http-equiv="description" content="<%=StageVariale.description%>">

    
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/idialog.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/zhezhao.css" />
    
    <script type='text/javascript' src='<%=request.getContextPath() %>/dwr/interface/costDao.js'></script> 
    <script type='text/javascript' src='<%=request.getContextPath() %>/dwr/engine.js'></script>
    <script type='text/javascript' src='<%=request.getContextPath() %>/dwr/util.js'></script>

    <script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
    <script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
    <script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
    <script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
    <script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>
    <script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/common.js"></script>
    <script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/combox.js"></script>

    <script type="text/javascript">
        function checknull(){
			var cost1_Id =  document.getElementById("cost1").value;
			if(cost1_Id=="0"){
                art.dialog.tips("请选择职业！", 2);
				return false;
			}

            var bprice=$("#costInfo\\.bprice").val();
            var unit=$("#costInfo\\.unit").val();
            var keywords = $("#costInfo\\.keywords").val(); 

            if(keywords==""){
                art.dialog.tips("细分名称不能为空！", 2);
                $("#costInfo\\.keywords").focus();
                return false;
            }
			var keywordsArr = keywords.split(",");
			for(var i=0; i<keywordsArr.length; i++){
				var keywordsIn = keywordsArr[i];
				var keywordsArrIn = keywordsIn.split("，");
				for(var j=0; j<keywordsArrIn.length; j++){
					//var re=/^([\u4E00-\u9FA5]|[\uFE30-\uFFA0]|[a-z])*$/gi;
					var re=/^([a-z]|[A-Z]|[\u4E00-\u9FA5]|[\uFE30-\uFFA0])*$/gi;
					if(!re.test(keywordsArrIn[j])){
					   art.dialog.tips("细分名称不能有数字，符号！", 2);
						$("#costInfo\\.keywords").focus();
						return false;
					}
					if(keywordsArrIn[j].length>6){
						art.dialog.tips("细分名称长度不能超过6个字！", 2);
						$("#costInfo\\.keywords").focus();
						return false;
					}
				}
			}

            if(bprice==""){
                art.dialog.tips("价格不能为空！", 2);
                $("#costInfo\\.bprice").focus();
                return false;
            }

            if(unit==""){
                art.dialog.tips("单位不能为空！", 2);
                $("#costInfo\\.unit").focus();
                return false;
            }
            if(unit.length>4){
                art.dialog.tips("单位长度不能超过4个汉字！", 2);
                $("#costInfo\\.unit").focus();
                return;
            }

            return true;
        }

        function saveCost(){
            var price=$("#costInfo\\.bprice").val();
            var unit=$("#costInfo\\.unit").val();
            var keywords = $("#costInfo\\.keywords").val(); 

            if(checknull()){
                    var costId=0;
                    var cost1_Id =  document.getElementById("cost1").value;
                    var cost2_Id =  document.getElementById("cost2").value;
                    var cost3_Id =  document.getElementById("cost3").value;     
                    var cost4_Id =  document.getElementById("cost4").value;     
                     if(cost4_Id && parseInt(cost4_Id)>0){
                           costId = cost4_Id;
                     }else if(cost3_Id && parseInt(cost3_Id)>0){
                           costId = cost3_Id;
                     }else if(cost2_Id && parseInt(cost2_Id)>0){
                           costId = cost2_Id;
                     }else if(cost1_Id && parseInt(cost1_Id)>0){
                           costId = cost1_Id;
                     }
                    /*
                    if(cost3_Id=='' || cost3_Id == -1){  
                         if(cost2_Id=='' || cost2_Id == -1){
                            costId=cost1_Id;
                         } else{
                            costId=cost2_Id;
                         }                                       
                    }else{
                        costId=cost3_Id;
                    }
                   */
                    
                    $.post('<%=request.getContextPath()%>/member/cost!checkCostIdForSession.htm?addUser=<%=addUser%>&index=<%=index%>&costId='+costId+"&cost1="+cost1_Id+"&cost2="+cost2_Id+"&cost3="+cost3_Id+"&cost4="+cost4_Id,
                        function(data){
                            if(data==1){
                                art.dialog.tips("您已添加该职业，不能再添加！");
                            } else {
                                $.ajax({
                                   url:"<%=request.getContextPath() %>/member/cost!saveCost.htm?norSign=<%=request.getParameter("sign")%>&index=<%=index%>",
                                   type:'POST',
                                   data:$("#costForm").serialize(),
                                   success:function(data1){
                                       if(data1 == 1){
                                           //parent.getUserInfoCost();
                                           //parent.getUserInfo2();
                                           <%if(costPrimaryKey!=null){
                                                     if(save!=null){                      %>
                                                         saveContent(<%=index%>,price,unit,keywords,costId,<%=costPrimaryKey%>);
                                               <%}else{%>
                                                         parent.showContent(<%=index%>,price,unit,keywords,costId,<%=costPrimaryKey%>);
                                                         art.dialog.close();
                                               <%}%>
                                           <%}else{%>
                                                      parent.showContent(<%=index%>,price,unit,keywords,costId);
                                                      art.dialog.close();
                                           <%}%>
                                           
                                       }
                                   }
                                });
                            }
                        },"html");
                   } 
        }        
 
 
  
function saveContent(id,price,unit,keywords,profession,costId){
		$.ajax({
				url:"<%=request.getContextPath() %>/member/userinfo!onlySaveCost.htm?addUser=<%=addUser%>&price="+price+"&unit="+encodeURI(unit)+"&keywords="+encodeURI(keywords)+"&profession="+encodeURI(profession)+"&costId="+costId+"&index="+id,
				type:'POST',
				data: {norSign:'<%=request.getParameter("sign")%>'},
				success:function(data){
					if(data=="1"){
						location.reload();
                        art.dialog.close();
					}
				}
		});
}
    
    function change1()
    {
        var cost1_Id = $("#cost1").val();
        $("#cost3").html('');
        $("#cost4").html('');
        $("#cost3").hide();
        $("#cost4").hide();

        //默认为不选择
        if(cost1_Id == '0'){
            $("#cost2").html('');
            $("#cost2").hide();
        }else{  
            $.combox.load("#cost2","<%=request.getContextPath()%>/member/cost!getSelectedTalentByParentId.htm?flag="+cost1_Id+"&userId=0","","--请选择--");  
        }   
        displayTips(cost1_Id);
    }
    
    function change2()
    {
      var cost2_Id =  document.getElementById("cost2").value;
      $("#cost4").html('');
      $("#cost4").hide();
        //默认为不选择
        if(cost2_Id == '0'){
            $("#cost3").html('');
            $("#cost3").hide();
        }else{
            $.combox.load("#cost3","<%=request.getContextPath()%>/member/cost!getSelectedTalentByParentId.htm?flag="+cost2_Id+"&userId=0","","--请选择--");  
        }
        displayTips(cost2_Id);
    }

    function change4()
    {
      var cost4_Id =  document.getElementById("cost4").value;
        displayTips(cost4_Id);
    }

    function change3()
    {
      var cost3_Id =  document.getElementById("cost3").value;
        //默认为不选择
        if(cost3_Id == '0'){
            $("#cost4").html('');
            $("#cost4").hide();
        }else{
            $.combox.load("#cost4","<%=request.getContextPath()%>/member/cost!getSelectedTalentByParentId.htm?flag="+cost3_Id+"&userId=0","","--请选择--");  
        }
        displayTips(cost3_Id);
    }

function displayTips(id){
      if(parseInt(id)==10){
            $("#tips").html("（如京剧演员，相声演员，评弹演员等，多个细分项之间用逗号隔开，每个细分项不超过6个字）");
      }else if (parseInt(id)==8){
            $("#tips").html("（如儿童演员，武打演员等，多个细分项之间用逗号隔开，每个细分项不超过6个字）");
      }else if (parseInt(id)==9){
            $("#tips").html("（如音乐剧演员，儿童剧演员等，多个细分项之间用逗号隔开，每个细分项不超过6个字）");
      }else if (parseInt(id)==49){
            $("#tips").html("（如游戏配音，广告配音，影视配音等，多个细分项之间用逗号隔开，每个细分项不超过6个字）");
      }else if (parseInt(id)==11){
            $("#tips").html("（多个细分项之间用逗号隔开，每个细分项不超过6个字）");
      }else if (parseInt(id)==7){
            $("#tips").html("（婚庆司仪，路演主持等，多个细分项之间用逗号隔开，每个细分项不超过6个字）");
      }else if (parseInt(id)==53){
            $("#tips").html("（如近景魔术、舞台魔术、巨型魔术等，多个细分项之间用逗号隔开，每个细分项不超过6个字） ");
      }else if (parseInt(id)==54){
            $("#tips").html("（如顶技，车技，绳技等，多个细分项之间用逗号隔开，每个细分项不超过6个字）");
      }else if (parseInt(id)==60){
            $("#tips").html("（如小提琴、中提琴、大提琴等，多个细分项之间用逗号隔开，每个细分项不超过6个字）  ");
      }else if (parseInt(id)==61){
            $("#tips").html("（如长笛、双簧管、单簧管等，多个细分项之间用逗号隔开，每个细分项不超过6个字）");
      }else if (parseInt(id)==62){
            $("#tips").html("（如小号、长号、大号等，多个细分项之间用逗号隔开，每个细分项不超过6个字）");
      }else if (parseInt(id)==63){
            $("#tips").html("（如钢琴、管风琴、手风琴等，多个细分项之间用逗号隔开，每个细分项不超过6个字）");
      }else if (parseInt(id)==64){
            $("#tips").html("（如大鼓、架子鼓、钟琴、木琴等，多个细分项之间用逗号隔开，每个细分项不超过6个字）");
      }else if (parseInt(id)==65){
            $("#tips").html("（如箫、唢呐、埙、巴乌、芦笙等，多个细分项之间用逗号隔开，每个细分项不超过6个字）");
      }else if (parseInt(id)==66){
            $("#tips").html("（如琵琶、筝、扬琴、古琴等，多个细分项之间用逗号隔开，每个细分项不超过6个字）");
      }else if (parseInt(id)==67){
            $("#tips").html("（如铜鼓、木鱼、杵、木鼓等，多个细分项之间用逗号隔开，每个细分项不超过6个字）");
      }else if (parseInt(id)==68){
            $("#tips").html("（如二胡、马头琴、高胡、拉线口弦等，多个细分项之间用逗号隔开，每个细分项不超过6个字）");
      }else if (parseInt(id)==18){
            $("#tips").html("（多个细分项之间用逗号隔开，每个细分项不超过6个字）");
      }else if (parseInt(id)==44){
            $("#tips").html("（如街舞，迪斯科，热舞等，多个细分项之间用逗号隔开，每个细分项不超过6个字）");
      }else if (parseInt(id)==26){
            $("#tips").html("（如服装模特、展示模特、表演模特等，多个细分项之间用逗号隔开，每个细分项不超过6个字）");
      }else if (parseInt(id)==25){
            $("#tips").html("（如平面模特、影视模特等，多个细分项之间用逗号隔开，每个细分项不超过6个字）");
      }else if (parseInt(id)==46){
            $("#tips").html("（如腿型模特，发型模特，人体模特等，多个细分项之间用逗号隔开，每个细分项不超过6个字）");
      }else if (parseInt(id)==73){
            $("#tips").html("（如少儿模特，老年模特等，多个细分项之间用逗号隔开，每个细分项不超过6个字）");
      }else if (parseInt(id)==28){
            $("#tips").html("（如跑酷，跳伞，冲浪，滑雪等，多个细分项之间用逗号隔开，每个细分项不超过6个字）");
      }else if (parseInt(id)==29){
            $("#tips").html("（如太极拳，剑术，集体刀，推手等，多个细分项之间用逗号隔开，每个细分项不超过6个字）");
      }else if (parseInt(id)==30){
            $("#tips").html("（请填写你的特殊技能名称，多个细分项之间用逗号隔开，每个细分项不超过6个字）");
      }else if (parseInt(id)==77){
            $("#tips").html("（如剧场、会所、录音棚等，多个细分项之间用逗号隔开，每个细分项不超过6个字）");
      }else{
            $("#tips").html("（多个细分项之间用逗号隔开，每个细分项不超过6个字）");
      }

}


$(function(){
        $("#cost2").html('');
        $("#cost3").html('');
        $("#cost4").html('');
        $.combox.load("#cost1","<%=request.getContextPath()%>/member/cost!getSelectedTalentByParentId.htm?flag=0&userId=0","<%=cost1%>","--请选择--");  
        displayTips("<%=cost1%>");
        <%if(cost2 > 0){%>
              $.combox.load("#cost2","<%=request.getContextPath()%>/member/cost!getSelectedTalentByParentId.htm?flag=<%=cost1%>&userId=0","<%=cost2%>","--请选择--");  
              displayTips("<%=cost2%>");
         <%}%>
         <%if(cost3 > 0){%>
              $.combox.load("#cost3","<%=request.getContextPath()%>/member/cost!getSelectedTalentByParentId.htm?flag=<%=cost2%>&userId=0","<%=cost3%>","--请选择--");  
              displayTips("<%=cost3%>");
         <%}%>
         <%if(cost4 > 0){%>
              $.combox.load("#cost4","<%=request.getContextPath()%>/member/cost!getSelectedTalentByParentId.htm?flag=<%=cost3%>&userId=0","<%=cost4%>","--请选择--");  
              displayTips("<%=cost4%>");
         <%}%>
});
        
 
    </script>
  </head>
  <body >
    <form id="costForm" name="costForm" action="member/cost!saveCost.htm?addUser=<%=addUser%>" method="post">
	<input type="hidden" name="addUser" id="addUser" value="<%=addUser%>">

<div  style="height:450px;">
  <span class="zhezhaoClose" title="关闭"></span>
    

<div class="jineng">
<div class="jineng_left">
<h3>职业技能</h3>
<ul>
<li>
    <div class="name"> 职业：</div>
<table>
    <tr>
        <td>
            <select name="cost1" id="cost1"  onchange="change1();">

            </select>
        </td>
        <td> 
                <select  name="cost2" id="cost2" onchange="change2();" style="display: none">
                </select> 
        </td>
        <td>
                <select  name="cost3" id="cost3" onchange="change3();"  style="display: none">
                </select>
        </td>
        <td>
                <select  name="cost4" id="cost4" onchange="change4();"  style="display: none">
                </select>
        </td>
    </tr>
</table>

</li>
<li>
    <div class="name"> 细分名称：</div>
    <input name="costInfo.keywords" id="costInfo.keywords" value="<%=keywords%>"><span id="tips">如箫、唢呐、埙、巴乌、芦笙等，多个细分项之间用逗号隔开，每个细分项不超过6个字。</span>
</li>
<li>
    <div class="name"> 价格：</div>
    <input class="duan" name="costInfo.bprice" id="costInfo.bprice"  value="<%=price%>"/> <div style="float:left;font:normal 14px/32px 微软雅黑; margin-right:10px; height:32px;">/</div><input  size='2' style='width:30px;'  name="costInfo.unit" id="costInfo.unit"  value="<%=unit%>"/>
    <font style="font:normal 12px/32px 微软雅黑; height:32px;">(单位)场、次、小时、天等</font>
</li>
<li>
<div class="tianjia">亲，请合理填写您的职业价格，这将直接影响到客户与您的交易意向哦。</div>
</li>

<li>
<a href="#"></a>
</li>
</ul>
</div>
<div class="baocun2" style="text-align:center;width:100%;">
<a href="javascript:saveCost()"  style="text-decoration: none;margin:0 auto;" >保存</a> 
</div>
</div>
  

    
 


        </form>
  </body>
</html>