package com.khedu.sooljura.product.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.khedu.sooljura.admin.model.vo.Product;
import com.khedu.sooljura.product.model.service.ProductService;
import com.khedu.sooljura.product.model.vo.Basket;
import com.khedu.sooljura.product.model.vo.ProductHistory;
import com.khedu.sooljura.product.model.vo.ProductListData;
import com.khedu.sooljura.user.controller.UserController;
import com.khedu.sooljura.user.model.vo.UserAddr;

@Controller
@RequestMapping("/product/")
public class ProductController {
	@Autowired
	@Qualifier("productService")
	private ProductService service;
	
	//장바구니 페이지로 이동
	@GetMapping("expPurchaseFrm.do")
	public String expPurchase(HttpSession session, Model model) {
		// 세션에서 userKey 가져오기
	    String userKey = (String) session.getAttribute("userKey");

	    // userKey로 Basket 리스트 조회해서 prodKey 가져오기
	    List<Basket> findProdKey = service.findProdKey(userKey);
	    if (findProdKey == null || findProdKey.isEmpty()) {
	        // Basket 리스트에서 prodKey가 없는경우
	        model.addAttribute("basketList", Collections.emptyList());
	    } else {
	        // Basket 리스트에서 가져온 prodKey로 제품 정보 조회
	        List<ProductListData> prodInfoList = new ArrayList<>();
	        findProdKey.forEach(basket -> {
	            ProductListData prodInfo = service.prodInfo(basket.getProdKey());
	            prodInfoList.add(prodInfo);	            
	        });
	        model.addAttribute("basketList", prodInfoList);
	    }
	    return "product/expPurchase";
	}

/*
	필요한 값 
	- prodKey -> 여러개 존재(basketKey로 조회? or 페이지에서 받아오기?)
	- basketCnt -> prodCnt - basketCnt 할 때 필요
	- userNo -> 주문내역에 넣어줄 때 필요함
	- prodPrice -> 장바구니 페이지에서 계산해서 받아오기
	- basketKey -> 결제 완료 시 basketKey 삭제해줘야함
*/
	//결제 페이지로 이동
	//제품 여러개일 수도 있으니까 반복문 걸기
	@GetMapping("productBuyFrm.do")
	@ResponseBody
	public String productBuyFrm(Model model ,List<String> prodKeys, String userKey){
		//userKey로 기본배송지 가져오기
		UserController userController = new UserController();
		UserAddr defaultAddr = userController.getDefaultAddr(userKey);
		
		//product 가져오기
        List<ProductListData> productList = new ArrayList<>();
        for (String prodKey : prodKeys) {
        	ProductListData prodInfo = service.prodInfo(prodKey);
        	productList.add(prodInfo);
        }
			
		//기본 주소지
		model.addAttribute("addr", defaultAddr);
		//제품 정보 리스트
		model.addAttribute("productList", productList);
		
		//장바구니 정보
		
		
		return "product/productBuy";
	}
	
	//결제 API에 주문번호 보내는 용도
	@PostMapping("makeOrderNo.do")
	@ResponseBody
	public String makeOrderNo(HttpSession session, String userKey, String prodKey, String addrKey){
		//결제 API에 orderNo 보내줘야함
		ProductHistory prodHistory = new ProductHistory();
		prodHistory.setUserKey(userKey);
		prodHistory.setProdKey(prodKey);
		prodHistory.setAddrKey(addrKey);
		
		//orderNo 생성 및 Product.java에 orderNo 집어넣음
		int makeOrderNo = service.makeOrderNo(prodHistory);

		if(makeOrderNo > 0) {
			String orderNo = prodHistory.getOrderNo();
			//정상적으로 넣으면 orderNo 반환
			return orderNo;
		}else {		
			//정상적으로 DB에 못넣으면 0반환
			return "0";
		}
	}
	
	//결제 API로 값 받아오고 삽입
	@PostMapping("productBuy.do")
	@ResponseBody
	public String productBuy(@RequestParam("prodKey") List<String> prodKeys,
		    @RequestParam("orderCnt") List<Integer> orderCnts,
		    @ModelAttribute ProductHistory prodHistory) {
		
		Map<String, Integer> orderDetail = new HashMap<>();
	    for (int i = 0; i < prodKeys.size(); i++) {
	        orderDetail.put(prodKeys.get(i), orderCnts.get(i));
	    }
	    
		//제품 구매내역 DB에 넣기
		int insertHistory = service.insertHistory(prodHistory, orderDetail);
		
		if(insertHistory > 0) {
			//정상적으로 넣으면 1 반환 오류 발생시 다른 숫자 반환
			//int result -> 정상적으로 결제 완료 시 위에서 만든 주문번호 제작용 컬럼 삭제
			int result = service.delOrderNo(prodHistory);
			return String.valueOf(result);
		}
		//오류 발생 시 0 반환
		return "0";
	}
	
	//제품 장바구니에 넣기
	public String insertBasket(Basket basket) {
		basket.setBasketCd(1);
		int insertBasket = service.insertBasket(basket);
		return String.valueOf(insertBasket);
	}
	
	//제품 찜하기
	public String insertLike(Basket basket) {
		basket.setBasketCd(2);
		int insertLike = service.insertBasket(basket);
		return String.valueOf(insertLike);
	}
	
	//장바구니에서 제품 삭제
	@GetMapping("delBasket.do")
	public String delBasket(String userKey, String prodKey) {
		Basket basket = new Basket();
		basket.setUserKey(userKey);
		basket.setProdKey(prodKey);
		
		int result = service.delBasket(basket);
		return String.valueOf(result);
	}
}
