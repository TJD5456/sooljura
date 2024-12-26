package com.khedu.sooljura.productlist.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.khedu.sooljura.admin.model.vo.Product;
import com.khedu.sooljura.productlist.model.service.ProductListService;

@Controller 
@RequestMapping("/common/")
public class ProductList {

	@Autowired
	@Qualifier("productListService")
	private ProductListService service;
	
	
	@GetMapping("/")
	public String CommonTerms(Model model) {
		   ArrayList<Product> items = service.prodList();
	       model.addAttribute("items", items);
	       return "index";
	}

}


