<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>자유게시판 - 게시글 상세보기</title>
<link rel="stylesheet" href="/resources/css/styles.css">
<style>
body {
	margin: 0;
	font-family: Arial, sans-serif;
	display: flex;
	flex-direction: column;
	height: 100vh;
}

/* 레이아웃 구조 */
.layout {
	display: flex;
	flex: 1;
}

/* 사이드바 */
.sidebar {
	width: 250px;
	height: 100vh;
	background-color: #f9f9f9;
	position: fixed;
	left: 0;
	top: 0;
	border-right: 1px solid #ddd;
	padding: 20px;
	box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
	z-index: 10;
}

/* 리모콘 */
.remote-controller {
	position: fixed;
	top: 20px;
	right: 20px;
}

/* 컨텐츠 영역 */
.content {
	flex: 1;
	padding: 20px;
	overflow-y: auto;
}

.container {
	width: 90%; /* 화면의 90% 사용 */
	max-width: 1200px; /* 최대 너비는 1200px로 제한 */
	margin: 0 auto;
	padding: 20px;
	background-color: #ffffff;
	border: 1px solid #ddd;
	border-radius: 5px;
	box-sizing: border-box; /* 패딩을 포함한 크기 계산 */
}

.post-title {
	font-size: 24px;
	font-weight: bold;
	margin-bottom: 10px;
}

.post-info {
	font-size: 14px;
	color: #555;
	margin-bottom: 20px;
}

.post-content {
	font-size: 16px;
	margin-bottom: 30px;
	line-height: 1.5;
}

/* 댓글 섹션 */
.comments {
	margin-top: 40px;
}

.comments h3 {
	font-size: 20px;
	margin-bottom: 20px;
}

.comment {
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 5px;
	margin-bottom: 15px;
}

.comment .author {
	font-weight: bold;
}

.comment .date {
	font-size: 12px;
	color: #777;
	margin-bottom: 5px;
}

/* 댓글 작성 폼 */
.comment-form {
	margin-top: 30px;
}

.comment-form textarea {
	width: 100%;
	max-width: 100%;
	height: 100px;
	margin-bottom: 10px;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 5px;
	resize: none;
}

.comment-form button {
	padding: 10px 20px;
	background-color: #007BFF;
	color: #fff;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.comment-form button:hover {
	background-color: #0056b3;
}

/* 목록 버튼 */
.back-button {
	margin-top: 20px;
	text-align: right;
}

.back-button a {
	text-decoration: none;
	color: #fff;
	background-color: #555;
	padding: 10px 20px;
	border-radius: 5px;
	transition: background-color 0.3s ease;
}

.back-button a:hover {
	background-color: #777;
}
</style>
</head>
<body>

	<!-- 사이드바 -->
	<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
	<main>
		<!-- 헤더 -->
		<jsp:include page="/WEB-INF/views/common/header.jsp" />

		<!-- 본문 -->
		<div class="container">
			<!-- 게시글 정보 -->
			<h1>자유게시판</h1>
			<br>
			<hr>
			<br>
			<div class="post-title">${post.postTitle}</div>
			<div class="post-info">작성자: ${post.userNickNm} | 작성일:
				${post.postDate} | 조회수: ${post.postViews}</div>
			<div class="post-content">${post.postContent}</div>

			<!-- 댓글 섹션 -->
			<div class="comments">
				<h4>댓글</h4>
				<br> <br>
				<c:forEach var="comment" items="${comments}">
					<div class="comment">
						<div>
							<!-- 댓글 작성자 닉네임 및 수정/삭제 버튼 -->
							<span class="author">${comment.userNickNm}</span>
							<c:if
								test="${not empty loginUser && comment.userKey == loginUser.userKey}">
								<!-- 삭제 버튼 -->
								<form action="/post/deleteComment.do" method="post"
									style="display: inline;">
									<input type="hidden" name="commentKey"
										value="${comment.commentKey}" /> <input type="hidden"
										name="userKey" value="${loginUser.userKey}" />
									<button type="submit"
										style="border: none; background: none; color: red; cursor: pointer;">삭제</button>
								</form>
								<!-- 수정 버튼 -->
								<button type="button"
									style="border: none; background: none; color: blue; cursor: pointer;"
									onclick="editComment('${comment.commentKey}', '${comment.commentContent}');">수정</button>
							</c:if>
						</div>
						<div class="date">${comment.commentDate}</div>
						<div class="content" id="comment-content-${comment.commentKey}">${comment.commentContent}</div>
					</div>
				</c:forEach>

				<!-- 댓글 작성 폼 -->
				<div class="comment-form">
					<c:choose>
						<c:when test="${not empty loginUser}">
							<form action="/post/addComment.do" method="post">
								<textarea name="commentContent" placeholder="댓글 내용을 입력하세요"
									required></textarea>
								<input type="hidden" name="postKey" value="${post.postKey}" />
								<button type="submit">댓글 등록</button>
							</form>
						</c:when>

						<c:otherwise>
							<p>댓글을 작성하려면 로그인이 필요합니다.</p>
							<form action="/user/loginFrm.do" method="get">
								<button type="submit"
									style="color: white; background-color: blue; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer;">
									로그인</button>
							</form>
						</c:otherwise>
					</c:choose>
				</div>
			</div>


			<!-- 목록 버튼 -->
			<div class="back-button">
				<a href="/post/list.do">목록</a>
			</div>
		</div>
		<!-- 리모콘 -->
		<div class="remote-controller">
			<jsp:include page="/WEB-INF/views/common/remote.jsp" />
		</div>
	</main>
	<!-- 풋터 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>


<script>
    // 댓글 수정 버튼 클릭 시 수정 폼 표시
    function editComment(commentKey, commentContent) {
    const contentDiv = document.getElementById(`comment-content-${commentKey}`);
    if (!contentDiv) {
        console.error(`Element with id comment-content-${commentKey} not found`);
        return;
    }
    contentDiv.innerHTML = `
        <form action="/post/updateComment.do" method="post">
            <textarea name="commentContent" required>${commentContent}</textarea>
            <input type="hidden" name="commentKey" value="${commentKey}" />
            <button type="submit">수정 완료</button>
            <button type="button" onclick="cancelEdit('${commentKey}', '${commentContent}');">취소</button>
        </form>
    `;
}

    // 수정 취소 시 원래 내용 복원
    function cancelEdit(commentKey, commentContent) {
        const contentDiv = document.getElementById(`comment-content-${commentKey}`);
        contentDiv.innerHTML = commentContent;
    }
</script>
</html>
