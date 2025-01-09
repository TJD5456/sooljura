<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>1:1 질문</title>
    <link rel="stylesheet" href="/resources/css/common.css"/>
    <script src="/resources/jquery/jquery-3.7.1.min.js"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background-color: #f2f2f2;
            font-family: Arial, sans-serif;
            color: #333;
        }

        main {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .wrapper {
            background-color: #fff;
            width: 100%;
            max-width: 600px;
            margin: 0 auto;
            padding: 30px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 6px;
        }

        .content .title h1 {
            font-size: 24px;
            margin-bottom: 16px;
            text-align: center;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        form label {
            font-weight: bold;
            margin-top: 16px;
            margin-bottom: 8px;
        }

        form input[type="text"],
        form textarea {
            padding: 8px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 100%;
        }

        form textarea {
            resize: none;
        }

        form input[type="submit"] {
            margin-top: 20px;
            padding: 10px 0;
            background-color: var(--button-background);
            box-shadow: 1px 1px 1px 1px var(--button-shadow);
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }

        form input[type="submit"]:hover {
            background-color: var(--button-background-hover);
            box-shadow: 1px 1px 1px 1px var(--button-background);
        }

        .content input[type="text"],
        .content textarea {
            margin-bottom: 16px;
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
                <input type="hidden" name="userKey" value="${userKey}">
                <input type="hidden" name="senderKey" value="${userKey}">

                <label for="roomTitleInput">제목</label>
                <input type="text" name="roomTitle" id="roomTitleInput" placeholder="제목을 입력하세요">

                <label for="msgInput">질문</label>
                <textarea name="msg" id="msgInput" rows="10" maxlength="1000" placeholder="질문을 입력하세요"></textarea>

                <input type="submit" value="만들기">
            </form>
        </div>
    </div>
</main>
</body>
</html>
