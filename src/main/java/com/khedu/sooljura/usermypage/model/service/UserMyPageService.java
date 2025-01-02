package com.khedu.sooljura.usermypage.model.service;

import com.khedu.sooljura.user.model.vo.User;
import com.khedu.sooljura.usermypage.model.dao.UserMyPageDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service("userMyPageService")
public class UserMyPageService {

    @Autowired
    @Qualifier("userMyPageDao")
    private UserMyPageDao userMyPageDao;

    //비밀번호 변경
    public int pwChg(User user) {
        return userMyPageDao.pwChg(user);
    }

    //회원탈퇴
    public int delUser(String userKey) {
        return userMyPageDao.delUser(userKey);
    }
}
