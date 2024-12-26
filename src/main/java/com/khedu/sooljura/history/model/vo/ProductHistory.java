package com.khedu.sooljura.history.model.vo;

public class ProductHistory {
	private String impUid;
	private String orderNo;
	private String prodKey;
	private String userKey;
	private String addrKey;
	private String cardCompany;
	private int orderPrice;
	private int orderCnt;
	private String orderDate;
	private int refundYn;
	private String refundReason;
	private String refundKey;
	private String refundDate;
	
	public ProductHistory() {
		super();
	}

	public ProductHistory(String impUid, String orderNo, String prodKey, String userKey, String addrKey,
			String cardCompany, int orderPrice, int orderCnt, String orderDate, int refundYn, String refundReason,
			String refundKey, String refundDate) {
		super();
		this.impUid = impUid;
		this.orderNo = orderNo;
		this.prodKey = prodKey;
		this.userKey = userKey;
		this.addrKey = addrKey;
		this.cardCompany = cardCompany;
		this.orderPrice = orderPrice;
		this.orderCnt = orderCnt;
		this.orderDate = orderDate;
		this.refundYn = refundYn;
		this.refundReason = refundReason;
		this.refundKey = refundKey;
		this.refundDate = refundDate;
	}

	public String getImpUid() {
		return impUid;
	}

	public void setImpUid(String impUid) {
		this.impUid = impUid;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
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

	public String getAddrKey() {
		return addrKey;
	}

	public void setAddrKey(String addrKey) {
		this.addrKey = addrKey;
	}

	public String getCardCompany() {
		return cardCompany;
	}

	public void setCardCompany(String cardCompany) {
		this.cardCompany = cardCompany;
	}

	public int getOrderPrice() {
		return orderPrice;
	}

	public void setOrderPrice(int orderPrice) {
		this.orderPrice = orderPrice;
	}

	public int getOrderCnt() {
		return orderCnt;
	}

	public void setOrderCnt(int orderCnt) {
		this.orderCnt = orderCnt;
	}

	public String getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}

	public int getRefundYn() {
		return refundYn;
	}

	public void setRefundYn(int refundYn) {
		this.refundYn = refundYn;
	}

	public String getRefundReason() {
		return refundReason;
	}

	public void setRefundReason(String refundReason) {
		this.refundReason = refundReason;
	}

	public String getRefundKey() {
		return refundKey;
	}

	public void setRefundKey(String refundKey) {
		this.refundKey = refundKey;
	}

	public String getRefundDate() {
		return refundDate;
	}

	public void setRefundDate(String refundDate) {
		this.refundDate = refundDate;
	}

	@Override
	public String toString() {
		return "ProductHistory [impUid=" + impUid + ", orderNo=" + orderNo + ", prodKey=" + prodKey + ", userKey="
				+ userKey + ", addrKey=" + addrKey + ", cardCompany=" + cardCompany + ", orderPrice=" + orderPrice
				+ ", orderCnt=" + orderCnt + ", orderDate=" + orderDate + ", refundYn=" + refundYn + ", refundReason="
				+ refundReason + ", refundKey=" + refundKey + ", refundDate=" + refundDate + "]";
	}
		
}
