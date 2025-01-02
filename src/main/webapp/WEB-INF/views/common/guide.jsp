<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>이용 안내</title>
    <style>
        /* 전체 레이아웃 */
        ul {
            list-style-type: none; /* 점(불릿)을 없앰 */
            padding: 0; /* 기본 패딩 제거 */
            margin: 0; /* 기본 마진 제거 */
        }

        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            background-color: #f9f9f9;
        }

        .container {
            display: flex;
            width: 100%;
        }

        .leftSideBar {
            width: 250px;
            padding: 20px;
            box-sizing: border-box;
            flex-shrink: 0; /* 사이드바가 줄어들지 않도록 설정 */
        }

        .content {
            flex: 1; /* 콘텐츠가 남은 공간을 차지 */
            padding: 20px;
            background-color: #fff;
            box-sizing: border-box;
            min-width: 0; /* flex 요소의 콘텐츠 오버플로우 방지 */
        }
    </style>
</head>
<body>
<!-- 사이드바 -->
<div class="leftSideBar">
    <jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
</div>

<!-- 메인 컨테이너 -->
<div class="main-container">
    <!-- 헤더 -->
    <div class="header">
        <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    </div>
    <br><br><br>
    <hr>
    <br><br><br>
    <div class="service_cont">
        <div class="service_guide">
            <h3>술주라 이용안내</h3><br>
            <br>
            ■ 회원가입안내<br>
            ① 저희 술주라은 기본적으로는 회원제로 운영하고 있습니다. <br>
            ② 회원가입비나 월회비, 연회비등 어떠한 비용도 청구하지 않는 100% 무료 입니다. <br>
            ■ 상품주문방법<br>
            저희술주라에서 상품을 주문하는 방법은 크게 6단계입니다. <br>
            ① 상품검색 <br>
            ② 쇼핑백에 담기 <br>
            ③ 회원ID 로그인 주문 <br>
            ④ 주문서 작성 <br>
            ⑤ 결제방법 선택 및 결제 <br>
            ⑥ 주문 성공 화면 (주문번호) <br>
            <br>
            ■ 안전한 대금 결제 시스템<br>
            저희 술주라은 신용카드 결제방법을 제공하여 드립니다. <br>
            신용카드 결제는 OOOPG사의 전자결제를 이용하므로 보안문제는 걱정하지 않으셔도 되며, 고객님의 이용내역서에는 ㈜OOO으로 기록됩니다. <br>
            이용 가능한 국내 발행 신용카드 <br>
            - 국내발행 모든 신용카드 <br>
            이용 가능한 해외 발생 신용카드 <br>
            - VISA Card, MASTER Card, AMEX Card <br><br>
            ■ 주문취소, 교환 및 환불<br>
            술주라은 소비자의보호를 위해서 규정한 제반 법규를 준수합니다. <br>
            주문 취소는 미결재인 상태에서는 고객님이 직접 취소하실 수가 있습니다. 결제후 취소는 저희 고객센터로 문의해 주시기 바랍니다. <br>
            결제 하신 경우, 승인 취소가 가능하면 취소을 해드리지만 승인 취소가 불가능한 경우 해당 금액을 모두 송금해 드립니다. <br>
            반송을 하실 때에는 주문번호, 회원번호를 메모하여 보내주시면 보다 신속한 처리에 도움이 됩니다.<br><br><br><br><br>
        </div>
    </div>
    <!-- 풋터 -->
    <div class="footer">
        <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    </div>
</div>
</body>
</html>
