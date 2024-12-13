package com.khedu.sooljura.admin.controller;

import com.khedu.sooljura.admin.model.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/")
public class AdminController {

    @Autowired
    @Qualifier("adminService")
    private AdminService adminService;

    @GetMapping("adminPage.do")
    public String adminPage() {
        return "adminPage";
    }
}
