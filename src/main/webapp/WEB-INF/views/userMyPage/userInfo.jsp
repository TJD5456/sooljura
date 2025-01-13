<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>술주라</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<style>
	.content{
		display: flex;
		flex-direction: column;
		align-items: center;
	}
	.innerContext{
		width: 1200px;
		display: flex;
		flex-direction: column;
		align-items: center;
	}
	.userQuitBtn{
		width:150px;
		height:75px;
	}
    .myPageChoices {
        width: 700px;
        margin: 0 auto;
        display: flex;
        justify-content: center;
    }

    .myPageInfoView {
        height: 800px;
    }

    .myPageChoiceBtn {
        width: 500px;
        height: 50px;
        margin: 15px;
        font-size: 20px;
        font-weight: bold;
    }

    .myPageInfoView {
        display: none;
    }

    .tblUserInfo > tbody > tr > th {
        text-align: left;
    }

    .tblUserInfo > tbody > tr > td > input {
        width: 100%;
        height: 50px;
        border: 1px solid gray;
        border-radius: 15px;
        padding-left: 15px;
        box-sizing: border-box;
    }

    .pwChgBtn > * {
        margin-left: 5px;
        margin-right: 5px;
    }

    #userPwChg > table > tbody > tr > th {
        text-align: left;
    }

    #userPwChg > table > tbody > tr > td > input {
        width: 275px;
        height: 30px;
        border: 1px solid gray;
        border-radius: 10px;
        padding-left: 15px;
        box-sizing: border-box;
    }

    #userPwMod > ul {
        list-style-type: none;
    }

    #userPwMod > ul > li {
        list-style-type: none;
    }
</style>
<body>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<main>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="wrapper">
        <div class="content">
            <div class="title">
                <h1>마이 페이지</h1>
            </div>

            <div class="myPageChoices">
					<button class="myPageChoiceBtn" value="1" id="userInfo">회원 정보</button>
					<button class="myPageChoiceBtn" value="2" id="shoppingInfo">구매 내역</button>
					<button class="myPageChoiceBtn" value="3" id="readMyPost">내글 보기</button>
					<button class="myPageChoiceBtn" value="4" id="likedItems">찜한상품</button>
					<button class="myPageChoiceBtn" value="5" id="addrMng">주소 관리</button>
				</div>
            <div class="myPageInfoView">
            </div>
    <div class="innerContext">
        <h1>회원 정보</h1>
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
                    <div id="userPwMod">
						<span>영어,숫자,특수기호(!@#$%^&#38;*)를 포함한 8~16글자의 비밀번호를 작성하여 주세요</span>
                    </div>
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
        <div class="userInfoInptBtn">
            <button class="userQuitBtn" type="button" id="delUserBtn" onclick="delUser()">회원탈퇴</button>
        </div>
            </div>
        </div>
        <jsp:include page="/WEB-INF/views/common/remote.jsp"/>
    </div>
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</main>

<script>
$('.myPageChoiceBtn').on('click', function(){
	let i = parseInt($(this).val(), 10);
	
	// 현재 페이지 URL 가져오기
	const url = window.location.href;// URL 객체 생성
	const urlParams = new URLSearchParams(new URL(url).search);// 특정 파라미터 값 가져오기 (예: 'id' 파라미터)
	const paramValue = urlParams.get('pg');
	
	switch (i) {
	case 1:
		location.href="/userMyPage/userMyPageFrm.do";
		break;
	case 2:
		location.href="/product/buyList.do?reqPage=1&userKey=${loginUser.userKey}";
		break;
	case 3:
		    const form = document.createElement('form');
		    form.method = 'POST';
		    form.action = '/post/readMyPost.do';

		    const input = document.createElement('input');
		    input.type = 'hidden';
		    input.name = 'userKey';
		    input.value = '${loginUser.userKey}';
		    form.appendChild(input);

		    document.body.appendChild(form);
		    form.submit(); // 서버로 POST 요청 전송 및 페이지 이동
		
		break;
	case 4:
		location.href="userMyPageFrm.do";//?
		break;
	case 5:
		location.href="/user/addrListFrm.do";
		break;
	default:
		break;
	}
	
})
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
</body>
</html>
