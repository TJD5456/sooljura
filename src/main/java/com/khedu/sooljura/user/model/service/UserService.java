package com.khedu.sooljura.user.model.service;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.khedu.sooljura.user.model.dao.UserDao;
import com.khedu.sooljura.user.model.vo.AddrListData;
import com.khedu.sooljura.user.model.vo.User;
import com.khedu.sooljura.user.model.vo.UserAddr;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;

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

	public HashMap chkInfo(String impUid) {
		HashMap<String, String> map = new HashMap<>();
		
		String impKey="6722455646321763";//내 키
		String impSecret = "Ojr32rXtP8Iobe8wEJN9U5x1SCDOM5JkdrZwBhGoSj9F3yd6PFCK5t1Rp63T1Yoeo6FuZj9DsJzB8P8P";
		String strUrl = "https://api.iamport.kr/users/getToken"; // 토큰 요청 보낼 주소
		String accessToken = "";
		String phone = "";//전화번호
		String name = "";//이름
		
		try {
			URL url = new URL(strUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection(); // url Http 연결 생성

			// POST 요청
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);// outputStream으로 post 데이터를 넘김

			conn.setRequestProperty("content-Type", "application/json");
			conn.setRequestProperty("Accept", "application/json");

			// 파라미터 세팅
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));

			JSONObject requestData = new JSONObject();
			requestData.put("imp_key", impKey);
			requestData.put("imp_secret", impSecret);
			
			bw.write(requestData.toString());
			bw.flush();
			bw.close();

			int resposeCode = conn.getResponseCode();

			System.out.println("응답코드 : " + resposeCode);
            
            if (resposeCode == 200) {// 성공이면 빼낼 로직 
            	BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            	StringBuilder sb = new StringBuilder();
            	String line;
            	while ((line = br.readLine()) != null) {
            	    sb.append(line + "\n");
            	}

            	// sb.toString()에는 전체 데이터를 문자열로 보유
            	System.out.println(sb.toString());
            	br.close();
            	
            	String jsonString = sb.toString();

            	JsonObject keys = (JsonObject) JsonParser.parseString(jsonString.toString());
            	JsonArray keyArray = (JsonArray) keys.get("keys");
            	
            	

            	// JSON 데이터 처리
            	accessToken = JsonObject.asd;
//            			("response").getString("access_token");
            	System.out.println("Access Token: " + accessToken);
            }
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return null;
	}	
}
