package com.khedu.sooljura.usermypage.model.dao;

import com.khedu.sooljura.admin.model.vo.Product;
import com.khedu.sooljura.product.model.vo.Basket;
import com.khedu.sooljura.user.model.vo.User;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository("userMyPageDao")
public class UserMyPageDao {

    @Autowired
    @Qualifier("sqlSessionTemplate")
    private SqlSessionTemplate sessionTemplate;

    //비밀번호 변경
    public int pwChg(User user) {
        return sessionTemplate.update("userMyPage.pwChg", user);
    }

    //회원탈퇴
    public int delUser(String userKey) {
        return sessionTemplate.delete("userMyPage.delUser", userKey);
    }

	public List<Basket> findProdKeyLikedList(String userKey) {
		return sessionTemplate.selectList("product.findProdKeyLikedList", userKey);
	}

	public List<Product> selProdInfoLikedList(String prodKey) {
		return sessionTemplate.selectList("product.selProdInfoLikedList", prodKey);
	}

	public int delLikedList(Basket basket) {
		return sessionTemplate.delete("product.delLikedList", basket);
	}

	public int delLikedProd(Basket basket) {
		return sessionTemplate.delete("product.delLikedProd", basket);
	}
}
