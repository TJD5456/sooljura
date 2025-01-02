<%@page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="/resources/jquery/jquery-3.7.1.min.js"></script>
<script src="/resources/js/sweetalert.min.js"></script>
<div class="userInfoUpdContent">
    <div>
        <h1>회원 정보</h1>
        <%--<form id="form" method="post" onSubmit="return false;"> --%>
        <input type="hidden" id="userKey" value="${loginUser.userKey}">
        <input type="hidden" id="userPw" value="${loginUser.userPw}">
        <table class="tbl tblUserInfo">
            <colgroup>
                <col style="width: 20%;">
                <col style="width: 80%;">
            </colgroup>
            <tr>
                <th>아이디</th>
                <td><input type="text" value="${loginUser.userId}" readonly></td>
            </tr>
            <tr>
                <th>비밀번호</th>
                <td>
                    <div class="pwChgBtns">
                        <div>
                            <button type="button" class="userInfoBtn" id="pwChgBtn">비밀번호 변경</button>
                        </div>
                        <div>
                            <button type="button" class="userInfoBtn" id="pwChgMod">비밀번호 양식</button>
                        </div>
                    </div>
                </td>
            </tr>
            <tr>
                <th></th>
                <td style="display: flex; flex-direction: row-reverse;">
                    <div id="userPwMod">
                        <ul>
                            <li>영어,숫자,특수기호(!@#$%^&#38;*)를 포함한</li>
                            <li>8~16글자의 비밀번호를 작성하여 주세요</li>
                        </ul>
                    </div>
                </td>
            </tr>
            <tr>
                <th></th>
                <td>
                    <div id="userPwChg">
                        <table>
                            <colgroup>
                                <col style="width: 40%;">
                                <col style="width: 60%;">
                            </colgroup>
                            <tr>
                                <th>현재 비밀번호</th>
                                <td><input id="userPwChk" type="password"> <img alt="" src=""></td>
                            </tr>
                            <tr>
                                <th>새 비밀번호</th>
                                <td><input id="userUpdPw" oninput="pwChk()" type="password"></td>
                            </tr>
                            <tr>
                                <th>새 비밀번호 확인</th>
                                <td><input id="userUpdPwChk" oninput="pwChk()" type="password"></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <button style="width:35%; height:5%" onclick="chgPw()">비밀번호 변경</button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
            <tr>
                <th>이메일</th>
                <td><input type="text" value="${loginUser.userEmail}" readonly></td>
            </tr>
            <tr>
                <th>이름</th>
                <td><input type="text" value="${loginUser.userNm}" readonly></td>
            </tr>
            <tr>
                <th>전화번호</th>
                <td><input type="text" value="${loginUser.userPhone}" readonly></td>
            </tr>
            <tr>
                <th>닉네임</th>
                <td><input type="text" value="${loginUser.userNickNm}" readonly></td>
            </tr>
            <tr>
                <th>가입일</th>
                <td><input type="text" value="${loginUser.enrollDate}" readonly></td>
            </tr>
        </table>
        <%-- onclick="userInfoUpdBtn(this)"--%>
        <div class="userInfoInptBtn">
            <button class="userInfoBtn" type="button" id="delUserBtn" onclick="delUser()">회원탈퇴</button>
        </div>
        <%-- </form> --%>
    </div>
</div>
<script>
    //swal 선언용
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

    //유저삭제를 위한 팝업창 띄우기
    function delUser() {
        let popupWidth = 500;
        let popupHeight = 350;

        let top = (window.innerHeight - popupHeight) / 2 + window.screenY;
        let left = (window.innerWidth - popupWidth) / 2 + window.screenX;

        window.open("/userMyPage/delUserFrm.do", "delUser", "width=" + popupWidth + ", top=" + top + ", height=" + popupHeight + ", left=" + left);
    }

    //비밀번호 변경
    function chgPw() {
        swal({
            title: "알림",
            text: "비밀번호를 변경하시겠습니까?",
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
                const regExp = /^[a-zA-Z0-9!@#$%^&*]{8,16}$/;
                const userUpdPw = $('#userUpdPw').val();
                const userUpdPwChk = $('#userUpdPwChk').val();

                if (!regExp.test(userUpdPw)) {
                    msg('알림', '비밀번호 형식이 일치하지 않습니다', 'error');
                    return false;
                } else {
                    $.ajax({
                        url: "/userMyPage/pwChg.do",
                        type: "POST",
                        data: {
                            "userKey": $('#userKey').val(),
                            "userPw": $('#userPw').val(),
                            "userPwChk": $('#userPwChk').val(),
                            "userUpdPw": userUpdPw,
                            "userUpdPwChk": userUpdPwChk
                        },
                        success: function (res) {
                            if (res === "1") {
                                msg('알림', '비밀번호가 변경되었습니다. 다시 로그인해주세요', 'success', "location.href = '/';");
                            } else if (res === "0") {
                                msg('알림', '기존 비밀번호가 일치하지 않습니다', 'error');
                            } else if (res === "2") {
                                msg('알림', '새로 입력한 비밀번호가 일치하지 않습니다', 'error');
                            } else if (res === "3") {
                                msg('알림', '비밀번호 변경 중 오류가 발생했습니다', 'error');
                            }
                        },
                        error: function () {
                            console.error("비밀번호 변경에서 ajax 오류");
                        }
                    });
                }
            }
        });
    }
</script>
