package com.khedu.sooljura.usermypage.controller;


import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.khedu.sooljura.usermypage.model.service.UserMyPageService;

@Controller
@RequestMapping("/userMyPage/")
public class UserMyPageController {
	
	@Autowired
	@Qualifier("userMyPageService")
	private UserMyPageService userMyPageService;
	
	@GetMapping("userMyPageInfoUpd.do")
    public String userPage() {
        return "userMyPage/userMyPageInfoUpd";
    }
}
