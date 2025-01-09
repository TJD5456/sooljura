package com.khedu.sooljura.admin.controller;

import com.google.gson.Gson;
import com.khedu.sooljura.admin.model.service.AdminService;
import com.khedu.sooljura.admin.model.vo.Product;
import com.khedu.sooljura.admin.model.vo.ProductCategory;
import com.khedu.sooljura.admin.model.vo.ProductImage;
import com.khedu.sooljura.admin.model.vo.Youtube;
import com.khedu.sooljura.chat.model.service.ChatService;
import com.khedu.sooljura.chat.model.vo.Room;
import com.khedu.sooljura.post.model.service.PostService;
import com.khedu.sooljura.post.model.vo.PostPageData;
import com.khedu.sooljura.user.model.vo.User;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
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

    private final AdminService serv;
    private final ChatService cServ;
    private final PostService pServ;

    public AdminController(@Qualifier("adminService") AdminService adminService, @Qualifier("chatService") ChatService chatService, @Qualifier("postService") PostService postService) {
        this.serv = adminService;
        this.cServ = chatService;
        this.pServ = postService;
    }

    @GetMapping("adminPage.do")
    public String adminPage(HttpSession session, Model model, String uploadYoutubeResult) {
        int newPost = serv.selNewPost();
        model.addAttribute("newPost", newPost);

        int newUser = serv.newUser();
        model.addAttribute("newUser", newUser);

        User admin = (User) session.getAttribute("loginUser");
        String adminKey = admin.getUserKey();
        int unRead = cServ.selUnread(adminKey);
        int noAdmin = cServ.selNoAdmin();

        int newChat = unRead + noAdmin;
        model.addAttribute("newChat", newChat);

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

        ArrayList<Product> products = serv.getAllProductsInfo();
        model.addAttribute("products", products);

        ArrayList<ProductCategory> categoryList = serv.getAllCategoryInfos();
        model.addAttribute("categoryList", categoryList);

        return "/admin/manageProducts";
    }

    @GetMapping("manageYoutube.do")
    public String manageYoutube(String uploadYoutubeResult, Model model) {

        if (uploadYoutubeResult != null) {
            model.addAttribute("uploadYoutubeResult", uploadYoutubeResult);
        }

        Youtube youtube = serv.selectYoutubeUrl();
        if (youtube != null) {
            model.addAttribute("youtube", youtube);

            ProductImage prod1 = serv.selectProductImageInfo(youtube.getProdKey1());
            model.addAttribute("prod1", prod1);

            if (youtube.getProdKey2() != null) {
                ProductImage prod2 = serv.selectProductImageInfo(youtube.getProdKey2());
                model.addAttribute("prod2", prod2);
            }

            if (youtube.getProdKey3() != null) {
                ProductImage prod3 = serv.selectProductImageInfo(youtube.getProdKey3());
                model.addAttribute("prod3", prod3);
            }
        }

        return "/admin/manageYoutube";
    }

    @GetMapping("uploadYoutube")
    public String uploadYoutube(Youtube youtube) {
        int result = serv.uploadYoutube(youtube);
        return "forward:/admin/adminPage.do?uploadYoutubeResult=" + result;
    }

    @GetMapping("managePosts.do")
    public String managePosts(Model model) {
        int requestPostCd = 2;
        PostPageData postPageDataList = pServ.selectPostList(1, requestPostCd);
        model.addAttribute("postList", postPageDataList.getList());
        model.addAttribute("pageNavi", postPageDataList.getPageNavi());
        return "/admin/managePosts";
    }

    @GetMapping("manageChats.do")
    public String manageChats(HttpSession session, Model model) {
        User loginAdmin = (User) session.getAttribute("loginUser");
        ArrayList<Room> roomList = cServ.getRoomList(loginAdmin);
        model.addAttribute("roomList", roomList);
        return "/admin/manageChats";
    }

    @GetMapping("manageLevel.do")
    public String manageLevel(Model model) {
        ArrayList<User> userList = serv.selectAllUserForLevelChange();

        for (int i = 0; userList != null && i < userList.size(); i++) {
            userList.get(i).setPostCnt(serv.selectUserPostCnt(userList.get(i).getUserKey()));
        }

        model.addAttribute("userList", userList);
        return "/admin/manageLevel";
    }

    public String savePath() {
        RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
        if (requestAttributes == null) {
            throw new IllegalStateException("No request attributes found. This method must be called within an HTTP request scope.");
        }
        HttpServletRequest request = ((ServletRequestAttributes) requestAttributes).getRequest();

        String savePath = request.getSession().getServletContext().getRealPath("/resources/upload/productImages/");

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
    public String uploadProduct(MultipartFile[] prodImages, Product product) {
        ArrayList<ProductImage> imageList = new ArrayList<>();

        String savePath = savePath();

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
        int uploadProductResult = serv.uploadProduct(product, imageList);

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
        int manageCategoryResult = serv.createCategory(category);
        return "redirect:/admin/manageProducts.do?manageCategoryResult=" + manageCategoryResult;
    }

    @GetMapping(value = "selectLowerCategoryLevel", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public String selectLowerCategoryLevel(String higherCategoryKey) {
        ArrayList<ProductCategory> lowerCategories = serv.selectLowerCategoryLevel(higherCategoryKey);
        Gson gson = new Gson();
        return gson.toJson(lowerCategories);
    }

    @GetMapping(value = "searchProductName", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public String searchProductName(String currentInputValue) {
        ArrayList<Product> productList = serv.searchProductName(currentInputValue);
        Gson gson = new Gson();
        return gson.toJson(productList);
    }

    @GetMapping("changeUserLevel")
    @ResponseBody
    public int changeUserLevel(String userKeyString, String userCdString) {
        String[] userKeyArr = userKeyString.split(",");
        String[] userCdArr = userCdString.split(",");

        return serv.changeUserLevel(userKeyArr, userCdArr);
    }

}
