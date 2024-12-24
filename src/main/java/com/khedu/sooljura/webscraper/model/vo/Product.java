package com.khedu.sooljura.webscraper.model.vo;
//임시로 쓰고있음. 추후 admin/model/vo/Product로 사용예정

import java.util.ArrayList;

import com.khedu.sooljura.admin.model.vo.ProductImage;

public class Product {
    private String prodName;   //제품명
    private String prodPrice;  //제품가격
    private String prodMaker;  //제조사
    private String prodOrigin; //원산지
    private String prodIntro;  //제품 소개
    private String prodCnt;    //제품 개수

    private String isTrading; //is_trading  거래중? 1=거래중 0=거래중지
    private String prodVol;   //용량  							
    private String prodProof; //알콜도수  							

    private String categoryKey;

    private ArrayList<ProductImage> productImages;

	private String detailImgLoc;
	private String detailImgNm;
	
	public Product() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Product(String prodName, String prodPrice, String prodMaker, String prodOrigin, String prodIntro,
			String prodCnt, String isTrading, String prodVol, String prodProof, String categoryKey,
			ArrayList<ProductImage> productImages, String detailImgLoc, String detailImgNm) {
		super();
		this.prodName = prodName;
		this.prodPrice = prodPrice;
		this.prodMaker = prodMaker;
		this.prodOrigin = prodOrigin;
		this.prodIntro = prodIntro;
		this.prodCnt = prodCnt;
		this.isTrading = isTrading;
		this.prodVol = prodVol;
		this.prodProof = prodProof;
		this.categoryKey = categoryKey;
		this.productImages = productImages;
		this.detailImgLoc = detailImgLoc;
		this.detailImgNm = detailImgNm;
	}

	public String getProdName() {
		return prodName;
	}

	public void setProdName(String prodName) {
		this.prodName = prodName;
	}

	public String getProdPrice() {
		return prodPrice;
	}

	public void setProdPrice(String prodPrice) {
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

	public String getProdCnt() {
		return prodCnt;
	}

	public void setProdCnt(String prodCnt) {
		this.prodCnt = prodCnt;
	}

	public String getIsTrading() {
		return isTrading;
	}

	public void setIsTrading(String isTrading) {
		this.isTrading = isTrading;
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

	public String getCategoryKey() {
		return categoryKey;
	}

	public void setCategoryKey(String categoryKey) {
		this.categoryKey = categoryKey;
	}

	public ArrayList<ProductImage> getProductImages() {
		return productImages;
	}

	public void setProductImages(ArrayList<ProductImage> productImages) {
		this.productImages = productImages;
	}

	public String getDetailImgLoc() {
		return detailImgLoc;
	}

	public void setDetailImgLoc(String detailImgLoc) {
		this.detailImgLoc = detailImgLoc;
	}

	public String getDetailImgNm() {
		return detailImgNm;
	}

	public void setDetailImgNm(String detailImgNm) {
		this.detailImgNm = detailImgNm;
	}

	@Override
	public String toString() {
		return "Product [prodName=" + prodName + ", prodPrice=" + prodPrice + ", prodMaker=" + prodMaker
				+ ", prodOrigin=" + prodOrigin + ", prodIntro=" + prodIntro + ", prodCnt=" + prodCnt + ", isTrading="
				+ isTrading + ", prodVol=" + prodVol + ", prodProof=" + prodProof + ", categoryKey=" + categoryKey
				+ ", productImages=" + productImages + ", detailImgLoc=" + detailImgLoc + ", detailImgNm=" + detailImgNm
				+ "]";
	}
	
	
	
}
