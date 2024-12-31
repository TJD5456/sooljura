<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>sooljura</title>
    <style>
        * {
            padding: 0;
            background-color: #EFECE5;
        }

        .login-wrap > * {
            margin-top: 20%;
            margin: 0 auto;
            display: block;
            justify-content: center;
        }

        img {
            margin-left: 1px;
        }

        .login {
            width: 400px;
            text-align: center;
            background-color: #EFECE5;
            overflow: hidden;
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

        input[type = submit] : hover {
            background-color: #f5afa5;
            box-shadow: 1px 1px 1px 1px #fc8173;
        }

        #userPw {
            margin-top: 0;
            border-top-left-radius: 0;
            border-top-right-radius: 0;
            margin-bottom: 0;
            width: 80%;
        }

        form > * {
            margin-bottom: 10px;
            margin-top: 10px;
            font-size: 20px;
            border-radius: 15px;
            display: block;
            width: 300px;
            height: 50px;
        }
    </style>
    <script src="/resources/jquery/jquery-3.7.1.min.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/textHeader.jsp"/>
<main>
    <div class="login">
        <form action="/userMyPage/delUser.do" method="post">
            <input type="hidden" id="userKey" value="${loginUser.userKey}">
            <input type="hidden" id="userPw" value="${loginUser.userPw}">
            <input type="password" id="userPwChk" placeholder="비밀번호 확인"><br>
            <input type="button" onclick="delUserBtn()" value="회원탈퇴">
        </form>
    </div>
</main>
<script>
    function delUserBtn() {
        swal({
            title: "알림",
            text: "회원탈퇴 하시겠습니까",
            icon: "success",
            buttons: {
                cancel: {
                    text: "취소",
                    value: false,
                    visible: true,
                    closeModal: true
                },
                confirm: {
                    text: "변경",
                    value: true,
                    visible: true,
                    closeModal: true
                }
            }
        }).then(function (isConfirm) {
            if (isConfirm) {
                $.ajax({
                    url: "/userMyPage/delUser.do",
                    type: "POST",
                    data: {
                        userKey: $('#userKey').val(),
                        userPw: $('#userPw').val(),
                        userPwChk: $('#userPwChk').val()
                    },
                    success: function (res) {
                        if (res === "1") {
                            msg('알림', '회원탈퇴가 완료되었습니다. 메인페이지로 이동합니다.', 'success', "window.self.close();window.opener.location.href = '/';");
                        } else if (res === "2") {
                            msg('알림', '비밀번호가 일치하지 않습니다.', 'error');
                        } else {
                            msg('알림', '회원탈퇴 중 오류가 발생했습니다.', 'error');
                        }
                    },
                    error: function () {
                        console.log('회원탈퇴 ajax 오류');
                    }
                });
            }
        });
    }
</script>
</body>
</html>