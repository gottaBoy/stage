<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.smt.webapp.util.UserSession"%>
<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	UserSession userSession = HttpSessionHelper.getUserSession(request) ;

	String hasNoMy=(String)session.getAttribute("hasNoMy");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns:wb="http://open.weibo.com/wb">
<head>
 <!-- test/index2.jsp    http://192.168.1.100/user/userAction!doTestIndex.htm-->
<title><%=StageVariale.title%></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
<META HTTP-EQUIV="Cache-Control" CONTENT="no-store, must-revalidate"> 
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">



<script type="text/javascript" src="<%=path%>/theme/index/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=path%>/theme/index/js/common.js"></script>
<script type="text/javascript" src="<%=path%>/theme/index/js/select.js"></script>
<script type="text/javascript" src="<%=path%>/theme/index/js/Focus.js"></script>
<script type="text/javascript" src="<%=path%>/theme/index/js/xsgd.js"></script>
 
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/idialog.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
<link rel="stylesheet" href="<%=path%>/theme/index/css/style2.css" />
<link rel="stylesheet" href="<%=path%>/theme/job/css/style3.css" />


<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>


<style type="text/css">
	a.red:hover {color: #FF0000;}
	.pellips{
		width:160px;
		overflow:hidden; 
		display:inline-block;
		height:30px;
	}
	.pellips2{
		width:280px;
		white-space:nowrap; 
		overflow:hidden; 
		text-overflow:ellipsis;
	}
	.pellips3{
		width:320px;
		white-space:nowrap; 
		overflow:hidden; 
		text-overflow:ellipsis;
	}
</style>
<script type="text/javascript">
	
	function handleImgLoadError(oEvent)
   	{
       oEvent.srcElement.src='<%=request.getContextPath()%>/theme/images/no_img_tj.jpg';
	}
	
	function doInfo(url){
		window.open(url);
	}

function pinfen(){}
function publishTask(){
	<%if(userSession != null){%>
		this.location = "<%=request.getContextPath()%>/member/task.htm?userId=<%=userSession.getId() %>";
	<%}else{
		//art.dialog.alert("请先登录！");

			
		String url ="?r="+HttpSessionHelper.urlEncode("/member/task.htm?userId=@{loginUserId}");
		%>
		parent.showPop(2,'<%=request.getContextPath() %>/loginHtml.htm<%=url%>');
	<%}%>
}
</script>


</head>



 <body>
<div class="top Layout">
<div class="top_t">


<%@include file= "/WEB-INF/page/public/top3.jsp"%>

</div>
<div class="top_c">

	<div class="top_c_nav mian Layout">
   	  <%@include file= "/WEB-INF/page/public/menu2.jsp"%>


        

</div>
</div>


        <div class="Content_r">
        	<div class="Focus fl">
            	<div id="slideshow">


                 <s:iterator value="#request.posterList" var="vo" status="st">
                    <a target='_blank' href='<s:property value="#vo.plink"/>' ><img src='<s:property value="#vo.purl"/>' width="652" height="334" /></a>
                </s:iterator> 

                </div>
            </div>
            <div class="rw fr">
            	<div class="rw_t">
                	<ul>
                    	<li id="a1" onclick="setTab('a',1,3)" class="rw_t_li1"><a  class="rw_t_li_a1">发布任务</a></li>
                        <li id="a2" onclick="setTab('a',2,3)" class="rw_t_li2 on"><a class="rw_t_li_a2">包打听</a></li>
                        <li id="a3" onclick="setTab('a',3,3)" class="rw_t_li3"><a  class="rw_t_li_a3">入驻第1舞台</a></li>
                    </ul>
                </div>
                <div class="rw_c">
                	<div class="rw_c1" id="con_a_1" style="display:none;">
                   	  <p><img src="<%=path%>/theme/index/images/rw_c1.png" width="167" height="51" /></p>
                        <div class="rw_c1_fb">
                        	<a href="javascript:publishTask()" ><img src="<%=path%>/theme/index/images/rw_c1_fb.jpg" width="121" height="40" /></a></a>
                        </div>
                  </div>
                  	<div class="rw_c2" id="con_a_2" style="display:block;">
                   	  <p>大项目、活动整包、找人嫌麻烦，交给第1舞台。为您提供高效、优质的项目解决方案。</p>
                        <div class="rw_c2_dh">
                   	    	<img src="<%=path%>/theme/index/images/rw_c2_dh.png" width="203" height="16" />
                         </div>
                  </div>
                  	<div class="rw_c3" id="con_a_3" style="display:none;">
                   	  <p>我是艺人，我要实现我的才艺价值；<br />我是买家，我需要精准的艺人解决方案。</p>
                        <div class="rw_c3_login">
                        	<a href="javascript:showPop(0,'/loginHtml.htm')" ><img src="<%=path%>/theme/index/images/rw_c3_login_dl.jpg" width="80" height="33" /></a><a href="javascript:showPop(1,'/loginHtml.htm')" ><img src="<%=path%>/theme/index/images/rw_c3_login_zc.jpg" width="114" height="33" /></a>
                        </div>
                  </div>
              </div>
                <div class="rw_b">
           	    <img src="<%=path%>/theme/index/images/rw_b.jpg" width="291" height="156" /> </div>
            </div>
            <div class="blank"></div>
            <div class="gzjh">
            	<div class="gzjh_l fl"><h3>工作机会</h3></div>
                <div class="gzjh_c fl">
					<a  target='_blank'  id="b0"  href="<%=path%>/index/indexAction!toJobChance.htm?fromWeb=1" onmouseover="set('b',0,2)"  class="on">通告市集</a>
                	<a   target='_blank'  id="b1" href="<%=path%>/index/indexAction!toJobChance.htm" onmouseover="set('b',1,2)">演艺机会</a><a  target='_blank'  id="b2"  href="<%=path%>/index/indexAction!toJobChance.htm?getZP=true" onmouseover="set('b',2,2)">企业招聘</a>

                </div>
                <div class="gzjh_r2">
                	<h3>签约榜</h3> 
					<ul class="gzjh_r_ul3">
				<s:iterator value="#request.businessList" var="item" status="st">
						<li class="gzjh_r_gs fr pellips2">恭喜艺人
						<s:if test="#item[6]==1"><a  target='_blank' href='<%=path%>/index/orgListAction.htm?id=<s:property value="#item[2]"/>'><s:property value="#item[1]"/></a></s:if>
						<s:else><a target='blank' href='<%=path%>/index/presonList.htm?id=<s:property value="#item[2]"/>'><s:property value="#item[1]"/></a></s:else>
						成功获得<a  target='blank' href='<%=path%>/query/queryAction!toQuery.htm?sign=<s:property value="#item[4]"/>&filterValue=<s:property value="#item[5]"/>'> <s:property value="#item[3]"/></a>工作机会！</li>
				</s:iterator>

                    </ul> 
                </div>
                <div class="gzjh_r" id="con_b_1">
                	<ul class="gzjh_r_ul"  style="display:none">  
                 <s:iterator value="#request.taskList" var="item" status="st">
						<s:if test="#item[1].isOrg==1">
				            <li class="gzjh_r_gs fl " style="cursor:pointer"><a style="cursor:pointer" href='<%=path%>/taskMore/taskMore!toTaskMoreDetail.htm?id=<s:property value="#item[0].id"/>' target="_blank"><span>
					
							 <s:if test="#item[0].title.length()>=26">
	         		<s:property value='#item[0].title.substring(0,26)'/><b>...</b>
	         		</s:if>     
             		<s:else><s:property value="#item[0].title"/></s:else> 

							  </span></a>
							 </li>
						</s:if>
				       <s:else>
				            <li class="gzjh_r_gs fl "  ><a style="cursor:pointer" href='<%=path%>/taskMore/taskMore!toTaskMoreDetail.htm?id=<s:property value="#item[0].id"/>' target="_blank"><span> 
							 <s:if test="#item[0].title.length()>=26">
	         		<s:property value='#item[0].title.substring(0,26)'/><b>...</b>
	         		</s:if>     
             		<s:else><s:property value="#item[0].title"/></s:else>
					</span></a>
							 </li> 
					    </s:else>
                 </s:iterator>
					</ul>
                </div>
                <div class="gzjh_r" id="con_b_2">
                	<ul class="gzjh_r_ul2" style="display:none">
				<s:iterator value="#request.zhaopinList" var="item" status="st">
							<li class="gzjh_r_gs fl "  style="cursor:pointer"><a style="cursor:pointer" href="<%=path%>/index/orgListAction.htm?id=<s:property value="#item[1].userId"/>&actionName=orgZhaoPin#orgTab" target="_blank">
							<em><s:property value="#item[1].nickName"/></em><span>
 <s:if test="#item[0].title.length()>=10">
	         		<s:property value='#item[0].title.substring(0,10)'/><b>...</b>
	         		</s:if>     
             		<s:else><s:property value="#item[0].title"/></s:else>
</span></a>
							</li>
				 </s:iterator>

                    </ul>
                </div>

                <div class="gzjh_r" id="con_b_0">
                	<ul class="gzjh_r_ul0">

                 <s:iterator value="#request.tgsjList" var="item" status="st">
						<s:if test="#item[1].isOrg==1">
				            <li class="gzjh_r_gs fl " style="cursor:pointer"><a style="cursor:pointer" href='<%=path%>/taskMore/taskMore!toTaskMoreDetail.htm?fromWeb=1&id=<s:property value="#item[0].id"/>' target="_blank"><span>
					
							 <s:if test="#item[0].title.length()>26">
	         		<s:property value='#item[0].title.substring(0,26)'/><b>...</b>
	         		</s:if>     
             		<s:else><s:property value="#item[0].title"/></s:else> 

							  </span></a>
							 </li>
						</s:if>
				       <s:else>
				            <li class="gzjh_r_gs fl "  ><a style="cursor:pointer" href='<%=path%>/taskMore/taskMore!toTaskMoreDetail.htm?fromWeb=1&id=<s:property value="#item[0].id"/>' target="_blank"><span> 
							 <s:if test="#item[0].title.length()>26">
	         		<s:property value='#item[0].title.substring(0,26)'/><b>...</b>
	         		</s:if>     
             		<s:else><s:property value="#item[0].title"/></s:else>
					</span></a>
							 </li>
					    </s:else>
                 </s:iterator>

                    </ul>
                </div>

            </div>
        </div>
    </div>
  

<!-- org start-->
<s:action name="index3Action" namespace="" executeResult="true">
        	<s:param name="prof" value="9"></s:param>
</s:action>
<!-- org end-->
<!-- new man -->
<s:action name="index3Action" namespace="" executeResult="true">
        	<s:param name="prof" value="1"></s:param>
</s:action>

<!-- yan yuan -->
<s:action name="index3Action" namespace="" executeResult="true">
        	<s:param name="prof" value="2"></s:param>
</s:action>

<!-- yin yue -->
<s:action name="index3Action" namespace="" executeResult="true">
        	<s:param name="prof" value="3"></s:param>
</s:action>
</div>

<!-- wu dao -->
<div class="mian2 Layout">
<s:action name="index3Action" namespace="" executeResult="true">
        	<s:param name="prof" value="4"></s:param>
</s:action>
</div>

<!-- mo te -->
<div class="mian2 Layout">
<s:action name="index3Action" namespace="" executeResult="true">
        	<s:param name="prof" value="5"></s:param>
</s:action>
</div>

<!-- da ren -->
<div class="mian2 Layout">
<s:action name="index3Action" namespace="" executeResult="true">
        	<s:param name="prof" value="6"></s:param>
</s:action>


<!-- mu hou -->
<s:action name="index3Action" namespace="" executeResult="true">
        	<s:param name="prof" value="7"></s:param>
</s:action>
</div>
<div class="blank2"></div>





<jsp:include page="/WEB-INF/page/public/footer.jsp"></jsp:include>

</body>
</html>
