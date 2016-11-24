<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    
    <title><%=StageVariale.title%></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>

	<script type="text/javascript">

		
		
		
		function confrim() {
			document.getElementById("alipayment").submit();
			
			var time = 0;
			var timer = setInterval(function(){			  
				time++;
				if(time == 3) {
					clearInterval(timer);
					$("#contentTable").css("display", "none");
					$("#comfirmTable").css("display", "");
				}
			},1000);
		}
		
		function reloadPage() {
			//alert(window.location.href);
			//window.location.href=window.location.href;
			parent.location.reload();
		}
	</script>
	<style type="text/css">
		span {
			display:-moz-inline-box;
			display:inline-block;
			border-bottom:1px solid #000000;
		}
		body {
			font-size:16px;
		}
	</style>
		
  </head>
  <body>
  	<div style="width:700px; margin-left: auto; margin-right: auto;">
  	
<div style="font-size:20px; font-weight:bold; text-align: center; padding-top: 30px;"><span style="text-align: center; width:200px;">&nbsp;&nbsp;asd&nbsp;&nbsp;</span>服务委托合同</div>

<div style="font-size:16px; font-weight:bold; padding-top: 10px;">委 托 方：<span style="text-align: center; width:500px;">&nbsp;&nbsp;asd&nbsp;&nbsp;</span>（简称“甲方”）</div>
<div style="font-size:16px; font-weight:bold; padding-top: 10px;">受 托 方：<span style="text-align: center; width:500px;">&nbsp;&nbsp;asd&nbsp;&nbsp;</span>（简称“乙方”）</div>
<div style="font-size:16px; font-weight:bold; padding-top: 10px;">见 证 方：<span style="text-align: center; width:500px;">&nbsp;&nbsp;asd&nbsp;&nbsp;</span>（简称“丙方”）</div>

<div style="padding-top: 20px; line-height: 25px;">&nbsp;&nbsp;&nbsp;&nbsp;甲、乙双方在自愿平等的基础上，经友好协商，通过丙方网站（即“第1舞台”网站，域名:www.d15t.com）并在其见证下，就乙方向甲方提供<span style="text-align: center; width:260px;">&nbsp;&nbsp;asd&nbsp;&nbsp;</span>服务相关事宜，达成如下协议,以兹共同遵守：</div>

<div style="padding-top: 10px;">1 声明或保证</div>
<div style="padding-top: 10px;">1.1 甲方保证：</div>
<div style="padding-top: 10px; line-height: 25px;">1.1.1 其为依法成立、享有完全民事权利能力和民事行为能力、并取得法律法规规定的相应资格、许可或授权的法人、组织、团体或其他主体，或为享有完全民事权利能力和民事行为能力的自然人；</div>
<div style="padding-top: 10px;">1.1.2 以合法、正当、真实的服务交易行为为目的；</div>
<div style="padding-top: 10px;">1.1.3 严格遵守现行法律法规、主管部门要求和丙方网站的服务协议与规则。</div>
<div style="padding-top: 10px;">1.1.4 尊重并保护乙方的姓名、肖像、名誉、隐私等人身权益。</div>
<div style="padding-top: 10px;">1.2 乙方保证：</div>
<div style="padding-top: 10px; line-height: 25px;">1.2.1 其为依法成立、享有完全民事权利能力和民事行为能力、并取得法律法规规定的相应资格、许可或授权的法人、组织、团体或其他主体，或为享有完全民事权利能力和民事行为能力的自然人；</div>
<div style="padding-top: 10px;">1.2.2 以合法、正当、真实的服务交易行为为目的；</div>
<div style="padding-top: 10px;">1.2.3 严格遵守现行法律法规、丙方网站的服务协议与规则和一般的社会公共道德标准或行为准则；</div>
<div style="padding-top: 10px;">1.2.4 其提供的服务不侵犯任何第三人的知识产权、人身或财产等其他权益。</div>

