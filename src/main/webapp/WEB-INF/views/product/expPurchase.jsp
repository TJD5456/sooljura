<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    display: flex;
    border: 1px solid gray;
    height: 100px;
    margin-top: 10px;
    background-color: #EFECE5;
}

.center-div-items {
    padding: 25px;
}

.center-div-items > button {
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

.center-div-items > input[type="button"] {
    border: none;
    border-radius: 15px;
    color: #efece5;
    background-color: #fc8173;
    box-shadow: 1px 1px 1px 1px var(--button-shadow);
    height: 25px;
    width: 60px;
}

.center-div-items > input[type="button"]:hover {
    background-color: #f5afa5;
    box-shadow: 1px 1px 1px 1px var(--button-background);
}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<main>
    <jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
    <h1>장바구니</h1>
    <br>
    <hr>
    <br>

    <!-- 장바구니가 비어 있는 경우 -->
    <c:if test="${empty basketList}">
        <h2>장바구니에 제품이 없습니다</h2>
    </c:if>
    <!-- 장바구니에 제품이 있는 경우 -->
    <c:if test="${not empty basketList}">

        <form action="/product/productBuyFrm.do" id="basketForm" method="get">

            <input type="checkbox" id="selectAll" onchange="toggleSelectAll(this)"><label for="selectAll">전체 선택</label>
            <input type="hidden" id="userKey" name="userKey" value="${loginUser.userKey}">

            <c:forEach var="basketProductInfo" items="${basketList}">
		    <!-- Basket 정보 -->
		    <c:set var="basket" value="${basketProductInfo.basket}" />
		
		    <!-- Product 정보 -->
		    <c:forEach var="product" items="${basketProductInfo.productList}">
		        <div class="div-wrap">
		            <input type="hidden" class="prodKey" name="prodKey" value="${product.prodKey}">
		            <input type="hidden" class="prodCnt" value="${product.prodCnt}"> <!-- 제품 재고 -->
		            <input type="hidden" class="basketCnt" value="${basket.basketCnt}"> <!-- 장바구니 수량 -->
		
		            <div class="center-div-items" style="width: 10px; padding:35px;">
		                <input type="checkbox" class="selProduct" value="${product.prodKey}">
		            </div>
		
		            <div class="div-items" style="width: 50%;">
		                <a href="#" style="cursor: pointer;">
		                    <input type="text" class="prodNm" value="${product.prodNm}" readonly>
		                </a><br>
		                <input type="text" class="prodPrice" value="${product.prodPrice}" readonly>
		            </div>
		
		            <div class="center-div-items" style="width: 10%;">
		                <!-- 장바구니 수량 -->
		                <span class="basketCnt">${basket.basketCnt}</span><br>
		                <button type="button" onclick="fn.buyCntCalc('-', this)">-</button>
		                <button type="button" onclick="fn.buyCntCalc('+', this)">+</button>
		            </div>
		
		            <div class="center-div-items" style="width: 10%; justify-items: center;">
		                <input type="button" onclick="delBasket(this)" value="삭제하기"><br>
		                <input type="button" onclick="buyBasket(this)" value="구매하기" style="margin-top: 5px;">
		            </div>
		        </div>
		    </c:forEach>
		</c:forEach>
            <div class="fixed-div">
            	<!-- 제품 총 금액 name 선언해서 넘겨주기 -->
                <span id="orderSummary" style="font-size: 30px; margin-top: 10px;">총 <span id="totalCnt">0</span>건의 주문금액 <span id="totalPrice">0</span>원</span>
                <input type="submit" style="border-radius: 10px; height: 50px; margin-top: 10px;" value="선택한 제품 구매하기">
            </div>
        </form>
    </c:if>
</main>

<script>
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

            // 수량 증가/감소
            basketCnt += (oper === '+') ? 1 : -1;
            $basketCnt.text(basketCnt);

            // 총합 갱신
            updateOrderSummary();
        }
    };

    function updateOrderSummary() {
        let totalCnt = 0;
        let totalPrice = 0;

        $('#basketForm .selProduct:checked').each(function () {
            const $parentDiv = $(this).closest('.div-wrap');
            const basketCnt = Number($parentDiv.find('.basketCnt').text());
            const prodPrice = Number($parentDiv.find('.prodPrice').val());

            totalCnt += basketCnt; // 수량 합산
            totalPrice += basketCnt * prodPrice; // 가격 합산
        });

        // 값 갱신
        $('#totalCnt').text(totalCnt);
        $('#totalPrice').text(totalPrice.toLocaleString());
        console.log("totalCnt:", totalCnt, "totalPrice:", totalPrice);
    }

    function toggleSelectAll(checkbox) {
        const isChecked = checkbox.checked;
        $('#basketForm .selProduct').prop('checked', isChecked);
        updateOrderSummary(); // 전체 선택/해제 시 총합 갱신
    }

    // 장바구니 제품 삭제
    function delBasket(button) {
        const prodKey = $(button).closest('.div-wrap').find('.prodKey').val();
        const userKey = $('#userKey').val();

        $.ajax({
            url: "/product/delBasket.do",
            type: "GET",
            data: { prodKey, userKey },
            success: function (res) {
                if (res === "1") {
                    msg('알림', '제품 삭제 완료', 'success', "location.href = '/product/expPurchaseFrm.do';");
                } else {
                    msg('알림', '오류가 발생했습니다', 'error');
                }
            },
            error: function () {
                console.log('장바구니 삭제 ajax 오류');
            }
        });
    }

    // 폼 제출 시 체크된 제품만 처리
    document.querySelector('#basketForm').addEventListener('submit', function (event) {
        event.preventDefault(); // 기본 폼 제출 방지

        const checkedProducts = document.querySelectorAll('.selProduct:checked');
        const userKey = document.querySelector('#userKey').value;

        if (checkedProducts.length === 0) {
            alert("선택된 제품이 없습니다.");
            return;
        }

        const prodKeys = Array.from(checkedProducts).map(input => input.value);

        const url = new URL(this.action, window.location.origin);
        url.searchParams.append('userKey', userKey);
        prodKeys.forEach(key => url.searchParams.append('prodKeys', key));

        window.location.href = url.toString();
    });
</script>
</body>
</html>