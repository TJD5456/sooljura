package com.khedu.sooljura.chat.controller;

import com.khedu.sooljura.chat.model.service.ChatService;
import com.khedu.sooljura.chat.model.vo.Chat;
import com.khedu.sooljura.chat.model.vo.Room;
import com.khedu.sooljura.user.model.vo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;

@Controller
@RequestMapping("/chat")
public class ChatController {

    @Autowired
    @Qualifier("chatService")
    private ChatService service;

    @GetMapping("/startChat.do")
    public String startChat(HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        String userId = loginUser.getUserId();
        model.addAttribute("userId", userId);
        return "chat/startChat";
    }

    @PostMapping("/createChat.do")
    @ResponseBody
    public String createChat(Room room, Chat chat) {

        String roomKey = service.createRoom(room);

        if(!roomKey.equals("foobar")){
            chat.setRoomKey(roomKey);
            int insertChatResult = service.insertChat(chat);
        }

        return "chat/chattingPage";
    }

    //    by UnEmotioneD

    //채팅방 목록 조회
    @GetMapping("/getRoomList.do")
    public String getRoomList(Model model, HttpSession session) {
        User loginUser = (User) session.getAttribute("loginMember");

        ArrayList<Room> roomList = service.getRoomList(loginUser.getUserId());
        model.addAttribute("roomList", roomList);

        return "chat/roomList";
    }

}
