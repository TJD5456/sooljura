package com.khedu.sooljura.admin.model.dao;

import com.khedu.sooljura.admin.model.vo.Product;
import com.khedu.sooljura.admin.model.vo.ProductCategory;
import com.khedu.sooljura.admin.model.vo.ProductImage;
import com.khedu.sooljura.admin.model.vo.Youtube;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.List;

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

    public int createCategory(ProductCategory category) {
        return template.insert("admin.createCategory", category);
    }

    public int uploadYoutube(Youtube youtube) {
        return template.insert("admin.uploadYoutube", youtube);
    }

    public List<Product> getAllProductsInfo() {
        return template.selectList("admin.getAllProductsInfo");
    }

    public ProductCategory getCategoryInfo(String categoryKey) {
        return template.selectOne("admin.getCategoryInfo", categoryKey);
    }

    public List<ProductImage> getProductImages(String prodKey) {
        return template.selectList("admin.getProductImages", prodKey);
    }
}
