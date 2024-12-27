package com.khedu.sooljura.user.model.vo;

public class User {
    private String userKey;
    private int userCd;
    private String userId;
    private String userPw;
    private String userEmail;
    private String userNm;
    private String userPhone;
    private String userNickNm;
    private int userPoint;
    private int adultChk;
    private String enrollDate;

    // 회원 관리 부분에서 보여주기 위해서 추가
    private int postCnt;

    public User() {
        super();
    }

    public User(String userKey, int userCd, String userId, String userPw, String userEmail, String userNm, String userPhone, String userNickNm, int userPoint, int adultChk, String enrollDate, int postCnt) {
        this.userKey = userKey;
        this.userCd = userCd;
        this.userId = userId;
        this.userPw = userPw;
        this.userEmail = userEmail;
        this.userNm = userNm;
        this.userPhone = userPhone;
        this.userNickNm = userNickNm;
        this.userPoint = userPoint;
        this.adultChk = adultChk;
        this.enrollDate = enrollDate;
        this.postCnt = postCnt;
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

    public String getUserNm() {
        return userNm;
    }

    public void setUserNm(String userNm) {
        this.userNm = userNm;
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public String getUserNickNm() {
        return userNickNm;
    }

    public void setUserNickNm(String userNickNm) {
        this.userNickNm = userNickNm;
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

    public int getPostCnt() {
        return postCnt;
    }

    public void setPostCnt(int postCnt) {
        this.postCnt = postCnt;
    }
}