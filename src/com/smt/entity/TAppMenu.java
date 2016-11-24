package com.smt.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * TAppMenu entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_app_menu", catalog = "no1stage")
public class TAppMenu implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer menuNo;
	private String menuName;
	private Integer menuLevel;
	private String active;
	private String link;

	// Constructors

	/** default constructor */
	public TAppMenu() {
	}

	/** minimal constructor */
	public TAppMenu(Integer menuNo, String menuName, Integer menuLevel) {
		this.menuNo = menuNo;
		this.menuName = menuName;
		this.menuLevel = menuLevel;
	}

	/** full constructor */
	public TAppMenu(Integer menuNo, String menuName, Integer menuLevel,
			String active, String link) {
		this.menuNo = menuNo;
		this.menuName = menuName;
		this.menuLevel = menuLevel;
		this.active = active;
		this.link = link;
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

	@Column(name = "menuNo", nullable = false)
	public Integer getMenuNo() {
		return this.menuNo;
	}

	public void setMenuNo(Integer menuNo) {
		this.menuNo = menuNo;
	}

	@Column(name = "menuName", nullable = false, length = 100)
	public String getMenuName() {
		return this.menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	@Column(name = "menuLevel", nullable = false)
	public Integer getMenuLevel() {
		return this.menuLevel;
	}

	public void setMenuLevel(Integer menuLevel) {
		this.menuLevel = menuLevel;
	}

	@Column(name = "active", length = 1)
	public String getActive() {
		return this.active;
	}

	public void setActive(String active) {
		this.active = active;
	}

	@Column(name = "link", length = 500)
	public String getLink() {
		return this.link;
	}

	public void setLink(String link) {
		this.link = link;
	}

}