<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="/resources/jquery/jquery-3.7.1.min.js"></script>
<script src="/resources/js/sweetalert.min.js"></script>

<style>
@charset "UTF-8";

:root {
    --header-text-hover: #FF5353;

    --button-background: #FC8173;
    --button-shadow: #D2210D;

    --button-background-hover: #F5AFA5;
    --button-shadow-hover: #F2CFC5;

    --sidebar-list: #FF2911;
    --sidebar-text-hover: #FF3819;
    --sidebar-text: #FF6851;
    --sidebar-background: #EFECE5;

    --back-ground: #F9F9F9;
    --footer-background: #F1F1F1;
    --black: #000000;
}
* {
    margin: 0;
    padding: 0;
}
header{
	width:100%;
	height: 75px;
	display: flex;
	background-color: #EFECE5;
}
input[type=button] {
    /* Disable text selection inside the button */
    /* Standard, FireFox, Safari & Chrome */
    user-select: none;
    -moz-user-select: none;
    -webkit-user-select: none;

    border: none;
    border-radius: 15px;
    color: #efece5;
    background-color: #fc8173;
    box-shadow: 1px 1px 1px 1px #d2210d;
    width:30%;
    height: 50px;
    display: block;
    position: fixed;
    bottom: 20px;
    left: 35%;
}
input[type=button]:hover{
	background-color: #f5afa5;
    box-shadow: 1px 1px 1px 1px #fc8173;
}
button:hover {
    background-color: #f5afa5;
    box-shadow: 1px 1px 1px 1px #fc8173;
}

main{
	width: 50%;
	display: block;
	justify-content: center;
	align-items: center;
	height: 100%;
	margin: 0 auto;
}
img{
	margin-left: 300px;
}

</style>

<header class="headWrap">
    <%--리모콘 버튼 맨 위로 올리기 위치값 이름--%>
    <div id="top"></div>

    <div class="headDiv">
        <img src="/resources/icons/text_logo.png" alt="">
    </div>
</header>

<script>
	function msg(title, text, icon, callback) {
	    swal({
	        title: title,
	        text: text,
	        icon: icon
	    }).then(function(){
	    	  if(callback != '' && callback != null) {
					//전달된 callback 내부 문자열을, Javascript 코드로 해석하고 실행할 수 있게 해주는 함수 : eval
					eval(callback);
				}
	      });
	}
</script>