package com.smt.webapp.util;

public class UserSession {
	private int id;
	private String userName;
	private String state;
	private String email;
	private String authority;
	private int isOrg;
	private String redirect;

	public String getRedirect() {
		return redirect;
	}
	public void setRedirect(String redirect) {
		this.redirect = redirect;
	}
	public int getIsOrg() {
		return isOrg;
	}
	public void setIsOrg(int isOrg) {
		this.isOrg = isOrg;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	
	
	

}
