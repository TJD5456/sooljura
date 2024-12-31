package com.khedu.sooljura.chat.model.vo;

public class Room {
    private String roomKey;
    private String roomTitle;
    private String userKey;
    private String adminKey;
    private String createDate;
    private String readYn;

    public Room() {
        super();
    }

    public Room(String roomKey, String roomTitle, String userKey, String adminKey, String createDate, String readYn) {
        this.roomKey = roomKey;
        this.roomTitle = roomTitle;
        this.userKey = userKey;
        this.adminKey = adminKey;
        this.createDate = createDate;
        this.readYn = readYn;
    }

    public String getRoomKey() {
        return roomKey;
    }

    public void setRoomKey(String roomKey) {
        this.roomKey = roomKey;
    }

    public String getRoomTitle() {
        return roomTitle;
    }

    public void setRoomTitle(String roomTitle) {
        this.roomTitle = roomTitle;
    }

    public String getUserKey() {
        return userKey;
    }

    public void setUserKey(String userKey) {
        this.userKey = userKey;
    }


    public String getAdminKey() {
        return adminKey;
    }

    public void setAdminKey(String adminKey) {
        this.adminKey = adminKey;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public String getReadYn() {
        return readYn;
    }

    public void setReadYn(String readYn) {
        this.readYn = readYn;
    }

}
