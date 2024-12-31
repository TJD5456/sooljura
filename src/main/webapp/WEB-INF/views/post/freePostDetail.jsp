<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>자유게시판 - 게시글 상세보기</title>
<link rel="stylesheet" href="/resources/css/styles.css">
<style>
/* 기존 스타일 유지 */
body {
	margin: 0;
	font-family: Arial, sans-serif;
	display: flex;
	flex-direction: column;
	height: 100vh;
}

.layout {
	display: flex;
	flex: 1;
}

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

.remote-controller {
	position: fixed;
	top: 20px;
	right: 20px;
}

.content {
	flex: 1;
	padding: 20px;
	overflow-y: auto;
}

.container {
	width: 90%;
	max-width: 1200px;
	margin: 0 auto;
	padding: 20px;
	background-color: #ffffff;
	border: 1px solid #ddd;
	border-radius: 5px;
	box-sizing: border-box;
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

textarea {
	resize: none; /* 사용자가 크기 변경 불가 */
	border: 1px solid #ddd;
	padding: 10px;
	border-radius: 5px;
}

.comments {
	margin-top: 40px;
}

.comments h3 {
	font-size: 20px;
	margin-bottom: 20px;
}

.comment {
	margin-bottom: 20px;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 5px;
}

.comment .content {
	margin-top: 10px;
}

.comment .author {
	font-weight: bold;
}

.comment .date {
	font-size: 12px;
	color: #777;
	margin-bottom: 5px;
}

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
						<!-- 댓글 작성자 -->
						<!-- 수정 및 삭제 버튼 (작성자만 표시) -->
						<c:forEach var="comment" items="${comments}">
							<div class="comment" id="comment-${comment.commentKey}">
								<div>
									<span class="author">${comment.userNickNm}</span>
									<c:if
										test="${not empty loginUser && comment.userKey == loginUser.userKey}">
										<!-- 삭제 버튼 -->
										<form action="/post/deleteComment.do" method="post"
											onsubmit="return confirm('정말 삭제하시겠습니까?');"
											style="display: inline;">
											<input type="hidden" name="commentKey"
												value="${comment.commentKey}" />
											<button type="submit"
												style="border: none; background: none; color: red; cursor: pointer;">삭제</button>
										</form>

										<!-- 수정 버튼 -->
										<button type="button"
											onclick="editComment('${comment.commentKey}', '${fn:escapeXml(comment.commentContent)}');">수정</button>
									</c:if>
								</div>
								<div class="date">${comment.commentDate}</div>
								<div class="content" id="comment-content-${comment.commentKey}">${fn:escapeXml(comment.commentContent)}</div>
							</div>
						</c:forEach>


						<!-- 댓글 작성 날짜 -->
						<div class="date">${comment.commentDate}</div>

						<!-- 댓글 내용 -->
						<div class="content" id="comment-content-${comment.commentKey}">${comment.commentContent}</div>
					</div>
				</c:forEach>
			</div>

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


		<div class="back-button">
			<!-- 뒤로가기 버튼 -->
			<button onclick="history.back();"
				style="border: none; background-color: #555; color: white; padding: 10px 20px; border-radius: 5px; cursor: pointer;">
				뒤로가기</button>
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
	function editComment(commentKey, commentContent) {
		// DOM 요소 찾기
		const parentDiv = document.getElementById(`comment-${commentKey}`);
		const contentDiv = document
				.getElementById(`comment-content-${commentKey}`);

		// 요소 존재 여부 확인
		if (!parentDiv || !contentDiv) {
			console
					.error(`Element with id comment-${commentKey} or comment-content-${commentKey} not found`);
			return;
		}

		// 기존 내용 숨기기
		contentDiv.style.display = 'none';

		// 수정 폼 생성
		const form = document.createElement('form');
		form.action = '/post/updateComment.do';
		form.method = 'post';

		const textarea = document.createElement('textarea');
		textarea.name = 'commentContent';
		textarea.textContent = commentContent;
		textarea.style.width = '100%';
		textarea.style.height = '100px';
		form.appendChild(textarea);

		const hiddenInput = document.createElement('input');
		hiddenInput.type = 'hidden';
		hiddenInput.name = 'commentKey';
		hiddenInput.value = commentKey;
		form.appendChild(hiddenInput);

		const submitButton = document.createElement('button');
		submitButton.type = 'submit';
		submitButton.textContent = '수정 완료';
		form.appendChild(submitButton);

		const cancelButton = document.createElement('button');
		cancelButton.type = 'button';
		cancelButton.textContent = '취소';
		cancelButton.onclick = function() {
			cancelEdit(commentKey, commentContent);
		};
		form.appendChild(cancelButton);

		parentDiv.appendChild(form);
	}

	function cancelEdit(commentKey, commentContent) {
		const parentDiv = document.getElementById(`comment-${commentKey}`);
		const contentDiv = document
				.getElementById(`comment-content-${commentKey}`);

		if (!parentDiv || !contentDiv) {
			console
					.error(`Element with id comment-${commentKey} or comment-content-${commentKey} not found`);
			return;
		}

		contentDiv.style.display = 'block';
		const form = parentDiv.querySelector('form');
		if (form) {
			parentDiv.removeChild(form);
		}
	}
</script>
</html>
