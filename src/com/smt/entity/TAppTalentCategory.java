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
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * TAppTalentCategory entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_app_talent_category", catalog = "no1stage")
public class TAppTalentCategory implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer parentId;
	private String typeName;
	private String remark;
	private String creatTime;
	private String flag;
	private String subId;
	private Integer layer;//层级
	private String alias;
	private Integer searchTime;//搜索率
	
	private List<TAppCostInfo> costList;
	

    @OneToMany(cascade=CascadeType.ALL, fetch = FetchType.EAGER)   
    @JoinColumn(name="profession") //对应儿子类的哪个字段   
	public List<TAppCostInfo> getCostList() {
		return costList;
	}

	public void setCostList(List<TAppCostInfo> costList) {
		this.costList = costList;
	}
	
	@Column(name="alias")
	public String getAlias() {
		return alias;
	}

	public void setAlias(String alias) {
		this.alias = alias;
	}
	@Column(name = "subid", nullable = false,length=5)
	public String getSubId() {
		return subId;
	}

	public void setSubId(String subId) {
		this.subId = subId;
	}

	// Constructors
	@Column(name = "flag", nullable = false,length=2)
	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	/** default constructor */
	public TAppTalentCategory() {
	}

	/** minimal constructor */
	public TAppTalentCategory(Integer id,Integer parentId) {
		this.id = id;
		this.parentId = parentId;
	}

	/** full constructor */
	public TAppTalentCategory(Integer id,Integer parentId, String typeName, String remark,
			String creatTime,String flag,String subId,Integer layer,String alias,Integer searchTime) {
		this.id = id;
		this.parentId = parentId;
		this.typeName = typeName;
		this.remark = remark;
		this.creatTime = creatTime;
		this.flag = flag;
		this.subId = subId;
		this.layer = layer;
		this.alias = alias;
		this.searchTime = searchTime;
	}

	// Property accessors
	@Id
	@GeneratedValue
	@Column(name = "ID", unique = true, nullable = false)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "ParentId", nullable = false)
	public Integer getParentId() {
		return this.parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	@Column(name = "TypeName", length = 100)
	public String getTypeName() {
		return this.typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	@Column(name = "Remark", length = 500)
	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@Column(name = "CreatTime", length = 100)
	public String getCreatTime() {
		return this.creatTime;
	}

	public void setCreatTime(String creatTime) {
		this.creatTime = creatTime;
	}
	
	@Column(name = "layer")
	public Integer getLayer() {
		return layer;
	}

	public void setLayer(Integer layer) {
		this.layer = layer;
	}
	@Column(name = "searchTime")
	public Integer getSearchTime() {
		return searchTime;
	}

	public void setSearchTime(Integer searchTime) {
		this.searchTime = searchTime;
	}
 
}