package com.khedu.sooljura.usermypage.controller;


import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.khedu.sooljura.usermypage.model.service.UserMyPageService;

@Controller
@RequestMapping("/userMyPage/")
public class UserMyPageController {
	
	@Autowired
	@Qualifier("userMyPageService")
	private UserMyPageService userMyPageService;
	
	@GetMapping("userMyPage.do")
    public String userPage() {
        return "userMyPage/userMyPage";
    }
	@GetMapping("userInfo.do")
    public String userInfo() {
        return "userMyPage/userInfo";
    }
	@GetMapping("shoppingInfo.do")
    public String shoppingInfo() {
        return "userMyPage/shoppingInfo";
    }
	@GetMapping("readMyPost.do")
    public String readMyPost() {
        return "userMyPage/readMyPost";
    }
	@GetMapping("likedMerc.do")
    public String likedMerc() {
        return "userMyPage/likedMerc";
    }
	
	@PostMapping("userInfoUpd")
	@ResponseBody
	public String userUpdInfo(String string) {
		
		System.out.println(string);
		//int i = userMyPageService.userUpdInfo();
		return null;
	}
}
