package com.khedu.sooljura.admin.model.vo;

public class ProductImage {
    private String imgKey;
    private String imgNm;
    private String imgPath;
    private String prodKey;

    public ProductImage() {
        super();
    }

    public ProductImage(String imgKey, String imgNm, String imgPath, String prodKey) {
        this.imgKey = imgKey;
        this.imgNm = imgNm;
        this.imgPath = imgPath;
        this.prodKey = prodKey;
    }

    public String getImgKey() {
        return imgKey;
    }

    public void setImgKey(String imgKey) {
        this.imgKey = imgKey;
    }

    public String getImgNm() {
        return imgNm;
    }

    public void setImgNm(String imgNm) {
        this.imgNm = imgNm;
    }

    public String getImgPath() {
        return imgPath;
    }

    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }

    public String getProdKey() {
        return prodKey;
    }

    public void setProdKey(String prodKey) {
        this.prodKey = prodKey;
    }

}
