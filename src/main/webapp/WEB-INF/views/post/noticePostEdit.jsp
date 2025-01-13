<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항 수정</title>
    <style>
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            font-weight: bold;
        }
        .form-group input[type="text"], .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .button-group {
            text-align: center;
            margin-top: 20px;
        }
        .button-group button {
            padding: 10px 30px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .button-group button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<main>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="wrapper">
        <div class="content">
            <h1>공지사항 수정</h1>
            <form action="/post/noticePostUpdate.do" method="post" onsubmit="return confirm('정말 수정하시겠습니까?');">
                <!-- 게시글 키 (숨김 필드) -->
                <input type="hidden" name="postKey" value="${post.postKey}"/>

                <!-- 제목 입력 -->
                <div class="form-group">
                    <label for="title">제목</label>
                    <input type="text" id="title" name="postTitle" value="${post.postTitle}" required/>
                </div>

                <!-- 본문 입력 -->
                <div class="form-group">
                    <label for="postContent">본문</label>
                    <textarea id="postContent" name="postContent" rows="10" required>${post.postContent}</textarea>
                </div>

                <!-- 버튼 -->
                <div class="button-group">
                    <button type="button" onclick="history.back();" style="background-color: #FC8173;">취소</button>
                    <button type="submit" style="background-color: #FC8173;">수정하기</button>
                </div>
            </form>
        </div>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</main>
</body>
</html>
