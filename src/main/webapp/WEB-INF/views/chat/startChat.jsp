<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>1:1 질문</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css"/>
    <script src="${pageContext.request.contextPath}/resources/jquery/jquery-3.7.1.min.js"></script>
    <style>
        main {
            display: flex;
        }

        #msgInput {
            margin-top: 16px;
            margin-bottom: 16px;
        }

        #msgInput, #roomTitleInput,[type="submit"] {
            padding: 4px;
        }
    </style>
</head>
<body>
<main>
    <div class="wrapper">
        <div class="content">
            <div class="title">
                <h1>1:1 질문</h1>
            </div>
            <form action="${pageContext.request.contextPath}/chat/createChat.do" method="post">
                <input type="hidden" name="userId" value="${senderId}">
                <input type="hidden" name="senderId" value="${senderId}">
                <label for="roomTitleInput"></label><input type="text" name="roomTitle" id="roomTitleInput" placeholder="제목">
                <br>
                <label for="msgInput"></label><textarea name="msg" id="msgInput" rows="10" cols="50" maxlength="1000" wrap="soft" style="resize: none" placeholder="질문"></textarea>
                <br>
                <input type="submit" value="보내기">
            </form>
        </div>
    </div>
</main>
</body>
</html>
