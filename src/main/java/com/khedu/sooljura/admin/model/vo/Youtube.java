package com.khedu.sooljura.admin.model.vo;

public class Youtube {
    private String youtubeUrl;
    private String content;
    private String prodKey1;
    private String prodKey2;
    private String prodKey3;

    public Youtube() {
        super();
    }

    public Youtube(String youtubeUrl, String content, String prodKey1, String prodKey2, String prodKey3) {
        this.youtubeUrl = youtubeUrl;
        this.content = content;
        this.prodKey1 = prodKey1;
        this.prodKey2 = prodKey2;
        this.prodKey3 = prodKey3;
    }

    public String getYoutubeUrl() {
        return youtubeUrl;
    }

    public void setYoutubeUrl(String youtubeUrl) {
        this.youtubeUrl = youtubeUrl;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getProdKey1() {
        return prodKey1;
    }

    public void setProdKey1(String prodKey1) {
        this.prodKey1 = prodKey1;
    }

    public String getProdKey2() {
        return prodKey2;
    }

    public void setProdKey2(String prodKey2) {
        this.prodKey2 = prodKey2;
    }

    public String getProdKey3() {
        return prodKey3;
    }

    public void setProdKey3(String prodKey3) {
        this.prodKey3 = prodKey3;
    }
}