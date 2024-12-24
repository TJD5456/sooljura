package com.khedu.sooljura.post.model.vo;

public class PostFile {
	private String postFileKey;
	private String postKey;
	private String postFileNm;
	private String postFilePath;
	
	
	public PostFile() {
		super();
		// TODO Auto-generated constructor stub
	}


	public PostFile(String postFileKey, String postKey, String postFileNm, String postFilePath) {
		super();
		this.postFileKey = postFileKey;
		this.postKey = postKey;
		this.postFileNm = postFileNm;
		this.postFilePath = postFilePath;
	}


	public String getPostFileKey() {
		return postFileKey;
	}


	public void setPostFileKey(String postFileKey) {
		this.postFileKey = postFileKey;
	}


	public String getPostKey() {
		return postKey;
	}


	public void setPostKey(String postKey) {
		this.postKey = postKey;
	}


	public String getPostFileNm() {
		return postFileNm;
	}


	public void setPostFileNm(String postFileNm) {
		this.postFileNm = postFileNm;
	}


	public String getPostFilePath() {
		return postFilePath;
	}


	public void setPostFilePath(String postFilePath) {
		this.postFilePath = postFilePath;
	}


	@Override
	public String toString() {
		return "PostFile [postFileKey=" + postFileKey + ", postKey=" + postKey + ", postFileNm=" + postFileNm
				+ ", postFilePath=" + postFilePath + "]";
	}
	
	
	
}
