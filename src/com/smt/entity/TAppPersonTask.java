package com.smt.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * TAppPersonTask entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_app_person_task", catalog = "no1stage")
public class TAppPersonTask implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer taskId;
	private Integer personId;
	private String createTime;
	private Integer isReady;
	private Long taskRoleId;

	// Constructors

	/** default constructor */
	public TAppPersonTask() {
	}

	/** full constructor */
	public TAppPersonTask(Integer taskId, Integer personId, String createtime,
			Integer isReady, Long taskRoleId) {
		this.taskId = taskId;
		this.personId = personId;
		this.createTime = createtime;
		this.isReady = isReady;
		this.taskRoleId = taskRoleId;
	}

	// Property accessors
	@Id
	@GeneratedValue
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "taskId")
	public Integer getTaskId() {
		return this.taskId;
	}

	public void setTaskId(Integer taskId) {
		this.taskId = taskId;
	}

	@Column(name = "personId")
	public Integer getPersonId() {
		return this.personId;
	}

	public void setPersonId(Integer personId) {
		this.personId = personId;
	}

	@Column(name = "createtime", length = 100)
	public String getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(String createtime) {
		this.createTime = createtime;
	}

	@Column(name = "isReady")
	public Integer getIsReady() {
		return this.isReady;
	}

	public void setIsReady(Integer isReady) {
		this.isReady = isReady;
	}

	@Column(name = "taskRoleId")
	public Long getTaskRoleId() {
		return this.taskRoleId;
	}

	public void setTaskRoleId(Long taskRoleId) {
		this.taskRoleId = taskRoleId;
	}

}