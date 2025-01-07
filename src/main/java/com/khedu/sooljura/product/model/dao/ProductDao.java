package com.khedu.sooljura.product.model.dao;

import com.khedu.sooljura.admin.model.vo.Product;
import com.khedu.sooljura.admin.model.vo.ProductImage;
import com.khedu.sooljura.product.model.vo.Basket;
import com.khedu.sooljura.product.model.vo.OrderHistory;
import com.khedu.sooljura.product.model.vo.ProductDiscountHistory;
import com.khedu.sooljura.product.model.vo.ProductDiscountInfo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

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

    public Product selOneProduct(String prodKey) {
        return sessionTemplate.selectOne("product.selOneProduct", prodKey);
    }

    public ProductImage selOneProdImg(String prodKey) {
        return sessionTemplate.selectOne("product.selOneProdImg", prodKey);
    }

    public ProductDiscountHistory selOnePDH(String prodKey) {
        return sessionTemplate.selectOne("product.selOnePDH", prodKey);
    }

    public ProductDiscountInfo selOnePDI(HashMap<String, String> map) {
        return sessionTemplate.selectOne("product.selOnePDI", map);
    }

    public int isPdhNull(String prodKey) {
        return sessionTemplate.selectOne("product.isPdhNull", prodKey);
    }

	public List<Product> getProdList(String categoryKey) {
		return sessionTemplate.selectList("product.getProdList", categoryKey);
    }

	public List<Product> getProdListByName(String categoryKey) {
		return sessionTemplate.selectList("product.getProdListByName", categoryKey);
	}

	public List<Product> getProdListByPrice(String categoryKey) {
		return sessionTemplate.selectList("product.getProdListByPrice", categoryKey);
	}

}
