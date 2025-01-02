package com.khedu.sooljura.admin.controller;

import com.google.gson.Gson;
import com.khedu.sooljura.admin.model.service.AdminService;
import com.khedu.sooljura.admin.model.vo.Product;
import com.khedu.sooljura.admin.model.vo.ProductCategory;
import com.khedu.sooljura.admin.model.vo.ProductImage;
import com.khedu.sooljura.admin.model.vo.Youtube;
import com.khedu.sooljura.chat.model.service.ChatService;
import com.khedu.sooljura.chat.model.vo.Room;
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
import javax.servlet.http.HttpSession;
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

    private final AdminService adminService;
    private final ChatService chatService;

    public AdminController(@Qualifier("adminService") AdminService adminService, @Qualifier("chatService") ChatService chatService) {
        this.adminService = adminService;
        this.chatService = chatService;
    }

    @GetMapping("adminPage.do")
    public String adminPage(HttpSession session, Model model, String uploadYoutubeResult) {
        int numberOfUnCheckedPost = adminService.numberOfUnCheckedPost();
        model.addAttribute("numberOfUnCheckedPost", numberOfUnCheckedPost);

        int numberOfUnCheckedNewUser = adminService.numberOfUnCheckedNewUser();
        model.addAttribute("numberOfUnCheckedNewUser", numberOfUnCheckedNewUser);

        User loginAdmin = (User) session.getAttribute("loginUser");
        String adminKey = loginAdmin.getUserKey();
        int selectUnreadChats = chatService.selectUnreadChats(adminKey);
        int selectChatsWithNoAdmin = chatService.selectChatsWithNoAdmin();

        int numberOfUnCheckedChats = selectUnreadChats + selectChatsWithNoAdmin;
        model.addAttribute("numberOfUnCheckedChats", numberOfUnCheckedChats);

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

        ArrayList<Product> products = adminService.getAllProductsInfo();
        model.addAttribute("products", products);

        ArrayList<ProductCategory> categoryList = adminService.getAllCategoryInfos();
        model.addAttribute("categoryList", categoryList);

        return "/admin/manageProducts";
    }

    @GetMapping("manageYoutube.do")
    public String manageYoutube(String uploadYoutubeResult, Model model) {

        if (uploadYoutubeResult != null) {
            model.addAttribute("uploadYoutubeResult", uploadYoutubeResult);
        }

        Youtube youtube = adminService.selectYoutubeUrl();
        if (youtube != null) {
            model.addAttribute("youtube", youtube);

            ProductImage prod1 = adminService.selectProductImageInfo(youtube.getProdKey1());
            model.addAttribute("prod1", prod1);

            if (youtube.getProdKey2() != null) {
                ProductImage prod2 = adminService.selectProductImageInfo(youtube.getProdKey2());
                model.addAttribute("prod2", prod2);
            }

            if (youtube.getProdKey3() != null) {
                ProductImage prod3 = adminService.selectProductImageInfo(youtube.getProdKey3());
                model.addAttribute("prod3", prod3);
            }
        }

        return "/admin/manageYoutube";
    }

    @GetMapping("uploadYoutube")
    public String uploadYoutube(Youtube youtube) {
        int result = adminService.uploadYoutube(youtube);
        return "forward:/admin/adminPage.do?uploadYoutubeResult=" + result;
    }

    @GetMapping("managePosts.do")
    public String managePosts() {
        return "/admin/managePosts";
    }

    @GetMapping("manageChats.do")
    public String manageChats(Model model) {
        Room room = new Room();
        room.setUserKey("admin");
        ArrayList<Room> roomList = chatService.getRoomList(room);
        model.addAttribute("roomList", roomList);
        return "/admin/manageChats";
    }

    @GetMapping("manageLevel.do")
    public String manageLevel(Model model) {
        ArrayList<User> userList = adminService.selectAllUserForLevelChange();

        for (int i = 0; userList != null && i < userList.size(); i++) {
            userList.get(i).setPostCnt(adminService.selectUserPostCnt(userList.get(i).getUserKey()));
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
        int uploadProductResult = adminService.uploadProduct(product, imageList);

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
        int manageCategoryResult = adminService.createCategory(category);
        return "redirect:/admin/manageProducts.do?manageCategoryResult=" + manageCategoryResult;
    }

    @GetMapping(value = "selectLowerCategoryLevel", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public String selectLowerCategoryLevel(String higherCategoryKey) {
        ArrayList<ProductCategory> lowerCategories = adminService.selectLowerCategoryLevel(higherCategoryKey);

        Gson gson = new Gson();

        return gson.toJson(lowerCategories);
    }

    @GetMapping(value = "searchProductName", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public String searchProductName(String currentInputValue) {

        ArrayList<Product> productList = adminService.searchProductName(currentInputValue);

        Gson gson = new Gson();

        return gson.toJson(productList);
    }

    @GetMapping("changeUserLevel")
    @ResponseBody
    public int changeUserLevel(String userKeyString, String userCdString) {

        String[] userKeyArr = userKeyString.split(",");
        String[] userCdArr = userCdString.split(",");

        return adminService.changeUserLevel(userKeyArr, userCdArr);
    }

}
