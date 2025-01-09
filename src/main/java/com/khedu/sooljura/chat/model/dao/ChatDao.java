package com.khedu.sooljura.chat.model.dao;

import com.khedu.sooljura.chat.model.vo.Chat;
import com.khedu.sooljura.chat.model.vo.Room;
import com.khedu.sooljura.user.model.vo.User;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository("chatDao")
public class ChatDao {

    private final SqlSessionTemplate template;

    public ChatDao(@Qualifier("sqlSessionTemplate") SqlSessionTemplate template) {
        this.template = template;
    }

    public int selUnread(String adminKey) {
        return template.selectOne("chat.selUnread", adminKey);
    }

    public int selNoAdmin() {
        return template.selectOne("chat.selNoAdmin");
    }

    public List<Room> getRoomList(User user) {
        return template.selectList("chat.getRoomList", user);
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

    public Object checkAdminPresence(String roomKey) {
        return template.selectOne("chat.checkAdminPresence", roomKey);
    }

    public int insertAdmin(HashMap<String, String> map) {
        return template.insert("chat.insertAdmin", map);
    }

    public List<Chat> getChatList(String roomId) {
        return template.selectList("chat.getChatList", roomId);
    }

    public void deleteRoom(Chat chat) {
        template.delete("chat.deleteRoom", chat);
    }

    public String selectUserNickNm(String roomKey) {
        return template.selectOne("chat.selectUserNickNm", roomKey);
    }

}
