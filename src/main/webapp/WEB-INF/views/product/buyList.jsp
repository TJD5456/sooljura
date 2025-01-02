<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>sooljura</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<main>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <h2>구매내역</h2>
    <c:forEach var="orderHistory" items="${orderHistory}">
        <div>
            <!-- 가능하면 이미지 넣기 -->
        </div>
        <div>
            <span>결제일 : ${orderHistory.orderDate}</span><br>
            <span>${product.productNm}</span>
            <span>${product.productPrice * orderHistory.orderCnt}</span><!-- 제품 총 가격 보여주기 -->
        </div>
        <div>
            <button onclick="detailHistory(this)">상세보기</button>
        </div>
    </c:forEach>
</main>
</body>
</html>