package com.khedu.sooljura.notice.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.khedu.sooljura.notice.model.service.NoticeService;

import org.springframework.beans.factory.annotation.Qualifier;

@Controller 
@RequestMapping("/notice/")
public class NoticeController {

	@Autowired
	@Qualifier("noticeService")
	private NoticeService service;
	
	@GetMapping("freeNotice.kh")
	public String writeFrm() {
		return "notice/freeNotice";
	}

	
	
}
