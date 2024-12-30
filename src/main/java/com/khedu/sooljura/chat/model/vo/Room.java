package com.khedu.sooljura.chat.model.vo;

public class Room {
    private String roomKey;
    private String roomTitle;
    private String userId;
    private String createDate;
    private String readYn;

    public Room() {
        super();
    }

    public Room(String roomKey, String roomTitle, String userId, String createDate, String readYn) {
        this.roomKey = roomKey;
        this.roomTitle = roomTitle;
        this.userId = userId;
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

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
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
