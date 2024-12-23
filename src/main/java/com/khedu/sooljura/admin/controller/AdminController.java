package com.khedu.sooljura.admin.controller;

import com.khedu.sooljura.admin.model.service.AdminService;
import com.khedu.sooljura.admin.model.vo.Product;
import com.khedu.sooljura.admin.model.vo.ProductCategory;
import com.khedu.sooljura.admin.model.vo.ProductImage;
import com.khedu.sooljura.admin.model.vo.Youtube;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
    public String manageProducts(Integer uploadProductResult, Integer manageCategoryResult, Model model) {
        if (uploadProductResult != null) {
            model.addAttribute("uploadProductResult", uploadProductResult);
        } else if (manageCategoryResult != null) {
            model.addAttribute("manageCategoryResult", manageCategoryResult);
        }

        ArrayList<Product> products = service.getAllProductsInfo();
        model.addAttribute("products", products);

        ArrayList<ProductCategory> categoryList = service.getAllCategoryInfos();

        model.addAttribute("categoryList", categoryList);

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

    public String savePath(HttpServletRequest request) {
        String savePath = request.getSession().getServletContext().getRealPath("/resources/upload/product_images/");

        if (savePath.contains("target")) {
            savePath = savePath.replace("\\target\\sooljura-1.0.0-BUILD-SNAPSHOT", "\\src\\main\\webapp");
        }

        File dir = new File(savePath);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        return savePath;
    }

    @PostMapping("uploadProduct")
    public String uploadProduct(HttpServletRequest request, MultipartFile[] prodImages, Product product) {
        ArrayList<ProductImage> imageList = new ArrayList<>();

        String savePath = savePath(request);

        for (MultipartFile image : prodImages) {
            if (!image.isEmpty()) {
                String originalFileName = image.getOriginalFilename();
                String fileName = originalFileName.substring(0, originalFileName.lastIndexOf("."));
                String extension = originalFileName.substring(originalFileName.lastIndexOf("."));

                String toDay = new SimpleDateFormat("yyyyMMdd").format(new Date());
                int ranNum = new Random().nextInt(10000) + 1;
                String filePath = fileName + "_" + toDay + "_" + ranNum + extension;

                savePath += filePath;

                BufferedOutputStream bos = null;

                try {
                    byte[] bytes = image.getBytes();
                    FileOutputStream fos = new FileOutputStream(new File(savePath));
                    bos = new BufferedOutputStream(fos);
                    bos.write(bytes);

                    ProductImage productImage = new ProductImage();
                    productImage.setImgNm(originalFileName);
                    productImage.setImgPath(filePath);

                    imageList.add(productImage);

                } catch (IOException e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (bos != null) {
                            bos.close();
                        }
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        int uploadProductResult = service.uploadProduct(product, imageList);

        if (uploadProductResult > 0) {
            return "redirect:/admin/manageProducts.do";
        } else {
            return "redirect:/admin/manageProducts.do?uploadProductResult=" + uploadProductResult;
        }
    } // uploadProduct()

    @GetMapping("manageCategoryFrm")
    public String manageCategoryFrm() {
        return "/admin/manageCategory";
    }

    @GetMapping("manageCategory")
    public String manageCategory(ProductCategory category) {
        int manageCategoryResult = service.createCategory(category);
        return "redirect:/admin/manageProducts.do?manageCategoryResult=" + manageCategoryResult;
    }

    @GetMapping("uploadYoutube")
    public String uploadYoutube(Youtube youtube) {
        int result = service.uploadYoutube(youtube);
        return "redirect:/admin/uploadYoutube.do?uploadYoutubeResult=" + result;
    }

}
