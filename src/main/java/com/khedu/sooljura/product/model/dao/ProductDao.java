package com.khedu.sooljura.product.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.khedu.sooljura.admin.model.vo.Product;
import com.khedu.sooljura.product.model.vo.Basket;
import com.khedu.sooljura.product.model.vo.ProductHistory;
import com.khedu.sooljura.product.model.vo.ProductListData;

@Repository("productDao")
public class ProductDao {
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sessionTemplate;

	//주문번호 생성용도(API결제에 필요함)
	public int makeOrderNo(ProductHistory prodHistory) {
		return sessionTemplate.insert("product.makeOrderNo", prodHistory);
	}

	//결제정보 삽입
	public int insertHistory(ProductHistory prodHistory, Map<String, Integer> orderDetail) {
		Map<String, Object> params = new HashMap<>();
        params.put("productHistory", prodHistory);
        params.put("orderDetails", orderDetail);
		
		return sessionTemplate.insert("product.insertHistory", params);
	}

	//주문번호 제작용도 제거
	public int delOrderNo(ProductHistory prodHistory) {
		return sessionTemplate.delete("product.delOrderNo", prodHistory);
	}

	// 장바구니에 넣은 제품 조회
	public List<Basket> findProdKey(String userKey) {
	    return sessionTemplate.selectList("product.findProdKey", userKey);
	}

	// 장바구니에 있는 제품들의 prodKey로 정보 조회
	public List<Product> selProdInfo(String prodKey) {
	    return sessionTemplate.selectList("product.selProdInfo", prodKey);
	}
}
