package com.smt.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * TAppMessage entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_app_message", catalog = "no1stage")
public class TAppMessage implements java.io.Serializable {

	// Fields

	private Integer id;
	private String status;
	private Integer toUserId;
	private Integer fromUserId;
	private String title;
	private String content;
	private String creatTime;
	private int type;//短信类型1、其他2、交易 3、评价
	private short sendType=0;//0 系统发送 (发送人不能见) 1 用户发送 (发送人可见) 

	// Constructors

	/** default constructor */
	public TAppMessage() {
	}

	/** full constructor */
	public TAppMessage(String status, Integer toUserId, Integer fromUserId,
			String title, String content, String creatTime, Short sendType) {
		this.status = status;
		this.toUserId = toUserId;
		this.fromUserId = fromUserId;
		this.title = title;
		this.content = content;
		this.creatTime = creatTime;
		this.sendType=sendType;
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

	@Column(name = "Status", length = 32)
	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Column(name = "ToUserId")
	public Integer getToUserId() {
		return this.toUserId;
	}

	public void setToUserId(Integer toUserId) {
		this.toUserId = toUserId;
	}

	@Column(name = "FromUserId")
	public Integer getFromUserId() {
		return this.fromUserId;
	}

	public void setFromUserId(Integer fromUserId) {
		this.fromUserId = fromUserId;
	}

	@Column(name = "Title", length = 100)
	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Column(name = "Content", length = 500)
	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Column(name = "CreatTime", length = 100)
	public String getCreatTime() {
		return this.creatTime;
	}

	public void setCreatTime(String creatTime) {
		this.creatTime = creatTime;
	}

	@Column(name = "type")
	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	@Column(name = "sendType")
	public short getSendType() {
		return sendType;
	}

	public void setSendType(short sendType) {
		this.sendType = sendType;
	}

	
}