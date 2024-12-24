package com.khedu.sooljura.user.controller;

import java.io.IOException;
import java.util.Collections;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.khedu.sooljura.user.model.service.UserService;
import com.khedu.sooljura.user.model.vo.AddrListData;
import com.khedu.sooljura.user.model.vo.User;
import com.khedu.sooljura.user.model.vo.UserAddr;

@Controller
@RequestMapping("/user/")
public class UserController {
	@Autowired
	@Qualifier("userService")
	private UserService service;
	
	//로그인 페이지로 이동
	@GetMapping("loginFrm.do")
	public String loginFrm () {
		return "user/login";
	}
	
	
	//로그인
	@PostMapping("login.do")
	public void login(User user, HttpSession session, HttpServletRequest request, HttpServletResponse response) 
					  throws ServletException, IOException {
		User login = service.login(user);
			
		if(login != null) {
			session.setAttribute("loginUser", login);
			session.setMaxInactiveInterval(60 * 60 * 2);
			
			//아이디 저장 체크버튼
			Cookie cookie = new Cookie("saveId", user.getUserId());
			if(request.getParameter("saveId") != null) {
				cookie.setMaxAge(60 * 60 * 24 * 30);//30일
			}else {
				cookie.setMaxAge(0);
			}
			response.addCookie(cookie);
			
			//로그인 성공 = 0, 로그인 실패 = 1
			response.getWriter().print("0");
		}else {
			//로그인 실패
			response.getWriter().print("1");
		}
	}
	
	//회원가입 페이지로 이동
	@GetMapping("joinFrm.do")
	public String joinFrm() {
		return "user/join";
	}
	
	//회원가입
	@PostMapping("join.do")
	public void join(User user, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int result = service.join(user);
		if(result == 1) {
			request.setAttribute("title", "알림");
			request.setAttribute("msg", "회원가입이 완료되었습니다. 로그인 페이지로 이동합니다");
			request.setAttribute("icon", "success");
			request.setAttribute("loc", "loginFrm.do");
			
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
		}else {
			request.setAttribute("title", "알림");
			request.setAttribute("msg", "회원가입 중 오류가 발생했습니다");
			request.setAttribute("icon", "error");
			
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
		}
	}
	
	//회원가입 - 아이디 체크
	@GetMapping("chkId.do")
	@ResponseBody
	public String chkId(String userId) {
		int result = service.chkId(userId);		
		return String.valueOf(result);
	}
	
	//회원가입 - 닉네임 체크
	@GetMapping("chkNickname.do")
	@ResponseBody
	public String chkNickname(String userNickNm) {
		int result = service.chkNickname(userNickNm);
		return String.valueOf(result);
	}
	
	//약관동의 페이지로 이동
	@GetMapping("provisionFrm.do")
	public String provisionFrm() {
		return "user/provision";
	}
	
	//주소지 관리 페이지로 이동 + 주소지 목록 보여주기
	@GetMapping("addrListFrm.do")
	public String addrListFrm(Model model, HttpSession session) {
		User loginUser = (User) session.getAttribute("loginUser");
		String userKey = loginUser.getUserKey();
		
		AddrListData addrList = service.addrList(userKey);
		
		if (addrList == null || addrList.getAddrList() == null || addrList.getAddrList().isEmpty()) {
	        model.addAttribute("addrList", Collections.emptyList());
	    } else {
	        model.addAttribute("addrList", addrList.getAddrList());
	    }
	    
	    return "user/addrList";
	}
	
	//주소지 추가 페이지
	@GetMapping("addAddrFrm.do")
	public String addAddrFrm() {
		return "user/addAddr";
	}
	
	//주소지 추가
	@PostMapping("addAddr.do")
	@ResponseBody
	public String addAddr(UserAddr userAddr) {
		int result = service.addAddr(userAddr);
		
		return String.valueOf(result);
	}
	
	//주소지 삭제
	@GetMapping("delAddr.do")
	@ResponseBody
	public String delAddr(String addrKey) {
		int result = service.delAddr(addrKey);
		return String.valueOf(result);
	}
	
	//주소지 수정 페이지 이동
	@PostMapping("updAddrFrm.do")
	@ResponseBody
	public String updAddrFrm(String addrKey, Model model) {
		UserAddr userAddr = service.userAddr(addrKey);
		
		System.out.println(userAddr.getAddrKey());
		
		model.addAttribute("addrInfo", userAddr);
		return "/user/updAddr.do?addrKey="+userAddr.getAddrKey();
	}
	
	//주소지 수정
	@PostMapping("updAddr.do")
	public String updAddr(UserAddr userAddr) {
		//주소지 변경
		int result = 0;
		//기본주소지 변경 체크박스 체크 시 기존에 기본주소지로 세팅되어있는 주소 defaultYn 0으로 변경
		int defaultYnChk = 0;
/*
		jsp에서 기본배송지가 아닌 경우만 defaultYn 체크박스 체크 가능
		defaultYn이 체크되어 있으면 1이 반환되고 1이 반환되면 기존 기본배송지의 defaultYn을 0으로 변경 후 주소지 변경(1 = 기본배송지, 0 = 배송지)
		defaultYn이 체크되어있지 않으면 0이니까 그냥 변경만
*/
		if(userAddr.getDefaultYn() == 1) {
			defaultYnChk = service.setDefaultYn(userAddr);
			result = service.updAddr(userAddr);			
		}else {
			result = service.updAddr(userAddr);			
		}
		int complete = result + defaultYnChk;
		
		return String.valueOf(complete);
	}
	
	//로그아웃
	@GetMapping("logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		
		return "redirect:/";
	}
}
