<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sooljura</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
* {
    padding: 0px;
    background-color: #EFECE5;
} 
.login-wrap > *{
    margin-top: 20% ;
    margin: 0 auto;
    display: block;
    justify-content: center; 
}
.login-wrap img {
    margin-bottom: 20px;
}
.login{
    width: 400px;
    text-align: center;
    border: 1px solid black;
    border-radius: 15px;
    background-color: #F2CFC5;
    overflow: hidden;
}
form > * {
    margin-bottom: 10px;
    margin-top: 10px;
    font-size: 15px;
    border-radius: 15px;
}
a {
    font-weight: bold;
    color: gray;
    text-decoration: none;
    font-size: 12px;
}
#userId, #userPw{
    width: 350px;
    height: 50px;
    border: 0.5px solid gray;
    border-radius: 5px;  
}
#userId{
    margin-top: 10px;
    margin-bottom: 0px;
    border-bottom-left-radius: 0px;
    border-bottom-right-radius: 0px;
    border-bottom: none;
}
#userPw{
    margin-top: 0px;
    border-top-left-radius: 0px;
    border-top-right-radius: 0px;
}
.remember {
    font-size: 12px;
    color: gray;
    float: left;
    margin-left: 30px;
    margin-top: -8px;
}
</style>
</head>
<body>
	<jsp:include page ="/WEB-INF/views/common/header.jsp" />
	<div class="login-wrap">
        <img src="/resources/icons/logo.png" class="logo">
        <div class="login">
            <form action="/user/login.do" method="post">
                <input type="text" id="userId" placeholder="아이디 입력"> <br>
                <input type="password" id="userPw" placeholder="비밀번호 입력"><br>
                <label class="remember">
                    <input type="checkbox" name="saveId">아이디 기억
                </label><br>
                <a href="#">비밀번호 찾기</a> |
                <a href="#">아이디 찾기</a> |
                <a href="#">회원 가입</a>

                <hr>

                <input type="button" name="loginBtn" value="로그인" onclick="loginBtn()"
                style="height: 40px; width: 200px; background-color:#FC8173; color:#EFECE5; border-radius: 20px; border: none;">
            </form>
        </div>
    </div>
<script>
<%--
	res = 0이면 로그인 성공 1이면 로그인 실패
--%>
	function loginBtn(){
		$.ajax({
			url : "/user/login",
			type : "POST",
			data : {
					"userId" : $('#userId').val(),
					"userPw" : $('#userPw').val()
					},
			success : function(res){
				if(res == "0"){
					window.opener.location.href="/";
				}else{
					msg("알림", "아이디, 비밀번호를 확인해주세요", "error");
				}
			},
			error : function(){
				console.log('ajax 오류');
			}
		})
	}
</script>
</body>
</html>