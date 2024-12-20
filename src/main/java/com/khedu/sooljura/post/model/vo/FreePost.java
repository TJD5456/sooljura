package com.khedu.sooljura.post.model.vo;

public class FreePost {
	
	private String postKey;
	private String postCd;
	private String userKey;
	private String commentContent;
	private String postDate;
	private String congirmYn;
	private String delelteYn;
	private String deleteReason;
	
	public FreePost() {
		super();
		// TODO Auto-generated constructor stub
	}

	public FreePost(String postKey, String postCd, String userKey, String commentContent, String postDate,
			String congirmYn, String delelteYn, String deleteReason) {
		super();
		this.postKey = postKey;
		this.postCd = postCd;
		this.userKey = userKey;
		this.commentContent = commentContent;
		this.postDate = postDate;
		this.congirmYn = congirmYn;
		this.delelteYn = delelteYn;
		this.deleteReason = deleteReason;
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

	public String getCommentContent() {
		return commentContent;
	}

	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}

	public String getPostDate() {
		return postDate;
	}

	public void setPostDate(String postDate) {
		this.postDate = postDate;
	}

	public String getCongirmYn() {
		return congirmYn;
	}

	public void setCongirmYn(String congirmYn) {
		this.congirmYn = congirmYn;
	}

	public String getDelelteYn() {
		return delelteYn;
	}

	public void setDelelteYn(String delelteYn) {
		this.delelteYn = delelteYn;
	}

	public String getDeleteReason() {
		return deleteReason;
	}

	public void setDeleteReason(String deleteReason) {
		this.deleteReason = deleteReason;
	}

	
	@Override
	public String toString() {
		return "FreePost [postKey=" + postKey + ", postCd=" + postCd + ", userKey=" + userKey + ", commentContent="
				+ commentContent + ", postDate=" + postDate + ", congirmYn=" + congirmYn + ", delelteYn=" + delelteYn
				+ ", deleteReason=" + deleteReason + "]";
	}
	
	
}
