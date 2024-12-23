package com.khedu.sooljura.webscraper.model.service;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.khedu.sooljura.webscraper.model.dao.WebScraperDao;
import com.khedu.sooljura.webscraper.model.vo.Product;

@Service("webScraperService")
public class WebScraperService {

	@Autowired
	@Qualifier("webScraperDao")
	private WebScraperDao dao;
	
	public String doScrapper() {
		Product prod = new Product();
		String [][] bevArrColl= {
				{
				//0 와인리스트
				"http://www.kajawine.kr/shop/list.php?ca_id=1010&sort=&sortodr=&type_color=&it_price=&it_opt4=&it_opt9=&page=",
				"http://www.kajawine.kr/shop/list.php?ca_id=1020&sort=&sortodr=&type_color=&it_price=&it_opt4=&it_opt9=&page=",
				"http://www.kajawine.kr/shop/list.php?ca_id=1030&sort=&sortodr=&type_color=&it_price=&it_opt4=&it_opt9=&page=",
				"http://www.kajawine.kr/shop/list.php?ca_id=1040&sort=&sortodr=&type_color=&it_price=&it_opt4=&it_opt9=&page=",
				"http://www.kajawine.kr/shop/list.php?ca_id=1060&sort=&sortodr=&type_color=&it_price=&it_opt4=&it_opt9=&page="
				},
				
				{
				//1 위스키 리스트
				"http://www.kajawine.kr/shop/list.php?ca_id=2010&sort=&sortodr=&type_color=&it_price=&it_opt4=&it_opt9=&page=",
				"http://www.kajawine.kr/shop/list.php?ca_id=2020&sort=&sortodr=&type_color=&it_price=&it_opt4=&it_opt9=&page=",
				"http://www.kajawine.kr/shop/list.php?ca_id=2030&sort=&sortodr=&type_color=&it_price=&it_opt4=&it_opt9=&page=",
				"http://www.kajawine.kr/shop/list.php?ca_id=2040&sort=&sortodr=&type_color=&it_price=&it_opt4=&it_opt9=&page=",
				"http://www.kajawine.kr/shop/list.php?ca_id=2050&sort=&sortodr=&type_color=&it_price=&it_opt4=&it_opt9=&page="
				},
				{
				//2 브랜디/ 꼬냑리스트
				"http://www.kajawine.kr/shop/list.php?ca_id=3010&sort=&sortodr=&type_color=&it_price=&it_opt4=&it_opt9=&page=",
				"http://www.kajawine.kr/shop/list.php?ca_id=3020&sort=&sortodr=&type_color=&it_price=&it_opt4=&it_opt9=&page=",
				"http://www.kajawine.kr/shop/list.php?ca_id=3040&sort=&sortodr=&type_color=&it_price=&it_opt4=&it_opt9=&page="
				},
				{
				//3 리큐르/ 보드카 리스트
				"http://www.kajawine.kr/shop/list.php?ca_id=6010&sort=&sortodr=&type_color=&it_price=&it_opt4=&it_opt9=&page=",
				"http://www.kajawine.kr/shop/list.php?ca_id=6020&sort=&sortodr=&type_color=&it_price=&it_opt4=&it_opt9=&page=",
				"http://www.kajawine.kr/shop/list.php?ca_id=6030&sort=&sortodr=&type_color=&it_price=&it_opt4=&it_opt9=&page=",
				"http://www.kajawine.kr/shop/list.php?ca_id=6040&sort=&sortodr=&type_color=&it_price=&it_opt4=&it_opt9=&page=",
				"http://www.kajawine.kr/shop/list.php?ca_id=6050&sort=&sortodr=&type_color=&it_price=&it_opt4=&it_opt9=&page="
				},
				{
				//4 리큐르/ 보드카 리스트
				"http://www.kajawine.kr/shop/list.php?ca_id=40&sort=&sortodr=&type_color=&it_price=&it_opt4=&it_opt9=&page=",
				"http://www.kajawine.kr/shop/list.php?ca_id=5010&sort=&sortodr=&type_color=&it_price=&it_opt4=&it_opt9=&page=",
				"http://www.kajawine.kr/shop/list.php?ca_id=5020&sort=&sortodr=&type_color=&it_price=&it_opt4=&it_opt9=&page=",
				"http://www.kajawine.kr/shop/list.php?ca_id=b0&sort=&sortodr=&type_color=&it_price=&it_opt4=&it_opt9=&page=",
				}
		};
		int i = 0;
		for (String[] bevArr : bevArrColl) {
			
			
			System.out.println(i);
			for(String bevUrl : bevArr) {
				i++;
				prod = scrapper(bevUrl);
				System.out.println(prod.toString());
			}
		}
		System.out.println(i);
		return "";
		
	}
	
