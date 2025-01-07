package com.khedu.sooljura.product.controller;

import com.khedu.sooljura.admin.model.vo.Product;
import com.khedu.sooljura.admin.model.vo.ProductImage;
import com.khedu.sooljura.product.model.service.ProductService;
import com.khedu.sooljura.product.model.vo.*;
import com.khedu.sooljura.user.controller.UserController;
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
	@Autowired
	@Qualifier("productService")
	private ProductService service;

	// 상세페이지
	@GetMapping("prodDetail.do")
	public String prodDetail(String prodKey, Model model, HttpServletRequest request, HttpServletResponse response)
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
		return "product/prodDetail";
	}
	
	// 장바구니 페이지로 이동
	@GetMapping("expPurchaseFrm.do")
	public String expPurchase(HttpSession session, Model model) {
		// 세션에서 userKey 가져오기(정상작동중)
		User loginUser = (User) session.getAttribute("loginUser");
		String userKey = ((User) loginUser).getUserKey();
		// userKey 로 Basket 리스트 조회해서 prodKey 가져오기 (정상작동중)
		ArrayList<Basket> findProdKey = service.findProdKey(userKey);

		if (findProdKey == null || findProdKey.isEmpty()) {
			// Basket 리스트에서 prodKey 가 없는경우
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
	public String productBuyFrm(Model model,  @RequestParam(required = false) List<String> prodKeys, 
            									@RequestParam(required = false) String userKey) {
		// userKey로 기본배송지 가져오기
		UserAddr defaultAddr = userController.findDefaultAddr(userKey);

		// product 가져오기
		List<ProductListData> productList = new ArrayList<>();
		ProductListData prodInfo = null;
		for (String prodKey : prodKeys) {
			
			prodInfo = service.prodInfo(prodKey);
			productList.add(prodInfo);
		}
		// 기본 주소지
		model.addAttribute("addr", defaultAddr);
		// 제품 정보 리스트
		model.addAttribute("productList", productList);
		// 장바구니 정보(결제완료 후 장바구니에서 제품 삭제용) - 보류

		return "product/productBuy";
	}

	// 결제 API 에 주문번호 보내는 용도
	@PostMapping("makeOrderNo.do")
	@ResponseBody
	public String makeOrderNo(OrderHistory orderHistory, String prodKeys) {
		System.out.println("inside makeOrderNo");
		System.out.println("userKey: " + orderHistory.getUserKey());
		System.out.println("addrKey: " + orderHistory.getAddrKey());

		System.out.println("prodKeys: " + prodKeys);
		// 결제 API 에 orderNo 보내줘야함
		// orderNo 생성 및 Product.java 에 orderNo 집어넣음

	    int makeOrderNo = service.makeOrderNo(orderHistory);

		if (makeOrderNo > 0) {
			String orderNo = orderHistory.getOrderNo();
			System.out.println("orderNo: " + orderNo);
			// 정상적으로 넣으면 orderNo 반환
			return orderNo;
		} else {
			// 정상적으로 DB에 못넣으면 0반환
			return "0";
		}
	}

	// 결제 API 로 값 받아오고 삽입
	@PostMapping("productBuy.do")
	@ResponseBody
	public String productBuy(@RequestParam("prodKey") List<String> prodKeys,
			@RequestParam("orderCnt") List<Integer> orderCnts, @ModelAttribute OrderHistory orderHistory) {

		Map<String, Integer> orderDetail = new HashMap<>();
		for (int i = 0; i < prodKeys.size(); i++) {
			orderDetail.put(prodKeys.get(i), orderCnts.get(i));
		}

		// 제품 구매내역 DB에 넣기
		int insertHistory = service.insertHistory(orderHistory, orderDetail);

		if (insertHistory > 0) {
			// 정상적으로 넣으면 1 반환 오류 발생시 다른 숫자 반환
			// int result -> 정상적으로 결제 완료 시 위에서 만든 주문번호 제작용 컬럼 삭제
			int result = service.delOrderNo(orderHistory);

			return String.valueOf(result);
		}
		// 오류 발생 시 0 반환
		return "0";
	}

	// 제품 장바구니에 넣기
	@GetMapping("insertBasket.do")
	public String insertBasket(Basket basket) {
		basket.setBasketCd(1);
		int insertBasket = service.insertBasket(basket);
		if(insertBasket == 1) {			
			return String.valueOf(insertBasket);
		}else {
			return String.valueOf(insertBasket);
		}
	}

	// 제품 찜하기
	@GetMapping("insertLike.do")
	public String insertLike(Basket basket) {
		basket.setBasketCd(2);
		int insertLike = service.insertBasket(basket);
		if(insertLike == 1) {			
			return String.valueOf(insertLike);
		}else {
			return String.valueOf(insertLike);
		}
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

/*		
	// 구매내역 페이지로 이동
	@GetMapping("buyList.do")
	public String buyList(HttpSession session, int reqPage, Model model) {
		String userKey = (String) session.getAttribute("userKey");
		// userKey로 구매내역 가져오기
		ProductListData orderHistory = service.orderList(userKey, reqPage);

		// 구매 내역에서 prodKey 리스트 추출
		// OrderHistory 객체의 prodKey 추출
		List<String> prodKey = orderHistory.getOrderHistory().stream().map(OrderHistory::getProdKey)
				.collect(Collectors.toList());

		// prodKey를 사용해 추가 데이터 가져오기
		if (!prodKey.isEmpty()) {
			List<Product> product = service.getProdInfo(prodKey);
			model.addAttribute("product", product);
		} else {
			model.addAttribute("product", Collections.emptyList());// 구매내역 없을 때 c:if로 보여주기 위한 용도
		}

		model.addAttribute("orderHistory", orderHistory.getOrderHistory());
		model.addAttribute("pageNavi", orderHistory.getPageNavi());

		// prodKey를 사용해 추가 데이터 가져오기
		if (!prodKey.isEmpty()) {
			List<Product> product = service.getProdInfo(prodKey);
			model.addAttribute("product", product);
		} else {
			model.addAttribute("product", Collections.emptyList());// 구매내역 없을 때 c:if로 보여주기 위한 용도
		}

		model.addAttribute("orderHistory", orderHistory.getOrderHistory());
		model.addAttribute("pageNavi", orderHistory.getPageNavi());

		return "product/buyList";
	}
*/
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
	
}
