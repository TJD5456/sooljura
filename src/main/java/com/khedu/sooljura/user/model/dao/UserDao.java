package com.khedu.sooljura.user.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.khedu.sooljura.user.model.vo.User;
import com.khedu.sooljura.user.model.vo.UserAddr;

@Repository("userDao")
public class UserDao {
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sessionTemplate;

	//로그인
	public User login(User user) {
		return sessionTemplate.selectOne("user.userLogin", user);
	}

	public int join(User user) {
		return sessionTemplate.insert("user.userJoin", user);
	}

	public int chkId(String userId) {
		return sessionTemplate.selectOne("user.chkId", userId);
	}

	public int chkNickname(String userNickname) {
		return sessionTemplate.selectOne("user.chkNickname", userNickname);
	}

	public int addAddr(UserAddr userAddr) {
		return sessionTemplate.insert("addr.addAddrInfo", userAddr);
	}

	public List<UserAddr> addrList(String userKey) {
		return sessionTemplate.selectList("addr.userAddrList", userKey);
	}
}
