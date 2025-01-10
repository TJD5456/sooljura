<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="/resources/css/common.css"/>
<script src="/resources/jquery/jquery-3.7.1.min.js"></script>
<script src="/resources/js/sweetalert.min.js"></script>
<script src="/resources/summernote/summernote-lite.min.js"></script>
<script src="/resources/summernote/lang/summernote-ko-KR.min.js"></script>
<link href="/resources/summernote/summernote-lite.min.css" rel="stylesheet">
<link rel="icon" href="/resources/icons/logo-circle-woText-16px-favicon.png">
<div id="top"></div>
<header>
    <c:choose>
        <c:when test="${not empty loginUser}">
            <c:if test="${loginUser.userCd == 0}">
                <a href="/admin/adminPage.do">
                    <img src="/resources/icons/icon_duck_gear.png" alt="관리자페이지" style="width: 45px;">
                </a>
            </c:if>
            <a href="/product/buyList.do?reqPage=1&userKey=${loginUser.userKey}">구매내역 테스트 페이지</a>         
            <a href="/user/logout.do">
                <img src="/resources/icons/logout_fix_45px.png" alt="로그아웃"><!-- 로그아웃 조건 추가 -->
            </a>
            <a href="/userMyPage/userMyPageFrm.do">
                <img src="/resources/icons/user_사용자_309492_45px.png" alt="마이페이지">
            </a>
            <a href="/product/expPurchaseFrm.do">
                <img src="/resources/icons/champagne_샴페인_3170079_45px.png" alt="장바구니">
                <!-- 장바구니(로그인이 되있으면 장바구니 페이지 안되있으면 로그인 페이지) -->
            </a>
        </c:when>
        <c:otherwise>
            <a href="/webScraping/webScraper.do">Scrap</a>
            <a href="/user/provisionFrm.do">
                <img src="/resources/icons/join_회원가입_5705819_45px.png" alt="회원가입"><!-- 로그아웃 조건 추가 -->
            </a>
            <a href="/user/loginFrm.do">
                <img src="/resources/icons/user_사용자_309492_45px.png" alt="로그인">
                <!-- mypage -test 지우고 여기에 로그인 되있으면 마이페이지로 넘어가는 조건 추가 -->
            </a>
            <a href="/user/loginFrm.do">
                <img src="/resources/icons/champagne_샴페인_3170079_45px.png" alt="샴페인">
                <!-- 장바구니(로그인이 되있으면 장바구니 페이지 안되있으면 로그인 페이지) -->
            </a>
        </c:otherwise>
    </c:choose>
</header>

<script>
    function msg(title, text, icon, callback) {
    	swal({
            title: title,
            text: text,
            icon: icon
        }).then(function () {
            if (callback != '' && callback != null) {
                //전달된 callback 내부 문자열을, Javascript 코드로 해석하고 실행할 수 있게 해주는 함수 : eval
                eval(callback);
            }
        });
    }
</script>
