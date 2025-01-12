package com.khedu.sooljura.admin.model.dao;

import com.khedu.sooljura.admin.model.vo.Product;
import com.khedu.sooljura.admin.model.vo.ProductCategory;
import com.khedu.sooljura.admin.model.vo.ProductImage;
import com.khedu.sooljura.admin.model.vo.Youtube;
import com.khedu.sooljura.user.model.vo.User;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository("adminDao")
public class AdminDao {

    private final SqlSessionTemplate template;

    public AdminDao(@Qualifier("sqlSessionTemplate") SqlSessionTemplate template) {
        this.template = template;
    }

    public int selNewPost() {
        return template.selectOne("admin.selNewPost");
    }

    public int newUser() {
        return template.selectOne("admin.newUser");
    }

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

    public int updateYoutube(Youtube youtube) {
        return template.update("admin.updateYoutube", youtube);
    }

    public List<Product> getAllProductsInfo() {
        return template.selectList("admin.getAllProductsInfo");
    }

    public ProductCategory getCategoryInfo(String categoryKey) {
        return template.selectOne("admin.getCategoryInfo", categoryKey);
    }

    public List<ProductCategory> getAllCategoryInfos() {
        return template.selectList("admin.getAllCategoryInfos");
    }

    public List<ProductImage> getProductImages(String prodKey) {
        return template.selectList("admin.getProductImages", prodKey);
    }

    public List<ProductCategory> selectLowerCategoryLevel(String higherCategoryKey) {
        return template.selectList("admin.selectLowerCategoryLevel", higherCategoryKey);
    }

    public List<ProductCategory> selHigherCat(String catNm) {
        return template.selectList("admin.selHigherCat", catNm);
    }

    public List<Product> searchProductName(String currentInputValue) {
        return template.selectList("admin.searchProductName", currentInputValue);
    }

    public Youtube selectYoutubeUrl() {
        return template.selectOne("admin.selectYoutubeUrl");
    }

    public ProductImage selectProductImageInfo(String prodKey) {
        return template.selectOne("admin.selectProductImageInfo", prodKey);
    }

    public List<User> selectAllUserForLevelChange() {
        return template.selectList("admin.selectAllUserForLevelChange");
    }

    public int selectUserPostCnt(String userKey) {
        return template.selectOne("admin.selectUserPostCnt", userKey);
    }

    public int changeUserLevel(HashMap<String, String> keyAndCd) {
        return template.update("admin.changeUserLevel", keyAndCd);
    }

    public int editProd(Product product) {
        return template.update("admin.editProd", product);
    }

    public int delProd(String prodKey) {
        return template.delete("admin.delProd", prodKey);
    }

}
