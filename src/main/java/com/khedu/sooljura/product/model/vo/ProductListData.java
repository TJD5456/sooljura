package com.khedu.sooljura.product.model.vo;

import java.util.ArrayList;

import com.khedu.sooljura.admin.model.vo.Product;

public class ProductListData {
	private ArrayList<Basket> basketList;
	private ArrayList<Product> productList;
	private String pageNavi;
	
	public ProductListData() {
		super();
	}

	public ProductListData(ArrayList<Basket> basketList, ArrayList<Product> productList, String pageNavi) {
		super();
		this.basketList = basketList;
		this.productList = productList;
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

	public String getPageNavi() {
		return pageNavi;
	}

	public void setPageNavi(String pageNavi) {
		this.pageNavi = pageNavi;
	}

	@Override
	public String toString() {
		return "ProductListData [basketList=" + basketList + ", productList=" + productList + ", pageNavi=" + pageNavi
				+ "]";
	}
}
