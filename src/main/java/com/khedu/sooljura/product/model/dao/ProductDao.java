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
import com.khedu.sooljura.product.model.vo.OrderHistory;


@Repository("productDao")
public class ProductDao {
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sessionTemplate;

	//주문번호 생성용도(API결제에 필요함)
	public int makeOrderNo(OrderHistory orderHistory) {
		return sessionTemplate.insert("product.makeOrderNo", orderHistory);
	}

	//결제정보 삽입
	public int insertHistory(OrderHistory orderHistory, Map<String, Integer> orderDetail) {
		Map<String, Object> params = new HashMap<>();
        params.put("OrderHistory", orderHistory);
        params.put("orderDetails", orderDetail);
		
		return sessionTemplate.insert("product.insertHistory", params);
	}

	//주문번호 제작용도 제거
	public int delOrderNo(OrderHistory orderHistory) {
		return sessionTemplate.delete("product.delOrderNo", orderHistory);
	}

	// 장바구니에 넣은 제품 조회
	public List<Basket> findProdKey(String userKey) {
	    return sessionTemplate.selectList("product.findProdKey", userKey);
	}

	// 장바구니에 있는 제품들의 prodKey로 정보 조회
	public List<Product> selProdInfo(String prodKey) {
	    return sessionTemplate.selectList("product.selProdInfo", prodKey);
	}

	//장바구니에 제품 넣기
	public int insertBasket(Basket basket) {
		return sessionTemplate.insert("product.insertBasket", basket);
	}

	//장바구니 제품 삭제
	public int delBasket(Basket basket) {
		return sessionTemplate.delete("product.delBasketProduct", basket);
	}

	//구매목록 가져오기
	public List<OrderHistory> orderList(HashMap<String, Object> map) {
		return sessionTemplate.selectList("product.orderList", map);
	}

	//구매목록 갯수
	public int orderHistoryCnt(String userKey) {
		return sessionTemplate.selectOne("product.orderHistoryPageNavi", userKey);
	}

	//prodKey로 제품정보 조회(장바구니용으로 사용한 쿼리문 재사용)
	public List<Product> getProdInfo(List<String> prodKey) {
		return sessionTemplate.selectList("product.selProdInfo", prodKey);
	}


}
