package com.khedu.sooljura.product.model.vo;

import java.util.List;

public class Basket {
    private String basketKey;
    private int basketCd;
    private String prodKey;
    private String userKey;
    private int basketCnt;

    private List<String> prodKeyArr;
    
	public Basket() {
		super();
	}

	public Basket(String basketKey, int basketCd, String prodKey, String userKey, int basketCnt,
			List<String> prodKeyArr) {
		super();
		this.basketKey = basketKey;
		this.basketCd = basketCd;
		this.prodKey = prodKey;
		this.userKey = userKey;
		this.basketCnt = basketCnt;
		this.prodKeyArr = prodKeyArr;
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

	public List<String> getProdKeyArr() {
		return prodKeyArr;
	}

	public void setProdKeyArr(List<String> prodKeyArr) {
		this.prodKeyArr = prodKeyArr;
	}

	@Override
	public String toString() {
		return "Basket [basketKey=" + basketKey + ", basketCd=" + basketCd + ", prodKey=" + prodKey + ", userKey="
				+ userKey + ", basketCnt=" + basketCnt + ", prodKeyArr=" + prodKeyArr + "]";
	}

	
}
