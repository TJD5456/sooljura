<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>찜리스트</title>
<link rel="icon" href="/resources/icons/logo-circle-woText-16px-favicon.png">
<style>
main {
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
.wrapper {
	display: felx;
	justify-content: center;
}
.content{
	display: flex;
    flex-direction: column;
    align-items: center;
}
}
.semi-title {
	text-align: inherit !important;
}
.likedList{
	width: 1000px;
}
table {
	margin: 0 !important;
	width: 100% !important;
	background-color: white;
	max-width: inherit !important;
}

.div-wrap {
	margin: 0 auto;
	width: 60%;
	display: flex;
	border: 1px solid gray;
	height: 100px;
	margin-top: 10px;
	background-color: #EFECE5;
}

.center-div-items {
	padding: 25px;
}

.center-div-items>button {
	width: 30px;
	height: 15px;
}

.fixed-div {
	position: fixed;
	display: flex;
	width: 100%;
	height: 70px;
	justify-content: center;
	border-top: 1px solid gray;
	bottom: 0;
	background-color: #EFECE5;
}

.prodNm, .prodPrice {
	font-size: 20px;
	font-weight: bold;
	margin-top: 10px;
	border: none;
	background-color: #EFECE5;
}

input[type="button"] {
	border: none;
	border-radius: 15px;
	color: #efece5;
	background-color: #fc8173;
	box-shadow: 1px 1px 1px 1px var(- -button-shadow);
	height: 25px;
	width: 60px;
}

