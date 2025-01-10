package com.khedu.sooljura.main.controller;

import java.util.ArrayList;
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

	@Autowired
	@Qualifier("mainService")
	private MainService service;
	
	@GetMapping("/")
    public String main(Model model) {
        
        ArrayList<Product> wineProdList = service.getWine();
        ArrayList<Product> whiskeyProdList = service.getWhiskey();
        ArrayList<Product> brandyProdList = service.getBrandy();
        ArrayList<Product> liqueurProdList = service.getLiqueur();
        ArrayList<Product> sojuProdList = service.getSoju();
        ArrayList<Product> etcProdList = service.getEtc();
        
        Youtube youtube = service.chkYt();
        String url = youtube.getYoutubeUrl();
        model.addAttribute("youtube", url);
        
        
        model.addAttribute("brandyProdList", brandyProdList);
        model.addAttribute("liqueurProdList", liqueurProdList);
        model.addAttribute("etcProdList", etcProdList);
        model.addAttribute("sojuProdList", sojuProdList);
        model.addAttribute("wineProdList", wineProdList);
        model.addAttribute("whiskeyProdList", whiskeyProdList);
        return "main/mainPage";
    }
}
