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
    private SqlSessionTemplate sqlSession;

    public List<Room> getRoomList(String memberId) {
        return sqlSession.selectList("chat.getRoomList", memberId);
    }

    public List<Chat> getChatList(String roomId) {
        return sqlSession.selectList("chat.getChatList", roomId);
    }

    public int insertChat(Chat chat) {
        return sqlSession.insert("chat.insertChat", chat);
    }

    public String getRoomId() {
        return sqlSession.selectOne("chat.getRoomId");
    }

    public int insertRoom(Room room) {
        return sqlSession.insert("chat.insertRoom", room);
    }

    public int insertChatMember(Room room) {
        return sqlSession.insert("chat.insertChatMember", room);
    }

    public int deleteRoom(Chat chat) {
        return sqlSession.update("chat.deleteRoom", chat);
    }

}
