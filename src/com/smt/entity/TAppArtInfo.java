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
@Table(name = "t_app_art_info", catalog = "no1stage")
public class TAppArtInfo implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer userId;
	private String type;
	private String title;
	private String intro;
	private String url;
	private String img;
	private String attachment;
	private Integer imgCount;
	private String creatTime;
	private Integer ding;
	private Integer share;
	private Integer evaluate;

	// Constructors
	@Column(name = "imgCount")
	public Integer getImgCount() {
		return imgCount;
	}

	public void setImgCount(Integer imgCount) {
		this.imgCount = imgCount;
	}

	/** default constructor */
	public TAppArtInfo() {
	}

	/** minimal constructor */
	public TAppArtInfo(Integer userId) {
		this.userId = userId;
	}

	/** full constructor */
	public TAppArtInfo(Integer userId, String type, String title, String intro,
			String url, String attachment, String creatTime,Integer ding,Integer share,Integer evaluate) {
		this.userId = userId;
		this.type = type;
		this.title = title;
		this.intro = intro;
		this.url = url;
		this.attachment = attachment;
		this.creatTime = creatTime;
		this.ding = ding;
		this.share = share;
		this.evaluate = evaluate;
	}

	// Property accessors
	@Id
	@Column(name = "ID", unique = true, nullable = false)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "UserId", nullable = false)
	public Integer getUserId() {
		return this.userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	@Column(name = "ding", nullable = false)
	public Integer getDing() {
		return this.ding;
	}

	public void setDing(Integer ding) {
		this.ding = ding;
	}

	@Column(name = "share", nullable = false)
	public Integer getShare() {
		return this.share;
	}

	public void setShare(Integer share) {
		this.share = share;
	}
	
	@Column(name = "evaluate", nullable = false)
	public Integer getEvaluate() {
		return this.evaluate;
	}

	public void setEvaluate(Integer evaluate) {
		this.evaluate = evaluate;
	}
	
	@Column(name = "Type", length = 100)
	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Column(name = "Title", length = 100)
	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Column(name = "Intro", length = 100)
	public String getIntro() {
		return this.intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	@Column(name = "Url", length = 100)
	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	@Column(name = "Attachment", length = 100)
	public String getAttachment() {
		return this.attachment;
	}

	public void setAttachment(String attachment) {
		this.attachment = attachment;
	}

	@Column(name = "CreatTime", length = 100)
	public String getCreatTime() {
		return this.creatTime;
	}

	public void setCreatTime(String creatTime) {
		this.creatTime = creatTime;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

}