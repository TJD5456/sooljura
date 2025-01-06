package com.khedu.sooljura.post.model.vo;

public class Post {

	 private String postKey;         // 게시글 키
	    private int postCd;             // 게시글 코드 (1 == 일상, 2 == 질문, 3 == 정보 나눔, 4 == 공지사항)
	    private String userKey;         // 작성자 키
	    private String userNickNm;      // 작성자 닉네임
	    private String userNm;          // 작성자 이름 (추가)
	    private String postTitle;       // 게시글 제목
	    private String postContent;     // 게시글 내용
	    private int postViews;          // 조회수
	    private String postDate;        // 작성일
	    private int confirmYn;          // 확인 여부 (0: N, 1: Y)
	    private int deleteYn;           // 삭제 여부 (0: N, 1: Y)
	    private String deleteReason;    // 삭제 사유

    public Post() {
        super();
    }

	public Post(String postKey, int postCd, String userKey, String userNickNm, String userNm, String postTitle,
			String postContent, int postViews, String postDate, int confirmYn, int deleteYn, String deleteReason) {
		super();
		this.postKey = postKey;
		this.postCd = postCd;
		this.userKey = userKey;
		this.userNickNm = userNickNm;
		this.userNm = userNm;
		this.postTitle = postTitle;
		this.postContent = postContent;
		this.postViews = postViews;
		this.postDate = postDate;
		this.confirmYn = confirmYn;
		this.deleteYn = deleteYn;
		this.deleteReason = deleteReason;
	}

	public String getPostKey() {
		return postKey;
	}

	public void setPostKey(String postKey) {
		this.postKey = postKey;
	}

	public int getPostCd() {
		return postCd;
	}

	public void setPostCd(int postCd) {
		this.postCd = postCd;
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

	public String getUserNm() {
		return userNm;
	}

	public void setUserNm(String userNm) {
		this.userNm = userNm;
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

	public int getConfirmYn() {
		return confirmYn;
	}

	public void setConfirmYn(int confirmYn) {
		this.confirmYn = confirmYn;
	}

	public int getDeleteYn() {
		return deleteYn;
	}

	public void setDeleteYn(int deleteYn) {
		this.deleteYn = deleteYn;
	}

	public String getDeleteReason() {
		return deleteReason;
	}

	public void setDeleteReason(String deleteReason) {
		this.deleteReason = deleteReason;
	}

	@Override
	public String toString() {
		return "Post [postKey=" + postKey + ", postCd=" + postCd + ", userKey=" + userKey + ", userNickNm=" + userNickNm
				+ ", userNm=" + userNm + ", postTitle=" + postTitle + ", postContent=" + postContent + ", postViews="
				+ postViews + ", postDate=" + postDate + ", confirmYn=" + confirmYn + ", deleteYn=" + deleteYn
				+ ", deleteReason=" + deleteReason + "]";
	}

   

}
