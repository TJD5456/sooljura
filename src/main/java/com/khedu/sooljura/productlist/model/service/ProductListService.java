package com.khedu.sooljura.productlist.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.khedu.sooljura.admin.model.vo.Product;
import com.khedu.sooljura.productlist.model.dao.ProductListDao;

@Service("productListService")
public class ProductListService {
	

		@Autowired
		@Qualifier("ProductListDao")
		private ProductListDao dao;

		public ArrayList<Product> prodList() {
			// TODO Auto-generated method stub
			return null;
		}

}
