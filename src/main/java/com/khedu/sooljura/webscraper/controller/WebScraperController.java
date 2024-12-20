package com.khedu.sooljura.webscraper.controller;

import java.io.IOException;
import java.util.ArrayList;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
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
	public String scrapper() {
		Product prod = new Product();
		// 1) 대상 페이지 URL
		String url = "http://www.kajawine.kr/shop/list.php?ca_id=1010&sort=&sortodr=&type_color=&it_price=&it_opt4=&it_opt9=&page=";

		for (int i = 1; i < 2; i++) {
			String pageUrl = url + i;
			try {

				// 2) 연결 요청 및 페이지 HTML 조회
				Document document = Jsoup.connect(pageUrl).ignoreContentType(true).get();

				// 아래는 스크래핑 대상 페이지 HTML 구조별 상이

				// 3) 위 url 페이지 내부에, 각 상품의 정보(상품명, 가격 등)를 가지고 있는 태그들의 공통 클래스명
				Elements parentsEls = document.getElementsByClass("item_thumb"); // li 태그
				
				ArrayList<Product> list = new ArrayList<Product>();
				
				for (Element parentsEl : parentsEls) {
					// 4) 원하는 정보 추출
					
					// 상세페이지 링크
					String prodDetailLink = parentsEl.getElementsByClass("sct_txt").get(0).getElementsByTag("a").attr("href");
					
					//상세페이지 스크래퍼
					prod = service.scraperDetail(prodDetailLink);
					
					//상품 사진 (thumbnail)
					String productThumbnail = parentsEl.getElementsByClass("listImg").get(0).getElementsByTag("a").get(0).getElementsByTag("img").attr("src");
					prod.setProdImgThumbnail(productThumbnail);
					// 상품명
					String productName = parentsEl.getElementsByClass("listImg").get(0).getElementsByTag("a").get(0).getElementsByTag("img").attr("alt");
					prod.setProdNm(productName);
					// 상품 정가
					String productPrice = parentsEl.getElementsByClass("sct_cost").get(0).getElementsByTag("strike").text();
					prod.setProdPrice(productPrice);
					
					
					//
					if(prod.getIsTrading().equals("0")) {
						System.out.println("거래 종료 상품");
					}else {
						list.add(prod);
						System.out.println(prod.toString());
						System.out.println(list.size());
					}
				}
				

			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		return "product/list";
	}
}
