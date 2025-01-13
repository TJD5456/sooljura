<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.khedu.sooljura.user.model.vo.User"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>자유 게시판 글 수정</title>
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css"
	rel="stylesheet">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
<style>
.form-group {
	display: flex;
	margin-bottom: 15px;
	align-items: center;
}

.form-group label {
	width: 120px;
	font-weight: bold;
	margin-right: 10px;
}

.form-group input[type="text"], .form-group textarea {
	flex: 1;
	padding: 8px;
	border: 1px solid #ddd;
	border-radius: 4px;
}

.button-group {
	display: flex;
	justify-content: center;
	gap: 10px;
	margin-top: 20px;
}

.button-group button {
	padding: 10px 30px;
	color: white;
	background-color: #007bff;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

.button-group button:hover {
	background-color: #0056b3;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
	<main>
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<div class="wrapper">
			<div class="content">
				<h1>자유 게시판 글 수정</h1>
				<form id="editForm" action="/post/freePostUpdate.do" method="post">
					<!-- 게시글 키 -->
					<input type="hidden" name="postKey" value="${post.postKey}" />

					<div class="form-group">
						<label for="title">제목</label> <input type="text" id="title"
							name="postTitle" value="${post.postTitle}" required>
					</div>

					<div class="form-group">
						<label for="postContent">본문</label>
						<textarea id="postContent" name="postContent">${post.postContent}</textarea>
					</div>

					<div class="button-group">
						<button type="button" style="background-color: #FF4D4D;" onclick="history.back();">취소</button>
						<button type="button" onclick="confirmUpdate();"
							style="padding: 10px 20px; background-color: #FF4D4D; color: white; border: none; border-radius: 5px; cursor: pointer;">
							수정하기</button>
					</div>
				</form>
			</div>
		</div>
	</main>
	<script>
		$(function() {
			$('#postContent')
					.summernote(
							{
								height : 400,
								lang : 'ko-KR',
								toolbar : [
										[ 'style', [ 'style' ] ],
										[
												'font',
												[ 'bold', 'italic',
														'underline', 'clear' ] ],
										[ 'fontname', [ 'fontname' ] ],
										[ 'fontsize', [ 'fontsize' ] ],
										[ 'color', [ 'color' ] ],
										[ 'para', [ 'ul', 'ol', 'paragraph' ] ],
										[
												'view',
												[ 'fullscreen', 'codeview',
														'help' ] ], ],
								placeholder : "내용을 입력하세요...",
							});
		});

		function confirmUpdate() {
			if (confirm("정말 수정하시겠습니까?")) {
				document.getElementById("editForm").submit(); // form 제출
			}
		}
	</script>
</body>
</html>
