package com.khedu.sooljura.usermypage.model.service;

import com.khedu.sooljura.usermypage.model.dao.UserMyPageDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service("userMyPageService")
public class UserMyPageService {

	@Autowired
    @Qualifier("userMyPageDao")
    private UserMyPageDao userMyPageDao;
}
