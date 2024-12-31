<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>오류 발생</title>
    <link rel="stylesheet" href="/resources/css/styles.css"> <!-- 필요한 경우 CSS 추가 -->
</head>
<body>
<div style="text-align: center; margin-top: 100px;">
    <h1>죄송합니다!</h1>
    <p>요청을 처리하는 도중 문제가 발생했습니다.</p>
    <p><strong>${errorMessage}</strong></p> <!-- 컨트롤러에서 전달한 에러 메시지 -->
    <a href="/"
       style="color: white; background-color: blue; padding: 10px 20px; text-decoration: none; border-radius: 5px;">메인
        페이지로 이동</a>
</div>
</body>
</html>
