<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="/resources/css/common.css"/>

<script src="/resources/jquery/jquery-3.7.1.min.js"></script>
<script src="/resources/js/sweetalert.min.js"></script>

<header class="headWrap">
    <%--리모콘 버튼 맨 위로 올리기 위치값 이름--%>
    <div id="top"></div>

    <div class="headDiv">
      	<a href="/admin/adminPage.do">To admin page</a>
      	<a href="/userMyPage/userMyPage.do">my page -test</a>
        <a href="/user/provisionFrm.do"><img src="/resources/icons/join_회원가입_5705819_45px.png" alt=""></a>
        <a href="/user/loginFrm.do"><img src="/resources/icons/user_사용자_309492_45px.png" alt=""></a>
        <a href="/"><img src="/resources/icons/champagne_샴페인_3170079_45px.png" alt=""></a>
    </div>
</header>

<script>
    function msg(title, text, icon) {
        swal({
            title: title,
            text: text,
            icon: icon
        });
    }
</script>
