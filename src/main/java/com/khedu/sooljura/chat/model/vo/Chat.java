package com.khedu.sooljura.chat.model.vo;

public class Chat {
    private String chatKey;
    private String roomKey;
    private String senderId;
    private String msg;
    private String sentDate;

    public Chat() {
        super();
    }

    public Chat(String chatKey, String roomKey, String senderId, String msg, String sentDate) {
        this.chatKey = chatKey;
        this.roomKey = roomKey;
        this.senderId = senderId;
        this.msg = msg;
        this.sentDate = sentDate;
    }

    public String getChatKey() {
        return chatKey;
    }

    public void setChatKey(String chatKey) {
        this.chatKey = chatKey;
    }

    public String getRoomKey() {
        return roomKey;
    }

    public void setRoomKey(String roomKey) {
        this.roomKey = roomKey;
    }

    public String getSenderId() {
        return senderId;
    }

    public void setSenderId(String senderId) {
        this.senderId = senderId;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public String getSentDate() {
        return sentDate;
    }

    public void setSentDate(String sentDate) {
        this.sentDate = sentDate;
    }

}