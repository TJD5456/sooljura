package com.khedu.sooljura.product.model.vo;

public class ProductDiscountHistory {

	private String histCd;
	private String prodKey;
	private String eventCd;
	private String eventNm;
	
	public ProductDiscountHistory() {
		super();
	}

	public ProductDiscountHistory(String histCd, String prodKey, String eventCd) {
		super();
		this.histCd = histCd;
		this.prodKey = prodKey;
		this.eventCd = eventCd;
	}

	public String getHistCd() {
		return histCd;
	}

	public void setHistCd(String histCd) {
		this.histCd = histCd;
	}

	public String getProdKey() {
		return prodKey;
	}

	public void setProdKey(String prodKey) {
		this.prodKey = prodKey;
	}

	public String getEventCd() {
		return eventCd;
	}

	public void setEventCd(String eventCd) {
		this.eventCd = eventCd;
	}

	public String getEventNm() {
		return eventNm;
	}

	public void setEventNm(String eventNm) {
		this.eventNm = eventNm;
	}
}
