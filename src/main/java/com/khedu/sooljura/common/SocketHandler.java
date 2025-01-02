package com.khedu.sooljura.common;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.khedu.sooljura.chat.model.service.ChatService;
import com.khedu.sooljura.chat.model.vo.Chat;
import com.khedu.sooljura.user.model.vo.User;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Set;

// applicationContext.xml 에 등록한 handler 이름
@Component("socketHandler")
public class SocketHandler extends TextWebSocketHandler {

    private final ArrayList<WebSocketSession> user;
    private final HashMap<String, HashMap<String, WebSocketSession>> roomMap;

    private final ChatService service;
    private HashMap<String, WebSocketSession> map;

    public SocketHandler(@Qualifier("chatService") ChatService service) {
        user = new ArrayList<>();
        roomMap = new HashMap<>();
        this.service = service;
    }

    // 소켓이 생성되어 연결되었을 때 실행되는 메소드
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        System.out.println("연결 성공");
        user.add(session); // 신규 접속자 정보 저장
    }

    // 메세지를 송신 시 동작하는 메소드
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {

        // 수신 받은 메시지 형식 == Json 형식 => 파싱 처리
        JsonParser parser = new JsonParser();
        JsonElement element = parser.parse(message.getPayload());
        JsonObject jsonObj = element.getAsJsonObject();
        String type = jsonObj.get("type").getAsString();

        if (type.equals("connect")) {
            // 최초 연결 시, 연결 정보 등록
            String userKey = jsonObj.get("userKey").getAsString();
            String roomKey = jsonObj.get("roomKey").getAsString();

            /*
             * 메세지 전송 시, 연결되어 있는 모든 세션에 메시지를 전송함.
             * 현재 방에 접속한 세션들에게만 메시지를 전송해야 하므로,
             * 방별로 세션 정보들을 관리
             */
            if (roomMap.containsKey(roomKey)) {
                map = roomMap.get(roomKey);

                map.put(userKey, session);
            } else {
                map = new HashMap<>();
                map.put(userKey, session);
                roomMap.put(roomKey, map);
            }

        } else if (type.equals("chat")) {
            // 메시지 송신
            String roomKey = jsonObj.get("roomKey").getAsString();
            String userKey = jsonObj.get("userKey").getAsString();
            String userCd = jsonObj.get("userCd").getAsString();
            String msg = jsonObj.get("msg").getAsString();

            Chat chat = new Chat();
            chat.setRoomKey(roomKey);
            chat.setSenderKey(userKey);
            chat.setMsg(msg);

            // DB 등록
            int result = service.insertChat(chat);

            if (result > 0) {
                User adminPresence = service.checkAdminPresence(roomKey);
                if(adminPresence == null && userCd.equals("0")){
                    int insertAdmin = service.insertAdmin(roomKey, userKey);
                    if(insertAdmin == 0){
                        System.out.println("=== from SocketHandler ===");
                        System.out.println("Failed to add admin");
                    }
                }
            }
        } else if (type.equals("delete")) {
            String roomKey = jsonObj.get("roomKey").getAsString();
            String userKey = jsonObj.get("userKey").getAsString();

            map = roomMap.get(roomKey);

            if (map.containsKey(userKey)) {
                // 현재 방에서 나가기
                map.remove(userKey);

                Chat chat = new Chat();
                chat.setRoomKey(roomKey);
                chat.setSenderKey(userKey);
                service.deleteRoom(chat);

                // 방에서 나간 뒤, 아무도 없으면 방 관리 Map 에서도 삭제.
                if (map.isEmpty()) {
                    roomMap.remove(roomKey);
                }
            }
        }
    }

    // 연결된 사용자들에게 메세지 전송
    public void sendMsg(String roomKey, String msg) {
        map = roomMap.get(roomKey);

        Set<String> set = map.keySet();

        for (String key : set) {
            WebSocketSession ws = map.get(key);

            if (ws != null) {
                try {
                    ws.sendMessage(new TextMessage(msg));
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    // 연결 종료
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        System.out.println("연결 종료");
        user.remove(session);
    }

}
