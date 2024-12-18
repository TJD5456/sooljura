<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>자유게시판 글쓰기</title>
<style>
/* 전체 레이아웃 */
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	display: flex;
	flex-direction: column;
	min-height: 100vh;
}

/* 사이드바 스타일 */
.leftSideBar {
	width: 250px;
	background-color: #f8f5f0;
	position: fixed;
	top: 0;
	left: 0;
	bottom: 0;
	padding: 20px;
	box-sizing: border-box;
	overflow-y: auto;
}

.main-container {
	margin-left: 250px; /* 사이드바 너비 */
	display: flex;
	flex-direction: column;
	min-height: 100vh;
}

.header, .footer {
	background-color: #fff;
	text-align: center;
	padding: 10px 20px;
	border-bottom: 1px solid #ddd;
}

.footer {
	margin-top: auto; /* 푸터를 하단에 고정 */
	border-top: 1px solid #ddd;
}

/* 콘텐츠 영역 */
.content {
	flex: 1;
	padding: 20px;
	box-sizing: border-box;
	background-color: #fff;
	margin: 20px;
	border: 1px solid #ddd;
	border-radius: 8px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

/* 폼 스타일 */
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

.form-group input[type="text"], .form-group select, textarea {
	flex: 1;
	padding: 8px;
	border: 1px solid #ddd;
	border-radius: 4px;
}

textarea {
	height: 200px;
	resize: none;
}

.button-group {
	display: flex;
	justify-content: center;
	gap: 10px;
	margin-top: 20px;
}

.button-group button {
	padding: 10px 30px;
	background-color: #007BFF;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

.button-group button:hover {
	background-color: #0056b3;
}

.button-group button:last-child {
	background-color: #6c757d;
}

.button-group button:last-child:hover {
	background-color: #5a6268;
}
</style>
</head>
<body>

	<!-- 사이드바 -->
	<div class="leftSideBar">
		<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
	</div>

	<!-- 메인 레이아웃 -->
	<div class="main-container">

		<!-- 헤더 -->
		<div class="header">
			<jsp:include page="/WEB-INF/views/common/header.jsp" />
		</div>

		<!-- 콘텐츠 -->
		<div class="content">
			<h1>자유 게시판 글쓰기</h1>

			<!-- 말머리 -->
			<div class="form-group">
				<label for="category">말머리</label> <select id="category"
					name="category">
					<option value="일상">일상</option>
					<option value="질문">질문</option>
					<option value="정보 나눔">정보 나눔</option>
					<option value="공지사항">공지사항</option>
				</select>
			</div>

			<!-- 글쓴이 -->
			<div class="form-group">
				<label for="author">글쓴이</label> <input type="text" id="author"
					name="author" value="이름" readonly>
			</div>

			<!-- 제목 -->
			<div class="form-group">
				<label for="title">제목</label> <input type="text" id="title"
					name="title" placeholder="제목을 입력하세요">
			</div>

			<!-- 본문 -->
			<div class="form-group">
				<label for="content">본문</label>
				<textarea id="content" name="content" placeholder="내용을 입력하세요..."></textarea>
			</div>

			<!-- 버튼 -->
			<div class="button-group">
				<button type="button">이전</button>
				<button type="submit">저장</button>
			</div>
		</div>

		<!-- 풋터 -->
		<div class="footer">
			<jsp:include page="/WEB-INF/views/common/footer.jsp" />
		</div>
	</div>

</body>
</html>