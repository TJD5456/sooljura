<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>자유게시판</title>
    <style>
        .button-div {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 0 auto 30px;
            width: 80%;
            max-width: 1000px;
        }

        .btn-write {
            padding: 10px 20px;
            background-color: #FC8173;
            color: #EFECE5;
            font-size: 16px;
            border-radius: 5px;
            text-decoration: none;
            transition: background-color 0.3s ease;
            float: right;
        }

        .btn-write:hover {
            background-color: #ff5722;
        }

        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        .pagination a, .pagination span {
            padding: 8px 12px;
            margin: 0 5px;
            text-decoration: none;
            color: #555;
            border: 1px solid #ddd;
            border-radius: 4px;
            transition: all 0.3s ease;
        }

        .pagination .current {
            background-color: #FC8173;
            color: #fff;
            font-weight: bold;
            border-color: #FC8173;
        }

        .pagination a:hover {
            background-color: #f4f4f4;
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
                <h1>자유게시판</h1>
            </div>
            <div class="button-div">
                <h2 style="margin: 0;">목록</h2>
                <c:if test="${not empty sessionScope.loginUser}">
                    <a href="/post/freePostWriter.do" class="btn-write">작성하기</a>
                </c:if>
            </div>

            <table>
                <thead>
                <tr>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                     <th>조회수</th>  <!-- 조회수 열 추가 -->
                </tr>
                </thead>
                <tbody>
                <c:forEach var="post" items="${list}">
                    <tr>
                        <td><a href="/post/freePostDetail.do?postKey=${post.postKey}">${post.postTitle}</a></td>
                        <td>${post.userNickNm}</td>
                        <td>${post.postDate}</td>
                        <td>${post.postViews}</td>  <!-- 조회수 표시 -->
                    </tr>
                </c:forEach>
                <c:if test="${empty list}">
                    <tr class="empty-row">
                        <td colspan="4">게시글이 없습니다.</td>
                    </tr>
                </c:if>
                </tbody>
            </table>

            <div class="pagination">
                <c:out value="${pageNavi}" escapeXml="false"/>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/remote.jsp"/>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</main>
</body>
</html>
