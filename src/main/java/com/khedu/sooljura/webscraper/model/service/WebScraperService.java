package com.khedu.sooljura.webscraper.model.service;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.util.ArrayList;

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

	//이미지 다운로드 받는 메소드
	private void getImageUrl(String imageUrl) throws IOException {
		URL url = null;
		InputStream in = null;
		OutputStream out = null;

		try {
			url = new URL(imageUrl);
			in = url.openStream();

			// 컴퓨터 또는 서버의 저장할 경로 저장 경로 c드라이브 내 sooljura 폴더 내부 저장
			String localSave = "";
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
	
	//가자 주류 웹 스크래퍼 -상세 페이지 
	public Product scraperDetail(String url) throws IOException{
		Document document = Jsoup.connect(url).ignoreContentType(true).get();
		Product prod = new Product();
		
		Elements rows = null;
		Elements tds = null;
		
		Element goodsImg = document.selectFirst(".popup_item_image");				//제품 사진을 위한 접근
		Element goodsInfo = document.selectFirst("#goods_extit_cont01");	//그외 정보 얻기 위한 접근
		
		String productOrigin = null;		//제품 원산지
		String productMaker = null;			//제품 제조사
		String productIntro = null;			//제품 소개
		String productCnt = "10";			//제품 개수 -- 기본값 = 10
		String productVol = null;			//제품 용량
		String productProof = null;			//제품 도수
		String productImgLink = null;		//제품 상세 이미지
		
		//스크래핑용 인스턴스 변수
		String productInfo1 = null;		 
		String productInfo2 = null;
		
		//이미지 받아오기위한 접근
		productImgLink = goodsImg.select("img").attr("src");
		System.out.println(goodsImg);
		//System.out.println("productImgLink : "+productImgLink);
		
		//가자주류 병신새끼들
		String nullCheck = document.select("title").text().substring(0, 4);
		if(nullCheck.equals("오류안내")) {
			prod.setIsTrading("0");
		}else {
			
		//원산지 및 제조사 가 적혀있는 테이블 아래 tbody 아래 tr태그 접근
		rows = goodsInfo.select("table").select("tbody").select("tr");
		
		if (rows.size() > 0) { // tr 태그가 존재하는지 확인
		    tds = rows.get(0).select("td"); // 첫 번째 tr의 td 요소들 선택
		    if (tds.size() > 0) { // 첫 번째 td가 존재하는지 확인
		    	
		    	//첫 tr의 첫 td의 text 요소
		        productInfo1 = tds.get(0).text();
		        if (tds.size() > 1) { // 두 번째 td가 존재하는지 확인
		        	
		        	//첫 tr의 첫 td의 text 요소
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
		System.out.println("원산지 및 제조사 까진 완료");
		
		//용량 및 알콜도수 가 적혀있는 테이블 아래 tbody 아래 tr태그 접근
		Element row = goodsInfo.select("table").select("tbody").select("tr").get(2);
				
		Element td = row.select("td").get(0); // 첫 번째 tr의 td 요소들 선택
				    if (td.attributesSize() > 0) { // 첫 번째 td가 존재하는지 확인
				    	
				    	//첫 tr의 첫 td의 text 요소
				        productInfo1 = td.text();
				        if (td.attributesSize() > 1) { // 두 번째 td가 존재하는지 확인
				        	
				        	//첫 tr의 첫 td의 text 요소
				        	productInfo2 = tds.get(1).text();

				        	// 용량 및 알콜도수, 두 값이 모두 존재할 때
				            if (productInfo1.startsWith("용량")) {
				            	//productInfo1 이 "용량"으로 시작할때
				                productVol = productInfo1;
				                productProof = productInfo2;
				            } else {
				            	//productInfo1 이 "용량"으로 시작하지 않을 때
				                productProof = productInfo1;
				            }
				        } else { // 두 번째 td가 없을 때
				            if (productInfo1.startsWith("용량")) {
				            	productVol = productInfo1;
				            } else {
				                productProof = productInfo1;
				            }
				        }
				    } else {
				        // 첫 번째 td가 없을 때 처리
				    }
				System.out.println("용량 및 알콜도수 도 완료");
				//제품 설명
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
		
}
