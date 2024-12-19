<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

/* 전체 레이아웃 설정 */
body {
	margin: 0;
	display: flex;
	flex-direction: column; /* 페이지를 세로 방향으로 구성 */
	font-family: Arial, sans-serif;
	min-height: 100vh; /* 화면 전체 높이를 기준으로 설정 */
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

/* 메인 컨텐츠 스타일 */
.main-container {
	margin-left: 250px; /* 사이드바의 너비만큼 여백 */
	padding-bottom: 60px; /* 풋터와 겹치지 않도록 여백 추가 */
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

.notice {
	font-weight: bold;
	color: #ff5722;
}

/* 풋터 스타일 */
.footer {
	width: 100%; /* 전체 가로폭 */
	padding: 20px 30px; /* 안쪽 여백 */
	text-align: center; /* 가운데 정렬 */
	font-size: 14px; /* 글자 크기 */
	box-sizing: border-box;
	margin-top: auto; /* 컨텐츠 아래로 푸터를 밀어냄 */
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

/* 클로즈 컨텐츠 스타일 */
.close-content {
	display: flex;
	justify-content: center; /* 가로 중앙 정렬 */
	align-items: center; /* 세로 중앙 정렬 */
	padding: 20px; /* 여백 추가 */
}

.close-message {
	font-weight: bold; /* 글자 굵게 */
	text-align: center; /* 텍스트 가운데 정렬 */
	font-size: 20px; /* 글자 크기 조절 */
	line-height: 1.6; /* 줄 간격 조절 */
	white-space: pre-line; /* 줄바꿈을 위해 pre-line 사용 */
}

/* 이미지를 가운데 정렬하는 스타일 */
.center-image {
	display: block; /* 인라인 요소에서 블록 요소로 변경 */
	margin: 20px auto; /* 상하 여백 20px, 좌우 자동 중앙 정렬 */
	max-width: 100%; /* 이미지가 컨테이너 너비를 넘지 않도록 제한 */
	height: auto; /* 비율을 유지하면서 높이를 자동으로 조절 */
}

/* 풋터 스타일 */
.footer {
	left: 250px; /* 사이드바 크기만큼 오른쪽으로 이동 */
	width: calc(100% - 250px); /* 화면 너비에서 사이드바 너비를 뺌 */
	padding: 20px 30px; /* 안쪽 여백 */
	display: flex;
	justify-content: center; /* 가운데 정렬 */
	align-items: center; /* 세로 중앙 정렬 */
	box-sizing: border-box;
	font-size: 14px; /* 글자 크기 */
}

/* 가운데 정렬 적용 */
.midle-content {
    display: flex; /* 컨텐츠를 유연하게 정렬 */
    flex-direction: column; /* 세로 방향으로 요소 배치 */
    justify-content: center; /* 세로 가운데 정렬 */
    align-items: center; /* 가로 가운데 정렬 */
    text-align: center; /* 텍스트 가운데 정렬 */
    padding: 20px; /* 여백 추가 */
    box-sizing: border-box;
}

.midle-content h3 {
    text-align: center; /* h3 텍스트 가운데 정렬 */
    line-height: 1.6; /* 줄 간격 조정 */
}
</style>
</head>
<body>

	<!-- 사이드바 -->
	<div class="sidebar">
		<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
	</div>

	<!-- 리모콘 -->
	<div class="remote-controller">
		<jsp:include page="/WEB-INF/views/common/remoteController.jsp" />
	</div>

	<div class="main-container">

		<!-- 헤더 -->
		<div class="header">
			<jsp:include page="/WEB-INF/views/common/header.jsp" />
		</div>
		<h1>웹사이트 소개</h1>
			<hr>
		<!-- 컨텐츠 영역 -->
		<section class="midle-content">
			<h1>안녕하세요 술주라입니다!</h1>
			<br> <br> <img src="/resources/Introducing/술 마켓.basic.png"
				alt=""> <img src="/resources/Introducing/술마켓.young.png" alt="">

			<h3>
			저희 술주라는 술을 다양한 분야의 술들을 소개하고 저희 제품들을 보고 <br>
			가볍게 한잔 부터 같이 즐겁게 마시는 것까지 <br>
			다양한 주종과 설명을 통해 내가 좋아할만한 술을 찾아보는 재미가 있는 페이지 입니다.
			</h3>
			<br>
			<h3>술주라는 예전에 마시기 싫어도 마셔야 하거나 <br>
				강제하는 마셔야지라는 말과는 반대로 내가 마시고 싶을 때<br>
				못마시는 사람이던 잘마시는 사람이던 한잔 마시고싶을 때를 생각하여 만들었습니다!!</h3>
		</section>

		<img src="/resources/Introducing/img_ligo_cro.png" alt=""
			class="center-image">

		<section class="close-content">
			<div class="close-message">
				"마시기 싫어도 마셔야 했던 시대는 끝!<br> 이제는 '마시고 싶을 때, 딱 한잔!' 술주라에서 당신의 취향
				저격 술을 찾아보세요!"
			</div>
		</section>
	</div>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />

</body>
</html>