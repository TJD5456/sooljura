<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>후기게시판</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 20px;
      line-height: 1.6;
    }
    .container {
      width: 80%;
      margin: 0 auto;
    }
    h1 {
      border-bottom: 2px solid #ddd;
      padding-bottom: 10px;
    }
    .post-header {
      display: flex;
      justify-content: space-between;
      border-bottom: 1px solid #ddd;
      padding: 10px 0;
      margin-bottom: 20px;
    }
    .post-header div {
      font-size: 14px;
      color: #666;
    }
    .post-title {
      font-size: 18px;
      font-weight: bold;
    }
    .post-content {
      margin-bottom: 30px;
    }
    .comments-section {
      margin-top: 30px;
      border-top: 2px solid #ddd;
      padding-top: 20px;
    }
    .comments-header {
      display: flex;
      justify-content: space-between;
      margin-bottom: 20px;
    }
    .comment-box {
      display: flex;
      align-items: center;
      gap: 10px;
    }
    .comment-box input {
      flex: 1;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 5px;
    }
    .comment-box button {
      padding: 10px 15px;
      background-color: #f4f4f4;
      border: 1px solid #ddd;
      cursor: pointer;
      border-radius: 5px;
    }
    .comment-box button:hover {
      background-color: #ddd;
    }
    .comments-header {
      display: flex;
      justify-content: space-between;
      margin-bottom: 20px;
    }
    .single-comment {
      margin-bottom: 20px;
      border-top: 1px solid #eee;
      padding-top: 10px;
    }
    .single-comment .comment-meta {
      font-size: 12px;
      color: #888;
      margin-bottom: 5px;
    }
    .single-comment .comment-text {
      font-size: 14px;
    }
    .btn-back {
      display: block;
      text-align: right;
      margin-top: 30px;
    }
    .btn-back button {
      padding: 10px 20px;
      background-color: #f4f4f4;
      border: 1px solid #ddd;
      cursor: pointer;
      border-radius: 5px;
    }
    .btn-back button:hover {
      background-color: #ddd;
    }
  </style>
</head>
<body>
  <div class="container">
    <h1>수다게시판</h1>
    <div class="post-header">
      <div class="post-title">[후기] 아토양조장 마루나 약주 후기</div>
      <div class="post-meta">장소진 | 2024.09.05 21:06:18 | 조회수 37</div>
    </div>
    <div class="post-content">
      병 디자인도 개업한 주간 와인병 같다는 생각이 들었습니다 :)<br><br>
      처음엔 평범한 강한 산미가 있어서 왜 사람들이 화이트와인 같다고 하는지 알 것 같았네요.<br><br>
      하지만 시간이 지나고 찰떡되었던 술이 조금씩 온도가 올라오면서 단 맛이 올라와서 맛있게 마실 수 있었습니다.<br><br>
      과실의 느낌이 강하니 회와 함께 먹으면 좋을 것 같았습니다~
    </div>
    <div class="comments-section">
      <div class="comments-header">
        <div>총 댓글 : 1</div>
        <div><button>추천하기</button></div>
      </div>
      <div class="comment-box">
        <input type="text" placeholder="댓글 내용을 입력하세요">
        <button>확인</button>
      </div>


      <div class="single-comment">
        <div class="comment-header">
        <div class="comment-meta">슬아맘 | 2024-09-06 09:51:23</div>
        <div class="comment-text">
          우리 회원님 덕분에 멋진 게시판을 보게 됩니다. 정말 감사합니다! 하하하
        </div>
    </div>
      </div>
    </div>
    <div class="btn-back">
      <button>목록</button>
    </div>
  </div>
</body>
</html>