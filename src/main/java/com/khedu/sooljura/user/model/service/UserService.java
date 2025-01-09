package com.khedu.sooljura.user.model.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.khedu.sooljura.user.model.dao.UserDao;
import com.khedu.sooljura.user.model.vo.AddrListData;
import com.khedu.sooljura.user.model.vo.User;
import com.khedu.sooljura.user.model.vo.UserAddr;

@Service("userService")
public class UserService {
    @Autowired
    @Qualifier("userDao")
    private UserDao dao;

    // 로그인
    public User login(User user) {
        User loginUser = dao.login(user);

        if (loginUser == null) {
            // 일치하는 아이디 없음
            return null;
        } else {
            // 비밀번호 bcrypt로 확인
            boolean chkpw = BCrypt.checkpw(user.getUserPw(), loginUser.getUserPw());

            if (chkpw) {
                // 일치하면 넘겨주기
                return loginUser;
            } else {
                // 비밀번호 다르면 null
                return null;
            }
        }
    }

    public HashMap<String, String> chkInfo(String impUid) {
        HashMap<String, String> map = new HashMap<String, String>();
        String impKey = "6722455646321763";// 내 키
        String impSecret = "Ojr32rXtP8Iobe8wEJN9U5x1SCDOM5JkdrZwBhGoSj9F3yd6PFCK5t1Rp63T1Yoeo6FuZj9DsJzB8P8P";
        String strUrl = "https://api.iamport.kr/users/getToken"; // 토큰 요청 보낼 주소
        String accessToken = "";
        String phone = "";// 전화번호
        String name = "";// 이름

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

            Map<String, Object> requestData = new HashMap<>();
            requestData.put("imp_key", impKey);
            requestData.put("imp_secret", impSecret);

            Gson gson = new Gson();
            String jsonRequest = gson.toJson(requestData);

            bw.write(jsonRequest);
            bw.flush();
            bw.close();

            int responseCode = conn.getResponseCode();

            System.out.println("POST 응답코드 : " + responseCode);

            if (responseCode == 200) {// 성공이면 빼낼 로직
                BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                StringBuilder sb = new StringBuilder();
                String line;
                while ((line = br.readLine()) != null) {
                    sb.append(line + "\n");
                }

                // sb.toString()에는 전체 데이터를 문자열로 보유
                br.close();

                String jsonString = sb.toString();

                // JsonElement로 변환
                JsonElement jsonElement = JsonParser.parseString(jsonString);

                // JsonObject로 캐스팅
                JsonObject jsonObject = jsonElement.getAsJsonObject();

                // response 객체에서 access_token 값 추출
                accessToken = jsonObject.getAsJsonObject("response").get("access_token").getAsString();

                String getCertificatUrl = "https://api.iamport.kr/certifications/" + impUid;
                URL certificatUrl = new URL(getCertificatUrl);
                HttpURLConnection certificatConn = (HttpURLConnection) certificatUrl.openConnection(); // "https://api.iamport.kr/certifications/"

                // GET 요청
                certificatConn.setRequestMethod("GET");
                certificatConn.setDoOutput(true);// outputStream으로 post 데이터를 넘김

                certificatConn.setRequestProperty("content-Type", "application/json");
                certificatConn.setRequestProperty("Authorization", "Bearer " + accessToken);

                int getResponseCode = certificatConn.getResponseCode();
                System.out.println("GET 응답코드 : " + getResponseCode);

                if (getResponseCode == 200) {
                    BufferedReader getBr = new BufferedReader(new InputStreamReader(certificatConn.getInputStream()));
                    StringBuilder getSb = new StringBuilder();
                    String getLine;
                    while ((getLine = getBr.readLine()) != null) {
                        getSb.append(getLine + "\n");
                    }
                    System.out.println("stream?");
                    getBr.close();

                    String response = getSb.toString();
                    System.out.println(response.toString());

                    JsonElement jsonElement1 = JsonParser.parseString(response);

                    JsonObject jsonObject1 = jsonElement1.getAsJsonObject();

                    phone = jsonObject1.getAsJsonObject("response").get("phone").getAsString();
                    map.put("phone", phone);
                    name = jsonObject1.getAsJsonObject("response").get("name").getAsString();
                    map.put("name", name);
                    String birthDay = jsonObject1.getAsJsonObject("response").get("birthday").getAsString();
                    map.put("birthDay", birthDay);
                    System.out.println(phone + " + " + name + " + " + birthDay);
                } else {
                    System.out.println("GET 에러코드 : " + getResponseCode);
                }
            } else {
                System.out.println("POST 에러코드 : " + responseCode);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        System.out.println("Phone : " + map.get("phone"));
        return map;
    }

    // 회원가입
    public int join(User user) {
        String userPw = BCrypt.hashpw(user.getUserPw(), BCrypt.gensalt());
        user.setUserPw(userPw);

        return dao.join(user);
    }

    // 아이디 중복체크
    public int chkId(String userId) {
        return dao.chkId(userId);
    }

    // 닉네임 중복체크
    public int chkNickname(String userNickNm) {
        return dao.chkNickname(userNickNm);
    }

    // 주소지 추가
    public int addAddr(UserAddr userAddr) {
        return dao.addAddr(userAddr);
    }

    // 주소지 목록 불러오기
    public AddrListData addrList(String userKey) {
        ArrayList<UserAddr> addrList = (ArrayList<UserAddr>) dao.addrList(userKey);

        AddrListData listData = new AddrListData(addrList);
        return listData;
    }
    
    //결제페이지에서 주소지 선택
  	public UserAddr selectAddr(String addrKey) {
  		return dao.selectAddr(addrKey);
  	}

    // 주소지 삭제
    public int delAddr(String addrKey) {
        return dao.delAddr(addrKey);
    }

    // 주소지 수정을 위한 조회
    public UserAddr userAddr(String addrKey) {
        UserAddr userAddr = dao.userAddr(addrKey);

        return userAddr;
    }

    // 주소지 수정
    public int updAddr(UserAddr userAddr) {
        return dao.updAddr(userAddr);
    }

    // 기존 defaultYn값 수정
    public int setDefaultYn(UserAddr userAddr) {
        return dao.setDefaultYn(userAddr);
    }

    // 회원가입시 주소지를 넣기 위한 유저코드 찾기
    public String findUserKey(String userId) {
        return dao.findUserKey(userId);
    }

    // 회원가입시 주소지 입력한 경우 주소지 DB에 넣기
    public int joinAddr(UserAddr userAddr) {
        return dao.joinAddr(userAddr);
    }

    // 결제를 위한 defaultAddr 값 가져오기
    public UserAddr findDefaultAddr(String userKey) {
        return dao.findDefaultAddr(userKey);
    }

    public int insertTestAccount(User u) {
        String userPw = BCrypt.hashpw(u.getUserPw(), BCrypt.gensalt());
        u.setUserPw(userPw);
        return dao.insertTestAccount(u);
    }

    public String idFind(String name, String phone) {
        HashMap<String, String> map = new HashMap<String, String>();
        map.put("name", name);
        map.put("phone", phone);

        return dao.idFind(map);
    }

    public int intIdFind(String name, String phone) {
        HashMap<String, String> map = new HashMap<String, String>();
        map.put("name", name);
        map.put("phone", phone);

        return dao.intIdFind(map);
    }

}
