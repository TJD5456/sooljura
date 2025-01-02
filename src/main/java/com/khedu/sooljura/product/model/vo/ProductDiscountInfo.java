package com.khedu.sooljura.product.model.vo;

public class ProductDiscountInfo {
	
	private String eventCode;
	private String eventName;
	private int discountPercent;
	private int discountAmount;
	
	public ProductDiscountInfo() {
		super();
	}

	public ProductDiscountInfo(String eventCode, String eventName, int discountPercent, int discountAmount) {
		super();
		this.eventCode = eventCode;
		this.eventName = eventName;
		this.discountPercent = discountPercent;
		this.discountAmount = discountAmount;
	}

	public String getEventCode() {
		return eventCode;
	}

	public void setEventCode(String eventCode) {
		this.eventCode = eventCode;
	}

	public String getEventName() {
		return eventName;
	}

	public void setEventName(String eventName) {
		this.eventName = eventName;
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

	@Override
	public String toString() {
		return "ProductDiscountInfo eventCode=" + eventCode + ", eventName=" + eventName + ", discountPercent="
				+ discountPercent + ", discountAmount=" + discountAmount;
	}
}
