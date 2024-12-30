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
    public String createRoom(String roomName, String createId, String members) {
        String roomId = dao.getRoomId(); //방 번호 조회

        Room room = new Room();
        room.setRoomKey(roomId);
        room.setRoomTitle(roomName);
        room.setUserId(createId);

        //채팅방 개설
        if (dao.insertRoom(room) > 0) {
            members += "," + createId;
            String[] memberList = members.split(",");

            //채티방 참여자 관리 정보 등록
            for (String s : memberList) {
                room.setUserId(s);
                dao.insertChatMember(room);
            }

            return roomId;
        } else {
            return null;
        }
    }

    public int deleteRoom(Chat chat) {
        return dao.deleteRoom(chat);
    }

}
