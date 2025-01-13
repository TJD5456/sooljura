<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>chatFrm.jsp</title>
    <link rel="stylesheet" href="/resources/css/common.css"/>
    <script src="/resources/jquery/jquery-3.7.1.min.js"></script>
    <style>
        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
        }

        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            background-color: #f2f2f2;
            color: #333;
        }

        .page-container {
            display: flex;
            flex-direction: column;
            flex: 1;
        }

        .main-header {
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: center;
        }

        .main-header h1 {
            margin: 0;
            font-size: 24px;
        }

        .chat-info-container {
            width: 90%;
            max-width: 900px;
            margin: 40px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
            border-radius: 6px;
        }

        .chat-info-container .title h1 {
            margin-bottom: 20px;
            font-size: 26px;
            text-align: left;
        }

        .new-chat {
            display: inline-block;
            float: right;
            padding: 10px 20px;
            margin-bottom: 20px;
            background-color: var(--button-background);
            color: var(--sidebar-background);
            box-shadow: 1px 1px 1px 1px var(--button-shadow);
            border: none;
            border-radius: 4px;
            font-size: 14px;
            cursor: pointer;
        }

        .new-chat:hover {
            background-color: var(--button-background-hover);
            box-shadow: 1px 1px 1px 1px var(--button-background);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 40px;
        }

        table thead {
            background-color: #f4f4f4;
        }

        table th, table td {
            padding: 12px 16px;
            border-bottom: 1px solid #e9e9e9;
        }

        tbody tr:nth-child(even) {
            background-color: #fcfcfc;
        }

        .goToRoom {
            transition: background-color 0.2s;
        }

        .goToRoom:hover {
            background-color: #fafafa;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="page-container">
    <header class="main-header">
        <h1>관리자에게 질문</h1>
    </header>

    <section class="chat-info-container">
        <div class="title">
            <h1>채팅 목록</h1>
        </div>

        <button onclick="startChat()" class="new-chat">새로운 질문</button>

        <table>
            <thead>
            <tr>
                <th>제목</th>
                <th>날짜 / 시간</th>
                <th>확인여부</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="room" items="${roomList}">
                <tr class="goToRoom" onclick="goToRoom('${room.roomKey}')">
                    <td>${room.roomTitle}</td>
                    <td>${room.createDate}</td>
                    <td>
                        <c:if test="${room.readYn == 0}">X</c:if>
                        <c:if test="${room.readYn == 1}">O</c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </section>
</div>

<script>
    function startChat() {
        window.location = "/chat/startChat.do";
    }

    function goToRoom(roomKey) {
        window.location = "/chat/chatRoom.do?roomKey=" + roomKey;
    }
</script>
</body>
</html>
