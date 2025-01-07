<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>sooljura</title>
</head>
<style>
    .div-wrap {
        margin: 0 auto;
        width: 80%;
        display: flex;
        flex-direction: column;
        border: 1px solid #ddd;
        border-radius: 10px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        padding: 20px;
        font-weight: bold;
    }

    .center-div-items {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 10px 0;
        border-bottom: 1px solid #ddd;
    }

    .center-div-items:last-child {
        border-bottom: none;
    }

    .prodNm, .prodPrice {
        font-size: 18px;
        font-weight: 500;
        margin: 0;
        border: none;
        width: 80%;
    }

    .addrWrap {
        margin-top: 10px;
        font-size: 14px;
        display: flex;
        align-items: center;
    }

    .addrWrap span {
        margin-right: 10px;
    }

    .addrWrap button {
        margin-left: auto;
        border: none;
        padding: 5px 10px;
        border-radius: 5px;
        font-size: 14px;
        cursor: pointer;
    }

    .fixed-div {
        position: fixed;
        display: flex;
        justify-content: center;
        width: 100%;
        height: 70px;
        border-top: 1px solid gray;
        bottom: 0;
        background-color: #EFECE5;
    }

    input[type="button"] {
        border: none;
        border-radius: 15px;
        color: #efece5;
        background-color: #fc8173;
        box-shadow: 1px 1px 1px 1px var(--button-shadow);
        height: 25px;
        width: 60px;
    }

    input[type="button"]:hover {
        background-color: #f5afa5;
        box-shadow: 1px 1px 1px 1px var(--button-background);
    }

    .order-product-title{
        border-top: 1px solid var(--table-border);
        padding-top: 30px;
    }

</style>
<%--
	user정보 		: loginUser
	addr정보		: addr
	product정보 	: productList
	Basket정보	    : basketList
