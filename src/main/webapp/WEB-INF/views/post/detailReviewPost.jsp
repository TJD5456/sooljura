<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>후기 게시판</title>
    <style>
        /* ================= 전체 레이아웃 ================= */
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            line-height: 1.6;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            background-color: #f9f9f9;
        }

        /* ================= 사이드바 ================= */
        .leftSideBar {
            width: 250px;
            height: 100vh;
            background-color: #fdf3e7;
            position: fixed;
            top: 0;
            left: 0;
            padding: 20px;
            box-sizing: border-box;
            overflow-y: auto;
            border-right: 1px solid #ddd;
        }

        .leftSideBar a {
            display: block;
            color: #666;
            text-decoration: none;
            margin-bottom: 10px;
        }

        .leftSideBar a:hover {
            color: #ff5722;
        }

        /* ================= 메인 콘텐츠 ================= */
        .container {
            margin-left: 250px; /* 사이드바 여백 */
            margin-right: 60px; /* 리모콘 여백 추가 */
            padding: 20px;
            box-sizing: border-box;
            flex: 1;
            width: calc(100% - 310px); /* 사이드바와 리모콘 영역을 제외한 너비 */
        }

        h1 {
            border-bottom: 2px solid #ddd;
            padding-bottom: 10px;
            margin-bottom: 20px;
            font-size: 1.8rem;
            text-align: center;
            color: #333;
        }

        .post-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
            font-size: 0.9rem;
            color: #666;
        }

        .post-title {
            font-size: 1.2rem;
            font-weight: bold;
            color: #333;
        }

        .post-content {
            font-size: 1rem;
            color: #444;
            line-height: 1.8;
            margin-bottom: 30px;
        }

        /* ================= 댓글 섹션 ================= */
        .comment-box {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }

        .comment-box input {
            flex: 1;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .comment-box button {
            padding: 10px 20px;
            background-color: #ff7f7f;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .comment-box button:hover {
            background-color: #ff5722;
        }

        .single-comment {
            margin-top: 15px;
            padding-top: 10px;
            border-top: 1px solid #eee;
            font-size: 0.9rem;
            color: #444;
        }
    </style>
</head>
<body>
<!-- 사이드바 -->
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>

<!-- 리모콘 -->
<jsp:include page="/WEB-INF/views/common/remote.jsp"/>

<!-- 메인 콘텐츠 -->
<div class="container">
    <!-- 헤더 -->
    <div class="header">
        <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    </div>

    <!-- 본문 -->
    <h1>후기 게시판</h1>
    <div class="post-header">
        <div class="post-title">[후기] 아토양조장 마루나 약주 후기</div>
        <div>장소진 | 2024.09.05 21:06:18 | 조회수 37</div>
    </div>
    <div class="post-content">
        병 디자인도 개업한 주간 와인병 같다는 생각이 들었습니다 :)<br> 처음엔 평범한 강한 산미가 있어서 왜 사람들이
        화이트와인 같다고 하는지 알 것 같았네요.<br> 시간이 지나고 찰떡되었던 술이 조금씩 온도가 올라오면서 단 맛이
        올라와서 맛있게 마실 수 있었습니다.<br> 과실의 느낌이 강하니 회와 함께 먹으면 좋을 것 같았습니다~
    </div>

    <!-- 댓글 섹션 -->
    <div class="comment-box">
        <input type="text" placeholder="댓글 내용을 입력하세요">
        <button>확인</button>
    </div>

    <div class="single-comment">
        슬아맘 | 2024-09-06 09:51:23 <br> 우리 회원님 덕분에 멋진 게시판을 보게 됩니다. 정말
        감사합니다! 하하하
    </div>
</div>
<!-- 풋터 -->
<div class="footer">
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
</body>
</html>