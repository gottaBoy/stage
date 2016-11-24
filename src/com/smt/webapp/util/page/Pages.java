package com.smt.webapp.util.page;
import java.io.IOException;
import java.io.Writer;
import javax.servlet.http.HttpServletRequest;
import org.apache.struts2.components.Component;
import com.opensymphony.xwork2.util.ValueStack;


public class Pages extends Component {
	private HttpServletRequest request;    
    private String pageNo;   //当前页码
    private String total;   //总页数
    private String styleClass;   //分页的样式
    private String theme;   //分页的主题
    private String url;   //action的路径
    private String urlType; //路径的类型，主要用于URL重写的扩展
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

	public HttpServletRequest getRequest() {
        return request;
    }

    public void setRequest(HttpServletRequest request) {
        this.request = request;
    }

    public String getPageNo() {
        return pageNo;
    }

    public void setPageNo(String pageNo) {
        this.pageNo = pageNo;
    }

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }

    public String getStyleClass() {
        return styleClass;
    }

    public void setStyleClass(String styleClass) {
        this.styleClass = styleClass;
    }

    public String getTheme() {
        return theme;
    }

    public void setTheme(String theme) {
        this.theme = theme;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getUrlType() {
        return urlType;
    }

    public void setUrlType(String urlType) {
        this.urlType = urlType;
    }

    public Pages(ValueStack arg0, HttpServletRequest request) {  
        super(arg0);  
        this.request = request;  
    }  
 
    @Override 
    public boolean end(Writer writer,String body) {  
        boolean result = super.start(writer);  
        try {  
         //从ValueStack中取出数值  
        	
            Object obj=this.getStack().findValue(pageNo);              
            pageNo = String.valueOf((Integer)obj)=="null"?"0":String.valueOf((Integer)obj);  
            obj=this.getStack().findValue(total);  
            total = String.valueOf((Integer)obj)=="null"?"1":String.valueOf((Integer)obj);   
            obj = this.getStack().findValue(rowCount);
            Integer rownum = Integer.valueOf(rowCount);  
            obj = this.getStack().findValue(params);
            //System.err.println(params);
            StringBuilder str = new StringBuilder();  
            if(params ==null){
            	params= "";
            }else params= params+"&&";
            String pageNoStr="?"+params+"rowCount="+rownum+"&&pageNo=";
            Integer cpageInt = Integer.valueOf(pageNo);  
              
            //文本样式  
            if ("text".equals(theme)) {  
                //当前页与总页数相等  
                if (pageNo.equals(total)) {  
                    //如果total = 1，则无需分页，显示“[第1页] [共1页]”  
                    if ("1".equals(total)) {  
                        str.append("[第 " + pageNo + " 页]");  
                        str.append(" [共 " + total + " 页]");  
                    } else {  
                        //到达最后一页,显示“[首页] [上一页] [末页]”  
                        str.append("<a href='"+url+pageNoStr+"1"+"'>[首页]</a> ");   
                        str.append("<a href='"+url+pageNoStr + (cpageInt - 1)+"'>[上一页]</a>" );  
                        str.append(" <a href='"+url+pageNoStr + total+"'>[末页]</a> ");  
                    }  
                } else {  
                    //当前页与总页数不相同  
                    if ("1".equals(pageNo)) {  
                        //第一页，显示“[首页] [下一页] [末页]”  
                        str.append("<a href='"+url+pageNoStr+"1"+"'>[首页]</a>");  
                        str.append("<a href='"+url+pageNoStr + (cpageInt + 1) +"'>[下一页]</a>");                         
                        str.append("<a href='"+url+pageNoStr + total +"'>[末页]</a>");  
                    } else {  
                        //不是第一页，显示“[首页] [上一页] [下一页] [末页]”  
                        str.append("<a href='"+url+pageNoStr+"1"+"'>[首页]</a>");  
                        str.append("<a href='"+url+pageNoStr + (cpageInt - 1)+"'>[上一页]</a>");  
                        str.append("<a href='"+url+pageNoStr + (cpageInt + 1)+"'>[下一页]</a>");  
                        str.append("<a href='"+url+pageNoStr + total +"'>[末页]</a>");  
                    }  
                }  
            } else if (theme == null || "number".equals(theme)) { //数字样式 [1 2 3 4 5 6 7 8 9 10 > >>]  
                Integer totalInt = Integer.valueOf(total); 
                totalInt = totalInt==0?1:totalInt;
                
                //如果只有一页，则无需分页  
                
                if (totalInt == 1) {  
                	//str.append("<li class='page_right'><a class='change' href='"+url+pageNoStr + 1 +"'>" + 1 + "</a></li> ");
                    //str.append("<strong>1</strong> ");  
                } else {
                	str.append("<div id='page_box'><div class='pageType'><ul>");
                    if (cpageInt > 1) {  
                        //<：返回前一页  \
                    	str.append("<li class='page_right page_next'><a href='"+url+pageNoStr + (cpageInt - 1)+"'><</a></li>" );  
                    }else{                            
                        str.append("<li class='page_right page_next'><a href='#'><</a></li>" );  
                    }  
                    
                    
                    
                   //kaishi
                    
                    
                    if(totalInt<=10){
                    	for(int i =1 ;i<=totalInt;i++){
                    		if(i==cpageInt){
                        		str.append("<li class='page_right'><a class='change' href='"+url+pageNoStr + i +"'>" + i + "</a></li> ");
                        	}else{
                        		str.append("<li class='page_right'><a href='"+url+pageNoStr + i +"'>" + i + "</a></li> ");
                        	}
                    	}
                    	
                    }else if(totalInt>10&&cpageInt<=6){
                    	for(int i =1 ;i<=10;i++){
                    		if(i==cpageInt){
                        		str.append("<li class='page_right'><a class='change' href='"+url+pageNoStr + i +"'>" + i + "</a></li> ");
                        	}else{
                        		str.append("<li class='page_right'><a href='"+url+pageNoStr + i +"'>" + i + "</a></li> ");
                        	}
                    	
                    	}
                    }else if(totalInt>10&&cpageInt>totalInt-5){
                    	for(int i =totalInt-9 ;i<=totalInt;i++){
                    		if(i==cpageInt){
                        		str.append("<li class='page_right'><a class='change' href='"+url+pageNoStr + i +"'>" + i + "</a></li> ");
                        	}else{
                        		str.append("<li class='page_right'><a href='"+url+pageNoStr + i +"'>" + i + "</a></li> ");
                        	}
                    	}
                    }else{
                    	for(int i =cpageInt-5 ;i<=cpageInt+4;i++){
                    		if(i==cpageInt){
                        		str.append("<li class='page_right'><a class='change' href='"+url+pageNoStr + i +"'>" + i + "</a></li> ");
                        	}else{
                        		str.append("<li class='page_right'><a href='"+url+pageNoStr + i +"'>" + i + "</a></li> ");
                        	}
                    	}
                    	
                    }
                    //jiesu
                    if (cpageInt<totalInt) {  
                    	str.append("<li class='page_next'><a href='"+url+pageNoStr + (cpageInt + 1)+"' >></a></li>");  
                    }else{  
                        str.append("<li class='page_next'><a href='#' >></a></li>");  
                   }  
                    str.append("</ul></div></div>");
                }  
            }  
              
            writer.write(str.toString());  
              
        } catch (IOException ex) {  
           ex.printStackTrace();
        }  
        return result;  
    }

}
