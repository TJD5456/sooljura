<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="/resources/css/common.css"/>

<script src="/resources/jquery/jquery-3.7.1.min.js"></script>
<script src="/resources/js/sweetalert.min.js"></script>

<style>
.headWrap{
	margin-left: 0px;
}
</style>

<header class="headWrap">
    <%--리모콘 버튼 맨 위로 올리기 위치값 이름--%>
    <div id="top"></div>

    <div class="headDiv">
        <img src="/resources/icons/join_회원가입_5705819_45px.png" alt="">
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