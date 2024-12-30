package com.khedu.sooljura.product.model.vo;

import java.util.ArrayList;

import com.khedu.sooljura.admin.model.vo.Product;

public class ProductListData {
	private ArrayList<Basket> basketList;
	private ArrayList<Product> productList;
	private ArrayList<OrderHistory> orderHistory;
	private String pageNavi;
	
	public ProductListData() {
		super();
	}

	public ProductListData(ArrayList<Basket> basketList, ArrayList<Product> productList,
			ArrayList<OrderHistory> orderHistory, String pageNavi) {
		super();
		this.basketList = basketList;
		this.productList = productList;
		this.orderHistory = orderHistory;
		this.pageNavi = pageNavi;
	}

	public ArrayList<Basket> getBasketList() {
		return basketList;
	}

	public void setBasketList(ArrayList<Basket> basketList) {
		this.basketList = basketList;
	}

	public ArrayList<Product> getProductList() {
		return productList;
	}

	public void setProductList(ArrayList<Product> productList) {
		this.productList = productList;
	}

	public ArrayList<OrderHistory> getOrderHistory() {
		return orderHistory;
	}

	public void setOrderHistory(ArrayList<OrderHistory> orderHistory) {
		this.orderHistory = orderHistory;
	}

	public String getPageNavi() {
		return pageNavi;
	}

	public void setPageNavi(String pageNavi) {
		this.pageNavi = pageNavi;
	}

	@Override
	public String toString() {
		return "ProductListData [basketList=" + basketList + ", productList=" + productList + ", orderHistory="
				+ orderHistory + ", pageNavi=" + pageNavi + "]";
	}
	
	
}
