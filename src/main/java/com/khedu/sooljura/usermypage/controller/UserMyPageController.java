package com.khedu.sooljura.usermypage.controller;


import org.springframework.beans.factory.annotation.Qualifier;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.khedu.sooljura.user.model.vo.User;
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
	
	//비밀번호 변경
	@PostMapping("pwChg.do")
	@ResponseBody
	public String pwChg(String userKey, String userPw, String userPwChk, String userUpdPw, String userUpdPwChk, 
						HttpServletResponse response, HttpSession session) {
		//기존 비밀번호와 입력한 비밀번호가 일치하지 않을때 0반환
		if(!BCrypt.checkpw(userPwChk, userPw)) {
			return String.valueOf(0);
		}else if(!userUpdPw.equals(userUpdPwChk)) {
			//새로운 비밀번호와 새로운 비밀번호 체크가 일치하지 않을 때 2반환
			return String.valueOf(2);
		}else {			
			//비밀번호 변경 조건에 문제없을 때
			User user = new User();
			user.setUserKey(userKey);
			
			userUpdPw = BCrypt.hashpw(userUpdPw, BCrypt.gensalt());
			user.setUserPw(userUpdPw);
			
			int result = userMyPageService.pwChg(user);
			
			//비밀번호 변경 성공 시 1반환
			if(result > 0) {			
				session.invalidate();
				return String.valueOf(result);
			}else {
				//비밀번호 변경 중 오류 발생 시 3 반환
				return String.valueOf(3);
			}			
		}
	}
	
	//회원탈퇴 페이지로 이동
	@GetMapping("delUserFrm.do")
	public String delUserFrm() {
		return "userMyPage/delUser";
	}
	
	//회원탈퇴
	@PostMapping("delUser.do")
	@ResponseBody
	public String delUser(String userKey, String userPw, String userPwChk, HttpSession session) {
		System.out.println(userKey);
		System.out.println(userPw);
		System.out.println(userPwChk);
		if(!BCrypt.checkpw(userPwChk, userPw)) {
			//회원 비밀번호와 입력한 비밀번호가 일치하지 않으면 2반환
			return String.valueOf(2);
		}else {
			//회원탈퇴 성공 시 1 반환
			int result = userMyPageService.delUser(userKey);
			
			session.invalidate();
			return String.valueOf(result);
		}
	}
}
