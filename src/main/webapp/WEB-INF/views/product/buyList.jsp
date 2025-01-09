<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sooljura</title>
<style>
main {
	background-color: #EFECE5;
}

.div-wrap {
	margin: 0 auto;
	width: 60%;
	border: 1px solid gray;
	height: auto;
	margin-top: 10px;
	background-color: #EFECE5;
}

.center-div-items {
	padding: 5px;
}

.prodNm, .prodPrice, #payDay {
	font-size: 20px;
	font-weight: bold;
	margin-top: 10px;
	border: none;
	background-color: #EFECE5;
}

.myPageChoices {
	width: 700px;
	margin: 0 auto;
	display: flex;
	justify-content: center;
}

.myPageChoiceBtn {
	width: 500px;
	height: 50px;
	margin: 15px;
	font-size: 20px;
	font-weight: bold;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
	<main>
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<div class="wrapper">
			<div class="content">
				<div class="title">
					<h1>마이 페이지</h1>
				</div>

				<div class="myPageChoices">
					<button class="myPageChoiceBtn" value="1" id="userInfo">회원
						정보</button>
					<button class="myPageChoiceBtn" value="2" id="shoppingInfo">쇼핑
						정보</button>
					<button class="myPageChoiceBtn" value="3" id="readMyPost">내글
						보기</button>
					<button class="myPageChoiceBtn" value="4" id="likedItems">찜한상품</button>
					<button class="myPageChoiceBtn" value="5" id="addrMng">주소
						관리</button>
				</div>
				<div class="myPageInfoView"></div>
				<h2>구매내역</h2>
				<br>
				<hr>
				<br>
				<!-- 구매 내역 순회 -->
				<c:set var="previousDateTime" value="" scope="page" />
				<c:forEach var="orderHistory" items="${orderHistory}">
					<!-- 현재 주문의 날짜 및 시간 추출 (yyyy-MM-dd HH:mm:ss 형식으로) -->
					<c:set var="currentDateTime" value="${orderHistory.orderDate}" />

					<!-- 새로운 날짜 및 시간이 시작될 때만 출력 -->
					<div class="div-wrap">
						<c:if
							test="${empty previousDateTime or previousDateTime != currentDateTime}">
							<span id="payDay" style="font-size: 15px;">결제일 :
								${currentDateTime}</span>
							<br>
							<!-- 이전 날짜 및 시간을 현재 값으로 업데이트 -->
							<c:set var="previousDateTime" value="${currentDateTime}"
								scope="page" />
						</c:if>

						<!-- 해당 결제 그룹의 제품 출력 -->
						<c:forEach var="product" items="${orderHistory.productList}">
							<div class="center-div-items">
								<span class="prodNm">${product.prodNm}</span>
								<!-- 제품 이름 -->
							</div>
							<div class="center-div-items">
								<span class="prodPrice">${product.prodPrice}</span>
								<!-- 제품 가격 -->
							</div>
						</c:forEach>
					</div>
				</c:forEach>
			</div>
			<jsp:include page="/WEB-INF/views/common/remote.jsp" />
		</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</main>
</body>
</html>