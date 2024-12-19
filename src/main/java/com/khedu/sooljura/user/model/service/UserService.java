package com.khedu.sooljura.user.model.service;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.khedu.sooljura.user.model.dao.UserDao;
import com.khedu.sooljura.user.model.vo.User;

@Service("userService")
public class UserService {
	@Autowired
	@Qualifier("userDao")
	private UserDao dao;

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

	public int join(User user) {
		String userPw = BCrypt.hashpw(user.getUserPw(), BCrypt.gensalt());
		user.setUserPw(userPw);
		
		return dao.join(user);
	}

	public int chkId(String userId) {
		return dao.chkId(userId);
	}

	public int chkNickname(String userNickname) {
		return dao.chkNickname(userNickname);
	} 
}
