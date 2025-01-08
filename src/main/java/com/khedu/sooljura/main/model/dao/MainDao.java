package com.khedu.sooljura.main.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.khedu.sooljura.admin.model.vo.Product;

@Repository("mainDao")
public class MainDao {

	   @Autowired
	   @Qualifier("sqlSessionTemplate")
	   private SqlSessionTemplate sessionTemplate;
	
	public List<Product> getAllItems() {
		return sessionTemplate.selectList("product.getAllItems");
	}

	public List<Product> getProdList(String categoryKey) {
		return sessionTemplate.selectList("product.getProdList", categoryKey);
	}

}
