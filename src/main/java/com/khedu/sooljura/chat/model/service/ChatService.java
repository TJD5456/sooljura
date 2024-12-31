package com.khedu.sooljura.chat.model.service;

import com.khedu.sooljura.chat.model.dao.ChatDao;
import com.khedu.sooljura.chat.model.vo.Chat;
import com.khedu.sooljura.chat.model.vo.Room;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Service("chatService")
public class ChatService {

    @Autowired
    @Qualifier("chatDao")
    private ChatDao dao;

    public ArrayList<Room> getRoomList(String memberId) {
        return (ArrayList<Room>) dao.getRoomList(memberId);
    }

    public ArrayList<Chat> getChatList(String roomId) {
        return (ArrayList<Chat>) dao.getChatList(roomId);
    }

    public int insertChat(Chat chat) {
        return dao.insertChat(chat);
    }

    @Transactional
    public int createRoom(Room room) {
        String roomKey = dao.selectRoomKey(); //방 번호 조회
        room.setRoomKey(roomKey);

        int createRoomResult = dao.createRoom(room);

        return 0;
    }

    public int deleteRoom(Chat chat) {
        return dao.deleteRoom(chat);
    }

}
