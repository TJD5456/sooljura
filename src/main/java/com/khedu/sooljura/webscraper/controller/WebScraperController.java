package com.khedu.sooljura.webscraper.controller;

import com.khedu.sooljura.webscraper.model.service.WebScraperService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/webScraping")
public class WebScraperController {
	/*
	분류코드 40 페이지 포맷 다름. 수정필요 맥주/사케 일단 보류. 시간 남을때 추가로 할것.
	가자주류 웹에 맥주 카테고리 없음. 수작업으로 몇개 넣고 추후 보충 예정
	가자주류 웹 사케 카테고리 포맷이 다른 주류의 그것과 다름, 필요시 수정예정  
	*/

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
        service.doScraper();
        return null;
    }

}
