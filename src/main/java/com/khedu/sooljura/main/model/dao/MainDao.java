package com.khedu.sooljura.main.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.khedu.sooljura.admin.model.vo.Product;
import com.khedu.sooljura.admin.model.vo.Youtube;

@Repository("mainDao")
public class MainDao {

    private final SqlSessionTemplate sessionTemplate;

    public MainDao(@Qualifier("sqlSessionTemplate") SqlSessionTemplate sessionTemplate) {
        this.sessionTemplate = sessionTemplate;
    }

    public List<Product> getAllItems() {
        return sessionTemplate.selectList("product.getAllItems");
    }

    public List<Product> getProdList(String categoryKey) {
        return sessionTemplate.selectList("product.getProdList", categoryKey);
    }

    public Youtube chkYt() {
        return sessionTemplate.selectOne("admin.selectYoutubeUrl");
    }

}
