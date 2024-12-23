package com.khedu.sooljura.webscraper.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.khedu.sooljura.admin.model.vo.ProductImage;
import com.khedu.sooljura.webscraper.model.vo.Product;


@Repository("webScraperDao")
public class WebScraperDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate template;

	public int insProd(Product prod) {
		//제품 등록
		return template.insert("webScraper.uploadProduct", prod);
	}
	public int insProdThmbImg(ProductImage prodImg) {
		//제품 이미지(섬네일) 등록
		return template.insert("webScraper.uploadProduct", prodImg);
	}
	public int insProdDetailImg(ProductImage prodImg) {
		//제품 이미지(상세) 등록
		return template.insert("webScraper.uploadProduct", prodImg);
	}
}
