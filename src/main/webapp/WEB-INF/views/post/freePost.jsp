<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	flex-direction: column; /* 전체 페이지를 세로 방향으로 구성 */
	font-family: Arial, sans-serif;
	min-height: 100vh; /* 화면 전체 높이 */
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
}

/* 메인 콘텐츠 및 레이아웃 */
.main-container {
	margin-left: 250px; /* 사이드바의 너비만큼 여백 */
	display: flex;
	flex-direction: column;
	justify-content: space-between; /* 콘텐츠와 풋터 사이 여백 */
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
	box-sizing: border-box;
	display: flex;
	flex-direction: column; /* 요소들을 세로로 정렬 */
	justify-content: flex-start; /* 상단 정렬 */
	align-items: center; /* 가운데 정렬 */
}

/* 테이블 스타일 */
table {
	width: 80%; /* 테이블의 최대 너비 설정 */
	max-width: 1000px; /* 최대 크기 제한 */
	margin: 0 auto; /* 가운데 정렬 */
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

h1 {
	margin: 0; /* h1 여백 제거 */
	font-size: 2rem; /* 적절한 크기로 조정 */
	text-align: center; /* 텍스트 가운데 정렬 */
}

.notice {
	font-weight: bold;
	color: #ff5722;
}

/* 풋터 스타일 */
.footer {
	position: fixed; /* 화면 하단에 고정 */
	bottom: 0; /* 화면의 아래쪽에 위치 */
	left: 0; /* 왼쪽 기준 정렬 */
	width: 100%; /* 전체 가로폭 */
	padding: 20px 30px; /* 안쪽 여백 */
	display: flex;
	justify-content: space-between; /* 내용 양쪽 정렬 */
	align-items: center; /* 세로 중앙 정렬 */
	box-sizing: border-box;
	font-size: 14px; /* 글자 크기 */
}
/* 작성하기 버튼 스타일 */
.btn-write {
	display: inline-block;
	margin-top: 20px;
	padding: 10px 30px;
	background-color: #FC8173;
	color: #EFECE5;
	font-size: 16px;
	border-radius: 5px;
	text-align: center;
	text-decoration: none; /* 밑줄 제거 */
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* 버튼 그림자 */
	transition: background-color 0.3s ease;
}

.btn-write:hover {
	background-color: #ddd;
}
</style>
</head>
<body>

	<!-- 사이드바 -->
	<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
	<!-- 리모콘 -->
	<jsp:include page="/WEB-INF/views/common/remoteController.jsp" />

	<!-- 메인 레이아웃 -->
	<div class="main-container">

		<!-- 헤더 -->
		<div class="header">
			<jsp:include page="/WEB-INF/views/common/header.jsp" />
		</div>

		<!-- 콘텐츠 영역 -->
		<div class="content">
			<h1>자유게시판</h1>

			<table>
				<thead>
					<tr>
						<th>번호</th>
						<th>분류</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회수</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="notice">공지</td>
						<td class="notice">공지</td>
						<td class="notice">충사모 앱 다운로드 즉시 3000pt 적립 지급!</td>
						<td>관리자</td>
						<td>2024-10-04</td>
						<td>159</td>
					</tr>
					<tr>
						<td class="notice">공지</td>
						<td class="notice">공지</td>
						<td class="notice">수리금액 및 유의사항</td>
						<td>관리자</td>
						<td>2017-07-05</td>
						<td>3247</td>
					</tr>
					<tr>
						<td>193</td>
						<td>일상</td>
						<td>오늘은 훈련 하기 싫은 날이네!~!</td>
						<td>메시</td>
						<td>2024-12-02</td>
						<td>18</td>
					</tr>
					<tr>
						<td>192</td>
						<td>정보</td>
						<td>※ 2024년 11월 무이자할부!</td>
						<td>관리자</td>
						<td>2024-11-01</td>
						<td>73</td>
					</tr>
				</tbody>
			</table>

			<a href="/post/freePostWirter.do">작성하기</a>
		</div>
		<!-- 풋터 -->
		<div class="footer">
			<jsp:include page="/WEB-INF/views/common/footer.jsp" />
		</div>

	</div>

</body>
</html>