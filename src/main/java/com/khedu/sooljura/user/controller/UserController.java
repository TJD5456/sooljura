package com.khedu.sooljura.user.controller;

import java.io.IOException;
import java.util.ArrayList;

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
	public void join(User user, HttpServletResponse response) {
		int result = service.join(user);
	}
	
	//회원가입 - 아이디 체크
	@GetMapping("chkId.do")
	public String chkId(String userId) {
		int result = service.chkId(userId);		
		return String.valueOf(result);
	}
	
	//회원가입 - 닉네임 체크
	@GetMapping("chkNickname.do")
	public String chkNickname(String userNickname) {
		int result = service.chkNickname(userNickname);
		return String.valueOf(result);
	}
	
	//약관동의 페이지로 이동
	@GetMapping("provisionFrm.do")
	public String provisionFrm() {
		return "user/provision";
	}
	
	//주소지 관리 팝업 페이지로 이동 + 주소지 목록 보여주기
	@GetMapping(value="addrListFrm.do", produces="application/json; charset=utf-8")
	@ResponseBody
	public String addrListFrm(Model model, String userKey) {
		AddrListData addrList = service.addrList(userKey);
		
		model.addAttribute("addrList", addrList);
		return "user/addrList";
	}
	
	//주소지 추가 페이지
	@GetMapping("addAddrFrm.do")
	public String addAddrFrm() {
		return "user/addAddr";
	}
	
	//주소지 추가
	@PostMapping("addAddr.do")
	public String addAddr(UserAddr userAddr) {
		int result = service.addAddr(userAddr);
		return String.valueOf(result);
	}
}
