package com.khedu.sooljura.chat.model.service;

import com.khedu.sooljura.chat.model.dao.ChatDao;
import com.khedu.sooljura.chat.model.vo.Chat;
import com.khedu.sooljura.chat.model.vo.Room;
import com.khedu.sooljura.user.model.vo.User;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;

@Service("chatService")
public class ChatService {

    private final ChatDao dao;

    public ChatService(@Qualifier("chatDao") ChatDao dao) {
        this.dao = dao;
    }

    public int selectChatsWithNoAdmin() {
        return dao.selectChatsWithNoAdmin();
    }

    public int selectUnreadChats(String adminKey) {
        return dao.selectUnreadChats(adminKey);
    }

    public ArrayList<Room> getRoomList(User user) {
        return (ArrayList<Room>) dao.getRoomList(user);
    }

    public String createRoom(Room room) {
        String roomKey = dao.selectRoomKey(); //방 번호 조회
        room.setRoomKey(roomKey);

        int createRoomResult = dao.createRoom(room);

        if (createRoomResult > 0) {
            return roomKey;
        } else {
            return "foobar";
        }
    }

    public int insertChat(Chat chat) {
        return dao.insertChat(chat);
    }

    public User checkAdminPresence(String roomKey) {
        return (User) dao.checkAdminPresence(roomKey);
    }

    public int insertAdmin(String roomKey, String userKey) {
        HashMap<String, String> map = new HashMap<>();
        map.put("roomKey", roomKey);
        map.put("userKey", userKey);
        return dao.insertAdmin(map);
    }

    public ArrayList<Chat> getChatList(String roomId) {
        return (ArrayList<Chat>) dao.getChatList(roomId);
    }

    public void deleteRoom(Chat chat) {
        dao.deleteRoom(chat);
    }
}
