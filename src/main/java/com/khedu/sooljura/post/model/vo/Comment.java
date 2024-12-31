package com.khedu.sooljura.post.model.vo;

public class Comment {
    private String commentKey;
    private String postKey;
    private String userKey;
    private String userNickNm; // 닉네임 추가
    private String commentContent;
    private String commentDate;

    public Comment() {
        super();
    }

    public Comment(String commentKey, String postKey, String userKey, String userNickNm, String commentContent,
                   String commentDate) {
        super();
        this.commentKey = commentKey;
        this.postKey = postKey;
        this.userKey = userKey;
        this.userNickNm = userNickNm;
        this.commentContent = commentContent;
        this.commentDate = commentDate;
    }

    public String getCommentKey() {
        return commentKey;
    }

    public void setCommentKey(String commentKey) {
        this.commentKey = commentKey;
    }

    public String getPostKey() {
        return postKey;
    }

    public void setPostKey(String postKey) {
        this.postKey = postKey;
    }

    public String getUserKey() {
        return userKey;
    }

    public void setUserKey(String userKey) {
        this.userKey = userKey;
    }

    public String getUserNickNm() {
        return userNickNm;
    }

    public void setUserNickNm(String userNickNm) {
        this.userNickNm = userNickNm;
    }

    public String getCommentContent() {
        return commentContent;
    }

    public void setCommentContent(String commentContent) {
        this.commentContent = commentContent;
    }

    public String getCommentDate() {
        return commentDate;
    }

    public void setCommentDate(String commentDate) {
        this.commentDate = commentDate;
    }

    @Override
    public String toString() {
        return "Comment [commentKey=" + commentKey + ", postKey=" + postKey + ", userKey=" + userKey + ", userNickNm="
                + userNickNm + ", commentContent=" + commentContent + ", commentDate=" + commentDate + "]";
    }

}
