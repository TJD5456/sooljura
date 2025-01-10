package com.khedu.sooljura.main.controller;

import java.util.ArrayList;

import com.khedu.sooljura.admin.model.service.AdminService;
import com.khedu.sooljura.admin.model.vo.ProductImage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.khedu.sooljura.admin.model.vo.Product;
import com.khedu.sooljura.admin.model.vo.Youtube;
import com.khedu.sooljura.main.model.service.MainService;

@Controller
public class MainController {

    private final MainService service;
    private final AdminService adminServ;

    public MainController(@Qualifier("mainService") MainService service,
                          @Qualifier("adminService") AdminService adminServ) {
        this.service = service;
        this.adminServ = adminServ;
    }

    @GetMapping("/")
    public String main(Model model) {

        ArrayList<Product> wineProdList = service.getWine();
        ArrayList<Product> whiskeyProdList = service.getWhiskey();
        ArrayList<Product> brandyProdList = service.getBrandy();
        ArrayList<Product> liqueurProdList = service.getLiqueur();
        ArrayList<Product> sojuProdList = service.getSoju();
        ArrayList<Product> etcProdList = service.getEtc();

        Youtube youtube = adminServ.selectYoutubeUrl();
        model.addAttribute("chkYt", youtube.getYoutubeUrl());
        if (youtube != null) {
            model.addAttribute("youtube", youtube);

            ProductImage prod1 = adminServ.selectProductImageInfo(youtube.getProdKey1());
            model.addAttribute("prod1", prod1);

            if (youtube.getProdKey2() != null) {
                ProductImage prod2 = adminServ.selectProductImageInfo(youtube.getProdKey2());
                model.addAttribute("prod2", prod2);
            }

            if (youtube.getProdKey3() != null) {
                ProductImage prod3 = adminServ.selectProductImageInfo(youtube.getProdKey3());
                model.addAttribute("prod3", prod3);
            }
        }

        model.addAttribute("brandyProdList", brandyProdList);
        model.addAttribute("liqueurProdList", liqueurProdList);
        model.addAttribute("etcProdList", etcProdList);
        model.addAttribute("sojuProdList", sojuProdList);
        model.addAttribute("wineProdList", wineProdList);
        model.addAttribute("whiskeyProdList", whiskeyProdList);

        return "main/mainPage";
    }
}
