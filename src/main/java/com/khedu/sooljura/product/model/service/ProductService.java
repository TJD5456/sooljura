package com.khedu.sooljura.product.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.khedu.sooljura.admin.model.vo.Product;
import com.khedu.sooljura.product.model.dao.ProductDao;
import com.khedu.sooljura.product.model.vo.Basket;
import com.khedu.sooljura.product.model.vo.ProductHistory;
import com.khedu.sooljura.product.model.vo.ProductListData;

@Service("productService")
public class ProductService {
	@Autowired
	@Qualifier("productDao")
	private ProductDao dao;

	//제품번호 생성(구매를 위한 API 선작업)
	public int makeOrderNo(ProductHistory prodHistory) {
		return dao.makeOrderNo(prodHistory);
	}

	//결제정보 삽입
	public int insertHistory(ProductHistory prodHistory, Map<String, Integer> orderDetail) {
		return dao.insertHistory(prodHistory, orderDetail);
	}

	//주문번호 제작용도 제거
	public int delOrderNo(ProductHistory prodHistory) {
		return dao.delOrderNo(prodHistory);
	}

	// 장바구니 제품 정보를 조회하기 위한 제품 키 조회
	public List<Basket> findProdKey(String userKey) {
	    return dao.findProdKey(userKey); // List<Basket> 반환
	}

	// 단일 prodKey로 제품 정보 조회
	public ProductListData prodInfo(String prodKey) {
	    List<Product> prodInfoList = dao.selProdInfo(prodKey);

	    ArrayList<Product> productArrayList = new ArrayList<>(prodInfoList);
	    
	    ProductListData prodInfo = new ProductListData();
	    prodInfo.setProductList(productArrayList);
	    return prodInfo;
	}

	//제품 장바구니에 넣기
	public int insertBasket(Basket basket) {
		return dao.insertBasket(basket);
	}
}