input[type="button"]:hover {
	background-color: #f5afa5;
	box-shadow: 1px 1px 1px 1px var(- -button-background);
}
.semi-title{
	width: 1000px;
	border-bottom: 1px solid black;
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
					<button class="myPageChoiceBtn" value="2" id="shoppingInfo">구매
						내역</button>
					<button class="myPageChoiceBtn" value="3" id="readMyPost">내글
						보기</button>
					<button class="myPageChoiceBtn" value="4" id="likedItems">찜한상품</button>
					<button class="myPageChoiceBtn" value="5" id="addrMng">주소
						관리</button>
				</div>
				<div class="likedList">
					<div class="semi-title">
						<h1>찜 리스트</h1>
					</div>
					<!-- 장바구니가 비어 있는 경우 -->
					<c:if test="${empty basketList}">
						<h4>장바구니에 제품이 없습니다</h4>
					</c:if>
					<!-- 장바구니에 제품이 있는 경우 -->
					<c:if test="${not empty basketList}">

						<form action="/product/productBuyFrm.do" id="basketForm"
							method="get">
							<label for="selectAll"> 전체선택
								<input type="checkbox" id="selectAll" onchange="toggleSelectAll(this)">
							</label> 
							<input type="hidden" id="userKey" name="userKey" value="${loginUser.userKey}">
							<input type="button" class="delSelectedLikedList" onclick="delBasket(this)" value="선택 제거">
								
							<table>
								<colgroup>
									<col width="5%" />
									<col width="15%" />
									<col width="65%" />
									<col width="15%" />
								</colgroup>
								<c:forEach var="productData" items="${basketList}">
									<c:forEach var="product" items="${productData.productList}" varStatus="status">
										<tr>
											<td>
												<div class="center-div-items" style="width: 10px; padding: 35px;">
													<input type="checkbox" class="selProduct" value="${product.prodKey}"> 
												</div>
											</td>
											<td>
												<div>
													<img alt="" width="100px"
														src="/resources/upload/productImages/${product.imgPath}">
												</div>
											</td>
											<td>
												<div class="div-items">
													<a href="/product/prodDetail.do?prodKey=${product.prodKey}"><span>${product.prodNm}</span></a>
												</div>
											</td>
											<td>
												<div class="div-items">
													<span><fmt:formatNumber value="${product.prodPrice}"
															type="number" pattern="#,###" />원</span>
												</div>
											</td>

											<td>
												<div class="center-div-items" style="width: 10%; justify-items: center;">
													<input type="button" class="delSelectedLikedList" value="제거">
													<input type="hidden" class="prodKey" name="prodKey" value="${product.prodKey}">
												</div>
											</td>
										</tr>
									</c:forEach>
								</c:forEach>
							</table>
						</form>
					</c:if>
				</div>
			</div>
		</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	</main>

	<script>
	$('.myPageChoiceBtn').on('click', function(){
		let i = parseInt($(this).val(), 10);
		
		// 현재 페이지 URL 가져오기
		const url = window.location.href;// URL 객체 생성
		const urlParams = new URLSearchParams(new URL(url).search);// 특정 파라미터 값 가져오기 (예: 'id' 파라미터)
		const paramValue = urlParams.get('pg');
		
		switch (i) {
		case 1:
			location.href="/userMyPage/userInfo.do";
			break;
		case 2:
			location.href="/product/buyList.do?reqPage=1&userKey=${loginUser.userKey}";
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
			location.href="/userMyPage/userMyPageFrm.do";//?
			break;
		case 5:
			location.href="/user/addrListFrm.do";
			break;
		default:
			break;
		}
		
	})
	
    let fn = {
        buyCntCalc: function (oper, btn) {
            let $parent = $(btn).closest('.center-div-items');
            let $basketCnt = $parent.find('.basketCnt');
            let basketCnt = Number($basketCnt.text());
            let prodCnt = Number($parent.closest('.div-wrap').find('.prodCnt').val());

            if (oper === '-' && basketCnt <= 1) {
                alert("최소 1개의 수량은 구매하셔야 합니다.");
                return;
            } else if (oper === '+' && basketCnt >= prodCnt) {
                alert("최대 " + prodCnt + "개 수량만 주문 가능합니다.");
                return;
            }

            basketCnt += (oper === '+') ? 1 : -1;
            $basketCnt.text(basketCnt);

            updateOrderSummary();
        }
    };

    function updateOrderSummary() {
        let totalCnt = 0;
        let totalPrice = 0;

        $('#basketForm .selProduct:checked').each(function () {
            const $parentDiv = $(this).closest('.div-wrap');
            const prodCnt = Number($parentDiv.find('.basketCnt').text());
            const prodPrice = Number($parentDiv.find('.prodPrice').val());

            totalCnt += prodCnt;
            totalPrice += prodCnt * prodPrice;
        });

        $('#orderSummary').text(`총 ${totalCnt}건의 주문금액 ${totalPrice.toLocaleString()}원`);
        console.log("totalCnt : " + totalCnt + ", totalPrice : " + totalPrice);
    }
    //선택삭제
	$('.delSelectedLikedList').on('click', function(){
		 const prodKeyArr = []; // prodKey 배열 선언
		    $('.selProduct:checked').each(function () { // 체크된 prodKey들을 배열에 추가
		    	prodKeyArr.push($(this).val());
		    });
		    const userKey = $('#userKey').val();

		    console.log("prodKeyArr : ", prodKeyArr);
		    console.log("userKey : ", userKey);

		    $.ajax({
		        url: "/userMyPage/delSelectedLikedList.do",
		        type: "GET",
		        traditional: true, // 배열 데이터를 전송할 수 있도록 설정
		        data: {
		        	prodKeyArr: prodKeyArr, // prodKeys 배열 전송
		            userKey: userKey
		        },
		        success: function (res) {
		            console.log(res);
		            if (res > 0) {
		                msg('알림', '제품 삭제 완료', 'success', "location.href = '/userMyPage/likedProdList.do';");
		            } else {
		                console.log(res);
		                msg('알림', '오류가 발생했습니다', 'error');
		            }
		        },
		        error: function () {
		            console.log('장바구니 삭제 ajax 오류');
		        }
		    });
	});
    /*
	$('.toBasket').on('click', function(){
		
	});
    */
    function toggleSelectAll(checkbox) {
        const isChecked = checkbox.checked;
        $('#basketForm .selProduct').prop('checked', isChecked);
        updateOrderSummary();
    }

    document.querySelector('#basketForm').addEventListener('submit', function (event) {
        event.preventDefault(); // 기본 폼 제출 방지

        const checkedProducts = document.querySelectorAll('.selProduct:checked');
        const userKey = document.querySelector('#userKey').value;

        if (checkedProducts.length === 0) {
            alert("선택된 제품이 없습니다.");
            return;
        }
        if (prodKeyArr.length === 0) {
            alert("삭제할 항목을 선택하세요.");
            return; // 요청 중단
        }
        // 체크된 prodKey 값을 수집
        const prodKeys = Array.from(checkedProducts).map(input => input.value);

        // 동적으로 GET URL 생성
        const url = new URL(this.action, window.location.origin);
        url.searchParams.append('userKey', userKey);
        prodKeys.forEach(key => url.searchParams.append('prodKeys', key));

        // 페이지 이동
        window.location.href = url.toString();
    });
</script>
</body>
</html>