	public Product scrapper(String url) {
		Product prod = new Product();
		// 1) 대상 페이지 URL
		
		
//		String url = "http://www.kajawine.kr/shop/list.php?ca_id=1010&sort=&sortodr=&type_color=&it_price=&it_opt4=&it_opt9=&page=";//French Wine
//		String url = "http://www.kajawine.kr/shop/list.php?ca_id=2010&sort=&sortodr=&type_color=&it_price=&it_opt4=&it_opt9=&page=";
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
					String prodDetailLink = parentsEl.getElementsByClass("sct_txt").get(0).getElementsByTag("a")
							.attr("href");

					// 상세페이지 스크래퍼
					prod = scraperDetail(prodDetailLink);

					// 상품 사진 (thumbnail)
					String productThumbnail = parentsEl.getElementsByClass("listImg").get(0).getElementsByTag("a")
							.get(0).getElementsByTag("img").attr("src");
					prod.setProdImgThumbnail(productThumbnail);
					// 상품명
					String productName = parentsEl.getElementsByClass("listImg").get(0).getElementsByTag("a").get(0)
							.getElementsByTag("img").attr("alt");
					prod.setProdNm(productName);
					// 상품 정가
					Element price = parentsEl.getElementsByClass("sct_cost").get(0);
					Element strikeTag = parentsEl.getElementsByClass("sct_cost").get(0).getElementsByTag("strike").first();
					if (strikeTag != null) {
						String productPrice = strikeTag.text(); 
						prod.setProdPrice(productPrice);
					}else {
						String productPrice = price.text(); 
						prod.setProdPrice(productPrice);
					}

					//
					if (prod.getIsTrading().equals("0")) {
						System.out.println("거래 종료 상품");

						prod.setProdOrigin(null);
						prod.setProdMaker(null);
						prod.setProdVol(null);
						prod.setProdProof(null);
						prod.setProdVol(null);
						prod.setProdIntro(null);
						prod.setIsTrading("0");
						prod.setProdCnt(null);
						prod.setProdImgDetail(null);

					} else {
						list.add(prod);
					}
				}

			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return prod;

	}

	// 가자 주류 웹 스크래퍼 -상세 페이지
	public Product scraperDetail(String url) throws IOException {
		Document document = Jsoup.connect(url).ignoreContentType(true).get();
		Product prod = new Product();

		Elements rows = null;
		Elements tds = null;

		Element goodsImg = document.selectFirst(".popup_item_image"); // 제품 사진을 위한 접근
		Element goodsInfo = document.selectFirst("#goods_extit_cont01"); // 그외 정보 얻기 위한 접근

		String productOrigin = null; // 제품 원산지
		String productMaker = null; // 제품 제조사
		String productIntro = null; // 제품 소개
		String productCnt = "10"; // 제품 개수 -- 기본값 = 10
		String productVol = null; // 제품 용량
		String productProof = null; // 제품 도수
		String productImgLink = null; // 제품 상세 이미지

		// 스크래핑용 인스턴스 변수
		String productInfo1 = null;
		String productInfo2 = null;

		// 가자주류 병신새끼들
		String nullCheck = document.select("title").text().substring(0, 4);
		if (nullCheck.equals("오류안내")) {
			prod.setIsTrading("0");
		} else {

			// 이미지 받아오기위한 접근
			productImgLink = goodsImg.select("img").attr("src");
			// System.out.println("productImgLink : "+productImgLink);

			// 원산지 및 제조사 가 적혀있는 테이블 아래 tbody 아래 tr태그 접근
			rows = goodsInfo.select("table").select("tbody").select("tr");

			if (rows.size() > 0) { // tr 태그가 존재하는지 확인
				tds = rows.get(0).select("td"); // 첫 번째 tr의 td 요소들 선택
				if (tds.size() > 0) { // 첫 번째 td가 존재하는지 확인

					// 첫 tr의 첫 td의 text 요소
					productInfo1 = tds.get(0).text();
					if (tds.size() > 1) { // 두 번째 td가 존재하는지 확인

						// 첫 tr의 첫 td의 text 요소
						productInfo2 = tds.get(1).text();

						// 원산지 및 제조사, 두 값이 모두 존재할 때
						if (productInfo1.startsWith("원산지")) {
							productOrigin = productInfo1;
						} else {
							productMaker = productInfo1;
						}
					} else { // 두 번째 td가 없을 때
						if (productInfo1.startsWith("원산지")) {
							productOrigin = productInfo1;
						} else {
							productMaker = productInfo1;
						}
					}
				} else {
					// 첫 번째 td가 없을 때 처리
				}
			} else {
				// tr 태그가 없을 때 처리
			}

			// 용량 및 알콜도수 가 적혀있는 테이블 아래 tbody 아래 tr태그 접근
			Element table = goodsInfo.select("table").first();
			if (table != null) {
				Element tbody = table.select("tbody").first();
				if (tbody != null) {
					rows = tbody.select("tr");
					if (rows.size() > 2) { // tr 요소가 3개 이상 있는지 확인
						Element row = rows.get(2);
						tds = row.select("td");

						if (!tds.isEmpty()) { // td가 존재하는지 확인
							Element td = tds.get(0);
							if (td != null) {
								productInfo1 = td.text();

								if (tds.size() > 1) { // 두 번째 td가 존재하는지 확인
									productInfo2 = tds.get(1).text();

									if (productInfo1.startsWith("용량")) {
										productVol = productInfo1;
										productProof = productInfo2;
									} else {
										productProof = productInfo1;
									}
								} else { // 두 번째 td가 없을 때
									if (productInfo1.startsWith("용량")) {
										productVol = productInfo1;
									} else {
										productProof = productInfo1;
									}
								}
							}
						}
					} else {
					}
				} else {
				}
			} else {
			}

			// 제품 설명

			productIntro = goodsInfo.select("#goods_extit_cont02").text();

			prod.setProdOrigin(productOrigin);
			prod.setProdMaker(productMaker);
			prod.setProdVol(productVol);
			prod.setProdProof(productProof);
			prod.setProdVol(productVol);
			prod.setProdIntro(productIntro);
			prod.setIsTrading("1");
			prod.setProdCnt(productCnt);
			prod.setProdImgDetail(productImgLink);

		}
		return prod;

	}

	// 이미지 다운로드 받는 메소드
	private void getImgFile(String imageUrl, String sortCode) throws IOException {
		URL url = null;
		InputStream in = null;
		OutputStream out = null;

		try {
			url = new URL(imageUrl);
			in = url.openStream();

			// 컴퓨터 또는 서버의 저장할 경로 저장 경로 c드라이브 내 sooljura 폴더 내부 저장
			String localSave = "C:/imgDownloadChk/";
			
			
			
			// 저장될 파일의 명칭
			localSave += "";

			//
			out = new FileOutputStream(localSave);

			while (true) {
				// 루프를 돌면서 이미지데이터를 읽음
				int data = in.read();

				// 데이터값이 -1이면 루프를 종료, break
				if (data == -1) {
					break;
				}

				// 읽어들인 이미지 데이터 저장
				out.write(data);
			}

			// 객체 클로즈
			in.close();
			out.close();

		} catch (Exception e) {
			// 예외처리
			e.printStackTrace();
		} finally {
			// 만일 에러가 발생해서 클로즈가 안됐을 가능성 유
			// NULL값을 체크후 클로즈
			if (in != null) {
				in.close();
			}
			if (out != null) {
				out.close();
			}
		}
	}

}
