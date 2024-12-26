package com.khedu.sooljura.product.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.khedu.sooljura.product.model.dao.ProductDao;

@Service("productService")
public class ProductService {
	@Autowired
	@Qualifier("productDao")
	private ProductDao dao;
}
