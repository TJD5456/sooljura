package com.khedu.sooljura.product.model.vo;

public class OrderHistory {
    private String impUid;
    private String orderNo;
    private String prodKey;
    private String userKey;
    private String addrKey;
    private String cardCompany;
    private int orderPrice;
    private int orderCnt;
    private String orderDate;
	
    public OrderHistory() {
		super();
	}

	public OrderHistory(String impUid, String orderNo, String prodKey, String userKey, String addrKey,
			String cardCompany, int orderPrice, int orderCnt, String orderDate) {
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

	@Override
	public String toString() {
		return "OrderHistory [impUid=" + impUid + ", orderNo=" + orderNo + ", prodKey=" + prodKey + ", userKey="
				+ userKey + ", addrKey=" + addrKey + ", cardCompany=" + cardCompany + ", orderPrice=" + orderPrice
				+ ", orderCnt=" + orderCnt + ", orderDate=" + orderDate + "]";
	}

}
