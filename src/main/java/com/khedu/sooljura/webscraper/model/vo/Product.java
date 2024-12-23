package com.khedu.sooljura.webscraper.model.vo;
//임시로 쓰고있음. 추후 admin/model/vo/Product로 사용예정


public class Product {
	private String prodNm; 		//제품명
	private String prodPrice; 	//제품가격
	private String prodMaker; 	//제조사
	private String prodOrigin; 	//원산지
	private String prodIntro; 	//제품 소개
	private String prodCnt; 	//제품 개수
	
	private String isTrading; 	//is_trading  거래중? 1=거래중 0=거래중지 	// tbl_prod 컬럼 추가 예정 
	private String prodVol; 	//용량  									//tbl_prod 컬럼 추가 예정 
	private String prodProof; 	//알콜도수  								//tbl_prod 컬럼 추가 예정 
	
	private String prodImgThumbnail;
	private String prodImgDetail;
	
	public Product() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Product(String prodNm, String prodPrice, String prodMaker, String prodOrigin, String prodIntro,
			String prodCnt, String isTrading, String prodVol, String prodProof, String prodImgThumbnail,
			String prodImgDetail) {
		super();
		this.prodNm = prodNm;
		this.prodPrice = prodPrice;
		this.prodMaker = prodMaker;
		this.prodOrigin = prodOrigin;
		this.prodIntro = prodIntro;
		this.prodCnt = prodCnt;
		this.isTrading = isTrading;
		this.prodVol = prodVol;
		this.prodProof = prodProof;
		this.prodImgThumbnail = prodImgThumbnail;
		this.prodImgDetail = prodImgDetail;
	}

	public String getProdNm() {
		return prodNm;
	}

	public void setProdNm(String prodNm) {
		this.prodNm = prodNm;
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

	public String getProdImgThumbnail() {
		return prodImgThumbnail;
	}

	public void setProdImgThumbnail(String prodImgThumbnail) {
		this.prodImgThumbnail = prodImgThumbnail;
	}

	public String getProdImgDetail() {
		return prodImgDetail;
	}

	public void setProdImgDetail(String prodImgDetail) {
		this.prodImgDetail = prodImgDetail;
	}

	@Override
	public String toString() {
		return "prodNm=" + prodNm + "\nprodPrice=" + prodPrice + "\nprodMaker=" + prodMaker + "\nprodOrigin="
				+ prodOrigin + "\nprodIntro=" + prodIntro + "\nprodCnt=" + prodCnt + "\nisTrading=" + isTrading
				+ "\nprodVol=" + prodVol + "\nprodProof=" + prodProof + "\nprodImgThumbnail=" + prodImgThumbnail
				+ "\nprodImgDetail=" + prodImgDetail;
	}

	
}	
