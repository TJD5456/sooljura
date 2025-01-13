<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매 내역</title>
<link rel="icon" href="/resources/icons/logo-circle-woText-16px-favicon.png">
<style>
main {
	background-color: #EFECE5;
}
.content{
		display: flex;
		flex-direction: column;
		align-items: center;
	}
	.innerContext{
		width: 1200px;
		display: flex;
		flex-direction: column;
		align-items: center;
	}
.semiTitle{
	border-bottom: 1px solid grey;
	margin-bottom: 30px;
}
.semiTitle>div{
	margin-bottom: 30px;
}
.myPageInfoView{
	width: 700px;
}
.div-wrap {
	margin: 0 auto;
	border: 1px solid gray;
	height: auto;
	margin-top: 10px;
	background-color: #EFECE5;
	display: flex;
	flex-direction: column;
}
.forEachDiv{
	display: flex;
	justify-content: space-between;
	margin-left: 15px;
	margin-right: 15px;
	margin-bottom: 5px;
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
					<button class="myPageChoiceBtn" value="1" id="userInfo">회원 정보</button>
					<button class="myPageChoiceBtn" value="2" id="shoppingInfo">구매 내역</button>
					<button class="myPageChoiceBtn" value="3" id="readMyPost">내글 보기</button>
					<button class="myPageChoiceBtn" value="4" id="likedItems">찜한상품</button>
					<button class="myPageChoiceBtn" value="5" id="addrMng">주소 관리</button>
				</div>
				<div class="myPageInfoView">
				<div class="semiTitle">
					<h2>구매내역</h2>
					<div></div>
				</div>
				<!-- 구매 내역 순회 -->
				<div class="div-wrap">
				<c:set var="previousDateTime" value="" scope="page" />
				<c:if test="${not empty orderHistory}">
				<c:forEach var="orderHistory" items="${orderHistory}">
					<!-- 현재 주문의 날짜 및 시간 추출 (yyyy-MM-dd HH:mm:ss 형식으로) -->
					<c:set var="currentDateTime" value="${orderHistory.orderDate}" />

					<!-- 새로운 날짜 및 시간이 시작될 때만 출력 -->
						<c:if test="${empty previousDateTime or previousDateTime != currentDateTime}">
							<div class="forEachDiv">
							<span id="payDay" style="font-size: 15px;">결제일 :
								${currentDateTime}</span>
							<!-- 이전 날짜 및 시간을 현재 값으로 업데이트 -->
							<c:set var="previousDateTime" value="${currentDateTime}" scope="page" />
							</div>
						</c:if>

						<div class="forEachDiv forEachProd">
						<!-- 해당 결제 그룹의 제품 출력 -->
						<c:forEach var="product" items="${orderHistory.productList}">
							<div class="center-div-items">
								<span class="prodNm">${product.prodNm}</span>
								<!-- 제품 이름 -->
							</div>
							<div class="center-div-items">
								<span class="prodPrice"><fmt:formatNumber value="${product.prodPrice}" type="number" pattern="#,###" />원</span>
								<!-- 제품 가격 -->
							</div>
						</c:forEach>
						</div>
				</c:forEach>
				</c:if>
				</div>
				<c:if test="${empty orderHistory}">
					<div>
						구매 내역 없음
					</div>
				</c:if>
				</div>
			</div>
			<jsp:include page="/WEB-INF/views/common/remote.jsp" />
		</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</main>
	<script>
	$('.myPageChoiceBtn').on('click', function() {
		let i = parseInt($(this).val(), 10);

		// 현재 페이지 URL 가져오기
		const url = window.location.href;// URL 객체 생성
		const urlParams = new URLSearchParams(
				new URL(url).search);// 특정 파라미터 값 가져오기 (예: 'id' 파라미터)
		const paramValue = urlParams.get('pg');

		switch (i) {
		case 1:
			location.href = "/userMyPage/userInfo.do"
			break;
		case 2:
			location.href = "/userMyPage/userMyPageFrm.do";
			break;
		case 3:
		    const form = document.createElement('form');
		    form.method = 'POST';
		    form.action = '/post/readMyPost.do';

		    const input = document.createElement('input');
		    input.type = 'hidden';
		    input.name = 'userKey';
		    input.value = '${loginUser.userKey}';
		    form.appendChild(input);

		    document.body.appendChild(form);
		    form.submit(); // 서버로 POST 요청 전송 및 페이지 이동
		
		break;
		case 4:
			location.href = "/userMyPage/likedProdList.do";//?
			break;
		case 5:
			location.href = "/user/addrListFrm.do";
			break;
		default:
			break;
		}

	})
	</script>
</body>
</html>