package alipay.config;

import java.util.ArrayList;
import java.util.List;

/* *
 *类名：AlipayConfig
 *功能：基础配置类
 *详细：设置帐户有关信息及返回路径
 *版本：3.3
 *日期：2012-08-10
 *说明：
 *以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 *该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
	
 *提示：如何获取安全校验码和合作身份者ID
 *1.用您的签约支付宝账号登录支付宝网站(www.alipay.com)
 *2.点击“商家服务”(https://b.alipay.com/order/myOrder.htm)
 *3.点击“查询合作者身份(PID)”、“查询安全校验码(Key)”

 *安全校验码查看时，输入支付密码后，页面呈灰色的现象，怎么办？
 *解决方法：
 *1、检查浏览器配置，不让浏览器做弹框屏蔽设置
 *2、更换浏览器或电脑，重新登录查询。
 */

public class AlipayConfig {
	
	//↓↓↓↓↓↓↓↓↓↓请在这里配置您的基本信息↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
	// 合作身份者ID，以2088开头由16位纯数字组成的字符串
	public static String partner = "2088011592196662";
	// 商户的私钥
	public static String key = "s45eqlnwgjeg2m3of18w1tbofbzwundd";
	
	public static String sellerEmail = "diyiwutai@163.com";
	public static String sellerName = "宁波聚艺堂网络科技有限公司";
	
	//数据库配置信息
	//public static String databaseUrl = "jdbc:mysql://localhost:3306/no1stage?user=root&password=root&useUnicode=true&characterEncoding=utf-8";
	public static String databaseUrl = "jdbc:mysql://localhost:3306/no1stage?user=root&password=root&useUnicode=true&characterEncoding=utf-8";
	//域名
	//private static String domainName = "http://122.227.226.238:5555/stage01";
	private static String domainName = "http://d15t.com";
	
	//以下页面需以http://格式的完整路径，不能加?id=123这类自定义参数，不能写成http://localhost/
	//付款即时到帐同步页面跳转通知页面
	public static String directNotifyUrl = domainName + "/alipay/direct_notify_url.jsp";
	//付款即时到帐异步页面跳转通知页面
	public static String directReturnUrl = domainName + "/alipay/direct_return_url.jsp";
	//付款批量付款异步通知页面
	public static String batchNotifyUrl = domainName + "/alipay/pay_notify_url.jsp";
	

	//退款即时到帐同步页面跳转通知页面
	public static String directNotifyUrlDrawback = domainName + "/alipay/direct_notify_url_drawback.jsp";
	//退款即时到帐异步页面跳转通知页面
	public static String directReturnUrlDrawback = domainName + "/alipay/direct_return_url_drawback.jsp";
	//退款批量付款异步通知页面
	public static String batchNotifyUrlDrawback = domainName + "/alipay/pay_notify_url_drawback.jsp";

	//↑↑↑↑↑↑↑↑↑↑请在这里配置您的基本信息↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
	

	// 调试用，创建TXT日志文件夹路径
	public static String log_path = "D:\\";

	// 字符编码格式 目前支持 gbk 或 utf-8
	public static String input_charset = "utf-8";
	
	// 签名方式 不需修改
	public static String sign_type = "MD5";
	
	public static String[] removeTrim(String[] array) {
		List<Object> list = new ArrayList<Object>();
		for (int i = 0; i < array.length; i++) {
			if(!array[i].equals("")) {
				list.add(array[i]);
			}
		}
		String[] newArray = new String[list.size()];
		for (int i = 0; i < list.size(); i++) {
			newArray[i] = list.get(i).toString();
		}
		return newArray;
	}

}
