package com.khedu.sooljura.chat.controller;

import com.khedu.sooljura.chat.model.service.ChatService;
import com.khedu.sooljura.chat.model.vo.Chat;
import com.khedu.sooljura.chat.model.vo.Room;
import com.khedu.sooljura.user.model.service.UserService;
import com.khedu.sooljura.user.model.vo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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

    @Autowired
    @Qualifier("userService")
    private UserService userService;

    //채팅방 목록 조회
    @GetMapping("/getRoomList.do")
    public String getRoomList(Model model, HttpSession session) {
        User loginUser = (User) session.getAttribute("loginMember");

        ArrayList<Room> roomList = service.getRoomList(loginUser.getUserId());
        model.addAttribute("roomList", roomList);

        return "chat/roomList";
    }

    //현재 방 기존 채팅 정보
    @GetMapping(value = "/getChatList.do")
    public String goChat(Model model, String roomId) {
        ArrayList<Chat> chatList = service.getChatList(roomId);

        model.addAttribute("roomId", roomId);
        model.addAttribute("chatList", chatList);

        return "chat/chat";
    }

    @GetMapping("/chatList.do")
    public String createRoomFrm(HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginMember");
        String userId = loginUser.getUserId();

        ArrayList<Chat> chatList = userService.selectChatList(userId);
        model.addAttribute("chatList", chatList);

        return "chat/chatList";
    }

    //방 만들기
    @GetMapping("/createRoom.do")
    @ResponseBody
    public String createRoom(HttpSession session, String roomName, String members) {
        User loginUser = (User) session.getAttribute("loginMember");

        return service.createRoom(roomName, loginUser.getUserId(), members);
    }

}
