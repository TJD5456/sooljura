<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>chatFrm.jsp</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css"/>
    <script src="${pageContext.request.contextPath}/resources/jquery/jquery-3.7.1.min.js"></script>
    <style>
        .goToRoom:hover {
            background-color: var(--footer-background);
            cursor: pointer;
        }
    </style>
</head>
<body>
<main>
    <div class="wrapper">
        <div class="content">
            <div class="title">
                <h1>채팅 목록</h1>
            </div>

            <a href="${pageContext.request.contextPath}/chat/startChat.do">새로운 질문</a>

            <table>
                <thead>
                <tr>
                    <th>제목</th>
                    <th>날짜</th>
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
        </div>
    </div>
</main>

<script>
    function goToRoom(roomKey) {
        console.log(roomKey);
    }
</script>
</body>
</html>
