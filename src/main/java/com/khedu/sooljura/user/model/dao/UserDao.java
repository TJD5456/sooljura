package com.khedu.sooljura.user.model.dao;

import com.khedu.sooljura.user.model.vo.User;
import com.khedu.sooljura.user.model.vo.UserAddr;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository("userDao")
public class UserDao {
    @Autowired
    @Qualifier("sqlSessionTemplate")
    private SqlSessionTemplate sessionTemplate;

    //로그인
    public User login(User user) {
        return sessionTemplate.selectOne("user.userLogin", user);
    }

    //회원가입
    public int join(User user) {
        return sessionTemplate.insert("user.userJoin", user);
    }

    //아이디 중복체크
    public int chkId(String userId) {
        return sessionTemplate.selectOne("user.chkId", userId);
    }

    //닉네임 중복체크
    public int chkNickname(String userNickNm) {
        return sessionTemplate.selectOne("user.chkNickName", userNickNm);
    }

    //주소지 추가
    public int addAddr(UserAddr userAddr) {
        return sessionTemplate.insert("addr.addAddrInfo", userAddr);
    }

    //주소 리스트 조회
    public List<UserAddr> addrList(String userKey) {
        return sessionTemplate.selectList("addr.userAddrList", userKey);
    }

    //주소 삭제
    public int delAddr(String addrKey) {
        return sessionTemplate.delete("addr.deleteAddr", addrKey);
    }

    //주소 정보 조회
    public UserAddr userAddr(String addrKey) {
        return sessionTemplate.selectOne("addr.addrInfo", addrKey);
    }

    //주소지 변경
    public int updAddr(UserAddr userAddr) {
        return sessionTemplate.update("addr.updAddr", userAddr);
    }

    //주소지 defaultYn 변경
    public int setDefaultYn(UserAddr userAddr) {
        return sessionTemplate.update("addr.setDefaultYn", userAddr);
    }

    //회원가입시 주소지에 값을 넣기 위한 userKey 찾기
    public String findUserKey(String userId) {
        return sessionTemplate.selectOne("user.findUserKey", userId);
    }

    //회원가입시 주소지 입력한 경우 주소지 DB에 넣기
    public int joinAddr(UserAddr userAddr) {
        return sessionTemplate.insert("addr.joinAddr", userAddr);
    }

    //결제를 위한 defaultAddr 값 가져오기
    public UserAddr findDefaultAddr(String userKey) {
        UserAddr userAddr = sessionTemplate.selectOne("addr.findDefaultAddr", userKey);
        return userAddr;
    }

    public int insertTestAccount(User u) {
        return sessionTemplate.insert("user.insertTestAccount", u);
    }

    public String idFind(HashMap<String, String> map) {
        return sessionTemplate.selectOne("user.idFind", map);
    }

    public int intIdFind(HashMap<String, String> map) {
        return sessionTemplate.selectOne("user.intIdFind", map);
    }
}
