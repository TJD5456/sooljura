package com.khedu.sooljura.admin.model.vo;

import java.util.ArrayList;

public class Product {
    private String prodKey;
    private String prodName;
    private int prodPrice;
    private String prodMaker;
    private String prodOrigin;
    private String prodIntro;
    private int prodCnt;
    private String uploadDate;
    private int categoryCd;

    private ArrayList<ProductImage> productImages;

    public Product() {
        super();
    }

    public Product(String prodKey, String prodName, int prodPrice, String prodMaker, String prodOrigin, String prodIntro, int prodCnt, String uploadDate, int categoryCd, ArrayList<ProductImage> productImages) {
        this.prodKey = prodKey;
        this.prodName = prodName;
        this.prodPrice = prodPrice;
        this.prodMaker = prodMaker;
        this.prodOrigin = prodOrigin;
        this.prodIntro = prodIntro;
        this.prodCnt = prodCnt;
        this.uploadDate = uploadDate;
        this.categoryCd = categoryCd;
        this.productImages = productImages;
    }

    public String getProdKey() {
        return prodKey;
    }

    public void setProdKey(String prodKey) {
        this.prodKey = prodKey;
    }

    public String getProdName() {
        return prodName;
    }

    public void setProdName(String prodName) {
        this.prodName = prodName;
    }

    public int getProdPrice() {
        return prodPrice;
    }

    public void setProdPrice(int prodPrice) {
        this.prodPrice = prodPrice;
    }

    public String getProdMaker() {
        return prodMaker;
    }

    public void setProdMaker(String prodMaker) {
        this.prodMaker = prodMaker;
    }

    public String getProdOrigin() {
        return prodOrigin;
    }

    public void setProdOrigin(String prodOrigin) {
        this.prodOrigin = prodOrigin;
    }

    public String getProdIntro() {
        return prodIntro;
    }

    public void setProdIntro(String prodIntro) {
        this.prodIntro = prodIntro;
    }

    public int getProdCnt() {
        return prodCnt;
    }

    public void setProdCnt(int prodCnt) {
        this.prodCnt = prodCnt;
    }

    public String getUploadDate() {
        return uploadDate;
    }

    public void setUploadDate(String uploadDate) {
        this.uploadDate = uploadDate;
    }

    public int getCategoryCd() {
        return categoryCd;
    }

    public void setCategoryCd(int categoryCd) {
        this.categoryCd = categoryCd;
    }

    public ArrayList<ProductImage> getProductImages() {
        return productImages;
    }

    public void setProductImages(ArrayList<ProductImage> productImages) {
        this.productImages = productImages;
    }
}
