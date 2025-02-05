package com.khedu.sooljura.product.model.service;

import com.khedu.sooljura.admin.model.vo.Product;
import com.khedu.sooljura.admin.model.vo.ProductImage;
import com.khedu.sooljura.product.model.dao.ProductDao;
import com.khedu.sooljura.product.model.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Service("productService")
public class ProductService {

    @Autowired
    @Qualifier("productDao")
    private ProductDao dao;

    //제품번호 생성(구매를 위한 API 선작업)
    public String makeOrderNo() {
        return dao.makeOrderNo();
    }

    //결제정보 삽입
    public int insertHistory(OrderHistory orderHistory) {
        return dao.insertHistory(orderHistory);
    }
/*
    //주문번호 제작용도 제거
    public int delOrderNo(OrderHistory orderHistory) {
        return dao.delOrderNo(orderHistory);
    }
*/
    // 장바구니 제품 정보를 조회하기 위한 제품 키 조회
    public ArrayList<Basket> findProdKey(String userKey) {
        return (ArrayList<Basket>) dao.findProdKey(userKey); // List<Basket> 반환
    }

    // 단일 prodKey 로 제품 정보 조회
    public ProductListData prodInfo(String prodKey) {
        List<Product> prodInfoList = dao.selProdInfo(prodKey);

        //Product에만 넣기 위한 선언
        ArrayList<Product> productArrayList = new ArrayList<>(prodInfoList);

        ProductListData prodInfo = new ProductListData();
        prodInfo.setProductList(productArrayList);
        return prodInfo;
    }

    //제품 장바구니에 넣기
    public int insertBasket(Basket basket) {
        return dao.insertBasket(basket);
    }

    //장바구니 제품 삭제
    public int delBasket(Basket basket) {
        return dao.delBasket(basket);
    }

    //구매내역 페이지에서 구매목록 보여주기
    public ProductListData orderList(String userKey, int reqPage) {
        int viewOrderCnt = 10;

        int end = reqPage * viewOrderCnt;
        int start = end - viewOrderCnt + 1;

        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("userKey", userKey);
        map.put("start", start);
        map.put("end", end);

        //구매목록 정보
        ArrayList<OrderHistory> list = (ArrayList<OrderHistory>) dao.orderList(map);
        
        //구매목록 갯수
        int totCnt = dao.orderHistoryCnt(userKey);
        int totPage = 0;
        if (totCnt % viewOrderCnt > 0) {
            totPage = totCnt / viewOrderCnt + 1;
        } else {
            totPage = totCnt / viewOrderCnt;
        }

        int pageNaviSize = 5;

        int pageNo = ((reqPage - 1) / pageNaviSize) * pageNaviSize + 1;

        //페이지 네비게이션 HTML
        String pageNavi = "";
        if (pageNo != 1) {
            pageNavi += "<a href='/product/buyList.do?reqPage=" + (pageNo - 1) + "'>이전</a>";
        }
        for (int i = 0; i < pageNaviSize; i++) {
            if (pageNo == reqPage) {
                pageNavi += "<span>" + pageNo + "</span>";
            } else {
                pageNavi += "<a href='/product/buyList.do?reqPage=" + pageNo + "'>" + pageNo + "</a>";
            }
            pageNo++;

            if (pageNo > totPage) {
                break;
            }
        }

        if (pageNo <= totPage) {
            pageNavi += "<a href='/product/buyList.do?reqPage=" + pageNo + "'>다음</a>";
        }

        ProductListData orderList = new ProductListData();
        orderList.setOrderHistory(list);
        orderList.setPageNavi(pageNavi);

        return orderList;
    }

    public List<Product> getProdInfo(List<String> prodKey) {
        return dao.getProdInfo(prodKey);
    }

    public Product selOneProduct(String prodKey) {
        return dao.selOneProduct(prodKey);
    }

    public ProductImage selOneProdImg(String prodKey) {
        return dao.selOneProdImg(prodKey);
    }

    public ProductDiscountHistory selOnePDH(String prodKey) {
        return dao.selOnePDH(prodKey);
    }

    public ProductDiscountInfo selOnePDI(String prodKey, String eventCode) {
        HashMap<String, String> map = new HashMap<>();
        map.put("prodKey", prodKey);
        map.put("eventCd", eventCode);
        return dao.selOnePDI(map);
    }

    public int isPdhNull(String prodKey) {
        return dao.isPdhNull(prodKey);
    }

    public ArrayList<Product> getProdList(String categoryKey) {
		return (ArrayList<Product>)dao.getProdList(categoryKey);
	}

	public ArrayList<Product> getProdListByName(String categoryKey) {
		return (ArrayList<Product>)dao.getProdListByName(categoryKey);
	}

	public ArrayList<Product> getProdListByPrice(String categoryKey) {
		return (ArrayList<Product>)dao.getProdListByPrice(categoryKey);
	}
	
	//장바구니에 넣기 전 장바구니 테이블에 있는지 체크
	public int chkBasket(Basket basket) {
		return dao.chkBasket(basket);
	}

    public ArrayList<ProductImage> selImg(String prodKey) {
        return (ArrayList<ProductImage>) dao.selImg(prodKey);
    }

    public String selCatNm(String prodKey) {
        return dao.selCatNm(prodKey);
    }

	public int delBoughtProd(OrderHistory orderHistory) {
		return dao.delBoughtProd(orderHistory);
	}
}
