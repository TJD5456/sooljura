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


    @GetMapping("commonTerms.do")
    public String CommonTerms() {
        return "common/Terms";
    }

    @GetMapping("commonprivacy.do")
    public String Commonprivacy() {
        return "common/privacy";
    }

    @GetMapping("commonguide.do")
    public String Commonguide() {
        return "common/guide";
    }

    @ExceptionHandler(Exception.class)
    public String handleAllExceptions(Exception ex, Model model) {
        // 에러 메시지 설정
        model.addAttribute("errorMessage", "예기치 못한 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
        // 로그 출력 (선택 사항)
        ex.printStackTrace();
        return "common/error"; // /WEB-INF/views/common/error.jsp로 이동
    }
}
