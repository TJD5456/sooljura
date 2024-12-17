package com.khedu.sooljura.user.model.vo;

public class User {
	private String userKey;
	private int userCd;
	private String userId;
	private String userPw;
	private String userEmail;
	private String userName;
	private String userPhone;
	private String userNickname;
	private int userPoint;
	private int adultChk;
	private String enrollDate;
	
	public User() {
		super();
		// TODO Auto-generated constructor stub
	}

	public User(String userKey, int userCd, String userId, String userPw, String userEmail, String userName,
			String userPhone, String userNickname, int userPoint, int adultChk, String enrollDate) {
		super();
		this.userKey = userKey;
		this.userCd = userCd;
		this.userId = userId;
		this.userPw = userPw;
		this.userEmail = userEmail;
		this.userName = userName;
		this.userPhone = userPhone;
		this.userNickname = userNickname;
		this.userPoint = userPoint;
		this.adultChk = adultChk;
		this.enrollDate = enrollDate;
	}

	public String getUserKey() {
		return userKey;
	}
	public void setUserKey(String userKey) {
		this.userKey = userKey;
	}

	public int getUserCd() {
		return userCd;
	}
	public void setUserCd(int userCd) {
		this.userCd = userCd;
	}

	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPw() {
		return userPw;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}

	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserPhone() {
		return userPhone;
	}
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}

	public String getUserNickname() {
		return userNickname;
	}
	public void setUserNickname(String userNickname) {
		this.userNickname = userNickname;
	}

	public int getUserPoint() {
		return userPoint;
	}
	public void setUserPoint(int userPoint) {
		this.userPoint = userPoint;
	}

	public int getAdultChk() {
		return adultChk;
	}
	public void setAdultChk(int adultChk) {
		this.adultChk = adultChk;
	}

	public String getEnrollDate() {
		return enrollDate;
	}
	public void setEnrollDate(String enrollDate) {
		this.enrollDate = enrollDate;
	}

	@Override
	public String toString() {
		return "User [userKey=" + userKey + ", userCd=" + userCd + ", userId=" + userId + ", userPw=" + userPw
				+ ", userEmail=" + userEmail + ", userName=" + userName + ", userPhone=" + userPhone + ", userNickname="
				+ userNickname + ", userPoint=" + userPoint + ", adultChk=" + adultChk + ", enrollDate=" + enrollDate
				+ "]";
	}
}
