package com.smt.webapp.util;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext; 
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

public class EMailUtil {
    public static final  ApplicationContext ctx =  new ClassPathXmlApplicationContext("application-mail.xml");

     

    public static  String send(String sendT0,String from,String otherName,String subject,String text) throws MessagingException {
    	//返回结果1=成功，0=失败
        String result ="1";
        
        JavaMailSender sender = (JavaMailSender) ctx.getBean("mailSender");
        MimeMessage mimeMessage = sender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "utf-8"); // <span style="color: #ff0000;">注意SimpleMailMessage只能用来发送text格式的邮件</span>

        try {
            helper.setTo(sendT0);// 接受者
            helper.setFrom(from, otherName);// 发送者,这里还可以另起Email别名，不用和xml里的username一致
            helper.setSubject(subject);// 主题
            helper.setText(text,true);// 邮件内容
            sender.send(mimeMessage);
        }
        catch (Exception e) {
            e.printStackTrace();
            result ="0";
        }
        
        return result;
    }
    
    public static void main(String[] args) {
        EMailUtil mail= new EMailUtil();
        try {
            StringBuffer textbuf= new StringBuffer();
            textbuf.append("<html><head></head><body style=' background-color:#00ff00;'>");
            textbuf.append("尊敬的用户您好:<br/>");
            textbuf.append("&nbsp;&nbsp;您使用了找回密码的功能，下面是您注册时使用的用户名和密码，请妥善保管。<br/>");
            textbuf.append("&nbsp;&nbsp;您的用户名：11");
            textbuf.append("&nbsp;&nbsp;您的密码：22");
            textbuf.append("感谢您对海田外贸平台的支持！");
            textbuf.append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;海田外贸平台");
            textbuf.append("</body><html>");
            mail.send("272542218@qq.com","admin01@qq.com","海田外贸平台","您在海田外贸平台的注册用户名和密码",textbuf.toString());
        }
        catch (MessagingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}