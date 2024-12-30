package com.khedu.sooljura.chat.model.service;

import com.khedu.sooljura.chat.model.dao.ChatDao;
import com.khedu.sooljura.chat.model.vo.Chat;
import com.khedu.sooljura.chat.model.vo.Room;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

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
        room.setRoomId(roomId);
        room.setRoomName(roomName);
        room.setCreateId(createId);

        //채팅방 개설
        if (dao.insertRoom(room) > 0) {
            members += "," + createId;
            List<String> memberList = Arrays.asList(members.split(","));

            //채티방 참여자 관리 정보 등록
            for (int i = 0; i < memberList.size(); i++) {
                room.setCreateId(memberList.get(i));
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
