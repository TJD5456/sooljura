package com.khedu.sooljura.common.controller;

import com.khedu.sooljura.admin.model.service.AdminService;
import com.khedu.sooljura.admin.model.vo.Product;
import com.khedu.sooljura.admin.model.vo.ProductImage;
import com.khedu.sooljura.admin.model.vo.Youtube;
import com.khedu.sooljura.common.model.service.CommonService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class CommonController {

    private final CommonService service;
    private final AdminService adminService;


    public CommonController(CommonService service, AdminService adminService) {
        this.service = service;
        this.adminService = adminService;
    }

    @GetMapping("/")
    public String startup(Model model) {
        ArrayList<Product> prodList = service.sel5EachCat();
        if (prodList != null && !prodList.isEmpty()) {
            // Map to group products by higher category
            Map<String, List<Product>> categoryMap = new HashMap<>();

            // Group products by category
            for (Product p : prodList) {
                String higherCatKey = p.getHigherCategory();
                categoryMap.computeIfAbsent(higherCatKey, k -> new ArrayList<>()).add(p);
            }

            // Add categorized lists to the model
            model.addAttribute("wineProdList", categoryMap.getOrDefault("c0001", new ArrayList<>()));
            model.addAttribute("whiskeyProdList", categoryMap.getOrDefault("c0002", new ArrayList<>()));
            model.addAttribute("brandyProdList", categoryMap.getOrDefault("c0003", new ArrayList<>()));
            model.addAttribute("liqueurProdList", categoryMap.getOrDefault("c0004", new ArrayList<>()));
            model.addAttribute("sojuProdList", categoryMap.getOrDefault("c0005", new ArrayList<>()));
            model.addAttribute("etcProdList", categoryMap.getOrDefault("c0006", new ArrayList<>()));
        }

            Youtube youtube = adminService.selectYoutubeUrl();
            model.addAttribute("chkYt", youtube.getYoutubeUrl());
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
        return "index";
    }

    @GetMapping("/common/webPageInfo.do")
    public String webPageInfo() {
        return "post/webPageInfo";
    }

    @GetMapping("/common/commonGuide.do")
    public String CommonGuide() {
        return "common/guide";
    }

    @GetMapping("/common/commonPrivacy.do")
    public String CommonPrivacy() {
        return "common/privacy";
    }

    @GetMapping("/common/commonTerms.do")
    public String CommonTerms() {
        return "common/terms";
    }

    @ExceptionHandler(Exception.class)
    public String handleAllExceptions(Exception e, Model model) {
        model.addAttribute("errorMessage", "예기치 못한 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
        e.printStackTrace();
        return "common/error";
    }

}
