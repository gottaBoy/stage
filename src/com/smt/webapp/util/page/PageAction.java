package com.smt.webapp.util.page;
import java.util.List;
import com.opensymphony.xwork2.ActionSupport;


public class PageAction {
	 public Integer pageNo=1;  

	    public final Integer pageSize=Util.pageSize;

	    public Integer total;
	    
	    public List<?> list;
	    
	    public Integer rowCount;
	    
	    public String params ;
	   

		public String getParams() {
			return params;
		}

		public void setParams(String params) {
			this.params = params;
		}

		public Integer getRowCount() {
			return rowCount;
		}

		public void setRowCount(Integer rowCount) {
			this.rowCount = rowCount;
		}

		public Integer getPageNo() {
	        return pageNo;
	    }

	    public void setPageNo(Integer pageNo) {
	        this.pageNo = pageNo;
	    }

	    public Integer getTotal() {
	        return total;
	    }

	    public void setTotal(Integer total) {
	        this.total = total;
	    }

	    public List<?> getList() {
	        return list;
	    }

	    public void setList(List<?> list) {
	        this.list = list;
	    }

	    public Integer getPageSize() {
	        return pageSize;
	    }   

}
