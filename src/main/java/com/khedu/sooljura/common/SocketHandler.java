package com.khedu.sooljura.common;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.khedu.sooljura.chat.model.service.ChatService;
import com.khedu.sooljura.chat.model.vo.Chat;
import org.springframework.beans.factory.annotation.Autowired;
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

@Component("socketHandler") // applicationContext.xml 에 등록한 handler 이름
public class SocketHandler extends TextWebSocketHandler {

    @Autowired
    @Qualifier("chatService")
    private ChatService service;

    private ArrayList<WebSocketSession> user;
    private HashMap<String, WebSocketSession> map;
    private HashMap<String, HashMap<String, WebSocketSession>> roomMap;

    public SocketHandler() {
        user = new ArrayList<>();
        roomMap = new HashMap<>();
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
            //최초 연결 시, 연결 정보 등록
            String memberId = jsonObj.get("memberId").getAsString();
            String roomId = jsonObj.get("roomId").getAsString();

            /*
             * 메세지 전송 시, 연결되어 있는 모든 세션에 메시지를 전송함.
             * 현재 방에 접속한 세션들에게만 메시지를 전송해야 하므로,
             * 방별로 세션 정보들을 관리
             */
            if (roomMap.containsKey(roomId)) {
                map = roomMap.get(roomId);

                map.put(memberId, session);
            } else {
                map = new HashMap<String, WebSocketSession>();
                map.put(memberId, session);
                roomMap.put(roomId, map);
            }

        } else if (type.equals("chat")) {
            // 메시지 송신
            String roomId = jsonObj.get("roomId").getAsString();
            String memberId = jsonObj.get("memberId").getAsString();
            String msg = jsonObj.get("msg").getAsString();
            String fileName = jsonObj.get("fileName") != null ? jsonObj.get("fileName").getAsString() : null;
            String filePath = jsonObj.get("filePath") != null ? jsonObj.get("filePath").getAsString() : null;

            Chat chat = new Chat();
            chat.setRoomKey(roomId);
            chat.setSenderId(memberId);
            chat.setMsg(msg);

            // DB 등록
            int result = service.insertChat(chat);

            if (result > 0) {
                // 파일 등록 시, 다운로드 가능하도록 텍스트 처리
                if (filePath != null) {
                    msg = "<a href='javascript:void(0)' onclick='fn.chatFileDown(\"" + fileName + "\", \"" + filePath + "\")'>" + fileName + "</a> " + msg;
                }

                msg = memberId + " : " + msg;
                this.sendMsg(roomId, msg);
            }
        } else if (type.equals("delete")) {
            String memberId = jsonObj.get("memberId").getAsString();
            String roomId = jsonObj.get("roomId").getAsString();

            map = roomMap.get(roomId);

            if (map.containsKey(memberId)) {
                // 현재 방에서 나가기
                map.remove(memberId);

                Chat chat = new Chat();
                chat.setRoomKey(roomId);
                chat.setSenderId(memberId);
                service.deleteRoom(chat);

                // 방에서 나간 뒤, 아무도 없으면 방 관리 Map 에서도 삭제.
                if (map.isEmpty()) {
                    roomMap.remove(roomId);
                }
            }
        }
    }

    // 연결된 사용자들에게 메세지 전송
    public void sendMsg(String roomId, String msg) {
        map = roomMap.get(roomId);

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
