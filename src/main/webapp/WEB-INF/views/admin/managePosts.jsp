<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>managePosts.jsp</title>
    <style>
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
                <h1>게시글 관리 페이지</h1>
            </div>

            <table>
                <thead>
                <tr>
                    <th>게시글 번호</th>
                    <th>작성자</th>
                    <th>제목</th>
                    <th>작성일</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="post" items="${postList}">
                    <tr>
                        <td><a id="post-${post.postKey}"
                               href="/post/freePostDetail.do?postKey=${post.postKey}">${post.postTitle}</a></td>
                        <td>${post.userNickNm}</td>
                        <td>${post.postTitle}</td>
                        <td>${post.postDate}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty postList}">
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
