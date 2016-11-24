<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="pg" uri="/page-tags"%>
<!-- 底部开始 -->

<!--bottom-->
<div class="foot">
	<div class="foot_c Layout mian">
  	<s:action name="about" namespace="/about" executeResult="true">
        	<s:param name="personPage">personPage</s:param> 
	</s:action>
   </div>
   
</div>
<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_5708886'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s9.cnzz.com/stat.php%3Fid%3D5708886%26show%3Dpic1' type='text/javascript'%3E%3C/script%3E"));</script>
<!-- 底部结束 -->
