<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>manageChats.jps</title>
    <style>
        .title {
            margin: 0 auto;
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<main>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="wrapper">
        <div class="content">
            <div class="title">
                <h1>1대1 채팅 관리 페이지</h1>
            </div>
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
        <jsp:include page="/WEB-INF/views/common/remote.jsp"/>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</main>
</body>
</html>
