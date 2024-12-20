package com.khedu.sooljura.common.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.khedu.sooljura.common.model.service.CommonService;

import org.springframework.beans.factory.annotation.Qualifier;

@Controller 
@RequestMapping("/common/")
public class CommonController {

	@Autowired
	@Qualifier("commonService")
	private CommonService service;
	
	
	@GetMapping("commonTerms.do")
	public String CommonTerms() {
		return "common/Terms";
	}

	
}
