<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sooljura</title>
</head>
<body>
	<form action="/product/productBuy.do" method="POST">
		
	</form>
<%-- 
	결제요청
	pg: "kcp.AO09C",             //상점ID(아임포트 연동 정보에 MID가 상점 ID임)
    pay_method: "card",          //결제구분(카드, 가상계좌 등)
    merchant_uid: orderNo,       //주문번호(DB Table primary key로 관리[주문번호])
    name: buyProdName,           //상품명
    amount: buyAmount * buyCnt,  //상품 가격
    buyer_email: $('#userEmail'),       //구매자 Email
    buyer_name: $('#userNm'),         //구매자명
    buyer_tel: $('#userPhone'),           //구매자 전화번호
    buyer_addr: $('#addr'),         //구매자 주소
    buyer_postcode: $('#addrCd'), //구매자 우편번호
    
    정상적으로 결제요청 완료된 후
    impUid		: resInfo.imp_uid,     	// 결제 API 사 관리용 결제 고유번호
	orderNo		: resInfo.merchant_uid,	// DB 에서 조회한 주문번호(시퀀스)
	prodKey		: $('#prodKey')			// 제품번호
	userKey		: $('#userKey')			// 유저번호
	addrKey		: $('#addrKey')			// 주소번호
	cardCompany	: resInfo.card_name		// 카드사
	orderPrice	: $('#orderPrice')		// 주문가격
	orderCnt	: $('#orderCnt')		// 주문갯수
	orderDate	: resInfo.paid_at,     	// 결제승인일시(70년 1월 1일부터 경과 초[second]))	
--%>
</body>
</html>