package com.smt.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * TAppArtInfo entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_app_skill_evaluate", catalog = "no1stage")
public class TAppSkillEvaluate implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer skillId;
	private String createtime;
	private String content;
	private Integer createId;
	

	/** default constructor */
	public TAppSkillEvaluate() {
	}

	/** minimal constructor */
	public TAppSkillEvaluate(Integer skillId) {
		this.skillId = skillId;
	}

	/** full constructor */
	public TAppSkillEvaluate(Integer skillId, String createtime, String content ,Integer createId) {
		this.skillId = skillId;
		this.createtime = createtime;
		this.content = content;
		this.createId = createId;
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

	@Column(name = "skillId", nullable = false)
	public Integer getSkillId() {
		return this.skillId;
	}

	public void setSkillId(Integer skillId) {
		this.skillId = skillId;
	}
	@Column(name = "createId", nullable = false)
	public Integer getCreateId() {
		return this.createId;
	}

	public void setCreateId(Integer createId) {
		this.createId = createId;
	}

	@Column(name = "createtime", length = 100)
	public String getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}

	@Column(name = "content", length = 100)
	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

}