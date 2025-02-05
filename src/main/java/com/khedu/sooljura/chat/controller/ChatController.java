package com.khedu.sooljura.chat.controller;

import com.khedu.sooljura.chat.model.service.ChatService;
import com.khedu.sooljura.chat.model.vo.Chat;
import com.khedu.sooljura.chat.model.vo.Room;
import com.khedu.sooljura.user.model.vo.User;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;

@Controller
@RequestMapping("/chat")
public class ChatController {

    private final ChatService service;

    public ChatController(@Qualifier("chatService") ChatService service) {
        this.service = service;
    }

    @GetMapping("chatFrm")
    public String chatFrm(HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        model.addAttribute("userKey", loginUser.getUserKey());

        ArrayList<Room> roomList = service.getRoomList(loginUser);

        if (roomList != null) {
            model.addAttribute("roomList", roomList);
            return null;
        } else {
            return "redirect:/chat/startChat.do";
        }
    }

    @GetMapping("/startChat.do")
    public String startChat(HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        model.addAttribute("userKey", loginUser.getUserKey());
        return "chat/startChat";
    }

    @PostMapping("/createChat.do")
    public String createChat(Room room, Chat chat) {
        String roomKey = service.createRoom(room);
        int insertChatResult = 0;

        if (!roomKey.equals("foobar")) {
            chat.setRoomKey(roomKey);
            insertChatResult = service.insertChat(chat);
        }

        if (insertChatResult > 0) {
            return "redirect:/chat/chatRoom.do?roomKey=" + roomKey;
        } else {
            return "";
        }
    }

    @GetMapping("/chatRoom.do")
    public String chatRoom(HttpSession session, Model model, String roomKey) {
        model.addAttribute("roomKey", roomKey);
        User loginUser = ((User) session.getAttribute("loginUser"));
        String userKey = loginUser.getUserKey();
        int userCd = loginUser.getUserCd();

        String userNickNm = service.selectUserNickNm(roomKey);
        model.addAttribute("userNickNm", userNickNm);

        model.addAttribute("userKey", userKey);
        model.addAttribute("userCd", userCd);

        ArrayList<Chat> chatList = service.getChatList(roomKey);
        model.addAttribute("chatList", chatList);
        return "/chat/chatRoom";
    }

    @GetMapping("toChatList.do")
    public String toChatList(HttpSession session, Model model) {
        User loginUser = (User) session.getAttribute("loginUser");
        int userCd = loginUser.getUserCd();

        if (userCd == 0) {
            return "redirect:/admin/manageChats.do";
        } else {
            return "redirect:/chat/chatFrm.do";
        }
    }

}