<div style="padding-top: 10px;">2 委托服务</div>
<div style="padding-top: 10px;">2.1 服务范围</div>
<div style="padding-top: 10px;">乙方向甲方提供<span style="text-align: center; width:260px;">&nbsp;&nbsp;asd&nbsp;&nbsp;</span>服务，具体包括<span style="text-align: center; width:660px;">&nbsp;&nbsp;asd&nbsp;&nbsp;</span>。</div>
<div style="padding-top: 10px;">2.2 服务时间</div>
<div style="padding-top: 10px;"><span style="text-align: center; width:60px;">2013</span>年<span style="text-align: center; width:40px;">08</span>月<span style="text-align: center; width:40px;">23</span>日至<span style="text-align: center; width:60px;">2013</span>年<span style="text-align: center; width:40px;">08</span>月<span style="text-align: center; width:40px;">24</span>日<span style="text-align: center; width:60px;">17:00</span>点至<span style="text-align: center; width:60px;">19:00</span>点期间。</div>
<div style="padding-top: 10px;">2.3 服务地点</div>
<div style="padding-top: 10px;">乙方在<span style="text-align: center; width:460px;">&nbsp;&nbsp;asd&nbsp;&nbsp;</span>向甲方提供委托服务。</div>
<div style="padding-top: 10px;">2.4 服务方式</div>
<div style="padding-top: 10px;">乙方按以下方式提供服务：□时间  □场次  □其他       </div>         
<div style="padding-top: 10px;">2.5 服务条件与要求</div>
<div style="padding-top: 10px; line-height: 25px;">甲方为乙方履行服务提供如下条件：<span style="text-align: center; width:460px;">&nbsp;&nbsp;asd&nbsp;&nbsp;</span>；乙方提供的服务应满足甲方如下要求:<span style="text-align: center; width:460px;">&nbsp;&nbsp;asd&nbsp;&nbsp;</span>。</div>

<div style="padding-top: 10px;">3 知识产权</div>
<div style="padding-top: 10px; line-height: 25px;">乙方应确保其在提供服务中所使用的他人知识产权已经获得合法、有效授权，并已按规定支付相应费用。</div>

<div style="padding-top: 10px;">4 服务费用</div>
<div style="padding-top: 10px;">4.1 费用金额</div>
<div style="padding-top: 10px; line-height: 25px;">服务费用总额为<span style="text-align: center; width:160px;">&nbsp;&nbsp;asd&nbsp;&nbsp;</span>元，采用：□固定金额  □暂定金额  □另行协商，包括<span style="text-align: center; width:460px;">&nbsp;&nbsp;asd&nbsp;&nbsp;</span>等费用，不含<span style="text-align: center; width:460px;">&nbsp;&nbsp;asd&nbsp;&nbsp;</span>等费用。如服务费用为暂定金额的，双方可按第4.2条中约定的计费标准据实结算。</div>
<div style="padding-top: 10px;">4.2 计费标准</div>
<div style="padding-top: 10px;">双方约定采用以下标准计算服务费用：</div>
<div style="padding-top: 10px;">4.2.1 按时间计费：<span style="text-align: center; width:160px;">1111</span>元/小时</div>
<div style="padding-top: 10px;">4.2.2 按场次计费：<span style="text-align: center; width:160px;">1111</span>元/场次</div>
<div style="padding-top: 10px;">4.2.3 其他方式：<span style="text-align: center; width:260px;">&nbsp;&nbsp;asd&nbsp;&nbsp;</span></div>                 
<div style="padding-top: 10px;">4.3 费用支付</div>
<div style="padding-top: 10px;">4.3.1 甲方按照以下方式支付服务费：</div>
<div style="padding-top: 10px;">□一次性支付，即<span style="text-align: center; width:160px;">&nbsp;&nbsp;asd&nbsp;&nbsp;</span>支付合同总价的100%（<span style="text-align: center; width:100px;">11111</span>元）；</div>
<div style="padding-top: 10px;">□分期支付， 即分<span style="text-align: center; width:50px;">2</span>期支付：</div>
<div style="padding-top: 10px;"><span style="text-align: center; width:100px;">&nbsp;&nbsp;asd&nbsp;&nbsp;</span>支付合同总价的<span style="text-align: center; width:30px;">20</span>%作为定金（<span style="text-align: center; width:100px;">11111</span>元）；</div>
<div style="padding-top: 10px;"><span style="text-align: center; width:100px;">&nbsp;&nbsp;asd&nbsp;&nbsp;</span>支付合同总价的<span style="text-align: center; width:30px;">20</span>%（<span style="text-align: center; width:100px;">11111</span>元）；</div>
<div style="padding-top: 10px;"><span style="text-align: center; width:100px;">&nbsp;&nbsp;asd&nbsp;&nbsp;</span>支付合同总价的<span style="text-align: center; width:30px;">100</span>%（<span style="text-align: center; width:100px;">11111</span>元）；</div>
<div style="padding-top: 10px;">□其他方式，即<span style="text-align: center; width:300px;">&nbsp;&nbsp;asd&nbsp;&nbsp;</span>。</div>

