package com.khedu.sooljura.webscraper.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.khedu.sooljura.webscraper.model.service.WebScraperService;
import com.khedu.sooljura.webscraper.model.vo.Product;

@Controller
@RequestMapping("/webScraping")
public class WebScraperController {

	@Autowired
	@Qualifier("webScraperService")
	private WebScraperService service;
	
	@GetMapping("webScraper.do")
	public String movePage() {
		return "/common/webScraper";
	}
	
	//가자주류 웹 스크래퍼 - 전체 리스트
	@GetMapping(value = "/scrapingTest.do")
	private String scrapper() {
		service.doScrapper();
		return null;
		// TODO Auto-generated method stub

	}
	
	
}
