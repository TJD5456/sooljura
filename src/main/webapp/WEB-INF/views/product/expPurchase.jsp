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
.div-wrap{
	margin: 0 auto;
    width: 60%;
    display: flex;
    border: 1px solid gray;
    height: 100px;
    margin-top: 10px;
    background-color: #EFECE5;
}
.center-div-items{
	padding: 25px;
}
.center-div-items > button{
	width: 30px;
	height: 15px;
}
.fixed-div{
	position: fixed;
	display: flex;
	width: 100%;
	height: 70px;
	justify-content: center;
	border-top: 1px solid gray;
	bottom: 0;
	background-color: #EFECE5;
}
.prodNm, .prodPrice{
	font-size: 20px;
	font-weight: bold;
	margin-top: 10px;
	border: none;
	background-color: #EFECE5;
}
.center-div-items > input[type="button"]{
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
        	<input type="checkbox" id="selectAll" onchange="toggleSelectAll(this)"> 전체 선택
            <input type="hidden" id="userKey" name="userKey" value="${loginUser.userKey}">
            <c:forEach var="productData" items="${basketList}">
	            <c:forEach var="product" items="${productData.productList}">
                    <input type="hidden" class="prodKey" name="prodKeys" value="${product.prodKey}">
                    <input type="hidden" class="prodCnt" value="${product.prodCnt}">
	                <div class="div-wrap">
	                	<div class="center-div-items" style="width: 10px; padding:35px;">
	                    	<input type="checkbox" class="selProduct" value="${product.prodKey}">
	                    </div>
	                    <div class="div-items" style="width: 50%;">
                            <a href="#" style="cursor: pointer;"><input type="text" class="prodNm" value="${product.prodNm}" readonly></a><br>
                            <input type="text" class="prodPrice" value="${product.prodPrice}" readonly>
	                    </div>
                        <div class="center-div-items" style="width: 10%;">
					          <span class="basketCnt">1</span><br>
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
	            <span id="orderSummary" style="font-size: 30px; margin-top: 10px;">총 0건의 주문금액 0원</span>
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

    
    function delBasket(button) {
        const prodKey = $('.prodKey').val();
        const userKey = $('#userKey').val();

        $.ajax({
            url: "/product/delBasket.do",
            type: "GET",
            data: { 
            		prodKey: prodKey,
            		userKey: userKey
            	},
            success: function (res) {
                if (res === "1") {
                	msg('알림', '제품 삭제 완료', 'success', "window.location.reload()");
                } else {
                	msg('알림', '오류가 발생했습니다', 'error');
                }
            },
            error: function () {
                console.log('장바구니 삭제 ajax 오류');
            }
        });
    }

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