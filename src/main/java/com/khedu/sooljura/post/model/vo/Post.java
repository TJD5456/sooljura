package com.khedu.sooljura.post.model.vo;

public class Post {

    private String postKey;      // 게시글 키
    private String postCd;       // 게시글 코드
    private String userKey;      // 작성자 키
    private String userNickname; // 작성자 닉네임
    private String postTitle;    // 게시글 제목
    private String postContent;  // 게시글 내용
    private int postViews;       // 조회수
    private String postDate;     // 작성일
    private String confirmYn;    // 승인 여부
    private String deleteYn;     // 삭제 여부
    private String deleteReason; // 삭제 사유
    private String postCategory; // 게시글 분류 이름 (조인 결과)

    public Post() {
        super();
    }

    public Post(String postKey, String postCd, String userKey, String userNickname, String postTitle,
                String postContent, int postViews, String postDate, String confirmYn, String deleteYn, String deleteReason,
                String postCategory) {
        super();
        this.postKey = postKey;
        this.postCd = postCd;
        this.userKey = userKey;
        this.userNickname = userNickname;
        this.postTitle = postTitle;
        this.postContent = postContent;
        this.postViews = postViews;
        this.postDate = postDate;
        this.confirmYn = confirmYn;
        this.deleteYn = deleteYn;
        this.deleteReason = deleteReason;
        this.postCategory = postCategory;
    }

    public String getPostKey() {
        return postKey;
    }

    public void setPostKey(String postKey) {
        this.postKey = postKey;
    }

    public String getPostCd() {
        return postCd;
    }

    public void setPostCd(String postCd) {
        this.postCd = postCd;
    }

    public String getUserKey() {
        return userKey;
    }

    public void setUserKey(String userKey) {
        this.userKey = userKey;
    }

    public String getUserNickname() {
        return userNickname;
    }

    public void setUserNickname(String userNickname) {
        this.userNickname = userNickname;
    }

    public String getPostTitle() {
        return postTitle;
    }

    public void setPostTitle(String postTitle) {
        this.postTitle = postTitle;
    }

    public String getPostContent() {
        return postContent;
    }

    public void setPostContent(String postContent) {
        this.postContent = postContent;
    }

    public int getPostViews() {
        return postViews;
    }

    public void setPostViews(int postViews) {
        this.postViews = postViews;
    }

    public String getPostDate() {
        return postDate;
    }

    public void setPostDate(String postDate) {
        this.postDate = postDate;
    }

    public String getConfirmYn() {
        return confirmYn;
    }

    public void setConfirmYn(String confirmYn) {
        this.confirmYn = confirmYn;
    }

    public String getDeleteYn() {
        return deleteYn;
    }

    public void setDeleteYn(String deleteYn) {
        this.deleteYn = deleteYn;
    }

    public String getDeleteReason() {
        return deleteReason;
    }

    public void setDeleteReason(String deleteReason) {
        this.deleteReason = deleteReason;
    }

    public String getPostCategory() {
        return postCategory;
    }

    public void setPostCategory(String postCategory) {
        this.postCategory = postCategory;
    }

    @Override
    public String toString() {
        return "Post [postKey=" + postKey + ", postCd=" + postCd + ", userKey=" + userKey + ", userNickname="
            + userNickname + ", postTitle=" + postTitle + ", postContent=" + postContent + ", postViews="
            + postViews + ", postDate=" + postDate + ", confirmYn=" + confirmYn + ", deleteYn=" + deleteYn
            + ", deleteReason=" + deleteReason + ", postCategory=" + postCategory + "]";
    }

}
