package com.khedu.sooljura.user.model.service;

import com.khedu.sooljura.user.model.dao.UserDao;
import com.khedu.sooljura.user.model.vo.AddrListData;
import com.khedu.sooljura.user.model.vo.User;
import com.khedu.sooljura.user.model.vo.UserAddr;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

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
	public int chkNickname(String userNickNm) {
		return dao.chkNickname(userNickNm);
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

	//회원가입시 주소지를 넣기 위한 유저코드 찾기
	public String findUserKey(String userId) {
		return dao.findUserKey(userId);
	}

	//회원가입시 주소지 입력한 경우 주소지 DB에 넣기
	public int joinAddr(UserAddr userAddr) {
		return dao.joinAddr(userAddr);
	}

	//결제를 위한 defaultAddr 값 가져오기
	public UserAddr getDefaultAddr(String userKey) {
		return dao.getDefaultAddr(userKey);
	}	
}
