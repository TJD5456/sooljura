package com.khedu.sooljura.usermypage.model.service;

import com.khedu.sooljura.admin.model.vo.Product;
import com.khedu.sooljura.product.model.vo.Basket;
import com.khedu.sooljura.product.model.vo.ProductListData;
import com.khedu.sooljura.user.model.vo.User;
import com.khedu.sooljura.usermypage.model.dao.UserMyPageDao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service("userMyPageService")
public class UserMyPageService {

    @Autowired
    @Qualifier("userMyPageDao")
    private UserMyPageDao dao;

    //비밀번호 변경
    public int pwChg(User user) {
        return dao.pwChg(user);
    }

    //회원탈퇴
    public int delUser(String userKey) {
        return dao.delUser(userKey);
    }

	public ArrayList<Basket> findProdKeyLikedList(String userKey) {
		return (ArrayList<Basket>) dao.findProdKeyLikedList(userKey); // List<Basket> 반환
	}

	public ProductListData selProdInfoLikedList(String prodKey) {
		 List<Product> prodInfoList = dao.selProdInfoLikedList(prodKey);

	        //Product에만 넣기 위한 선언
	        ArrayList<Product> productArrayList = new ArrayList<>(prodInfoList);

	        ProductListData prodInfo = new ProductListData();
	        prodInfo.setProductList(productArrayList);
	        return prodInfo;
	}

	public int delLikedList(Basket basket) {
		 return dao.delLikedList(basket);
	}

	public int delLikedProd(Basket basket) {
		 return dao.delLikedProd(basket);
	}
}
