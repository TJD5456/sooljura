<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sooljura</title>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <script
      type="text/javascript"
      src="http://code.jquery.com/jquery-3.3.1.js"
    ></script>
</head>
<body>
<%--
	user정보 		: loginUser
	addr정보		: addr	
	product정보 	: product
--%>
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
<script>
	// 결제 요청
	reqPayment: function (payBtn) {
	    $.ajax({
	        url: '/product/makeOrderNo.do', // 주문번호 생성 요청 URL
	        type: 'POST',
	        dataType: 'json', // JSON 형식의 데이터 수신
	        success: function (orderData) {
	            if (orderData && orderData.orderNo) {
	                let buyProdName = $(payBtn).parent().find('.buyProdName').html();
	                let buyAmount = $(payBtn).parent().find('.buyAmount').html().replace(',', '');
	                let buyCnt = $(payBtn).parent().find('.buyCnt').html();
	                let buyName = $('#userNm').val(); // 서버에서 받은 사용자 이름
	                let buyEmail = $('#userEmail').val(); // 서버에서 받은 사용자 이메일
	                let buyTel = $('#userPhone').val(); // 서버에서 받은 사용자 전화번호
	                let buyAddr = $('#addr').val(); // 서버에서 받은 사용자 주소
	                let buyPostCode = $('#addrCd').val(); // 우편번호는 임의 값 또는 추가 구현
	
	                // 아임포트 결제 요청
	                IMP.request_pay({
	                    pg: "kcp.AO09C", // 상점 ID
	                    pay_method: "card", // 결제 구분
	                    merchant_uid: orderData.orderNo, // 서버에서 받은 주문번호
	                    name: buyProdName, // 상품명
	                    amount: buyAmount * buyCnt, // 총 금액
	                    buyer_email: buyEmail, // 구매자 이메일
	                    buyer_name: buyName, // 구매자 이름
	                    buyer_tel: buyTel, // 구매자 전화번호
	                    buyer_addr: buyAddr, // 구매자 주소
	                    buyer_postcode: buyPostCode // 구매자 우편번호
	                }, function (resInfo) {
	                    if (resInfo.success) {
	                        // 결제 성공 시 서버에 결제 결과 전송
	                        let orderPayload = {
	                        impUid: resInfo.imp_uid, // 결제 API사 고유번호
	                        orderNo: resInfo.merchant_uid, // 주문번호
	                        tid: resInfo.pg_tid, // PG사 결제 고유번호
	                        authDate: resInfo.paid_at, // 결제 승인 시간
	                        productName: buyProdName, // 상품명
	                        quantity: buyCnt, // 수량
	                        totalAmount: buyAmount * buyCnt, // 총 금액
	                        userEmail: buyEmail, // 사용자 이메일
	                        userName: buyName, // 사용자 이름
	                        userPhone: buyTel, // 사용자 전화번호
	                        userAddr: buyAddr, // 사용자 주소
	                        userPostCode: buyPostCode // 사용자 우편번호
	                        };
	                        
	                        $.ajax({
	                            url: '/product/productBuy.do',
	                            type: 'post',
	                            contentType: 'application/json', // JSON 데이터 전송
	                            data: JSON.stringify(orderPayload), // 주문 정보와 결제 정보를 JSON으로 변환
	                            success: function (res) {
	                                if (res === '1') {
	                                    alert('결제 및 주문 저장 성공');
	                                } else {
	                                    alert('주문 저장 실패');
	                                }
	                            },
	                            error: function () {
	                                alert('서버와의 통신 오류');
	                            }
	                        });
	                    } else {
	                        // 결제 실패 처리
	                        alert("결제에 실패하였습니다. 에러 내용: " + resInfo.error_msg);
	                    }
	                });
	            } else {
	                alert('주문번호 생성에 실패했습니다.');
	            }
	        },
	        error: function () {
	            alert('서버 통신 중 오류가 발생했습니다.');
	        }
	    });
	}
	};
	
	$(function () {
	// 아임포트 가맹점 식별 코드 설정
	IMP.init("imp56726440");
	});
</script>
</body>
</html>