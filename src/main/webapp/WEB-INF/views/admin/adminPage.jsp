<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>adminPage.jsp</title>
    <style>
        tr > th {
            text-align: left;
            padding-left: 45%;
        }

        tr td {
            width: 7%;
        }
        th > a {
        	text-decoration: none;
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
                <h1>관리자 페이지</h1>
            </div>
            <table>
                <tbody>
                <tr>
                    <th colspan="2"><a href="/admin/manageProducts.do">상품 등록</a></th>
                </tr>
                <tr>
                    <th colspan="2"><a href="/admin/manageYoutube.do">유튜브 관리</a></th>
                </tr>
                <tr>
                    <th><a href="/admin/managePosts.do">게시글 관리</a></th>
                    <td>${newPost}</td>
                </tr>
                <tr>
                    <th><a href="/admin/manageChats.do">1대1 채팅</a></th>
                    <td>${newChat}</td>
                </tr>
                <tr>
                    <th><a href="/admin/manageLevel.do">회원 레벨 관리</a></th>
                    <td>${newUser}</td>
                </tr>
                </tbody>
            </table>
        </div>
        <jsp:include page="/WEB-INF/views/common/remote.jsp"/>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</main>
</body>
</html>
