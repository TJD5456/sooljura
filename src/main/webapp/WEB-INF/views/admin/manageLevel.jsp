<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>manageLevel.jsp</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<main>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="wrapper">
        <div class="content">
            <div class="title">
                <h1>회원 레벨 관리 페이지</h1>
            </div>

            <table>
                <thead>
                <tr>
                    <th>체크</th>
                    <th>회원번호</th>
                    <th>이름</th>
                    <th>이메일</th>
                    <th>게시글 수</th>
                    <th>가입일</th>
                    <th>레벨</th>
                    <th>레벨 변경</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td>
                            <div class="input-wrap">
                                <label>
                                    <input type="checkbox" class="chk">
                                </label>
                            </div>
                        </td>
                        <td>${user.userNm}</td>
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
