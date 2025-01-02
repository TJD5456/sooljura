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
#prodNm, #prodPrice{
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
.center-div-items > input[type="button"] : hover{
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
            <c:forEach var="productData" items="${basketList}">
	            <c:forEach var="product" items="${productData.productList}">
                    <input type="hidden" id="prodKey" value="${product.prodKey}">
                    <input type="hidden" id="userKey" value="${loginUser.userKey}">
                    <input type="hidden" id="prodCnt" value="${product.prodCnt}">
	                <div class="div-wrap">
	                	<div class="center-div-items" style="width: 10px; padding:35px;">
	                    	<input type="checkbox" id="selProduct" onchange="selProduct(this)">
	                    </div>
	                    <div class="div-items" style="width: 50%;">
                            <a href="#" style="cursor: pointer;"><input type="text" id="prodNm" value="${product.prodNm}" readonly></a><br>
                            <input type="text" id="prodPrice" value="${product.prodPrice}" readonly>
	                    </div>
                        <div class="center-div-items" style="width: 10%;"><%-- 이름 클릭하면 해당 제품 상세 페이지로 이동 --%>
                            <%-- productData로 가져온 구매 갯수 넣어줘야함 --%>
					          <span id="basketCnt">1</span><br>
					          <button onclick="fn.buyCntCalc('-', this)">-</button>
					          <button onclick="fn.buyCntCalc('+', this)">+</button>
                        </div>
                        <div class="center-div-items" style="width: 10%; justify-items: center;">
                            <input type="button" onclick="delBasket()" value="삭제하기"><br>
                            <input type="button" onclick="buyBasket()" value="구매하기" style="margin-top: 5px;">
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
            let buyCntObj = $(btn).parent().find("#basketCnt");
            let basketCnt = Number($(btn).parent().find("#basketCnt").html());
            let prodCnt = $('#prodCnt').val();

            //나중에 제품관련 model에 넣는 이름 정해지면 수정(product)
            if (oper === "-" && basketCnt < 2) {
                alert("최소 1개의 수량은 구매하셔야 합니다.");
                return;
            } else if (oper === "+" && basketCnt > prodCnt) {
                alert("최대 " + prodCnt + "개 수량만 주문 가능합니다.");
                return;
            }

            oper = oper + "1";

            buyCntObj.html(eval(buyCnt + oper));
        }
    }

    //주문건, 총 금액 보여주기
    function updateOrderSummary() {
        let totalCnt = 0; // 총 prodCnt
        let totalPrice = 0; // 총 prodPrice
    }

    // 체크된 체크박스들을 순회
    $('#basketForm input[type="checkbox"]:checked').each(function () {
        const parentDiv = $(this).closest('div'); // 현재 체크박스가 속한 div
        const prodCnt = Number(parentDiv.find('#prodCnt').val()); // 해당 제품의 prodCnt
        const prodPrice = Number(parentDiv.find('#prodPrice').val()); // 해당 제품의 prodPrice

        totalCnt += prodCnt;
        totalPrice += prodCnt * prodPrice; // 수량과 가격 곱
    });

    // span 태그에 값 업데이트
    $('span#orderSummary').text(`총 ${totalCnt}건의 주문금액 ${totalPrice.toLocaleString()}원`);


    // 체크박스가 변경될 때마다 주문 요약 업데이트
    $('#basketForm input[type="checkbox"]').on('change', updateOrderSummary);

    //단일 제품 삭제
    function delBasket(){
        $.ajax({
            url: "/product/delBasket.do",
            type: "GET",
            data: {
                userKey: $('#userKey').val(),
                prodKey: $('#prodKey').val()
            },
            success: function (res) {
                if (res === "1") {
                    msg('알림', '제품 삭제 완료', 'success', "window.location.reload()");
                } else {
                    msg('알림', '오류가 발생했습니다', 'error')
                }
            },
            error: function () {
                console.lof('ajax 오류');
            }
        });
    }

    //Form을 제출할 때 유효한 데이터만 제출되도록 확인
    $('#basketForm').submit(function (e) {
        const checkedProducts = $('#basketForm input[type="checkbox"]:checked');
        if (checkedProducts.length === 0) {
            alert('구매할 제품을 선택해주세요.');
            e.preventDefault();
        }
    });

</script>
</body>
</html>