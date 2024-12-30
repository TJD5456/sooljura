package com.khedu.sooljura.admin.controller;

import com.google.gson.Gson;
import com.khedu.sooljura.admin.model.service.AdminService;
import com.khedu.sooljura.admin.model.vo.Product;
import com.khedu.sooljura.admin.model.vo.ProductCategory;
import com.khedu.sooljura.admin.model.vo.ProductImage;
import com.khedu.sooljura.admin.model.vo.Youtube;
import com.khedu.sooljura.user.model.vo.User;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
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

    private final AdminService service;

    public AdminController(@Qualifier("adminService") AdminService service) {
        this.service = service;
    }

    @GetMapping("adminPage.do")
    public String adminPage(Model model, String uploadYoutubeResult) {
        int numberOfUnCheckedPost = service.numberOfUnCheckedPost();
        model.addAttribute("numberOfUnCheckedPost", numberOfUnCheckedPost);

        int numberOfUnCheckedNewUser = service.numberOfUnCheckedNewUser();
        model.addAttribute("numberOfUnCheckedNewUser", numberOfUnCheckedNewUser);

        if (uploadYoutubeResult != null) {
            model.addAttribute("uploadYoutubeResult", uploadYoutubeResult);
        }

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
    public String manageYoutube(String uploadYoutubeResult, Model model) {

        if (uploadYoutubeResult != null) {
            model.addAttribute("uploadYoutubeResult", uploadYoutubeResult);
        }

        Youtube youtube = service.selectYoutubeUrl();

        ProductImage prod1 = service.selectProductImageInfo(youtube.getProdKey1());
        model.addAttribute("prod1", prod1);

        if (youtube.getProdKey2() != null) {
            ProductImage prod2 = service.selectProductImageInfo(youtube.getProdKey2());
            model.addAttribute("prod2", prod2);
        }

        if (youtube.getProdKey3() != null) {
            ProductImage prod3 = service.selectProductImageInfo(youtube.getProdKey3());
            model.addAttribute("prod3", prod3);
        }

        model.addAttribute("youtube", youtube);

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
    public String manageLevel(Model model) {
        ArrayList<User> userList = service.selectAllUserForLevelChange();

        for (int i = 0; userList != null && i < userList.size(); i++) {
            userList.get(i).setPostCnt(service.selectUserPostCnt(userList.get(i).getUserKey()));
        }

        model.addAttribute("userList", userList);
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
                String filePath = null;
                if (originalFileName != null) {
                    String fileName = originalFileName.substring(0, originalFileName.lastIndexOf("."));
                    String extension = originalFileName.substring(originalFileName.lastIndexOf("."));

                    String toDay = new SimpleDateFormat("yyyyMMdd").format(new Date());
                    int ranNum = new Random().nextInt(10000) + 1;
                    filePath = fileName + "_" + toDay + "_" + ranNum + extension;
                    savePath += filePath;
                }

                BufferedOutputStream bos = null;

                try {
                    byte[] bytes = image.getBytes();
                    FileOutputStream fos = new FileOutputStream(savePath);
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

    @GetMapping(value = "selectLowerCategoryLevel", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public String selectLowerCategoryLevel(String higherCategoryKey) {
        ArrayList<ProductCategory> lowerCategories = service.selectLowerCategoryLevel(higherCategoryKey);

        Gson gson = new Gson();

        return gson.toJson(lowerCategories);
    }

    @GetMapping("uploadYoutube")
    public String uploadYoutube(Youtube youtube) {
        int result = service.uploadYoutube(youtube);
        return "forward:/admin/adminPage.do?uploadYoutubeResult=" + result;
    }

    @GetMapping(value = "searchProductName", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public String searchProductName(String currentInputValue) {

        ArrayList<Product> productList = service.searchProductName(currentInputValue);

        Gson gson = new Gson();

        return gson.toJson(productList);
    }

    @GetMapping("changeUserLevel")
    @ResponseBody
    public int changeUserLevel(String userKeyString, String userCdString) {

        String[] userKeyArr = userKeyString.split(",");
        String[] userCdArr = userCdString.split(",");

        return service.changeUserLevel(userKeyArr, userCdArr);
    }

    @GetMapping("startChat")
    public String startChat() {
        return "";
    }

}
