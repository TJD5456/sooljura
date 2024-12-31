package com.khedu.sooljura.chat.model.dao;

import com.khedu.sooljura.chat.model.vo.Chat;
import com.khedu.sooljura.chat.model.vo.Room;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("chatDao")
public class ChatDao {

    @Autowired
    @Qualifier("sqlSessionTemplate")
    private SqlSessionTemplate template;

    public String selectRoomKey() {
        return template.selectOne("chat.selectRoomKey");
    }

    public int createRoom(Room room) {
        return template.insert("chat.createRoom", room);
    }

    public List<Room> getRoomList(String memberId) {
        return template.selectList("chat.getRoomList", memberId);
    }

    public List<Chat> getChatList(String roomId) {
        return template.selectList("chat.getChatList", roomId);
    }

    public int insertChat(Chat chat) {
        return template.insert("chat.insertChat", chat);
    }

    public int insertChatMember(Room room) {
        return template.insert("chat.insertChatMember", room);
    }

    public int deleteRoom(Chat chat) {
        return template.update("chat.deleteRoom", chat);
    }
}
