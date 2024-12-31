package com.khedu.sooljura.usermypage.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.khedu.sooljura.user.model.vo.User;

@Repository("userMyPageDao")
public class UserMyPageDao {

	@Autowired
    @Qualifier("sqlSessionTemplate")
    private SqlSessionTemplate sqlSessionTemplate;

	//비밀번호 변경
	public int pwChg(User user) {
		return sqlSessionTemplate.update("userMyPage.pwChg", user);
	}

	//회원탈퇴
	public int delUser(String userKey) {
		return sqlSessionTemplate.delete("userMyPage.delUser", userKey);
	}
}
