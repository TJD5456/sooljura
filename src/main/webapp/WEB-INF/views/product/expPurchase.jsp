<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sooljura</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<main>
    <h1>장바구니</h1>
    <br><hr><br>

    <!-- 장바구니가 비어 있는 경우 -->
    <c:if test="${empty basketList}">
        <h2>장바구니에 제품이 없습니다</h2>
    </c:if>

    <!-- 장바구니에 제품이 있는 경우 -->
    <c:if test="${not empty basketList}">
        <form action="/product/productBuyFrm.do" method="get">
            <c:forEach var="product" items="${basketList}">
                <div>
                    <input type="checkbox" id="selProduct" onchange="selProduct(this)">
                    <div>
                        <input type="hidden" id="prodKey" value="${product.prodKey}">
                        <div>
                            <a><input type="text" id="prodNm" value="${product.prodNm}" readonly></a><br>
                            <input type="text" id="prodPrice" value="${product.prodPrice}" readonly>
                            <span>수량
					          <span id="basketCnt">1</span>
					          <button onclick="fn.buyCntCalc('-', this)">-</button>
					          <button onclick="fn.buyCntCalc('+', this)">+</button>
        					</span>
                        </div>
                        <div>
                            <input type="button" onclick="delBasket(this)" value="삭제하기">
                            <input type="button" onclick="buyBasket(this)" value="구매하기">
                        </div>
                    </div>
                </div>
            </c:forEach>
            <input type="button" onclick="buyAllBasket(this)" value="전체구매하기">
        </form>
    </c:if>
</main>
<script>
	let fn = {
        buyCntCalc: function (oper, btn) {
          let buyCntObj = $(btn).parent().find("#basketCnt");
          let basketCnt = Number($(btn).parent().find("#basketCnt").html());

          if (oper === "-" && basketCnt < 2) {
	            alert("최소 1개의 수량은 구매하셔야 합니다.");
	            return;
          } else if (oper === "+" && basketCnt > 9) {
	            alert("최대 10개 수량만 주문 가능합니다.");
	            return;
          }

          oper = oper + "1";

          buyCntObj.html(eval(buyCnt + oper));
    }
</script>
</body>
</html>