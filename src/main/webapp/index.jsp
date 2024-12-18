<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>술주라</title>
    <link rel="icon" href="/resources/icons/logo-circle-woText-16px-favicon.png">
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
	<div class="rWrap">
		<jsp:include page="/WEB-INF/views/common/header.jsp"/>
		<main>
		<%--사이드바가 있으므로, <div class = "mainDiv"> </div> 안에 내용 넣어주어야 함. 만약 이 안에 내용 넣기 싫다면, padding-left:225px; 넣어줄것   --%>
			<h1>메인페이지</h1>
			<div style="height: 800px;"></div>
		<jsp:include page="/WEB-INF/views/common/remote.jsp"/>
		</main>
	</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>
