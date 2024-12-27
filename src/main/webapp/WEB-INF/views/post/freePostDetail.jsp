<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시글 상세보기</title>
</head>
<body>
    <h1>${post.postTitle}</h1>
    <p>작성자: ${post.userNickNm} (${post.userNm})</p>
    <p>작성일: ${post.postDate}</p>
    <p>조회수: ${post.postViews}</p>
    <h2>내용</h2>
    <p>${post.postContent}</p>
</body>
</html>

