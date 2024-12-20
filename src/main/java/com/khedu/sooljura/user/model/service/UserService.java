package com.khedu.sooljura.user.model.service;

import java.util.ArrayList;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.khedu.sooljura.user.model.dao.UserDao;
import com.khedu.sooljura.user.model.vo.AddrListData;
import com.khedu.sooljura.user.model.vo.User;
import com.khedu.sooljura.user.model.vo.UserAddr;

@Service("userService")
public class UserService {
	@Autowired
	@Qualifier("userDao")
	private UserDao dao;

	//로그인
	public User login(User user) {
		 User loginUser = dao.login(user);
		 
		 if(loginUser == null) {
			 //일치하는 아이디 없음
			 return null;
		 }else {		
			 //비밀번호 bcrypt로 확인
			 boolean chkpw = BCrypt.checkpw(user.getUserPw(), loginUser.getUserPw());
			 
			 if(chkpw) {
				 //일치하면 넘겨주기
				 return loginUser;
			 }else {
				 //비밀번호 다르면 null
				 return null;
			 }
		 }
	}

	//회원가입
	public int join(User user) {
		String userPw = BCrypt.hashpw(user.getUserPw(), BCrypt.gensalt());
		user.setUserPw(userPw);
		
		return dao.join(user);
	}

	//아이디 중복체크
	public int chkId(String userId) {
		return dao.chkId(userId);
	}

	//닉네임 중복체크
	public int chkNickname(String userNickname) {
		return dao.chkNickname(userNickname);
	}

	//주소지 추가
	public int addAddr(UserAddr userAddr) {
		return dao.addAddr(userAddr);
	}

	//주소지 목록 불러오기
	public AddrListData addrList(String userKey) {
		ArrayList<UserAddr> addrList = (ArrayList<UserAddr>) dao.addrList(userKey);
		
		AddrListData listData = new AddrListData(addrList);
		return listData;
	}

	//주소지 삭제
	public int delAddr(String addrKey) {
		return dao.delAddr(addrKey);
	}

	//주소지 수정을 위한 조회
	public UserAddr userAddr(String addrKey) {
		UserAddr userAddr = dao.userAddr(addrKey);
		
		return userAddr;
	}

	//주소지 수정
	public int updAddr(UserAddr userAddr) {
		return dao.updAddr(userAddr);
	}

	//기존 defaultYn값 수정
	public int setDefaultYn(UserAddr userAddr) {
		return dao.setDefaultYn(userAddr);
	}
}
