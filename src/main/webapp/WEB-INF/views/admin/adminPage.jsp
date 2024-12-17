<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>adminPage.jsp</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>

<div class="title">
    <span>관리자 페이지</span>
</div>

<div>
    <span><a href="/admin/manageProducts.do">상품 등록</a></span>
</div>
<div>
    <span><a href="/admin/manageYoutube.do">유튜브 관리</a></span>
</div>
<div>
    <span><a href="/admin/managePosts.do">게시글 관리</a></span>
    <span>새로 업로드된 확인되지 않은 게시글 갯수를 보여주는 span 태그</span>
</div>
<div>
    <span><a href="/admin/manageLevel.do">회원 레벨 관리</a></span>
    <span>새로 회원가입한 회원수를 보여주는 span 태그</span>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>