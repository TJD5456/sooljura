<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>자유게시판</title>
<link rel="stylesheet" href="/resources/css/your-styles.css">
<style>
/* 전체 레이아웃 및 스타일 */
body {
	margin: 0;
	display: flex;
	flex-direction: column;
	font-family: Arial, sans-serif;
}

.leftSideBar {
	width: 250px;
	height: 100vh;
	background-color: #fdf3e7;
	position: fixed;
	top: 0;
	left: 0;
	padding: 20px;
	overflow-y: auto;
	border-right: 1px solid #ddd;
}

.main-container {
	margin-left: 250px;
	flex: 1;
	display: flex;
	flex-direction: column;
}

.header {
	background-color: #fff;
	padding: 10px 20px;
	text-align: center;
	border-bottom: 1px solid #ddd;
}

.content {
	flex: 1;
	padding: 20px;
}

table {
	width: 80%;
	margin: 0 auto;
	border-collapse: collapse;
}

th, td {
	border: 1px solid #ddd;
	padding: 10px;
	text-align: center;
}

th {
	background-color: #f4f4f4;
}

tr:hover {
	background-color: #f9f9f9;
}

tr.empty-row td {
	text-align: center;
	font-style: italic;
	color: #888;
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

	<!-- 사이드바 -->
	<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
	<!-- 리모콘 -->
	<div class="remote-controller">
		<jsp:include page="/WEB-INF/views/common/remote.jsp" />
	</div>

	<!-- 메인 레이아웃 -->
	<div class="main-container">
		<!-- 헤더 -->
		<div class="header">
			<jsp:include page="/WEB-INF/views/common/header.jsp" />
		</div>

		<!-- 콘텐츠 영역 -->
		<div class="content">
			<h1>자유게시판</h1>
			<div
				style="display: flex; justify-content: space-between; align-items: center; width: 80%; margin: 0 auto;">
				<h2 style="margin: 0;">목록</h2>
				<!-- 로그인 세션이 있을 때만 작성하기 버튼 표시 -->
				<c:if test="${not empty sessionScope.loginUser}">
					<a href="/post/freePostWriter.do" class="btn-write">작성하기</a>
				</c:if>
			</div>
			<br>
			<table>
				<thead>
					<tr>

						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="post" items="${list}">
						<tr>
							<td><a href="/post/freePostDetail.do?postKey=${post.postKey}">${post.postTitle}</a></td>
							<td>${post.userNickNm}</td>
							<td>${post.postDate}</td>
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
				<c:out value="${pageNavi}" escapeXml="false" />
			</div>
		</div>

		<!-- 풋터 -->
		<div class="footer">
			<jsp:include page="/WEB-INF/views/common/footer.jsp" />
		</div>
	</div>

</body>
</html>
