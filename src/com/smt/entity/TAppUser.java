package com.smt.entity;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;


/**
 * TAppUser entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name="t_app_user"
    ,catalog="no1stage"
)

public class TAppUser  implements java.io.Serializable {


    // Fields    

     private Integer id;
     private String username;
     private String userPsd;
     private String email;
     private String rzState;
     private String state;
     private String onlineDate;
     private String creatTime;
     private Integer isOrg;
     private Integer authority;
     private Integer parentID;
     private Integer roleId;
     private Integer applicate;
     private String openId;

     public Integer getApplicate() {
		return applicate;
	}

	public void setApplicate(Integer applicate) {
		this.applicate = applicate;
	}

	private List<TAppUserInfo> userList;
     
     @OneToMany(cascade=CascadeType.ALL)   
     @JoinColumn(name="userId") //对应儿子类的哪个字段   
     public List<TAppUserInfo> getUserList() {
 		return userList;
 	}

 	public void setUserList(List<TAppUserInfo> userList) {
 		this.userList = userList;
 	}

 	private List<TAppCostInfo> costList;
 	
 	@OneToMany(cascade=CascadeType.ALL)   
    @JoinColumn(name="userId") //对应儿子类的哪个字段   
 	public List<TAppCostInfo> getCostList() {
 		return costList;
 	}

 	public void setCostList(List<TAppCostInfo> costList) {
 		this.costList = costList;
 	}
 	
	private List<TAppFriendInfo> friendInfo;
	 @OneToMany(cascade=CascadeType.ALL)   
     @JoinColumn(name="userId") //对应儿子类的哪个字段  
      public List<TAppFriendInfo> getFriendInfo() {
 		return friendInfo;
 	}

 	public void setFriendInfo(List<TAppFriendInfo> friendInfo) {
 		this.friendInfo = friendInfo;
 	}
	
    // Constructors
//    private List<TAppUserInfo> userList;
//    
//    @OneToMany(fetch = FetchType.LAZY,targetEntity = TAppUserInfo.class,cascade =      //单项一对多配置
//    {
//    CascadeType.PERSIST,CascadeType.REMOVE,CascadeType.MERGE,
//    })
//    @JoinColumns(value={@JoinColumn(name="userId", referencedColumnName="id")})
//    public List<TAppUserInfo> getUserList() {
//		return userList;
//	}
//
//	public void setUserList(List<TAppUserInfo> userList) {
//		this.userList = userList;
//	}
//
//	private List<TAppCostInfo> costList;
//	
//	@OneToMany(fetch = FetchType.LAZY,targetEntity = TAppCostInfo.class,cascade =      //单项一对多配置
//    {
//    CascadeType.PERSIST,CascadeType.REMOVE,CascadeType.MERGE,
//    })
//    @JoinColumns(value={@JoinColumn(name="userId", referencedColumnName="id")})
//	public List<TAppCostInfo> getCostList() {
//		return costList;
//	}
//
//	public void setCostList(List<TAppCostInfo> costList) {
//		this.costList = costList;
//	}

	/** default constructor */
    public TAppUser() {
    }

	/** minimal constructor */
    public TAppUser(String username, String userPsd, String email, String creatTime) {
        this.username = username;
        this.userPsd = userPsd;
        this.email = email;
        this.creatTime = creatTime;
    }
    
    /** full constructor */
    public TAppUser(String username, String userPsd, String email, String rzState, String state, String onlineDate, String creatTime, Integer isOrg, Integer authority,Integer parentID,Integer roleId) {
        this.username = username;
        this.userPsd = userPsd;
        this.email = email;
        this.rzState = rzState;
        this.state = state;
        this.onlineDate = onlineDate;
        this.creatTime = creatTime;
        this.isOrg = isOrg;
        this.authority = authority;
        this.parentID = parentID;
        this.roleId = roleId;
    }

   
    // Property accessors
    @Id  
    @Column(name="ID", unique=true, nullable=false)

    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    
    
    @Column(name="parentID")
    public Integer getParentID() {
		return parentID;
	}

	public void setParentID(Integer parentID) {
		this.parentID = parentID;
	}

	@Column(name="Username", nullable=false, length=50)

    public String getUsername() {
        return this.username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    @Column(name="UserPsd", nullable=false, length=50)

    public String getUserPsd() {
        return this.userPsd;
    }
    
    public void setUserPsd(String userPsd) {
        this.userPsd = userPsd;
    }
    
    @Column(name="Email", nullable=false, length=100)

    public String getEmail() {
        return this.email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    @Column(name="RzState", length=1)

    public String getRzState() {
        return this.rzState;
    }
    
    public void setRzState(String rzState) {
        this.rzState = rzState;
    }
    
    @Column(name="State", length=1)

    public String getState() {
        return this.state;
    }
    
    public void setState(String state) {
        this.state = state;
    }
    
    @Column(name="OnlineDate", length=50)

    public String getOnlineDate() {
        return this.onlineDate;
    }
    
    public void setOnlineDate(String onlineDate) {
        this.onlineDate = onlineDate;
    }
    
    @Column(name="CreatTime", nullable=false, length=50)

    public String getCreatTime() {
        return this.creatTime;
    }
    
    public void setCreatTime(String creatTime) {
        this.creatTime = creatTime;
    }
    
    @Column(name="isORG", length=1)

    public Integer getIsOrg() {
        return this.isOrg;
    }
    
    public void setIsOrg(Integer isOrg) {
        this.isOrg = isOrg;
    }
    @Column(name="authority", length=32)
	public void setAuthority(Integer authority) {
		this.authority = authority;
	}

	public Integer getAuthority() {
		return authority;
	}
	
    @Column(name="roleId")
    public Integer getRoleId() {
        return this.roleId;
    }
    
    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    @Column(name="openId")
	public String getOpenId() {
		return openId;
	}

	public void setOpenId(String openId) {
		this.openId = openId;
	}
    
    


   








}