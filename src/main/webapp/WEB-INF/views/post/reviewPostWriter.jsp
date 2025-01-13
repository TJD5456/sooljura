<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>제품 후기 작성</title>
<link rel="icon" href="/resources/icons/logo-circle-woText-16px-favicon.png">
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
				<h1>제품 후기 작성</h1>
				<form action="/post/reviewPostWrite.do" method="post">
					<!-- 작성자 -->
					<div class="form-group">
						<label for="author">작성자</label> <input type="text" id="author"
							value="${loginUser.userNickNm}" readonly>
					</div>

					<!-- 제목 입력 -->
					<div class="form-group">
						<label for="title">제목</label> <input type="text" id="title"
							name="postTitle" placeholder="후기 제목을 입력하세요" required>
					</div>

					<!-- 본문 입력 -->
					<div class="form-group">
						<label for="postContent">후기 내용</label>
						<textarea id="postContent" name="postContent" required></textarea>
					</div>

					<!-- **게시판 코드 설정 (숨겨진 필드)** -->
					<input type="hidden" name="postCd" value="3">

					<div class="button-group">
						<button type="button" onclick="history.back();" style="background-color: #FC8173;">취소</button>
						<button type="submit" style="background-color: #FC8173;">작성하기</button>
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
								placeholder : "제품에 대한 후기를 입력하세요...",
							});
		});
	</script>
</body>
</html>
