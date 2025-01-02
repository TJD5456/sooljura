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
<script src="/resources/js/custom.js"></script>
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
	display: block; /* 모든 댓글과 수정 창이 세로로 나열되도록 설정 */
}

.comments h3 {
	font-size: 20px;
	margin-bottom: 20px;
}
.comment {
    position: relative;
    margin-bottom: 20px;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    display: flex;
    flex-direction: column; /* 댓글 내용과 수정 폼을 세로로 배치 */
    align-items: stretch; /* 수정 폼 너비가 댓글 컨테이너 너비와 동일하도록 설정 */
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
#edit-form-container-${commentKey} {
    margin-top: 10px; /* 수정 폼과 댓글 간 간격 */
    width: 100%; /* 댓글 컨테이너에 맞춤 */
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
					<div class="comment" id="comment-${comment.commentKey}">
						<!-- 댓글 작성자 -->
						<div>
							<span class="author">${comment.userNickNm}</span>
							<c:if
								test="${not empty loginUser && comment.userKey == loginUser.userKey}">
								<button type="button"
									onclick="editComment('${comment.commentKey}', '${fn:escapeXml(comment.commentContent).replaceAll("
									'", "\\'")}')"
        							style="border: none; background: none; color: blue; cursor: pointer;">
									수정</button>
								<!-- 삭제 버튼 -->
								<form action="/post/deleteComment.do" method="post"
									onsubmit="return confirm('정말 삭제하시겠습니까?');"
									style="display: inline;">
									<input type="hidden" name="commentKey"
										value="${comment.commentKey}" />
									<button type="submit"
										style="border: none; background: none; color: red; cursor: pointer;">
										삭제</button>
								</form>
							</c:if>
						</div>
						<!-- 댓글 작성 날짜 -->
						<div class="date">${comment.commentDate}</div>
						<!-- 댓글 내용 -->
						<div class="content" id="comment-content-${comment.commentKey}">
							${fn:escapeXml(comment.commentContent)}</div>
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
		<div class="comment" id="comment-${comment.commentKey}">
			<div class="content" id="comment-content-${comment.commentKey}">
				${fn:escapeXml(comment.commentContent)}</div>
		</div>
		<!-- 리모콘 -->
		<div class="remote-controller">
			<jsp:include page="/WEB-INF/views/common/remote.jsp" />
		</div>
	</main>
	<!-- 풋터 -->
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

	<script>
    // 현재 수정 중인 댓글의 key를 추적
    let currentEditingKey = null;

    // 댓글 수정 함수
    window.editComment = function (commentKey, commentContent) {
        console.log("EditComment Called:", commentKey, commentContent);

        // 이미 다른 댓글을 수정 중일 경우 확인 메시지
        if (currentEditingKey && currentEditingKey !== commentKey) {
            if (!confirm("현재 수정 중인 댓글이 있습니다. 다른 댓글을 수정하시겠습니까?")) {
                return;
            }
            cancelEdit(currentEditingKey); // 기존 수정 취소
        }

        // 수정 중인 key 업데이트
        currentEditingKey = commentKey;

        const parentDiv = document.getElementById(`comment-${commentKey}`);
        const contentDiv = document.getElementById(`comment-content-${commentKey}`);

        if (!parentDiv || !contentDiv) {
            console.error(`Element not found for commentKey: ${commentKey}`);
            return;
        }

        // 이미 수정 폼이 생성된 경우 추가 생성 방지
        if (document.getElementById(`edit-form-container-${commentKey}`)) {
            console.warn("Edit form already exists for this comment.");
            return;
        }

        // 댓글 내용을 숨김
        contentDiv.style.display = 'none';

        // 수정 폼 생성
        const formContainer = document.createElement('div');
        formContainer.id = `edit-form-container-${commentKey}`;
        formContainer.style.marginTop = '10px';

        const form = document.createElement('form');
        form.action = '/post/editComment.do';
        form.method = 'post';

        const textArea = document.createElement('textarea');
        textArea.name = 'commentContent';
        textArea.value = commentContent;
        textArea.style.width = '100%';
        textArea.style.marginBottom = '10px';
        form.appendChild(textArea);

        const hiddenInput = document.createElement('input');
        hiddenInput.type = 'hidden';
        hiddenInput.name = 'commentKey';
        hiddenInput.value = commentKey;
        form.appendChild(hiddenInput);

        const saveButton = document.createElement('button');
        saveButton.type = 'submit';
        saveButton.textContent = '저장';
        saveButton.style.marginRight = '10px';
        form.appendChild(saveButton);

        const cancelButton = document.createElement('button');
        cancelButton.type = 'button';
        cancelButton.textContent = '취소';
        cancelButton.onclick = function () {
            cancelEdit(commentKey);
        };
        form.appendChild(cancelButton);

        formContainer.appendChild(form);

        // 댓글 내용 바로 아래에 수정 폼 삽입
        contentDiv.insertAdjacentElement('afterend', formContainer);
    };

    // 댓글 수정 취소 함수
    window.cancelEdit = function (commentKey) {
        console.log("CancelEdit Called:", commentKey);

        const formContainer = document.getElementById(`edit-form-container-${commentKey}`);
        const contentDiv = document.getElementById(`comment-content-${commentKey}`);

        if (formContainer) {
            formContainer.remove();
        }
        if (contentDiv) {
            contentDiv.style.display = 'block';
        }

        // 수정 상태 초기화
        currentEditingKey = null;
    };
</script>


</body>
</html>
