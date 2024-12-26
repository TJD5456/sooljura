package com.khedu.sooljura.admin.model.service;

import com.khedu.sooljura.admin.model.dao.AdminDao;
import com.khedu.sooljura.admin.model.vo.Product;
import com.khedu.sooljura.admin.model.vo.ProductCategory;
import com.khedu.sooljura.admin.model.vo.ProductImage;
import com.khedu.sooljura.admin.model.vo.Youtube;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Service("adminService")
public class AdminService {

    private final AdminDao dao;

    public AdminService(@Qualifier("adminDao") AdminDao dao) {
        this.dao = dao;
    }

    @Transactional
    public int uploadProduct(Product product, ArrayList<ProductImage> imgList) {
        String prodKey = dao.selectProdKey();

        product.setProdKey(prodKey);

        int result = dao.uploadProduct(product);

        if (result == 1) {
            for (ProductImage image : imgList) {
                image.setProdKey(prodKey);
                result = dao.uploadProdImg(image);
            }
        }
        return result;
    }

    public int createCategory(ProductCategory category) {
        return dao.createCategory(category);
    }

    public ArrayList<Product> getAllProductsInfo() {
        ArrayList<Product> productsInfos = (ArrayList<Product>) dao.getAllProductsInfo();

        for (Product product : productsInfos) {

            ProductCategory category = dao.getCategoryInfo(product.getCategoryKey());
            product.setProductCategory(category);

            ArrayList<ProductImage> images = (ArrayList<ProductImage>) dao.getProductImages(product.getProdKey());
            product.setProductImages(images);
        }

        return productsInfos;
    }

    public ArrayList<ProductCategory> getAllCategoryInfos() {
        return (ArrayList<ProductCategory>) dao.getAllCategoryInfos();
    }

    public int numberOfUnCheckedPost() {
        return dao.numberOfUnCheckedPost();
    }

    public int numberOfUnCheckedNewUser() {
        return dao.numberOfUncheckedNewUser();
    }

    public int uploadYoutube(Youtube youtube) {
        return dao.uploadYoutube(youtube);
    }

    public ArrayList<ProductCategory> selectLowerCategoryLevel(String higherCategoryKey) {
        return (ArrayList<ProductCategory>) dao.selectLowerCategoryLevel(higherCategoryKey);
    }

    public ArrayList<Product> searchProductName(String currentInputValue) {
        return (ArrayList<Product>) dao.searchProductName(currentInputValue);
    }
}
