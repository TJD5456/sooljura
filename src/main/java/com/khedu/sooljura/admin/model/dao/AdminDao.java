package com.khedu.sooljura.admin.model.dao;

import com.khedu.sooljura.admin.model.vo.Product;
import com.khedu.sooljura.admin.model.vo.ProductImage;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository("adminDao")
public class AdminDao {

    @Autowired
    @Qualifier("sqlSessionTemplate")
    private SqlSessionTemplate template;

    public String selectProdKey() {
        return template.selectOne("admin.selectProdKey");
    }

    public int uploadProduct(Product product) {
        return template.insert("admin.uploadProduct", product);
    }

    public int uploadProdImg(ProductImage img) {
        return template.insert("admin.uploadProdImg", img);
    }

}
