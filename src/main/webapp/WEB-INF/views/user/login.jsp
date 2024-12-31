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
#remember {
	text-align: none;
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
                <div id="remember">
	                <c:if test="${empty cookie.saveId.value }">
	                    <input type="checkbox" name="saveId" id="saveId" value="chk">					
	                </c:if>
	                <c:if test="${!empty cookie.saveId.value }">
	                    <input type="checkbox" name="saveId" id="saveId" value="chk" checked>					
	                </c:if>
                    <label for="saveId">아이디 저장</label>
                </div>   
                <br>
                <%--<a href="/user/pwFindFrm.do">비밀번호 찾기</a> | --%>
                <a href="/user/idFindFrm.do">아이디 찾기</a> |
                <a href="/user/provisionFrm.do">회원 가입</a>

                <hr>

                <button type="button" id="login" onclick="loginBtn()">로그인</button>
            </form>
        </div>
<%--        Test--%>
        <input type="button" onclick="autoLogin(0)" value="관리자 로그인" style="width: 100px">
        <input type="button" onclick="autoLogin(1)" value="레벨 1 로그인" style="width: 100px">
        <input type="button" onclick="autoLogin(-1)" value="레벨 -1 로그인" style="width: 100px">
    </div>
<script>
<%--
	res = 0이면 로그인 성공 1이면 로그인 실패
--%>
	function loginBtn(){
		$.ajax({
			url : "/user/login.do",
			type : "POST",
			data : {
					"userId" : $('#userId').val(),
					"userPw" : $('#userPw').val()
					},
			success : function(res){
				if(res === "0"){
					location.href = "/";
				}else{
					msg("알림", "아이디, 비밀번호를 확인해주세요", "error");
				}
			},
			error : function(){
				console.log('ajax 오류');
			}
		})
	}

    function autoLogin(i){
        if(i == 0){
            $('#userId').val('admin999');
            $('#userPw').val('admin999@');
            loginBtn();
        } else if(i == 1){
            $('#userId').val('user111');
            $('#userPw').val('user111@');
            loginBtn();
        } else if(i == -1){
            $('#userId').val('user555');
            $('#userPw').val('user555@');
            loginBtn();
        }
    }

</script>
</body>
</html>