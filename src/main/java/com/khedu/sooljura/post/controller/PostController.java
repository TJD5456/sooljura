package com.khedu.sooljura.post.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.khedu.sooljura.post.model.service.PostService;
import com.khedu.sooljura.post.model.vo.Post;
import com.khedu.sooljura.post.model.vo.PostFile;
import com.khedu.sooljura.post.model.vo.PostPageData;
import com.khedu.sooljura.user.model.vo.User;

@Controller
@RequestMapping("/post/")
public class PostController {

	@Autowired
	@Qualifier("postService")
	private PostService service;

	@GetMapping("notePost.do")
	public String notePost() {
		return "post/notePost";
	}

	@GetMapping("detailReviewPost.do")

	public String detailReviewPost() {
		return "post/detailReviewPost";
	}

	@GetMapping("reviewListPost.do")

	public String reviewListPost() {
		return "post/reviewListPost";
	}

	@GetMapping("freePostWriter.do")

	public String freePostWirter() {
		return "post/freePostWriter";
	}

	@GetMapping("webPageInfo.do")

	public String webPageInfo() {
		return "post/webPageInfo";
	}

	@GetMapping("getList.do")
	public String getList(int reqPage, Model model) {
		PostPageData pd = service.selectPostList(reqPage);

		// 응답페이지(list.jsp)에서 게시글 목룍을 보여주기 위해, 응답 데이터를 등록 할 수 있는 Model 객체 매개변수에 추가.
		model.addAttribute("list", pd.getList());
		model.addAttribute("pageNavi", pd.getPageNavi());

		return "post/freePost";
	}

	@PostMapping("freewrite.do")
	public String freewrite(HttpSession session, Post post, Model model) {
	   
		// 0.제목 확인
	    if (post.getPostTitle() == null || post.getPostTitle().isEmpty()) {
	        model.addAttribute("errorMessage", "제목을 입력해주세요.");
	        return "post/freePostWriter";
	    }
		
		// 1. 로그인 사용자 정보 확인
	    User loginUser = (User) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        model.addAttribute("errorMessage", "로그인이 필요합니다.");
	        return "redirect:/user/login.do"; // 로그인 페이지로 리다이렉트
	    }

	    // 2. 작성자 정보 설정
	    post.setUserKey(loginUser.getUserKey());
	    post.setUserNm(loginUser.getUserNm());

	    // 3. 게시글 저장
	    try {
	        int result = service.insertPost(post);
	        if (result > 0) {
	            return "redirect:/post/getList.do?reqPage=1"; // 성공 시 목록 페이지로 리다이렉트
	        } else {
	            model.addAttribute("errorMessage", "게시글 등록 중 오류가 발생했습니다.");
	            return "post/freePostWriter"; // 실패 시 작성 페이지로 복귀
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        model.addAttribute("errorMessage", "게시글 등록 중 예외가 발생했습니다.");
	        return "post/freePostWriter"; // 예외 발생 시 작성 페이지로 복귀
	    }
	}
}
