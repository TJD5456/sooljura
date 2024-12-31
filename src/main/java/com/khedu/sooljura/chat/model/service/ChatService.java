package com.khedu.sooljura.chat.model.service;

import com.khedu.sooljura.chat.model.dao.ChatDao;
import com.khedu.sooljura.chat.model.vo.Chat;
import com.khedu.sooljura.chat.model.vo.Room;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service("chatService")
public class ChatService {

    @Autowired
    @Qualifier("chatDao")
    private ChatDao dao;

    public String createRoom(Room room) {
        String roomKey = dao.selectRoomKey(); //방 번호 조회
        room.setRoomKey(roomKey);

        int createRoomResult = dao.createRoom(room);

        if(createRoomResult > 0) {
            return roomKey;
        } else {
            return "foobar";
        }
    }

    public int insertChat(Chat chat) {
        return dao.insertChat(chat);
    }

//    by UnEmotioneD

    public ArrayList<Room> getRoomList(String memberId) {
        return (ArrayList<Room>) dao.getRoomList(memberId);
    }

    public ArrayList<Chat> getChatList(String roomId) {
        return (ArrayList<Chat>) dao.getChatList(roomId);
    }

    public int deleteRoom(Chat chat) {
        return dao.deleteRoom(chat);
    }

}