--%>
<body>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<main>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="wrapper">
        <div class="content">
                <input type="hidden" id="userKey" value="${loginUser.userKey}">
                <input type="hidden" id="userEmail" value="${loginUser.userEmail}">
                <input type="hidden" id="userPhone" value="${loginUser.userPhone}">
                <input type="hidden" id="addrKey" value="${addr.addrKey}">

                <div class="div-wrap">
                    <h2>배송지</h2>
                    <div class="addrWrap">
                        <input type="hidden" class="addrKey" name="addrKey" value="${addr.addrKey}">
                        <span style="display: flex; font-size: 20px;">
                         ${addr.rcptNm}
                         <c:if test="${not empty addr.addrNm}">
                             (${addr.addrNm})
                         </c:if>
                         <c:if test="${addr.defaultYn == 1}">
                             <span style="font-weight: lighter; color: #fc8173; border: 1px solid #fc8173; font-size: 15px; margin-left: 10px;">기본배송지</span>
                         </c:if>
                     </span>
                    </div>

                    <div class="btnWrap">
                        <input type="button" onclick="chgAddr()" value="변경">
                    </div>

                    <div class="addrWrap">
                        <span id="rcptPhone">${addr.rcptPhone}</span>
                    </div>

                    <div class="addrWrap">
                        <span id="addr">${addr.addr}</span> <span id="addrDetail">${addr.addrDetail}</span> <span
                            id="addrCd">(${addr.addrCd})</span>
                    </div>

                    <h2 class="order-product-title">주문상품</h2>
                    <c:forEach var="productData" items="${productList}">
                        <c:forEach var="product" items="${productData.productList}">
                            <input type="hidden" class="prodKeys" value="${product.prodKey}"><%-- 값 있음 --%>
                            <div class="center-div-items" style="border-bottom: none;">
                                <input type="text" class="prodNm" value="${product.prodNm}" readonly>
                            </div>
                            <div class="center-div-items" style="border-top: none;">
                                <input type="text" class="prodPrice" value="${product.prodPrice}" readonly>
                            </div>
                        </c:forEach>
                    </c:forEach>
                </div>
                <div class="fixed-div">
                    <span id="orderSummary" style="font-size: 30px; margin-top: 10px;">총 0건의 주문금액 0원</span>
                    <input type="submit" id="buyBtn" onclick="reqPayment()"
                           style="border-radius: 10px; height: 50px; margin-top: 10px;" value="선택한 제품 구매하기">
                </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/remote.jsp"/>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</main>

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
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script>
    function updateOrderSummary() {
        let totalCnt = 0; // 총 prodCnt
        let totalPrice = 0; // 총 prodPrice
    }

    // 모든 제품 순회
    $('div input.prodCnt').each(function () {
        const prodCnt = Number($(this).val()); // 제품 수량
        const prodPrice = Number($(this).closest('div').find('.prodPrice').val()); // 제품 가격

        totalCnt += prodCnt;
        totalPrice += prodCnt * prodPrice; // 수량과 가격의 곱
    });

    // span 태그에 결과 업데이트
    $('#orderSummary').text(`총 ${totalCnt}건의 주문금액 ${totalPrice}원`);


    // 페이지 로드 시 초기 계산
    $(document).ready(function () {
        updateOrderSummary();
    });

    function reqPayment() {
        // 결제 요청(주문내역에 넣을 prodKey 배열 따로 생성)
        let prodKeys = []; // prodKey 배열 - 일단은 string으로 하나만
        
        
        $('.prodKeys').each(function () {
             prodKeys.push($(this).val()); // prodKey 값을 배열에 추가
        });

        console.log(prodKeys);
        $(function () {
	        // 아임포트 가맹점 식별 코드 설정
	        IMP.init("imp56726440");
	    });

        $.ajax({
            url: '/product/makeOrderNo.do', // 주문번호 생성 요청 URL
            type: 'get',
            success: function (orderNo) {
            	
                   let buyProdName = $('.prodNm').val();
                   let buyAmount = $('.prodPrice').val();
                   let buyCnt = $('.prodCnt').val();
                   let buyName = $('#userNm').val(); // 서버에서 받은 사용자 이름
                   let buyEmail = $('#userEmail').val(); // 서버에서 받은 사용자 이메일
                   let buyTel = $('#userPhone').val(); // 서버에서 받은 사용자 전화번호
                   let buyAddr = $('#addr').val() + $('#addrDetail').val(); // 서버에서 받은 사용자 주소
                   let buyPostCode = $('#addrCd').val(); // 우편번호는 임의 값 또는 추가 구현
                   console.log(buyProdName);

                   // 아임포트 결제 요청
                   IMP.request_pay({
                       pg: "kcp.AO09C", // 상점 ID
                       pay_method: "card", // 결제 구분
                       merchant_uid: orderNo, // 서버에서 받은 주문번호
                       name: buyProdName, // 상품명
                       amount: buyAmount, // 총 금액
                       buyer_email: buyEmail, // 구매자 이메일
                       buyer_name: buyName, // 구매자 이름
                       buyer_tel: buyTel, // 구매자 전화번호
                       buyer_addr: buyAddr, // 구매자 주소
                       buyer_postcode: buyPostCode // 구매자 우편번호
                   }, function (resInfo) {
                       if (resInfo.success) {
                           // 결제 성공 시 서버에 결제 결과 전송
                           let orderPayload = {
                               impUid		: resInfo.imp_uid, // 결제 API사 고유번호
                               orderNo		: resInfo.merchant_uid, // 주문번호
                               prodKeys 	: prodKeys,
                               addrKey 		: $('#addrKey').val(),
                               userKey 		: $('#userKey').val(),
                               orderPrice	: buyAmount * buyCnt, // 총 금액
                               orderCnt		: buyCnt, // 수량
                               orderDate	: resInfo.paid_at // 결제 승인 시간
                               //tid			: resInfo.pg_tid, // PG사 결제 고유번호
                               //productName	: buyProdName, // 상품명
                               //userEmail	: buyEmail, // 사용자 이메일
                               //userName		: buyName, // 사용자 이름
                               //userPhone	: buyTel, // 사용자 전화번호
                               //userAddr		: buyAddr, // 사용자 주소
                               //userPostCode	: buyPostCode, // 사용자 우편번호
                           };

                           $.ajax({
                               url: '/product/productBuy.do',
                               type: 'post',
                               contentType: 'application/json', // JSON 데이터 전송
                               data: JSON.stringify(orderPayload), // 주문 정보와 결제 정보를 JSON 으로 변환
                               success: function (res) {
                                   if (res === '1') {
                                       msg('알림', '결제가 완료되었습니다', 'success', "location.href = '/product/buyList.do?reqPage=1';");
                                   } else {
                                       msg('알림', '주문 저장 실패', 'error');
                                   }
                               },
                               error: function () {
                                   alert('서버와의 통신 오류');
                               }
                           });
                       } else {
                           // 결제 실패 처리
                           msg('알림', '결제에 실패하였습니다. 에러 내용: ' + resInfo.error_msg, 'error');
                       }
                   });             
            },
            error: function () {
                alert('서버 통신 중 오류가 발생했습니다.');
            }
        });
    }

    //주소지 변경 버튼 클릭 시
    function chgAddr() {
        $.ajax({
            url: "/product/chgAddr.do",
            type: "POST",
            data: {
                userKey: $('#userKey').val()
            },
            success: function (res) {
                if (res === "1") {

                } else {
                    msg('알림', '주소지 변경 중 오류가 발생했습니다', 'error');
                }
            },
            error: function () {
                console.log('주소지변경 ajax 오류');
            }
        });
    }
</script>
</body>
</html>