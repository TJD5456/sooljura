package com.khedu.sooljura.product.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.khedu.sooljura.product.model.service.ProductService;

@Controller
@RequestMapping("/product/")
public class ProductController {
	@Autowired
	@Qualifier("productService")
	private ProductService service;
}
