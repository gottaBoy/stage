package com.smt.entity;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;


/**
 * TAppUserInfo entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_app_user_info", catalog = "no1stage")
public class TAppUserInfo implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer userId;
	private String name;
	private String sex;
	private String heartSize;
	private String waistSize;
	private String bottocksSize;
	private String birthday;
	private String height;
	private String mobile;
	private String provice;
	private String company;
	private String education;
	private String school;
	private String major;
	private Integer signNumber;
	private String signAmount;
	private String introduction;
	private Integer popularityTotal;
	private String idCard;
	private String idCardCopy;
	private String idCardCopy2;
	private String orgCard;
	private String orgCardCopy;
	private String headPortrait;
	private String grade;
	private String sellerGrade;//卖家等级
	private Integer feedbackRate;
	private String talentsType;
	private String modifyTime;
	private String creatTime;
	private String nickName;
	private String booldType;
	private String city;
	private String weight;
	private String telPhone;
	private String qq;
	private String profession;
	private String isRecommend;
	private String recommendUrl;
	private String recommendTime;
	private String alipay;
	private String professionStr;
	private String comRecommend;
	private String comRecommendTime;
	private Integer collect;
	private Integer attention;
	private Integer mobileRadio;//1、不公开2、公开3、仅好友可见
	private Integer qqRadio;
	private String alipayName;
	private Integer age;
	private Integer jcxxIsFinish;//基础信息是否录入完成1、是2、否，30%
	private Integer zyjnIsFinish;//职业技能是否录入完成1、是2、否，20%
	private Integer czjlIsFinish;//成长经历是否录入完成1、是2、否，10%
	private Integer xcIsFinish;//相册是否录入完成1、是2、否，10%
	private Integer spIsFinish;//视频是否录入完成1、是2、否，10%
	private Integer ypIsFinish;//音频是否录入完成1、是2、否，10%
	private Integer sytjIsFinish;//首页推荐是否录入完成1、是2、否，10%
	private Integer isShare;//是否弹出分享页面1、是2、否
	private String place;
	private String companyTags;
	private String seviceScope;
	
	private int totalFriends;
	
	// Constructors

	/** default constructor */
	public TAppUserInfo() {
	}

	/** minimal constructor */
	public TAppUserInfo(Integer userId) {
		this.userId = userId;
	}

	/** full constructor */
	public TAppUserInfo(Integer id, Integer userId, String name, String sex,
			String heartSize, String waistSize, String bottocksSize,
			String birthday, String height, String mobile, String provice,
			String company, String education, String school, String major,
			Integer signNumber, String signAmount, String introduction,
			Integer popularityTotal, String idCard, String idCardCopy,
			String headPortrait, String grade, String sellerGrade,
			Integer feedbackRate, String talentsType, String modifyTime,
			String creatTime, String nickName, String booldType, String city,
			String weight, String telPhone, String qq, String profession,
			String isRecommend, String recommendUrl, String recommendTime,
			String alipay, String professionStr, String comRecommend,
			String comRecommendTime, Integer collect, Integer attention,
			Integer mobileRadio, Integer qqRadio, String alipayName,
			Integer jcxxIsFinish, Integer zyjnIsFinish, Integer czjlIsFinish,
			Integer xcIsFinish, Integer spIsFinish, Integer ypIsFinish,
			Integer sytjIsFinish,Integer age,Integer isShare,String place) {
		this.id = id;
		this.userId = userId;
		this.name = name;
		this.sex = sex;
		this.heartSize = heartSize;
		this.waistSize = waistSize;
		this.bottocksSize = bottocksSize;
		this.birthday = birthday;
		this.height = height;
		this.mobile = mobile;
		this.provice = provice;
		this.company = company;
		this.education = education;
		this.school = school;
		this.major = major;
		this.signNumber = signNumber;
		this.signAmount = signAmount;
		this.introduction = introduction;
		this.popularityTotal = popularityTotal;
		this.idCard = idCard;
		this.idCardCopy = idCardCopy;
		this.headPortrait = headPortrait;
		this.grade = grade;
		this.sellerGrade = sellerGrade;
		this.feedbackRate = feedbackRate;
		this.talentsType = talentsType;
		this.modifyTime = modifyTime;
		this.creatTime = creatTime;
		this.nickName = nickName;
		this.booldType = booldType;
		this.city = city;
		this.weight = weight;
		this.telPhone = telPhone;
		this.qq = qq;
		this.profession = profession;
		this.isRecommend = isRecommend;
		this.recommendUrl = recommendUrl;
		this.recommendTime = recommendTime;
		this.alipay = alipay;
		this.professionStr = professionStr;
		this.comRecommend = comRecommend;
		this.comRecommendTime = comRecommendTime;
		this.collect = collect;
		this.attention = attention;
		this.mobileRadio = mobileRadio;
		this.qqRadio = qqRadio;
		this.alipayName = alipayName;
		this.jcxxIsFinish = jcxxIsFinish;
		this.zyjnIsFinish = zyjnIsFinish;
		this.czjlIsFinish = czjlIsFinish;
		this.xcIsFinish = xcIsFinish;
		this.spIsFinish = spIsFinish;
		this.ypIsFinish = ypIsFinish;
		this.sytjIsFinish = sytjIsFinish;
		this.age = age;
		this.isShare = isShare;
		this.place = place;
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

	@Column(name = "Name", length = 100)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "Sex", length = 100)
	public String getSex() {
		return this.sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	@Column(name = "Heart_size", length = 100)
	public String getHeartSize() {
		return this.heartSize;
	}

	public void setHeartSize(String heartSize) {
		this.heartSize = heartSize;
	}

	@Column(name = "Waist_size", length = 100)
	public String getWaistSize() {
		return this.waistSize;
	}

	public void setWaistSize(String waistSize) {
		this.waistSize = waistSize;
	}

	@Column(name = "Bottocks_size", length = 100)
	public String getBottocksSize() {
		return this.bottocksSize;
	}

	public void setBottocksSize(String bottocksSize) {
		this.bottocksSize = bottocksSize;
	}

	@Column(name = "Birthday", length = 100)
	public String getBirthday() {
		return this.birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	@Column(name = "Height", length = 100)
	public String getHeight() {
		return this.height;
	}

	public void setHeight(String height) {
		this.height = height;
	}

	@Column(name = "Mobile", length = 100)
	public String getMobile() {
		return this.mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	@Column(name = "provice", length = 32)
	public String getProvice() {
		return this.provice;
	}

	public void setProvice(String provice) {
		this.provice = provice;
	}

	@Column(name = "Company", length = 200)
	public String getCompany() {
		return this.company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	@Column(name = "Education", length = 200)
	public String getEducation() {
		return this.education;
	}

	public void setEducation(String education) {
		this.education = education;
	}

	@Column(name = "School", length = 200)
	public String getSchool() {
		return this.school;
	}

	public void setSchool(String school) {
		this.school = school;
	}

	@Column(name = "Major", length = 100)
	public String getMajor() {
		return this.major;
	}

	public void setMajor(String major) {
		this.major = major;
	}

	@Column(name = "SignNumber")
	public Integer getSignNumber() {
		return this.signNumber;
	}

	public void setSignNumber(Integer signNumber) {
		this.signNumber = signNumber;
	}

	@Column(name = "SignAmount", length = 100)
	public String getSignAmount() {
		return this.signAmount;
	}

	public void setSignAmount(String signAmount) {
		this.signAmount = signAmount;
	}

	@Column(name = "Introduction", length = 500)
	public String getIntroduction() {
		return this.introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	@Column(name = "PopularityTotal", length = 100)
	public Integer getPopularityTotal() {
		return this.popularityTotal;
	}

	public void setPopularityTotal(Integer popularityTotal) {
		this.popularityTotal = popularityTotal;
	}

	@Column(name = "IdCard", length = 100)
	public String getIdCard() {
		return this.idCard;
	}

	public void setIdCard(String idCard) {
		this.idCard = idCard;
	}

	@Column(name = "IdCardCopy", length = 100)
	public String getIdCardCopy() {
		return this.idCardCopy;
	}

	public void setIdCardCopy(String idCardCopy) {
		this.idCardCopy = idCardCopy;
	}
	@Column(name = "IdCardCopy2", length = 100)
	public String getIdCardCopy2() {
		return this.idCardCopy2;
	}
	
	public void setIdCardCopy2(String idCardCopy2) {
		this.idCardCopy2 = idCardCopy2;
	}
	@Column(name = "orgCard", length = 100)
	public String getOrgCard() {
		return orgCard;
	}

	public void setOrgCard(String orgCard) {
		this.orgCard = orgCard;
	}
	@Column(name = "orgCardCopy", length = 100)
	public String getOrgCardCopy() {
		return orgCardCopy;
	}

	public void setOrgCardCopy(String orgCardCopy) {
		this.orgCardCopy = orgCardCopy;
	}

	@Column(name = "HeadPortrait", length = 100)
	public String getHeadPortrait() {
		return this.headPortrait;
	}

	public void setHeadPortrait(String headPortrait) {
		this.headPortrait = headPortrait;
	}

	@Column(name = "Grade", length = 100)
	public String getGrade() {
		return this.grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}
	@Column(name = "sellerGrade", length = 100)
	public String getSellerGrade() {
		return this.sellerGrade;
	}

	public void setSellerGrade(String sellerGrade) {
		this.sellerGrade = sellerGrade;
	}

	@Column(name = "FeedbackRate", length = 100)
	public Integer getFeedbackRate() {
		return this.feedbackRate;
	}

	public void setFeedbackRate(Integer feedbackRate) {
		this.feedbackRate = feedbackRate;
	}

	@Column(name = "TalentsType", length = 100)
	public String getTalentsType() {
		return this.talentsType;
	}

	public void setTalentsType(String talentsType) {
		this.talentsType = talentsType;
	}

	@Column(name = "ModifyTime", length = 100)
	public String getModifyTime() {
		return this.modifyTime;
	}

	public void setModifyTime(String modifyTime) {
		this.modifyTime = modifyTime;
	}

	@Column(name = "CreatTime", length = 100)
	public String getCreatTime() {
		return this.creatTime;
	}

	public void setCreatTime(String creatTime) {
		this.creatTime = creatTime;
	}

	@Column(name = "nickName", length = 100)
	public String getNickName() {
		return this.nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	@Column(name = "booldType", length = 2)
	public String getBooldType() {
		return this.booldType;
	}

	public void setBooldType(String booldType) {
		this.booldType = booldType;
	}

	@Column(name = "city", length = 32)
	public String getCity() {
		return this.city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	@Column(name = "weight", length = 32)
	public String getWeight() {
		return this.weight;
	}

	public void setWeight(String weight) {
		this.weight = weight;
	}

	@Column(name = "telPhone", length = 32)
	public String getTelPhone() {
		return this.telPhone;
	}

	public void setTelPhone(String telPhone) {
		this.telPhone = telPhone;
	}

	@Column(name = "qq", length = 32)
	public String getQq() {
		return this.qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	@Column(name = "profession", length = 100)
	public String getProfession() {
		return this.profession;
	}

	public void setProfession(String profession) {
		this.profession = profession;
	}

	@Column(name = "isRecommend", length = 32)
	public String getIsRecommend() {
		return this.isRecommend;
	}

	public void setIsRecommend(String isRecommend) {
		this.isRecommend = isRecommend;
	}

	@Column(name = "recommendUrl", length = 100)
	public String getRecommendUrl() {
		return this.recommendUrl;
	}

	public void setRecommendUrl(String recommendUrl) {
		this.recommendUrl = recommendUrl;
	}
	
	
	@Column(name = "recommendTime", length = 32)
	public String getRecommendTime() {
		return this.recommendTime;
	}

	public void setRecommendTime(String recommendTime) {
		this.recommendTime = recommendTime;
	}
	
	@Column(name = "alipay", length = 200)
	public String getAlipay() {
		return this.alipay;
	}

	public void setAlipay(String alipay) {
		this.alipay = alipay;
	}
	
	@Column(name = "professionStr", length = 500)
	public String getProfessionStr() {
		return this.professionStr;
	}

	public void setProfessionStr(String professionStr) {
		this.professionStr = professionStr;
	}
	
	@Column(name = "comRecommend", length = 32)
	public String getComRecommend() {
		return this.comRecommend;
	}

	public void setComRecommend(String comRecommend) {
		this.comRecommend = comRecommend;
	}
	
	@Column(name = "comRecommendTime", length = 100)
	public String getComRecommendTime() {
		return this.comRecommendTime;
	}

	public void setComRecommendTime(String comRecommendTime) {
		this.comRecommendTime = comRecommendTime;
	}
	@Column(name = "collect")
	public Integer getCollect() {
		return collect;
	}

	public void setCollect(Integer collect) {
		this.collect = collect;
	}
	@Column(name = "attention")
	public Integer getAttention() {
		return attention;
	}

	public void setAttention(Integer attention) {
		this.attention = attention;
	}
	@Column(name = "mobileRadio")
	public Integer getMobileRadio() {
		return mobileRadio;
	}

	public void setMobileRadio(Integer mobileRadio) {
		this.mobileRadio = mobileRadio;
	}
	@Column(name = "qqRadio")
	public Integer getQqRadio() {
		return qqRadio;
	}

	public void setQqRadio(Integer qqRadio) {
		this.qqRadio = qqRadio;
	}

	@Column(name = "alipayName", length = 100)
	public String getAlipayName() {
		return this.alipayName;
	}

	public void setAlipayName(String alipayName) {
		this.alipayName = alipayName;
	}

	@Column(name = "jcxxIsFinish")
	public Integer getJcxxIsFinish() {
		return jcxxIsFinish;
	}

	public void setJcxxIsFinish(Integer jcxxIsFinish) {
		this.jcxxIsFinish = jcxxIsFinish;
	}

	@Column(name = "zyjnIsFinish")
	public Integer getZyjnIsFinish() {
		return zyjnIsFinish;
	}

	public void setZyjnIsFinish(Integer zyjnIsFinish) {
		this.zyjnIsFinish = zyjnIsFinish;
	}

	@Column(name = "czjlIsFinish")
	public Integer getCzjlIsFinish() {
		return czjlIsFinish;
	}

	public void setCzjlIsFinish(Integer czjlIsFinish) {
		this.czjlIsFinish = czjlIsFinish;
	}

	@Column(name = "xcIsFinish")
	public Integer getXcIsFinish() {
		return xcIsFinish;
	}

	public void setXcIsFinish(Integer xcIsFinish) {
		this.xcIsFinish = xcIsFinish;
	}

	@Column(name = "spIsFinish")
	public Integer getSpIsFinish() {
		return spIsFinish;
	}

	public void setSpIsFinish(Integer spIsFinish) {
		this.spIsFinish = spIsFinish;
	}

	@Column(name = "ypIsFinish")
	public Integer getYpIsFinish() {
		return ypIsFinish;
	}

	public void setYpIsFinish(Integer ypIsFinish) {
		this.ypIsFinish = ypIsFinish;
	}

	@Column(name = "sytjIsFinish")
	public Integer getSytjIsFinish() {
		return sytjIsFinish;
	}

	public void setSytjIsFinish(Integer sytjIsFinish) {
		this.sytjIsFinish = sytjIsFinish;
	}
	
	@Column(name = "age", nullable = false)
	public Integer getAge() {
		return this.age;
	}

	public void setAge(Integer age) {
		this.age = age;
	}
	
	@Column(name = "isShare")
	public Integer getIsShare() {
		return this.isShare;
	}

	public void setIsShare(Integer isShare) {
		this.isShare = isShare;
	}
	
	@Column(name = "Place", length = 500)
	public String getPlace() {
		return this.place;
	}

	public void setPlace(String place) {
		this.place = place;
	}
	@Column(name = "companyTags", length = 500)
	public String getCompanyTags() {
		return companyTags;
	}

	public void setCompanyTags(String companyTags) {
		this.companyTags = companyTags;
	}
	@Column(name = "seviceScope", length = 500)
	public String getSeviceScope() {
		return seviceScope;
	}

	public void setSeviceScope(String seviceScope) {
		this.seviceScope = seviceScope;
	}

	@Transient
	public int getTotalFriends() {
		return totalFriends;
	}

	public void setTotalFriends(int totalFriends) {
		this.totalFriends = totalFriends;
	}

}