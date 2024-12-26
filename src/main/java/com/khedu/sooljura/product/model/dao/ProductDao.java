package com.khedu.sooljura.product.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository("productDao")
public class ProductDao {
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sessionTemplate;
}
