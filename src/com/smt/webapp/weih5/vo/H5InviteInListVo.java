package com.smt.webapp.weih5.vo;

public class H5InviteInListVo {

	private int inviteUserId;
	private String inviteUserName;
	private String price;
	private String costName;
	private String address;
	private String content;
	private String displayCreateDate;

	/**
	 * for biz/bro user
	 */
	private int artistId;
	private String artistName;
	
	public int getInviteUserId() {
		return inviteUserId;
	}

	public void setInviteUserId(int inviteUserId) {
		this.inviteUserId = inviteUserId;
	}

	public String getInviteUserName() {
		return inviteUserName;
	}

	public void setInviteUserName(String inviteUserName) {
		this.inviteUserName = inviteUserName;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getCostName() {
		return costName;
	}

	public void setCostName(String costName) {
		this.costName = costName;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDisplayCreateDate() {
		return displayCreateDate;
	}

	public void setDisplayCreateDate(String displayCreateDate) {
		this.displayCreateDate = displayCreateDate;
	}

	public int getArtistId() {
		return artistId;
	}

	public void setArtistId(int artistId) {
		this.artistId = artistId;
	}

	public String getArtistName() {
		return artistName;
	}

	public void setArtistName(String artistName) {
		this.artistName = artistName;
	}
	
	

}
