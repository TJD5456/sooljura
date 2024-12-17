package com.khedu.sooljura.user.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.khedu.sooljura.user.model.service.UserService;
import com.khedu.sooljura.user.model.vo.User;

@Controller
@RequestMapping("/user/")
public class UserController {
	@Autowired
	@Qualifier("userService")
	private UserService service;
	
	//로그인
	@PostMapping("login")
	public String login(User user, HttpSession session) {
		User login = service.login(user);
			
		if(login != null) {
			session.setAttribute("loginUser", login);
			session.setMaxInactiveInterval(60 * 60 * 2);
			
			//아이디 저장 체크버튼
			Cookie cookie = new Cookie("saveId", user.getUserId());
			
			
			return "redirect:/";
		}else {
			return null;
		}
	}
}
