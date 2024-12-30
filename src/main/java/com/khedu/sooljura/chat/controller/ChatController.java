package com.khedu.sooljura.chat.controller;

import com.google.gson.Gson;
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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Random;

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

    //메시지 송신 이전, 파일 업로드
    @PostMapping(value = "/fileUpload.do", produces = "application/json; charset=utf-8")
    @ResponseBody
    public String fileUpload(HttpServletRequest request, MultipartFile file) {
        Chat chat = null;

        if (!file.isEmpty()) {

            String savePath = request.getSession().getServletContext().getRealPath("/resources/upload/");
            String originalFilename = file.getOriginalFilename();
            String fileName = originalFilename.substring(0, originalFilename.lastIndexOf("."));
            String extension = originalFilename.substring(originalFilename.lastIndexOf("."));

            //서버 업로드 파일명 중복되지 않도록
            String toDay = new SimpleDateFormat("yyyyMMdd").format(new Date());
            int ranNum = new Random().nextInt(100000) + 1;
            String filePath = fileName + "_" + toDay + "_" + ranNum + extension;

            savePath += filePath;

            try {
                byte[] bytes = file.getBytes();
                BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(new File(savePath)));
                bos.write(bytes);
                bos.close();

                chat = new Chat();
                chat.setFileName(originalFilename);
                chat.setFilePath(filePath);

                //result = service.insertChatFile(chat);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        return new Gson().toJson(chat);
    }

    // 파일 다운
    @GetMapping(value = "/fileDown.do", produces = "application/octet-stream;")
    public void noticeFileDown(HttpServletRequest request, HttpServletResponse response, String fileName, String filePath) {

        String root = request.getSession().getServletContext().getRealPath("/resources/upload/");


        BufferedInputStream bis = null;
        BufferedOutputStream bos = null;

        try {
            FileInputStream fis = new FileInputStream(root + filePath);

            bis = new BufferedInputStream(fis);

            ServletOutputStream sos = response.getOutputStream();

            bos = new BufferedOutputStream(sos);

            String resFilename = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");

            response.setHeader("Content-Disposition", "attachment; filename=" + resFilename);

            while (true) {
                int read = bis.read();
                if (read == -1) {
                    break;
                } else {
                    bos.write(read);
                }
            }

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (bis != null && bos != null) {
                    bos.close();
                    bis.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    /*
    //방 만들기 페이지 이동
    @GetMapping("/createRoomFrm.do")
    public String createRoomFrm(Model model) {
        ArrayList<User> userList = userService.selectUserList();
        model.addAttribute("userList", userList);
        return "chat/createRoom";
    }
    */

    //방 만들기
    @GetMapping("/createRoom.do")
    @ResponseBody
    public String createRoom(HttpSession session, String roomName, String members) {
        User loginUser = (User) session.getAttribute("loginMember");

        return service.createRoom(roomName, loginUser.getUserId(), members);
    }

}