<div style="padding-top: 10px;">5 甲方权利与义务
<div style="padding-top: 10px;">5.1 甲方应按照约定及时、足额支付乙方的服务费用；</div>
<div style="padding-top: 10px; line-height: 25px;">5.2 甲方不得要求乙方及其人员从事约定内容以外的服务，不得要求乙方及其人员从事任何涉嫌色情、违法或违反伦理道德内容的服务，对于任何违法行为或要求，乙方有权予以拒绝，并向有关部门举报。未经乙方许可，甲方不得私自与乙方人员联系或互留通讯方式，否则乙方有权终止服务并要求甲方赔偿；</div>
<div style="padding-top: 10px; line-height: 25px;">5.3 甲方不得无故更改服务地点、时间等主要内容，如遇特殊情况，应至少提前三天通知乙方，在征得乙方同意后方可更改上述服务条款；</div>
<div style="padding-top: 10px;">5.4 甲方应为乙方履行服务行为提供或创造相应便利条件，或满足第2.5条要求；</div>
<div style="padding-top: 10px;">5.5 甲方保障乙方及其人员在履行服务过程中的人身、财产安全和正当利益。</div>

<div style="padding-top: 10px;">6 乙方权利与义务</div>
<div style="padding-top: 10px; line-height: 25px;">6.1 乙方及其人员在提供服务过程中应遵守法律、法规和服务地点的风俗人情，严格遵守甲方的工作制度，服从甲方的统一安排；</div>
<div style="padding-top: 10px; line-height: 25px;">6.2 乙方应按约定向甲方提供合格、适当和具备一定业务能力与素质的服务人员。如乙方人员无法满足甲方正当的服务要求，甲方有权要求乙方更换服务人员直至甲方满意。如遇特殊情况，乙方可提前三天通知甲方，并在甲方同意下更换符合要求的人员；</div>
<div style="padding-top: 10px;">6.3 乙方应按照约定的范围提供委托服务，确保服务质量，符合合同约定的要求；</div>
<div style="padding-top: 10px;">6.4 乙方应确保其所提供的服务介绍资料及内容的真实、合法、有效；</div>
<div style="padding-top: 10px;">6.5 乙方有权获得甲方支付的全部服务费用。</div>

<div style="padding-top: 10px;">7 不可抗力</div>
<div style="padding-top: 10px;">如因不可抗力，如战争、暴动、灾害等因素导致服务不能进行所造成的损失，双方互不承担责任。</div>

