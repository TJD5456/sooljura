package com.khedu.sooljura.common.controller;

import com.khedu.sooljura.common.model.service.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/common/")
public class CommonController {

    @Autowired
    @Qualifier("commonService")
    private CommonService service;

    @GetMapping("commonGuide.do")
    public String CommonGuide() {
        return "common/guide";
    }

    @GetMapping("commonPrivacy.do")
    public String CommonPrivacy() {
        return "common/privacy";
    }

    @GetMapping("commonTerms.do")
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
