package com.khedu.sooljura.webscraper.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository("webScraperDao")
public class WebScraperDao {

	
	 @Autowired
	    @Qualifier("sqlSessionTemplate")
	    private SqlSessionTemplate template;
	 
	 
}
