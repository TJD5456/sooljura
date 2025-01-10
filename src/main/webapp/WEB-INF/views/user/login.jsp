<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>sooljura</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <style>
        * {
            padding: 0;
            background-color: #EFECE5;
        }

        .login-wrap > * {
            margin: 0 auto;
            display: block;
            justify-content: center;
        }

        .login-wrap img {
            margin-bottom: 20px;
        }

        .login {
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
		a:hover{
			cursor: pointer;
		}

        #userId, #userPw {
            width: 350px;
            height: 50px;
            border: 1px solid gray;
            border-radius: 5px;
        }

        #userId {
            margin-top: 10px;
            margin-bottom: 0;
            border-bottom-left-radius: 0;
            border-bottom-right-radius: 0;
            border-bottom: none;
        }

        #userPw {
            margin-top: 0;
            border-top-left-radius: 0;
            border-top-right-radius: 0;
            margin-bottom: 0;
        }

        #remember {
            font-size: 12px;
            color: gray;
            float: left;
            margin-left: 30px;
        }

        input[type = submit] {
            border: none;
            border-radius: 15px;
            color: #efece5;
            background-color: #fc8173;
            box-shadow: 1px 1px 1px 1px #d2210d;
            width: 60%;
            height: 50px;
        }

        input[type = submit]:hover {
            background-color: #f5afa5;
            box-shadow: 1px 1px 1px 1px #fc8173;
        }

        #specialWrap {
            display: flex;
            justify-items: center;
            gap: 10px;
            align-items: center;
        }

        .logo {
            cursor: pointer;
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div class="login-wrap">
    <img src="/resources/icons/logo.png" class="logo" alt="logo" onclick="window.location.href='/'">
    <div class="login">
        <form action="/user/login.do" method="post" onsubmit="return loginBtn(event);">
            <input type="text" id="userId" value="${cookie.saveId.value}" placeholder="아이디 입력"> <br>
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
            <div id="specialWrap">
                <%--<a href="/user/pwFindFrm.do">비밀번호 찾기</a> | --%>
                <a onclick="idFindFrmBtn()">아이디 찾기</a> |
                <a href="/user/provisionFrm.do">회원 가입</a>
            </div>
            <hr>

            <input type="submit" onclick="loginBtn()" value="로그인">
        </form>
    </div>
    <%-- fast login --%>
    <input type="button" onclick="autoLogin(0)" value="관리자 로그인" style="width: 100px">
    <input type="button" onclick="autoLogin(1)" value="레벨 1 로그인" style="width: 100px">
    <input type="button" onclick="autoLogin(-1)" value="레벨 -1 로그인" style="width: 100px">
</div>
<script>
    <%-- res = 0이면 로그인 성공 1이면 로그인 실패 --%>

    function loginBtn(event) {
        event.preventDefault();
        const saveIdChecked = $('#saveId').is(':checked') ? 'chk' : null;

        $.ajax({
            url: "/user/login.do",
            type: "POST",
            data: {
                "userId": $('#userId').val(),
                "userPw": $('#userPw').val(),
                "saveId": saveIdChecked
            },
            success: function (res) {
                if (res === "0") {
                    location.href = "/";
                } else {
                    msg("알림", "아이디, 비밀번호를 확인해주세요", "error");
                }
            },
            error: function () {
                console.log('ajax 오류');
            }
        });
        return false;
    }

    // fast login
    function autoLogin(i) {
        if (i === 0) {
            $('#userId').val('admin999');
            $('#userPw').val('admin999@');
            loginBtn(event);
        } else if (i === 1) {
            $('#userId').val('user111');
            $('#userPw').val('user111@');
            loginBtn(event);
        } else if (i === -1) {
            $('#userId').val('user555');
            $('#userPw').val('user555@');
            loginBtn(event);
        }
    }
    
    function idFindFrmBtn() {   	
    	let popupWidth = 550;
		let popupHeight = 400;
		let top = (window.innerHeight - popupHeight) / 2 + window.screenY;
		let left = (window.innerWidth - popupWidth) / 2 + window.screenX;
		
		window.open("/user/idFindFrm.do", "idFindFrm", "width="+popupWidth+", top="+top+", height="+popupHeight+", left="+left);
    }
</script>
</body>
</html>