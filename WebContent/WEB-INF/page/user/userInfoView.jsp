<%@page import="com.smt.webapp.util.HttpSessionHelper"%>
<%@page import="com.smt.common.StageVariale"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    
    <title><%=StageVariale.title%></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="<%=StageVariale.description%>">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/member_center.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/01stageDialog/skins/idialog.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/theme/css/layout.css" />
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/js/jquery.validate.min.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/theme/stageDate/WdatePicker.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/jquery.artDialog.js"></script>
	<script type="text/javascript" language="javascript" src="<%=request.getContextPath() %>/01stageDialog/plugins/iframeTools.js"></script>

	<script type="text/javascript">
	
		function CloseWin() 
		{ 
			art.dialog.close(); 
		 
		} 
		
		function handleImgLoadError(oEvent){
           oEvent.srcElement.src='<%=request.getContextPath() %>/theme/images/rz_imgphoto.jpg';
  	    }

		
		function view(obj){
		art.dialog({
		    padding: 0,
		    title: '照片',
		    content: '<img src="'+obj.src+'" />',
		    lock: true
		});
	}

	</script>
	

  </head>
  <body>
	<table width="720" border="0" align="center" cellpadding="0" cellspacing="0" style="margin:0px auto; ">
    <tr>
        <td height="750" bgcolor="#FFFFFF">
        
        <!-- 弹出框内容 开始 -->
        <div class="add_table_box02">
        <table width="680" border="0" align="center" cellpadding="0" cellspacing="0" class="add__admin_title">
            <tr>
                <td height="18">基础信息</td>
            </tr><s:if test=""></s:if>
        </table>
        <table width="680" border="0" align="center" cellpadding="0" cellspacing="1" class="add__gly" bgcolor="#CCCCCC">
            <tr>
                <td width="86" align="right" bgcolor="#FFFFFF">用户名：</td>
                <td width="83" bgcolor="#FFFFFF" class="text_cor">${user.username }</td>
                <td width="81" align="right" bgcolor="#FFFFFF">昵称：</td>
                <td width="97" bgcolor="#FFFFFF" class="text_cor">${userInfo.nickName }</td>
                <td width="66" align="right" bgcolor="#FFFFFF">性别：</td>
                <td width="116" bgcolor="#FFFFFF" class="text_cor">
                	<s:if test="userInfo.sex==1">男</s:if>
                	<s:if test="userInfo.sex==2">女</s:if></td>
                <td width="45" align="right" bgcolor="#FFFFFF">生日：</td>
                <td width="97" bgcolor="#FFFFFF" class="text_cor">${userInfo.birthday }</td>
            </tr>
            <tr>
                <td align="right" bgcolor="#FFFFFF">真实姓名：</td>
                <td bgcolor="#FFFFFF" class="text_cor">${userInfo.name }</td>
                <td align="right" bgcolor="#FFFFFF">所在地：</td>
                <td bgcolor="#FFFFFF" class="text_cor">${userInfo.provice } ${userInfo.city }</td>
                <td align="right" bgcolor="#FFFFFF">血型：</td>
                <td bgcolor="#FFFFFF" class="text_cor">${userInfo.booldType }</td>
                <td align="right" bgcolor="#FFFFFF">身高：</td>
                <td bgcolor="#FFFFFF" class="text_cor">${userInfo.height }CM</td>
            </tr>
            <tr>
                <td align="right" bgcolor="#FFFFFF">三围：</td>
                <td colspan="3" bgcolor="#FFFFFF" style="line-height:22px; vertical-align:middle; padding-left:0px;">
                
                <table width="220" border="0" align="left" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="30" align="right">胸：</td>
                        <td width="32" class="text_cor">${userInfo.heartSize }CM</td>
                        <td width="36" align="right"> 腰：</td>
                        <td width="40" class="text_cor">${userInfo.waistSize }CM</td>
                        <td width="35" align="right">臀：</td>
                        <td width="47" class="text_cor">${userInfo.bottocksSize }CM</td>
                    </tr>
                </table></td>
                <td align="right" bgcolor="#FFFFFF">E-mail：</td>
                <td colspan="3" bgcolor="#FFFFFF" class="text_cor">${user.email }</td>
                </tr>
            <tr>
                <td align="right" bgcolor="#FFFFFF">手机：</td>
                <td bgcolor="#FFFFFF" class="text_cor">${userInfo.mobile }</td>
                <td align="right" bgcolor="#FFFFFF">电话：</td>
                <td bgcolor="#FFFFFF" class="text_cor">${userInfo.telPhone }</td>
                <td align="right" bgcolor="#FFFFFF">QQ：</td>
                <td bgcolor="#FFFFFF" class="text_cor">${userInfo.qq }</td>
                <td align="right" bgcolor="#FFFFFF">体重：</td>
                <td bgcolor="#FFFFFF" class="text_cor">${userInfo.weight }</td>
            </tr>
            <tr>
                <td align="right" bgcolor="#FFFFFF">学历：</td>
                <td bgcolor="#FFFFFF" class="text_cor">${userInfo.education }</td>
                <td align="right" bgcolor="#FFFFFF">毕业院校：</td>
                <td bgcolor="#FFFFFF" class="text_cor">${userInfo.school }</td>
                <td align="right" bgcolor="#FFFFFF">所学专业：</td>
                <td colspan="3" bgcolor="#FFFFFF" class="text_cor">${userInfo.major }</td>
                </tr>
            <tr>
                <td align="right" bgcolor="#FFFFFF">身份证ID：</td>
                <td colspan="7" bgcolor="#FFFFFF" class="text_cor">${userInfo.idCard }</td>
                </tr>
            <tr>
                <td align="right" bgcolor="#FFFFFF" style="line-height:32px; vertical-align:middle;">个人介绍：</td>
                <td colspan="7" bgcolor="#FFFFFF"><textarea name="textarea" id="textarea" cols="45" rows="5" class="add_textcon ">${userInfo.introduction }</textarea></td>
                </tr>
        </table>
        <table width="680" border="0" align="center" cellpadding="0" cellspacing="0" class="add__admin_title" style="margin-top:6px;">
            <tr>
                <td height="18">职业技能</td>
            </tr>
        </table>
        <table width="680" border="0" align="center" cellpadding="0" cellspacing="1" class="add__gly" bgcolor="#CCCCCC">
            <tr>
                <td width="152" align="center" bgcolor="#F2F2F2"><strong>职业排序</strong></td>
                <td width="221" align="center" bgcolor="#F2F2F2"><strong>职业</strong></td>
                <td width="303" align="center" bgcolor="#F2F2F2">价格区间（单位：元）</td>
            </tr>
            <s:iterator value="#request.costList" var="item">
            <tr>
                <td align="center" bgcolor="#FFFFFF">第<s:property value="#item[0].orderNo"/>职业 </td>
                <td align="center" bgcolor="#FFFFFF"><s:property value="#item[1].typeName"/></td>
                <td align="center" bgcolor="#FFFFFF"><s:property value="#item[0].bprice"/>-<s:property value="#item[0].eprice"/></td>
            </tr>
            </s:iterator>
            
        </table>
        <table width="680" border="0" align="center" cellpadding="0" cellspacing="0" class="add__admin_title" style="margin-top:6px;">
            <tr>
                <td height="18">认证信息</td>
            </tr>
        </table>
        <table width="680" border="0" cellspacing="0" cellpadding="0" style="margin-top:20px;">
            <tr>
                <td width="410" height="110" align="center" valign="middle"><img src="<%=request.getContextPath() %>/theme/images/rzxx_0${user.rzState }.jpg" width="410" height="110" /></td>
                <td width="97">&nbsp;</td>
                <td width="173">
                
                <img onclick="view(this)" onerror="handleImgLoadError(event);" src="/stageUpload/idCard/${userInfo.idCardCopy}?id=<%=new Date() %>" width="110" height="110" /><br>
                <img onclick="view(this)" onerror="handleImgLoadError(event);" src="/stageUpload/idCard/${userInfo.idCardCopy2}?id=<%=new Date() %>" width="110" height="110" />
              <!--   
               <s:if test="userInfo.idCardCopy==null||userInfo.idCardCopy==''">
               <img src="<%=request.getContextPath() %>/theme/images/rz_imgphoto.jpg" width="110" height="110" />
              </s:if> -->
                </td>
            </tr>
        </table>
        </div>
         <!-- 弹出框内容 结束 -->
        
        </td>
    </tr>
</table>
  </body>
</html>