package com.smt.webapp.util.page;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.components.Component;
import org.apache.struts2.views.jsp.ComponentTagSupport;

import com.opensymphony.xwork2.util.ValueStack;

public class PageTag extends ComponentTagSupport{

	/**
	 *自定义分页标签结构或属性
	 *@version1.0
	 */

	    private String pageNo;  
	    private String total;  
	    private String styleClass;  
	    private String theme;
	    private String url;
	    private String urlType;
	    private String rowCount;
	    private String params;
	      
	    public String getParams() {
			return params;
		}
		public void setParams(String params) {
			this.params = params;
		}
		public String getRowCount() {
			return rowCount;
		}
		public void setRowCount(String rowCount) {
			this.rowCount = rowCount;
		}
		public void setUrlType(String urlType) {
	       this.urlType = urlType;
	    }
	    public void setUrl(String url) {
	       this.url = url;
	    }
	    public void setTheme(String theme) {  
	        this.theme = theme;  
	    }      
	    public void setStyleClass(String styleClass) {  
	        this.styleClass = styleClass;  
	    }  
	    public void setPageNo(String pageNo) {  
	        this.pageNo = pageNo;  
	    }  
	    public void setTotal(String total) {  
	        this.total = total;  
	    }  
	 
	  
	    public String getPageNo() {
	        return pageNo;
	    }
	    public String getTotal() {
	        return total;
	    }
	    public String getStyleClass() {
	        return styleClass;
	    }
	    public String getTheme() {
	        return theme;
	    }
	    public String getUrl() {
	        return url;
	    }
	    public String getUrlType() {
	        return urlType;
	    }
	    @Override 
	    public Component getBean(ValueStack arg0, HttpServletRequest arg1, HttpServletResponse arg2) {  
	        return new Pages(arg0, arg1);  
	    }  
	 
	    protected void populateParams() {  
	        super.populateParams();  
	          
	        Pages pages = (Pages)component;  
	        pages.setPageNo(pageNo);    
	        pages.setTotal(total);  
	        pages.setStyleClass(styleClass);  
	        pages.setTheme(theme);  
	        pages.setUrl(url);
	        pages.setUrlType(urlType);
	        pages.setRowCount(rowCount);
	        pages.setParams(params);
	 
	    }  
	}   

