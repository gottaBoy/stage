package com.smt.entity;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;


/**
 * TAppBusinessEvaluate entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name="t_app_business_evaluate"
    ,catalog="no1stage"
)

public class TAppBusinessEvaluate  implements java.io.Serializable {


    // Fields    

     private Integer id;
     private Integer businessId;
     private Integer creatId;
     private String pjContent;
     private String creatTime;
     private String pjGrade="1";//默认好评,  好，一般，差
     private String msGrade="5"; //描述相符 5分
     private String tdGrade="5"; //工作态度相符 5分
     private String zlGrade="5"; //完成质量相符 5分
     private Short state=0;
     private Short pjcount=0;
     



	/** default constructor */
    public TAppBusinessEvaluate() {
    }

	/** minimal constructor */
    public TAppBusinessEvaluate(Integer creatId) {
        this.creatId = creatId;
    }
    
    /** full constructor */
    public TAppBusinessEvaluate(Integer businessId, Integer creatId, String pjContent, String creatTime, String type, String pjGrade,String msGrade,String tdGrade,String zlGrade, Short state, Short pjcount) {
        this.businessId = businessId;
        this.creatId = creatId;
        this.pjContent = pjContent;
        this.creatTime = creatTime;
        this.pjGrade = pjGrade;
        this.msGrade=msGrade;
        this.tdGrade=tdGrade;
        this.zlGrade=zlGrade;
        this.state=state;
        this.pjcount=pjcount;
        
    }

   
    // Property accessors
    @Id @GeneratedValue
    
    @Column(name="ID", unique=true, nullable=false)

    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    @Column(name="BusinessId", length=32)

    public Integer getBusinessId() {
        return this.businessId;
    }
    
    public void setBusinessId(Integer businessId) {
        this.businessId = businessId;
    }
    
    @Column(name="CreatId", nullable=false)

    public Integer getCreatId() {
        return this.creatId;
    }
    
    public void setCreatId(Integer creatId) {
        this.creatId = creatId;
    }
    
    @Column(name="PjContent", length=500)

    public String getPjContent() {
        return this.pjContent;
    }
    
    public void setPjContent(String pjContent) {
        this.pjContent = pjContent;
    }
    
    @Column(name="CreatTime", length=100)

    public String getCreatTime() {
        return this.creatTime;
    }
    
    public void setCreatTime(String creatTime) {
        this.creatTime = creatTime;
    }
    
 
    @Column(name="PjGrade", length=32)

    public String getPjGrade() {
        return this.pjGrade;
    }
    
    public void setPjGrade(String pjGrade) {
        this.pjGrade = pjGrade;
    }
    
    @Column(name="MsGrade", length=32)

    public String getMsGrade() {
        return this.msGrade;
    }
    
    public void setMsGrade(String msGrade) {
        this.msGrade = msGrade;
    }
    
    @Column(name="TdGrade", length=32)

    public String getTdGrade() {
        return this.tdGrade;
    }
    
    public void setTdGrade(String tdGrade) {
        this.tdGrade = tdGrade;
    }
    
    @Column(name="ZlGrade", length=32)

    public String getZlGrade() {
        return this.zlGrade;
    }
    
    public void setZlGrade(String zlGrade) {
        this.zlGrade = zlGrade;
    }
   


    @Column(name="state", length=16)

    public Short getState() {
        return this.state;
    }
    
    public void setState(Short state) {
        this.state = state;
    }
   

    @Column(name="pjcount", length=16)

    public Short getPjcount() {
        return this.pjcount;
    }
    
    public void setPjcount(Short pjcount) {
        this.pjcount = pjcount;
    }
   


}