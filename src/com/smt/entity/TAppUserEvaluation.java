package com.smt.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * TAppUserEvaluation entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name="t_app_user_evaluation"
    ,catalog="no1stage"
)

public class TAppUserEvaluation  implements java.io.Serializable {


    // Fields    

     private Integer id;
     private Integer userId;
     private Integer evaluation;
     private Integer sellerEvaluation;
     private double msGradeValue;
     private double tdGradeValue;
     private double zlGradeValue;


    // Constructors


    public TAppUserEvaluation() {
    	
	}


	/** full constructor */
    public TAppUserEvaluation(Integer userId, Integer evaluation,double msGradeValue,double tdGradeValue,double zlGradeValue,Integer sellerEvaluation) {
	    this.userId = userId;
        this.evaluation = evaluation;
        this.msGradeValue = msGradeValue;
        this.tdGradeValue = tdGradeValue;
        this.zlGradeValue = zlGradeValue;
        this.sellerEvaluation = sellerEvaluation;
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
    
    @Column(name = "userId")
    public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	@Column(name = "evaluation")
	public Integer getEvaluation() {
		return evaluation;
	}

	public void setEvaluation(Integer evaluation) {
		this.evaluation = evaluation;
	}

	@Column(name = "sellerEvaluation")
	public Integer getSellerEvaluation() {
		return sellerEvaluation;
	}

	public void setSellerEvaluation(Integer sellerEvaluation) {
		this.sellerEvaluation = sellerEvaluation;
	}
	@Column(name = "msGradeValue")
	public double getMsGradeValue() {
		return msGradeValue;
	}


	public void setMsGradeValue(double msGradeValue) {
		this.msGradeValue = msGradeValue;
	}

	 @Column(name = "tdGradeValue")
	public double getTdGradeValue() {
		return tdGradeValue;
	}


	public void setTdGradeValue(double tdGradeValue) {
		this.tdGradeValue = tdGradeValue;
	}

	 @Column(name = "zlGradeValue")
	public double getZlGradeValue() {
		return zlGradeValue;
	}


	public void setZlGradeValue(double zlGradeValue) {
		this.zlGradeValue = zlGradeValue;
	}



}