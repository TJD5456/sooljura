package com.khedu.sooljura.usermypage.controller;

import com.khedu.sooljura.product.model.vo.Basket;
import com.khedu.sooljura.product.model.vo.ProductListData;
import com.khedu.sooljura.user.model.vo.User;
import com.khedu.sooljura.usermypage.model.service.UserMyPageService;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/userMyPage/")
public class UserMyPageController {

	@Autowired
	@Qualifier("userMyPageService")
	private UserMyPageService service;

	@GetMapping("userMyPageFrm.do")
	public String userPage() {
		return "userMyPage/userMyPage";
	}

	@GetMapping("shoppingInfo.do")
	public String shoppingInfo() {
		return "userMyPage/shoppingInfo";
	}

	@GetMapping("likedMerc.do")
	public String likedMerc() {
		return "userMyPage/likedMerc";
	}

	@PostMapping("userInfoUpd")
	@ResponseBody
	public String userUpdInfo(String string) {

		System.out.println(string);
		// int i = userMyPageService.userUpdInfo();
		return null;
	}

	@GetMapping("userInfo.do")
	public String userInfoPage() {
		return "userMyPage/userInfo";
	}

	// 비밀번호 변경
	@PostMapping("pwChg.do")
	@ResponseBody
	public String pwChg(String userKey, String userPw, String userPwChk, String userUpdPw, String userUpdPwChk,
			HttpServletResponse response, HttpSession session) {
		// 기존 비밀번호와 입력한 비밀번호가 일치하지 않을때 0반환
		if (!BCrypt.checkpw(userPwChk, userPw)) {
			return String.valueOf(0);
		} else if (!userUpdPw.equals(userUpdPwChk)) {
			// 새로운 비밀번호와 새로운 비밀번호 체크가 일치하지 않을 때 2반환
			return String.valueOf(2);
		} else {
			// 비밀번호 변경 조건에 문제없을 때
			User user = new User();
			user.setUserKey(userKey);

			userUpdPw = BCrypt.hashpw(userUpdPw, BCrypt.gensalt());
			user.setUserPw(userUpdPw);

			int result = service.pwChg(user);

			// 비밀번호 변경 성공 시 1반환
			if (result > 0) {
				session.invalidate();
				return String.valueOf(result);
			} else {
				// 비밀번호 변경 중 오류 발생 시 3 반환
				return String.valueOf(3);
			}
		}
	}
	// 회원탈퇴 페이지로 이동
		@GetMapping("delUserFrm.do")
		public String delUserFrm() {
			return "userMyPage/delUser";
		}
		// 회원탈퇴
		@PostMapping("delUser.do")
		@ResponseBody
		public String delUser(String userKey, String userPw, String userPwChk, HttpSession session) {
			System.out.println(userKey);
			System.out.println(userPw);
			System.out.println(userPwChk);
			if (!BCrypt.checkpw(userPwChk, userPw)) {
				// 회원 비밀번호와 입력한 비밀번호가 일치하지 않으면 2반환
				return String.valueOf(2);
			} else {
				// 회원탈퇴 성공 시 1 반환
				int result = service.delUser(userKey);

				session.invalidate();
				return String.valueOf(result);
			}
		}
	@GetMapping("likedProdList.do")
	public String likedProdList(HttpSession session, Model model) {
		// 세션에서 userKey 가져오기(정상작동중)
		User loginUser = (User) session.getAttribute("loginUser");
		if(loginUser == null) {
			model.addAttribute("access-denied", "잘못된 접근 입니다.");
			return "userMyPage/likedProdList";
		}
		String userKey = ((User) loginUser).getUserKey();
		// userKey 로 Basket 리스트 조회해서 prodKey 가져오기 (정상작동중)
		ArrayList<Basket> findProdKey = service.findProdKeyLikedList(userKey);

		if (findProdKey == null || findProdKey.isEmpty()) {
			// Basket 리스트에서 prodKey 가 없는경우
			model.addAttribute("basketList", Collections.emptyList());
		} else {
			// Basket 리스트에서 가져온 prodKey로 제품 정보 조회
			List<ProductListData> prodInfoList = new ArrayList<>();
			findProdKey.forEach(basket -> {
				ProductListData prodInfo = service.selProdInfoLikedList(basket.getProdKey());
				prodInfoList.add(prodInfo);
			});
			model.addAttribute("basketList", prodInfoList);
		}
		return "userMyPage/likedProdList";
	}
	@GetMapping("delLikedProd.do")
	@ResponseBody
	public String delLikedProd(String userKey, String prodKey) {		
		Basket basket = new Basket();
		basket.setUserKey(userKey);
		basket.setProdKey(prodKey);

		int result = service.delLikedProd(basket);
		return String.valueOf(result);
	}
	
	@GetMapping("delSelectedLikedList.do")
	@ResponseBody
	public int delSelectedLikedList(@RequestParam List<String> prodKeyArr, 
            						   @RequestParam String userKey) {		
		//왜 되는지 모름. 오류 나긴나는데, 실행은 됨;
		Basket basket = new Basket();
		basket.setUserKey(userKey);
		basket.setProdKeyArr(prodKeyArr);
		System.out.println(basket.getProdKeyArr());
		int result = service.delLikedList(basket);
		return result;
	}
	@GetMapping("likedProdToBasket.do")
	@ResponseBody
	public String likedProdToBasket(String userKey, String prodKey) {		
		Basket basket = new Basket();
		basket.setUserKey(userKey);
		basket.setProdKey(prodKey);

		int result = service.delLikedList(basket);
		return String.valueOf(result);
	}
	@GetMapping("likedListToBasket.do")
	@ResponseBody
	public int likedListToBasket(@RequestParam List<String> prodKeyArr, 
            						   @RequestParam String userKey) {		
		//왜 되는지 모름. 오류 나긴나는데, 실행은 됨;
		Basket basket = new Basket();
		basket.setUserKey(userKey);
		basket.setProdKeyArr(prodKeyArr);
		System.out.println(basket.getProdKeyArr());
		int result = service.delLikedList(basket);
		return result;
	}
	
}
