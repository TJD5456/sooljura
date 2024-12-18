package com.khedu.sooljura.admin.controller;

import com.khedu.sooljura.admin.model.service.AdminService;
import com.khedu.sooljura.admin.model.vo.Product;
import com.khedu.sooljura.admin.model.vo.ProductImage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Random;

@Controller
@RequestMapping("/admin/")
public class AdminController {

    @Autowired
    @Qualifier("adminService")
    private AdminService service;

    @GetMapping("adminPage.do")
    public String adminPage() {
        return "/admin/adminPage";
    }

    @GetMapping("manageProducts.do")
    public String manageProducts() {
        return "/admin/manageProducts";
    }

    @GetMapping("manageYoutube.do")
    public String manageYoutube() {
        return "/admin/manageYoutube";
    }

    @GetMapping("managePosts.do")
    public String managePosts() {
        return "/admin/managePosts";
    }

    @GetMapping("manageChats.do")
    public String manageChats() {
        return "/admin/manageChats";
    }

    @GetMapping("manageLevel.do")
    public String manageLevel() {
        return "/admin/manageLevel";
    }

    @PostMapping("uploadProduct")
    public String uploadProduct(HttpServletRequest request, MultipartFile[] images, Product product) {
        ArrayList<ProductImage> imgList = new ArrayList<>();

        for (MultipartFile prodImg : images) {
            if (!prodImg.isEmpty()) {
                String savePath = request.getSession().getServletContext().getRealPath("/resources/upload/productImages/");
                String originalFileName = prodImg.getOriginalFilename();
                String fileName = originalFileName.substring(0, originalFileName.lastIndexOf("."));
                String extension = originalFileName.substring(originalFileName.lastIndexOf("."));

                String toDay = new SimpleDateFormat("yyyyMMdd").format(new Date());
                int ranNum = new Random().nextInt(10000) + 1;
                String filePath = fileName + "_" + toDay + "_" + ranNum + extension;

                savePath += filePath;

                BufferedOutputStream bos = null;

                try {
                    byte[] bytes = prodImg.getBytes();
                    FileOutputStream fos = new FileOutputStream(new File(savePath));
                    bos = new BufferedOutputStream(fos);
                    bos.write(bytes);

                    ProductImage productImage = new ProductImage();
                    productImage.setImgNm(originalFileName);
                    productImage.setImgPath(filePath);

                    imgList.add(productImage);

                } catch (IOException e) {
                    System.out.println("IOException from AdminController.uploadProduct while handling bos");
                } finally {
                    try {
                        if (bos != null) {
                            bos.close();
                        }
                    } catch (IOException e) {
                        System.out.println("IOException from AdminController.uploadProduct while closing bos");
                    }
                }
            }
        }
        int result = service.uploadProduct(product, imgList);

        if (result == 1) {
            return "redirect:/admin/adminPage.do";
        } else {
            return "redirect:/admin/manageProducts.do";
        }
    } // uploadProduct()

}
