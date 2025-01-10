package com.khedu.sooljura.admin.model.vo;

import java.util.ArrayList;

public class Product {
    private String prodKey;
    private String prodNm;
    private int prodPrice;
    private String prodMaker;
    private String prodOrigin;
    private String prodIntro;
    private int prodCnt;
    private String prodVol;
    private String prodProof;
    private String uploadDate;
    private int tradingYn;
    private String categoryKey;

    private ProductCategory productCategory;

    private ArrayList<ProductImage> productImages;

    private String imgKey;
    private String imgNm;
    private String imgPath;
    
    public Product() {
        super();
    }

	public Product(String prodKey, String prodNm, int prodPrice, String prodMaker, String prodOrigin, String prodIntro,
			int prodCnt, String prodVol, String prodProof, String uploadDate, int tradingYn, String categoryKey,
			ProductCategory productCategory, ArrayList<ProductImage> productImages, String imgKey, String imgNm,
			String imgPath) {
		super();
		this.prodKey = prodKey;
		this.prodNm = prodNm;
		this.prodPrice = prodPrice;
		this.prodMaker = prodMaker;
		this.prodOrigin = prodOrigin;
		this.prodIntro = prodIntro;
		this.prodCnt = prodCnt;
		this.prodVol = prodVol;
		this.prodProof = prodProof;
		this.uploadDate = uploadDate;
		this.tradingYn = tradingYn;
		this.categoryKey = categoryKey;
		this.productCategory = productCategory;
		this.productImages = productImages;
		this.imgKey = imgKey;
		this.imgNm = imgNm;
		this.imgPath = imgPath;
	}

	public String getProdKey() {
		return prodKey;
	}

	public void setProdKey(String prodKey) {
		this.prodKey = prodKey;
	}

	public String getProdNm() {
		return prodNm;
	}

	public void setProdNm(String prodNm) {
		this.prodNm = prodNm;
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

	public String getProdVol() {
		return prodVol;
	}

	public void setProdVol(String prodVol) {
		this.prodVol = prodVol;
	}

	public String getProdProof() {
		return prodProof;
	}

	public void setProdProof(String prodProof) {
		this.prodProof = prodProof;
	}

	public String getUploadDate() {
		return uploadDate;
	}

	public void setUploadDate(String uploadDate) {
		this.uploadDate = uploadDate;
	}

	public int getTradingYn() {
		return tradingYn;
	}

	public void setTradingYn(int tradingYn) {
		this.tradingYn = tradingYn;
	}

	public String getCategoryKey() {
		return categoryKey;
	}

	public void setCategoryKey(String categoryKey) {
		this.categoryKey = categoryKey;
	}

	public ProductCategory getProductCategory() {
		return productCategory;
	}

	public void setProductCategory(ProductCategory productCategory) {
		this.productCategory = productCategory;
	}

	public ArrayList<ProductImage> getProductImages() {
		return productImages;
	}

	public void setProductImages(ArrayList<ProductImage> productImages) {
		this.productImages = productImages;
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

	@Override
	public String toString() {
		return "Product [prodKey=" + prodKey + ", prodNm=" + prodNm + ", prodPrice=" + prodPrice + ", prodMaker="
				+ prodMaker + ", prodOrigin=" + prodOrigin + ", prodIntro=" + prodIntro + ", prodCnt=" + prodCnt
				+ ", prodVol=" + prodVol + ", prodProof=" + prodProof + ", uploadDate=" + uploadDate + ", tradingYn="
				+ tradingYn + ", categoryKey=" + categoryKey + ", productCategory=" + productCategory
				+ ", productImages=" + productImages + ", imgKey=" + imgKey + ", imgNm=" + imgNm + ", imgPath="
				+ imgPath + "]";
	}
	
	

}