<div style="padding-top: 10px;">8 违约责任</div>
<div style="padding-top: 10px; line-height: 25px;">8.1 任何一方有证据表明对方已经、正在或将要违约，可以暂时终止履行本协议，但应及时通知对方。若对方继续不履行、履行不当或者违反本合同，非违约方有权解除本合同并要求对方赔偿损失；</div>
<div style="padding-top: 10px;">8.2 如甲方未按合同约定及时支付乙方服务费用，每延期一日按合同总金额的3‰支付违约金；</div>
<div style="padding-top: 10px;">8.3 如乙方履行服务不当或不符合合同约定的，乙方应承担给甲方造成的相应实际损失。</div>

<div style="padding-top: 10px;">9 保密</div>
<div style="padding-top: 10px; line-height: 25px;">双方应严格保守在合同履行过程中所知晓的对方的商业及技术机密、个人基本资料、隐私等信息，未经对方同意，任何一方不得将上述商业内容用于本合同目的以外，否则该方应承当给对方造成的相应损失。</div>

<div style="padding-top: 10px;">10 法律条款</div>
<div style="padding-top: 10px;">10.1 适用法律</div>
<div style="padding-top: 10px;">本合同适用中华人民共和国法律，受中华人民共和国法律保护和约束。</div>
<div style="padding-top: 10px;">10.2 争议解决</div>
<div style="padding-top: 10px; line-height: 25px;">双方履行合同过程中发生纠纷或争议的，应积极友好协商解决，如协商不成，双方同意提交原告所在地法院裁决。</div>

<div style="padding-top: 10px;">11 生效</div>
<div style="padding-top: 10px; line-height: 25px;">本合同自甲、乙双方盖章、签字后生效，丙方对双方签订合同的事实予以见证。如合同有不明之处，双方可通过签订补充合同形式予以明确。</div>

<div style="padding-top: 10px;">12 其他</div>
<div style="padding-top: 10px;">12.1 本合同在<span style="text-align: center; width:300px;">&nbsp;&nbsp;asd&nbsp;&nbsp;</span>正式签订；</div>
<div style="padding-top: 10px; line-height: 25px;">12.2 本合同壹式陆份，正、副本各三份，正、副本具有同等效力。甲、乙、丙三方各执正、副本一份。（以下无条文）</div>





<div style="padding-top: 30px;">委 &nbsp;托&nbsp; 方：</div>
<div style="padding-top: 10px;">法定代表人（或委托代理人）：<span style="text-align: center; width:200px;"></span></div>       
<div style="padding-top: 10px;">联 &nbsp;系&nbsp; 人：<span style="text-align: center; width:200px;"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;手机：<span style="text-align: center; width:200px;"></span></div>        
<div style="padding-top: 10px;">联系地址：<span style="text-align: center; width:200px;"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;邮编：<span style="text-align: center; width:200px;"></span></div>                
<div style="padding-top: 10px;">电子邮件：<span style="text-align: center; width:200px;"></span></div>                 

<div style="padding-top: 30px;">受 &nbsp;托&nbsp; 方：</div>                                          
<div style="padding-top: 10px;">法定代表人（或委托代理人）：<span style="text-align: center; width:200px;"></span></div>                             
<div style="padding-top: 10px;">联 &nbsp;系&nbsp; 人：<span style="text-align: center; width:200px;"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;手机：<span style="text-align: center; width:200px;"></span></div>                 
<div style="padding-top: 10px;">联系地址：<span style="text-align: center; width:200px;"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;邮编：<span style="text-align: center; width:200px;"></span></div>                 
<div style="padding-top: 10px;">电子邮件：<span style="text-align: center; width:200px;"></span></div>

<div style="padding-top: 30px;">见 &nbsp;证&nbsp; 方：<span style="text-align: center; width:200px;"></span></div>                                             
<div style="padding-top: 10px;">联系地址：<span style="text-align: center; width:200px;"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;邮编：</div>               

<div style="padding-left: 300px; padding-top: 30px;">签订日期：<span style="text-align: center; width:60px;"></span>年<span style="text-align: center; width:60px;"></span>月<span style="text-align: center; width:60px;"></span>日</div>
  		
  	</div>
	
 
  </body>
</html>
