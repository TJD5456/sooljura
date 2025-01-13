<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공지사항 상세보기</title>
<link rel="icon" href="/resources/icons/logo-circle-woText-16px-favicon.png">
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 20px;
}

.wrapper {
	width: 70%;
	margin: 0 auto;
}

.content {
	padding: 20px;
	background-color: #fdfdfd;
	border-radius: 8px;
	border: 1px solid #ddd;
}

.post-title {
	font-size: 24px;
	font-weight: bold;
	margin-bottom: 10px;
}

.post-info {
	font-size: 14px;
	color: #666;
	margin-bottom: 20px;
}

.post-content {
	line-height: 1.6;
	margin-bottom: 30px;
}

.back-button {
	text-align: center;
	margin-top: 20px;
}

.back-button button {
	padding: 10px 20px;
	background-color: #555;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.back-button button:hover {
	background-color: #333;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
	<main>
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<div class="wrapper">
			<div class="container content">
				<!-- 공지사항 정보 -->
				<h1>공지사항</h1>
				<div class="post-title">${post.postTitle}</div>
				<div class="post-info">작성자: ${post.userNickNm} | 작성일:
					${post.postDate} | 조회수: ${post.postViews}</div>
				<c:if test="${not empty loginUser && loginUser.userCd == 0}">
					<!-- 수정 및 삭제 버튼 -->
					<div style="margin-bottom: 20px; text-align: right;">
						<a href="/post/noticePostEdit.do?postKey=${post.postKey}"
							onclick="return confirm('수정 페이지로 이동하시겠습니까?');"
							style="padding: 8px 16px; background-color: #FC8173; color: white; text-decoration: none; border-radius: 5px; margin: 5px;">
							수정 </a>
						<form action="/post/deletePost.do" method="post"
							style="display: inline;"
							onsubmit="return confirm('게시글을 삭제하시겠습니까?');">
							<input type="hidden" name="postKey" value="${post.postKey}">
							<button type="submit"
								style="padding: 8px 16px; background-color: FC8173; color: white; border: none; border-radius: 5px; cursor: pointer;">
								삭제</button>
						</form>
					</div>
				</c:if>




				<div class="post-content">${post.postContent}</div>

				<div class="back-button">
					<!-- 뒤로가기 버튼 -->
					<button onclick="history.back();" style="background-color: #FC8173;">뒤로가기</button>
				</div>
			</div>
			<jsp:include page="/WEB-INF/views/common/remote.jsp" />
		</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</main>
</body>
</html>
