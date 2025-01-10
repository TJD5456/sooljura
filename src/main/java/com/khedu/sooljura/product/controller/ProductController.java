package com.khedu.sooljura.product.controller;

import com.khedu.sooljura.admin.model.service.AdminService;
import com.khedu.sooljura.admin.model.vo.Product;
import com.khedu.sooljura.admin.model.vo.ProductImage;
import com.khedu.sooljura.product.model.service.ProductService;
import com.khedu.sooljura.product.model.vo.*;
import com.khedu.sooljura.user.controller.UserController;
import com.khedu.sooljura.user.model.vo.AddrListData;
import com.khedu.sooljura.user.model.vo.User;
import com.khedu.sooljura.user.model.vo.UserAddr;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;

@Controller
@RequestMapping("/product/")
public class ProductController {

	private final ProductService service;
	private final AdminService adminService;

	public ProductController(@Qualifier("productService") ProductService service,
							 @Qualifier("adminService") AdminService adminService) {
		this.adminService = adminService;
		this.service = service;
	}

	// 상세페이지
	@GetMapping("prodDetail.do")
	public String prodDetail(String prodKey, Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws ServletException, IOException {
		Product prod = service.selOneProduct(prodKey);
		if (prod.getTradingYn() < 1) {
			System.out.println("access denied");
			request.setAttribute("title", "알림");
			request.setAttribute("msg", "판매 중지된 상품입니다.");
			request.setAttribute("icon", "error");
			request.setAttribute("loc", "/");
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
		}
		ProductImage prodImg = service.selOneProdImg(prodKey);
		int price = prod.getProdPrice();

		int isPdhNull = service.isPdhNull(prodKey);
		if (isPdhNull > 0) {
			model.addAttribute("pdhNull", 0);
			ProductDiscountHistory pDh = service.selOnePDH(prodKey);
			String eventCode = pDh.getEventCd();
			ProductDiscountInfo pDi = service.selOnePDI(prodKey, eventCode);

			int pOrA = pDi.getEventNm();
			if (pOrA == 0) {
				// 0 == percent
				model.addAttribute("pOrA", 0);
				model.addAttribute("dcPrice", pDi.getDiscountPercent());
				double percent = pDi.getDiscountPercent();

				int payPrice = price - (int) Math.round(price * (percent / 100));
				String priceWithComma = String.format("%,d", payPrice);
				model.addAttribute("payPrice", priceWithComma);
			} else {
				model.addAttribute("pOrA", 1);
				model.addAttribute("dcPrice", pDi.getDiscountAmount());

				int payPrice = price - pDi.getDiscountAmount();
				String priceWithComma = String.format("%,d", payPrice);
				model.addAttribute("payPrice", priceWithComma);
			}
		} else {
			model.addAttribute("pdhNull", 1);
			model.addAttribute("pOrA", 2);
			String priceWithComma = String.format("%,d", price);
			model.addAttribute("payPrice", priceWithComma);
		}

		model.addAttribute("retailPrice", price);
		model.addAttribute("prodImg", prodImg);
		model.addAttribute("prod", prod);

		if (session.getAttribute("loginUser") != null) {
			User admin = (User) session.getAttribute("loginUser");
			model.addAttribute("userCd", admin.getUserCd());
		}

		return "product/prodDetail";
	}

	// 장바구니 페이지로 이동
	@GetMapping("expPurchaseFrm.do")
	public String expPurchase(HttpSession session, Model model) {
	    // 세션에서 userKey 가져오기
	    User loginUser = (User) session.getAttribute("loginUser");
	    String userKey = loginUser.getUserKey();

	    // userKey로 Basket 리스트 조회
	    ArrayList<Basket> findProdKey = service.findProdKey(userKey);

	    if (findProdKey == null || findProdKey.isEmpty()) {
	        // 장바구니가 비어 있는 경우
	        model.addAttribute("basketList", Collections.emptyList());
	    } else {
	        // Basket 리스트와 관련된 제품 정보 가져오기
	        List<Map<String, Object>> basketProductInfoList = new ArrayList<>();

	        findProdKey.forEach(basket -> {
	            // 제품 정보 조회
	            ProductListData prodInfo = service.prodInfo(basket.getProdKey());
	            Map<String, Object> basketProductInfo = new HashMap<>();

	            // 장바구니 정보와 제품 정보를 함께 담음
	            basketProductInfo.put("basket", basket);
	            basketProductInfo.put("productList", prodInfo.getProductList());
	            basketProductInfoList.add(basketProductInfo);
	        });

	        model.addAttribute("basketList", basketProductInfoList);
	    }
	    return "product/expPurchase";
	}

	@Autowired
	private UserController userController;
	
	/*
	 * 필요한 값 - prodKey -> 여러개 존재(basketKey로 조회? or 페이지에서 받아오기?) - basketCnt ->
	 * prodCnt - basketCnt 할 때 필요 - userNo -> 주문내역에 넣어줄 때 필요함 - prodPrice -> 장바구니
	 * 페이지에서 계산해서 받아오기 - basketKey -> 결제 완료 시 basketKey 삭제해줘야함
	 */
	// 결제 페이지로 이동
	// 제품 여러개일 수도 있으니까 반복문 걸기
	@GetMapping("productBuyFrm.do")
	public String productBuyFrm(Model model, 
	                             @RequestParam List<String> prodKeys, 
	                             @RequestParam List<String> basketCnts, 
	                             @RequestParam List<String> prodPrices, 
	                             @RequestParam List<String> prodNms, 
	                             @RequestParam String userKey) {
	    // 기본 배송지 가져오기
	    UserAddr defaultAddr = userController.findDefaultAddr(userKey);
	    
	    // 선택된 제품 정보 처리
	    List<Map<String, Object>> productList = new ArrayList<>();
	    for (int i = 0; i < prodKeys.size(); i++) {
	        Map<String, Object> productData = new HashMap<>();
	        productData.put("prodKey", prodKeys.get(i));
	        productData.put("basketCnt", basketCnts.get(i));
	        productData.put("prodPrice", prodPrices.get(i));
	        productData.put("prodNm", prodNms.get(i));
	        productList.add(productData);
	    }

	    // 모델에 데이터 추가
	    model.addAttribute("addr", defaultAddr);
	    model.addAttribute("productList", productList);

	    return "product/productBuy";
	}

	// 결제 API 에 주문번호 보내는 용도
	@GetMapping("makeOrderNo.do")
	@ResponseBody
	public String makeOrderNo(OrderHistory orderHistory) {
		// 결제 API 에 orderNo 보내줘야함
		// orderNo 생성 및 Product.java 에 orderNo 집어넣음		
	    String makeOrderNo = service.makeOrderNo();

		if (makeOrderNo != null) {
			orderHistory.setOrderNo(makeOrderNo);
			// 정상적으로 넣으면 orderNo 반환
			return makeOrderNo;
		} else {
			// 정상적으로 DB에 못넣으면 0반환
			return "0";
		}
	}

	// 결제 API 로 값 받아오고 삽입
	@PostMapping("productBuy.do")
	@ResponseBody
	public String productBuy(@RequestBody OrderHistory orderHistory) {
		System.out.println("orderHistoryTotalPrice : " + orderHistory.getOrderPrice());
		// 제품 구매내역 DB에 넣기
		int insertHistory = service.insertHistory(orderHistory);
		
		if (insertHistory > 0) {
			// 정상적으로 넣으면 1 반환 오류 발생시 다른 숫자 반환
			// int result -> 정상적으로 결제 완료 시 위에서 만든 주문번호 제작용 컬럼 삭제 - 보류
			return String.valueOf(insertHistory);
		}
		// 오류 발생 시 0 반환
		return "0";
	}

	// 제품 장바구니에 넣기
	@GetMapping("insertBasket.do")
	@ResponseBody
	public String insertBasket(Basket basket) {		
		basket.setBasketCd(1);
		
		//장바구니에 넣기 전 장바구니 테이블에 있는지 체크
		int chkBasket = service.chkBasket(basket);
		if(chkBasket < 1) {	
			//장바구니 테이블 삽입
			int insertBasket = service.insertBasket(basket);
			if(insertBasket == 1) {			
				return String.valueOf(insertBasket);
			}
		}
		return String.valueOf(0);
	}

	// 제품 찜하기
	@GetMapping("insertLike.do")
	@ResponseBody
	public String insertLike(Basket basket) {
		basket.setBasketCd(2);
		basket.setBasketCnt(0);
		
		//장바구니에 넣기 전 장바구니 테이블에 있는지 체크
		int chkBasket = service.chkBasket(basket);
		if(chkBasket < 1) {
			//좋아요 테이블 삽입
			int insertLike = service.insertBasket(basket);
			if(insertLike == 1) {			
				return String.valueOf(insertLike);
			}
		}
		return String.valueOf(0);
	}

	// 장바구니에서 제품 삭제
	@GetMapping("delBasket.do")
	@ResponseBody
	public String delBasket(String userKey, String prodKey) {		
		Basket basket = new Basket();
		basket.setUserKey(userKey);
		basket.setProdKey(prodKey);

		int result = service.delBasket(basket);
		return String.valueOf(result);
	}

	// 구매내역 페이지로 이동
	@GetMapping("buyList.do")
	public String buyList(int reqPage, Model model, String userKey) {
	    // 1. 사용자 구매 내역 가져오기
	    ProductListData ohList = service.orderList(userKey, reqPage);

	    // 2. orderHistory와 productList 매핑
	    ohList.getOrderHistory().forEach(order -> {
	        // prodKey를 String 타입으로 받아 ProductListData 객체 반환
	        ProductListData productData = service.prodInfo(order.getProdKey());
	        order.setProductList(productData.getProductList()); // ProductListData에서 productList 설정
	    });

	    // 3. Model에 데이터 추가
	    model.addAttribute("orderHistory", ohList.getOrderHistory());
	    model.addAttribute("pageNavi", ohList.getPageNavi());
	    return "product/buyList";
	}

	@PostMapping("productDcCnt")
	@ResponseBody
	public String productDcCnt(String prodKey, int prodCntVal, Model model) {
		int isPdhNull = service.isPdhNull(prodKey);
		Product prod = service.selOneProduct(prodKey);
		int price = prod.getProdPrice();
		if (isPdhNull > 0) {
			ProductDiscountHistory pDH = service.selOnePDH(prodKey);
			String eventCode = pDH.getEventCd();
			ProductDiscountInfo pDI = service.selOnePDI(prodKey, eventCode);

			int pOrA = pDI.getEventNm();
			if (pOrA == 0) {
				// 0 == percent
				double percent = pDI.getDiscountPercent();
				int totalPrice = (price - (int) Math.round(price * (percent / 100))) * prodCntVal;
				String payPrice = String.format("%,d", totalPrice);
				return payPrice;
			} else if (pOrA == 1) {
				// 1 == amount
				int totalPrice = (price - pDI.getDiscountAmount()) * prodCntVal;
				String payPrice = String.format("%,d", totalPrice);
				return payPrice;
			}
		}
		int totalPrice = price * prodCntVal;
		String payPrice = String.format("%,d", totalPrice);
		model.addAttribute("pOrA",2);
		return payPrice;
	}
	
	@GetMapping("productList.do")
	public String productList(String categoryKey, int sort, Model model) {
		ArrayList<Product> prodlist = null;
		String listTitle = null;
		switch (categoryKey) {
		case "c0001":
			listTitle = "와인/샴페인";
			break;
		case "c0002":
			listTitle = "위스키";
			break;
		case "c0003":
			listTitle = "브랜디/꼬냑";
			break;
		case "c0004":
			listTitle = "리큐르/보드카";
			break;
		case "c0005":
			listTitle = "전통주/민속주";
			break;
		case "c0006":
			listTitle = "기타주류";
			break;
		default:
			break;
		}
		model.addAttribute("prodCate", categoryKey);
		model.addAttribute("listTitle", listTitle);
		if(sort > 0) {
			if(sort == 1) {
				prodlist = service.getProdListByName(categoryKey);
				
			}else if(sort == 2) {
				prodlist = service.getProdListByPrice(categoryKey);
			}
		}else {
			prodlist = service.getProdList(categoryKey);
		}
		model.addAttribute("prodlist", prodlist);
		return "product/prodList";
	}
	
	//결제페이지 주소지 팝업띄우기
	@GetMapping("chgAddr.do")
	public String chgAddr(String userKey, Model model) {
		AddrListData addrList = userController.buyPageAddr(userKey);
		
		model.addAttribute("addrList", addrList.getAddrList());
		return "product/selectAddr";
	}
	
	//결제페이지 주소지 선택
	@PostMapping("selAddr.do")
	@ResponseBody
	public UserAddr selAddr(String addrKey, Model model) {
		return userController.selectAddr(addrKey);		
	}
	
	//결제페이지 주소 팝업에서 주소지 추가 페이지 이동
	@GetMapping("addBuyPageAddrFrm.do")
	public String addBuyPageAddrFrm() {		
		return "product/addBuyPageAddr";
	}
	
	//결제페이지 주소지 팝업에서 주소지 수정
	@GetMapping("updBuyPageAddrFrm.do")
	public String updBuyPageAddrFrm(String addrKey, Model model) {
		UserAddr addrInfo = userController.updBuyPageAddrFrm(addrKey);
		model.addAttribute("addrInfo", addrInfo);
		return "product/updBuyPageAddr";
	}

	@GetMapping("editProdFrm.do")
	public String editProd(String prodKey, Model model) {
		model.addAttribute("prodKey", prodKey);
        model.addAttribute("prod", service.selOneProduct(prodKey));
        model.addAttribute("img", service.selImg(prodKey));
		model.addAttribute("catNm", service.selCatNm(prodKey));
		model.addAttribute("catList", adminService.getAllCategoryInfos());
        return "product/editProd";
	}

}
