<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>adminPage.jsp</title>
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
            <div>
                <span><a href="${pageContext.request.contextPath}/admin/manageProducts.do">상품 등록</a></span>
            </div>
            <div>
                <span><a href="${pageContext.request.contextPath}/admin/manageYoutube.do">유튜브 관리</a></span>
            </div>
            <div>
                <span><a href="${pageContext.request.contextPath}/admin/managePosts.do">게시글 관리</a></span>
                <span>${numberOfUnCheckedPost}</span>
            </div>
            <div>
                <span><a href="${pageContext.request.contextPath}/admin/manageChats.do">1대1 채팅</a></span>
                <%-- TODO: 채팅창 부분도 하기 --%>
                <span>${numberOfUnCheckedChats}</span>
            </div>
            <div>
                <span><a href="${pageContext.request.contextPath}/admin/manageLevel.do">회원 레벨 관리</a></span>
                <span>${numberOfUnCheckedNewUser}</span>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/remote.jsp"/>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</main>
<script>
    $(function () {
        let uploadYoutubeResult = "${uploadYoutubeResult}";

        if (uploadYoutubeResult === "1") {
            window.alert("유튜브 등록 성공");
        } else if (uploadYoutubeResult === "0") {
            window.alert("유튜브 등록 중 오류가 발생하였습니다");
        }
    });
</script>
</body>
</html>
