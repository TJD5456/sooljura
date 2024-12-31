package com.khedu.sooljura.user.model.vo;

public class UserAddr {
    private String addrKey;
    private String userKey;
    private String addrNm;
    private String addrCd;
    private String addr;
    private String addrDetail;
    private String addrRef;
    private String rcptNm;
    private String rcptPhone;
    private int defaultYn;

    public UserAddr() {
        super();
    }

    public UserAddr(String addrKey, String userKey, String addrNm, String addrCd, String addr, String addrDetail,
                    String addrRef, String rcptNm, String rcptPhone, int defaultYn) {
        super();
        this.addrKey = addrKey;
        this.userKey = userKey;
        this.addrNm = addrNm;
        this.addrCd = addrCd;
        this.addr = addr;
        this.addrDetail = addrDetail;
        this.addrRef = addrRef;
        this.rcptNm = rcptNm;
        this.rcptPhone = rcptPhone;
        this.defaultYn = defaultYn;
    }

    public String getAddrKey() {
        return addrKey;
    }

    public void setAddrKey(String addrKey) {
        this.addrKey = addrKey;
    }

    public String getUserKey() {
        return userKey;
    }

    public void setUserKey(String userKey) {
        this.userKey = userKey;
    }

    public String getAddrNm() {
        return addrNm;
    }

    public void setAddrNm(String addrNm) {
        this.addrNm = addrNm;
    }

    public String getAddrCd() {
        return addrCd;
    }

    public void setAddrCd(String addrCd) {
        this.addrCd = addrCd;
    }

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr;
    }

    public String getAddrDetail() {
        return addrDetail;
    }

    public void setAddrDetail(String addrDetail) {
        this.addrDetail = addrDetail;
    }

    public String getAddrRef() {
        return addrRef;
    }

    public void setAddrRef(String addrRef) {
        this.addrRef = addrRef;
    }

    public String getRcptNm() {
        return rcptNm;
    }

    public void setRcptNm(String rcptNm) {
        this.rcptNm = rcptNm;
    }

    public String getRcptPhone() {
        return rcptPhone;
    }

    public void setRcptPhone(String rcptPhone) {
        this.rcptPhone = rcptPhone;
    }

    public int getDefaultYn() {
        return defaultYn;
    }

    public void setDefaultYn(int defaultYn) {
        this.defaultYn = defaultYn;
    }

    @Override
    public String toString() {
        return "UserAddr [addrKey=" + addrKey + ", userKey=" + userKey + ", addrNm=" + addrNm + ", addrCd=" + addrCd
                + ", addr=" + addr + ", addrDetail=" + addrDetail + ", addrRef=" + addrRef + ", rcptNm=" + rcptNm
                + ", rcptPhone=" + rcptPhone + ", defaultYn=" + defaultYn + "]";
    }

}
