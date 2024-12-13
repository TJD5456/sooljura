package com.khedu.sooljura.admin.model.service;

import com.khedu.sooljura.admin.model.dao.AdminDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service("adminService")
public class AdminService {

    @Autowired
    @Qualifier("adminDao")
    private AdminDao adminDao;
}
