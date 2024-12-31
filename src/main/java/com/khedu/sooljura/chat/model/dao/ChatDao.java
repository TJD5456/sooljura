package com.khedu.sooljura.chat.model.dao;

import com.khedu.sooljura.chat.model.vo.Chat;
import com.khedu.sooljura.chat.model.vo.Room;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("chatDao")
public class ChatDao {

    private final SqlSessionTemplate template;

    public ChatDao(@Qualifier("sqlSessionTemplate") SqlSessionTemplate template) {
        this.template = template;
    }

    public List<Room> getRoomList(String userKey) {
        return template.selectList("chat.getRoomList", userKey);
    }

    public String selectRoomKey() {
        return template.selectOne("chat.selectRoomKey");
    }

    public int createRoom(Room room) {
        return template.insert("chat.createRoom", room);
    }

    public int insertChat(Chat chat) {
        return template.insert("chat.insertChat", chat);
    }

    public List<Chat> getChatList(String roomId) {
        return template.selectList("chat.getChatList", roomId);
    }

    public void deleteRoom(Chat chat) {
        template.delete("chat.deleteRoom", chat);
    }

}
