package com.khedu.sooljura.product.model.vo;

public class Basket {
	private String basketKey;
	private int basketCd;
	private String prodKey;
	private String userKey;
	private int basketCnt;
	
	public Basket() {
		super();
	}

	public Basket(String basketKey, int basketCd, String prodKey, String userKey, int basketCnt) {
		super();
		this.basketKey = basketKey;
		this.basketCd = basketCd;
		this.prodKey = prodKey;
		this.userKey = userKey;
		this.basketCnt = basketCnt;
	}

	public String getBasketKey() {
		return basketKey;
	}

	public void setBasketKey(String basketKey) {
		this.basketKey = basketKey;
	}

	public int getBasketCd() {
		return basketCd;
	}

	public void setBasketCd(int basketCd) {
		this.basketCd = basketCd;
	}

	public String getProdKey() {
		return prodKey;
	}

	public void setProdKey(String prodKey) {
		this.prodKey = prodKey;
	}

	public String getUserKey() {
		return userKey;
	}

	public void setUserKey(String userKey) {
		this.userKey = userKey;
	}

	public int getBasketCnt() {
		return basketCnt;
	}

	public void setBasketCnt(int basketCnt) {
		this.basketCnt = basketCnt;
	}

	@Override
	public String toString() {
		return "basket [basketKey=" + basketKey + ", basketCd=" + basketCd + ", prodKey=" + prodKey + ", userKey="
				+ userKey + ", basketCnt=" + basketCnt + "]";
	}
	
}
