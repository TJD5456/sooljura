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

<!-- 스타일 시트 연결 -->
<style>
/* 전체 레이아웃 설정 */
body {
	margin: 0;
	display: flex;
	flex-direction: column;
	font-family: Arial, sans-serif;
}

/* 사이드바 스타일 */
.leftSideBar {
	width: 250px;
	height: 100vh;
	background-color: #fdf3e7;
	position: fixed;
	top: 0;
	left: 0;
	padding: 20px;
	box-sizing: border-box;
	overflow-y: auto;
	border-right: 1px solid #ddd;
}

/* 메인 콘텐츠 및 레이아웃 */
.main-container {
	margin-left: 250px;
	display: flex;
	flex-direction: column;
	flex: 1;
}

/* 헤더 */
.header {
	background-color: #fff;
	padding: 10px 20px;
	text-align: center;
	border-bottom: 1px solid #ddd;
}

/* 콘텐츠 영역 */
.content {
	flex: 1;
	padding: 20px;
}

/* 테이블 스타일 */
table {
	width: 80%;
	max-width: 1000px;
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
	font-weight: bold;
}

tr:hover {
	background-color: #f9f9f9;
}

.notice {
	font-weight: bold;
	color: #ff5722;
}

/* 작성하기 버튼 스타일 */
.btn-write {
	display: inline-block;
	padding: 10px 20px;
	background-color: #FC8173;
	color: #EFECE5;
	font-size: 16px;
	border-radius: 5px;
	text-align: center;
	text-decoration: none;
	transition: background-color 0.3s ease;
	float: right;
}

.btn-write:hover {
	background-color: #ff5722;
}

/* 풋터 스타일 
.footer {
	position: fixed;
	bottom: 0;
	left: 0;
	width: 100%;
	padding: 20px 30px;
	display: flex;
	justify-content: space-between;
	box-sizing: border-box;
	font-size: 14px;
}
*/
/* 페이지네이션 컨테이너 스타일 */
.pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 20px;
    padding: 10px 0;
    font-size: 14px;
}

/* 페이지 번호 스타일 */
.pagination a,
.pagination span {
    display: inline-block;
    padding: 8px 12px;
    margin: 0 5px;
    text-decoration: none;
    color: #555;
    border: 1px solid #ddd;
    border-radius: 4px;
    transition: all 0.3s ease;
}

/* 현재 페이지 번호 스타일 */
.pagination .current {
    background-color: #FC8173;
    color: #fff;
    font-weight: bold;
    border-color: #FC8173;
}

/* 호버 시 스타일 */
.pagination a:hover {
    background-color: #f4f4f4;
    border-color: #bbb;
    color: #000;
}
</style>
</head>
<body>

	<!-- 사이드바 -->
	<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
	<!-- 리모콘 -->
	<jsp:include page="/WEB-INF/views/common/remote.jsp" />

	<!-- 메인 레이아웃 -->
	<div class="main-container">

		<!-- 헤더 -->
		<div class="header">
			<jsp:include page="/WEB-INF/views/common/header.jsp" />
		</div>

		<!-- 콘텐츠 영역 -->
		<div class="content">
			<h1>자유게시판</h1>
			<br> <br> <br> <br>
			<!-- 버튼과 테이블을 같은 섹션에 포함 -->
			<div
				style="display: flex; justify-content: space-between; align-items: center; width: 80%; margin: 0 auto;">
				<h2 style="margin: 0;">목록</h2>
				<!-- 테이블 제목 -->
				<a href="/post/freePostWirter.do" class="btn-write">작성하기</a>
				<!-- 작성하기 버튼 -->
			</div>
			<br>
			<table>
				<thead>
					<tr>
						<th>번호</th>
						<th>분류</th>
						<th>제목</th>
						<th>작성자</th>
						<th>조회수</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="post" items="${list}">
						<tr>
							<td>${post.postKey}</td>
							<td>${post.postCategory}</td>
							<td><a href="/post/postView.do?postCd=${notice.noticeNo}">${post.postTitle}</a></td>
							<td>${post.userNickname}</td>
							<td>${post.postViews}</td>
							<td>${post.postDate}</td>
						</tr>
					</c:forEach>
					<c:if test="${empty list}">
						<tr>
							<td colspan="6">게시글이 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<div class="pagination">${pageNavi}</div>
		<br><br><br><br><br><br>
		<!-- 풋터 -->
		<div class="footer">
			<jsp:include page="/WEB-INF/views/common/footer.jsp" />
		</div>
		</div>
		
		
		

	</div>

</body>
</html>