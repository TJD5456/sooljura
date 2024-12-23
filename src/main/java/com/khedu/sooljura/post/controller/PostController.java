package com.khedu.sooljura.post.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.khedu.sooljura.post.model.service.PostService;
import com.khedu.sooljura.post.model.vo.PostPageData;

import org.springframework.beans.factory.annotation.Qualifier;

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
	@GetMapping("detaliReviewPost.do")
	public String detaliReviewPost() {
		return "post/detaliReviewPost";
	}
	
	@GetMapping("reviewListPost.do")
	public String reviewListPost() {
		return "post/reviewListPost";
	}
	@GetMapping("freePostWirter.do")
	public String freePostWirter() {
		return "post/freePostWirter";
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
	
	
	
	
	
}
