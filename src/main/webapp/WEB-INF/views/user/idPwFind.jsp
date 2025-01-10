<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>sooljura</title>
<style>
* {
	margin: 0;
}
.wrapper {
	width: 450px;
	display: block;
    justify-content: center;
    align-items: center !important;   
}

.idPwFind {
    border: 1px solid gray;
    width: 100%;
    height: 40%;
    display: flex;
    flex-direction: column;
    align-items: center;
}

.idPwHeader {
    width: 100%;
    height: 30%;
}
a {
	text-decoration: none;
}
.headDiv{
	width: 100%;
    height: 75px;
    display: flex;
    background-color: #EFECE5;
}
img {
    margin-left: 20%;
}
main{
	display: flex;
    align-items: center;
    justify-content: center;
    margin-top: 80px;
}
h1{
	display: flex;
    justify-content: center;
}
div > #checkBtn{
	width : 100px; 
	height: 40px; 
	display: flex; 
	justify-content: center; 
	margin:0 auto; 
	align-items: center;
	background-color: #FC8173;
	border-radius: 15px;
	color: #EFECE5;
	margin-bottom: 20px;
	margin-top: 20px;
}
div > #idFindBtn{
	width : 100px; 
	height: 40px; 
	display: flex; 
	justify-content: center; 
	margin:0 auto; 
	align-items: center;
	background-color: #FC8173;
	color: #EFECE5;
}
div > #checkBtn:hover, div > #idFindBtn:hover {
    background-color: #f5afa5;
    box-shadow: 1px 1px 1px 1px #fc8173;
}
</style>
</head>
<body>
<div class="headDiv">
   	<img src="/resources/icons/text_logo.png">
</div>
<main>
    <div class="wrapper">
        <c:if test="${idOrPW eq 1}">
            <div class="idPwFind">
                <div>
                    <h1>아이디 찾기</h1>
                </div>
                <div class="idPwHeader" style="display: block; justify-content: center;">
                    <form action="/user/idFind.do" method="post"
                          style="display: flex;">
                        <div style="display: flex; flex-direction: column; width: 60%;">
                            <input type="text" id="nameInpt" name="name" placeholder="이름"
                                   style="height: 50px; font-size: 30px;"> <input
                                type="text" id="phoneInpt" name="phone" placeholder="가입휴대폰번호"
                                style="height: 50px; font-size: 30px;">
                        </div>
                        <div style="width: 40%; height: 108px;">
                            <input type="submit" id="idFindBtn" name="idFindBtn" value="아이디 찾기"
                                   style="width: 100%; height: 100%; font-size: 30px;">
                        </div>
                    </form>
                </div>
                <div></div>
            </div>
        </c:if>
        <%--
        <c:if test="${idOrPW eq 2}">
            <div class="idPwFind">
                <div>
                    <h1>비밀번호 찾기</h1>
                </div>
                <div class="idPwHeader">
                    <form action="">
                        <input type="text" name="id"> <input type="text" name="">
                    </form>
                </div>
                <div></div>
            </div>
        </c:if>
         --%>
        <c:if test="${res eq 3}">
            <div class="idPwFind">
                <div>
                    <h1>아이디 찾기</h1>
                </div>
                <div class="idPwHeader">
                    <h1>your id is ${idFind}</h1>
                </div>
                <div>
                	<button id="checkBtn" onclick="checkBtn()">확인</button>
                </div>
            </div>
        </c:if>
    </div>
</main>
<script>
	function checkBtn(){
		window.self.close();
	}

</script>
</body>
</html>
