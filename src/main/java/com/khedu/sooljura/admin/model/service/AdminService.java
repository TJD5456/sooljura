package com.khedu.sooljura.admin.model.service;

import com.khedu.sooljura.admin.model.dao.AdminDao;
import com.khedu.sooljura.admin.model.vo.Product;
import com.khedu.sooljura.admin.model.vo.ProductCategory;
import com.khedu.sooljura.admin.model.vo.ProductImage;
import com.khedu.sooljura.admin.model.vo.Youtube;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Service("adminService")
public class AdminService {

    @Autowired
    @Qualifier("adminDao")
    private AdminDao dao;

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

    public int uploadYoutube(Youtube youtube) {
        return dao.uploadYoutube(youtube);
    }

    public ArrayList<Product> getAllProductsInfo() {
        return (ArrayList<Product>) dao.getAllProductsInfo();
    }
}
