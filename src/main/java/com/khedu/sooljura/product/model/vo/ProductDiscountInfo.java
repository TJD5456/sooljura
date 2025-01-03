package com.khedu.sooljura.product.model.vo;

public class ProductDiscountInfo {
	
	private String eventCode;
	private int eventNm;
	private int discountPercent;
	private int discountAmount;
	
	public ProductDiscountInfo() {
		super();
	}

	public ProductDiscountInfo(String eventCode, int eventNm, int discountPercent, int discountAmount) {
		super();
		this.eventCode = eventCode;
		this.eventNm = eventNm;
		this.discountPercent = discountPercent;
		this.discountAmount = discountAmount;
	}

	public String getEventCode() {
		return eventCode;
	}

	public void setEventCode(String eventCode) {
		this.eventCode = eventCode;
	}

	public int getEventNm() {
		return eventNm;
	}

	public void setEventNm(int eventNm) {
		this.eventNm = eventNm;
	}

	public int getDiscountPercent() {
		return discountPercent;
	}

	public void setDiscountPercent(int discountPercent) {
		this.discountPercent = discountPercent;
	}

	public int getDiscountAmount() {
		return discountAmount;
	}

	public void setDiscountAmount(int discountAmount) {
		this.discountAmount = discountAmount;
	}

		
}
