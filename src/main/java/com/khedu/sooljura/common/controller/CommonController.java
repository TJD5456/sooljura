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

        if (service.chkProd() > 0) {
            ArrayList<Product> wineProdList    = service.getProdList("c0001");
            ArrayList<Product> whiskeyProdList = service.getProdList("c0002");
            ArrayList<Product> brandyProdList  = service.getProdList("c0003");
            ArrayList<Product> liqueurProdList = service.getProdList("c0004");
            ArrayList<Product> sojuProdList    = service.getProdList("c0005");
            ArrayList<Product> etcProdList     = service.getProdList("c0006");

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

            model.addAttribute("brandyProdList", brandyProdList);
            model.addAttribute("liqueurProdList", liqueurProdList);
            model.addAttribute("etcProdList", etcProdList);
            model.addAttribute("sojuProdList", sojuProdList);
            model.addAttribute("wineProdList", wineProdList);
            model.addAttribute("whiskeyProdList", whiskeyProdList);
        }

        return "index";
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
