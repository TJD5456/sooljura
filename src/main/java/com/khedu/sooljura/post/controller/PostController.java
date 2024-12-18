package com.khedu.sooljura.post.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.khedu.sooljura.post.model.service.PostService;

import org.springframework.beans.factory.annotation.Qualifier;

@Controller 
@RequestMapping("/post/")
public class PostController {

	@Autowired
	@Qualifier("postService")
	private PostService service;
	
	@GetMapping("freePost.do")
	public String freePost() {
		return "post/freePost";
	}
	
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
	
}
