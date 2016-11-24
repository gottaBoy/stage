package com.smt.webapp.web.member;

import java.io.BufferedInputStream; 
import java.io.FileInputStream; 
import java.io.FileNotFoundException; 
import java.io.InputStream; 
import java.io.UnsupportedEncodingException; 
  
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse; 
  
import org.apache.struts2.ServletActionContext; 
import org.springframework.beans.factory.annotation.Autowired;
  
import com.opensymphony.xwork2.ActionSupport; 
import com.smt.entity.TAppUploadFile;
import com.smt.webapp.service.business.BusinessInfoService;
  
  
/** 
 * 文件下载 
 * @author Luxh 
 */
public class DownloadAction extends ActionSupport { 
  
    private static final long serialVersionUID = -3036349171314867490L; 

	@Autowired
	private BusinessInfoService businessInfoService;
	
    //文件名 
    private String fileName; 
      
    public String getFileName() { 
        return fileName; 
    } 
  
    public void setFileName(String fileName) throws UnsupportedEncodingException { 
        //用UTF-8重新编码文件名,解决中文乱码 
        this.fileName = new String(fileName.getBytes("ISO-8859-1"),"UTF-8"); 
    } 
    
    public InputStream getInputStream() throws UnsupportedEncodingException, FileNotFoundException{ 
        HttpServletResponse response = ServletActionContext.getResponse(); 
        HttpServletRequest request = ServletActionContext.getRequest();
//        //attachment,以附件的方式下载文件,会打开保存文件对话框;inline,以内联的方式下载,浏览器会直接打开文件 
        
        int fileId = 0;
        
        try {
			fileId = Integer.parseInt(this.fileName.substring(0, this.fileName.indexOf(".")));
		} catch (NumberFormatException e) {
			e.printStackTrace();
			//return null;
		}
        
		TAppUploadFile uploadFile = businessInfoService.getBusinessFileById(fileId);
		
		String name = this.fileName;
		if(uploadFile != null) {
			name = uploadFile.getAttachName();
		}
		
		name = java.net.URLEncoder.encode(uploadFile.getAttachName(),"UTF-8");
		name = name.replaceAll("\\+",  "%20"); //处理空格
        response.setHeader("Content-Disposition", "attachment;fileName="
                  + name);//java.net.URLEncoder.encode(fileName,"UTF-8")  编码转换，解决乱码 
//           
//        //如果fileName是相对路径 
//        //return ServletActionContext.getServletContext().getResourceAsStream(fileName); 
//        //如果fileName是绝对路径 
//        return new BufferedInputStream(new FileInputStream(fileName)); 
        
        String path = request.getSession().getServletContext().getRealPath("");
		path.lastIndexOf(System.getProperty("file.separator"));
		path = path.substring(0, path.lastIndexOf(System.getProperty("file.separator")))+"\\stageUpload\\orderFile\\";
		
		path = path.replace("\\", System.getProperty("file.separator"));
		
		return new BufferedInputStream(new FileInputStream(path + fileName)); 
    } 
      
    @Override
    public String execute() throws Exception { 
        return SUCCESS; 
    } 
      
} 
