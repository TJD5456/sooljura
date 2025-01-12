<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>sooljura</title>
<style>
main {
    padding: 0;
}

/* 전체 배경색 설정 */
body {
    align-items: center; /* 수직 가운데 정렬 */
    height: 100vh; /* 화면 높이를 100%로 설정 */
    margin: 0;
}

/* 폼 컨테이너 스타일 */
.insert {
    border: 1px solid black; /* 검은 테두리 */
    width: 600px; /* 폼의 너비 */
    height: auto; /* 높이를 콘텐츠에 맞게 조정 */
    display: flex; /* 플렉스 박스 사용 */
    flex-direction: column; /* 자식 요소를 세로로 배치 */
    align-items: center; /* 수평 가운데 정렬 */
    padding: 20px; /* 내부 여백 */
    background-color: #fff; /* 배경 흰색 */
    border-radius: 10px; /* 모서리를 둥글게 */
}

/* 폼 스타일 */
form {
    width: 80%; /* 폼 너비 설정 */
    display: flex; /* 플렉스 박스 사용 */
    flex-direction: column; /* 요소를 세로로 배치 */
    align-items: center; /* 자식 요소를 수평 중앙 정렬 */
    margin: 0 auto;
}

/* 입력 필드 공통 스타일 */
.insertInfo {
    width: 100%; /* 입력 필드 너비를 100%로 설정 */
    margin-bottom: 10px; /* 아래쪽 여백 */
    padding: 10px; /* 내부 여백 */
    border: 1px solid black; /* 검은 테두리 */
    border-radius: 5px; /* 모서리를 둥글게 */
}

/* 버튼 스타일 */
button {
    height: 40px; /* 버튼 높이 */
    width: 200px; /* 버튼 너비 */
    background-color: #FC8173; /* 버튼 배경색 */
    color: #EFECE5; /* 버튼 글자색 */
    border-radius: 20px; /* 버튼 모서리를 둥글게 */
    border: none; /* 테두리 제거 */
    cursor: pointer; /* 커서 스타일 변경 */
}

/* 회원가입 버튼 중앙 배치 */
button > .submit {
    height: 40px; /* 버튼 높이 */
    width: 200px; /* 버튼 너비 */
    background-color: #FC8173; /* 버튼 배경색 */
    color: #EFECE5; /* 버튼 글자색 */
    border-radius: 20px; /* 버튼 모서리를 둥글게 */
    border: none; /* 테두리 제거 */
    cursor: pointer; /* 커서 스타일 변경 */
    margin-top: 20px; /* 위 요소와 간격 */
    align-self: center; /* 부모 컨테이너에서 중앙 정렬 */
}

/* 개별 입력 그룹 간 간격 */
.form-group {
    width: 100%; /* 각 그룹의 너비를 부모 기준 100%로 설정 */
    display: flex; /* 플렉스 박스 사용 */
    justify-content: space-between; /* 자식 요소 간 간격 배분 */
    margin-bottom: 10px; /* 아래쪽 간격 추가 */
}

/* 중복 체크 버튼 스타일 */
input[type="button"] {
    width: auto; /* 너비를 내용에 맞게 조정 */
    margin-left: 10px; /* 입력 필드와 버튼 간의 간격 */
    padding: 10px; /* 내부 여백 */
    background-color: #FC8173; /* 버튼 배경색 */
    color: #EFECE5; /* 버튼 글자색 */
    border: none; /* 테두리 제거 */
    border-radius: 5px; /* 모서리를 둥글게 */
    cursor: pointer; /* 커서 스타일 변경 */
    height: 37px; /*중복 체크 버튼 높이 조정*/
}

.insert-wrap {
    display: flex;
    justify-content: center;
    padding: 100px;
    margin-right: 130px;
}

form {
    margin-top: 50px;
}

.btnWrap > button {
    width: 110px;
    height: 40px;
}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<main>
	<h1>주소지 추가</h1>
    <hr>
    <form action="/user/addAddr.do" id="addAddr" method="POST">
        <input type="hidden" id="userKey" name="userKey" value="${loginUser.userKey}">
        <div class="form-group">
            <input type="text" class="insertInfo" id="rcptNm" name="rcptNm" placeholder="수취인 이름">
        </div>
        <div class="form-group">
            <input type="text" class="insertInfo" id="rcptPhone" name="rcptPhone" placeholder="수취인 전화번호">
        </div>
        <div class="form-group">
            <input type="text" class="insertInfo" id="addrNm" name="addrNm" placeholder="주소지 이름">
        </div>
        <div class="form-group">
            <input type="text" class="insertInfo" id="addrCd" name="addrCd" placeholder="우편번호" readonly>
            <button type="button" onclick="srchAddr()">주소지 검색</button>
        </div>
        <div class="form-group">
            <input type="text" class="insertInfo" id="addr" name="addr" placeholder="주소" readonly>
        </div>
        <div class="form-group">
            <input type="text" class="insertInfo" id="addrDetail" name="addrDetail" placeholder="상세주소">
            <input type="text" class="insertInfo" id="addrRef" name="addrRef" placeholder="참고주소" readonly>
        </div>
        <div class="btn-group">
            <input type="button" onclick="undo(this)" value="돌아가기">
            <input type="button" onclick="submitBtn(this)" value="추가하기">
        </div>
    </form>
</main>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //주소찾기 버튼
    function srchAddr() {
        new daum.Postcode({
            oncomplete: function (data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if (data.userSelectedType === 'R') {
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if (data.buildingName !== '' && data.apartment === 'Y') {
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if (extraAddr !== '') {
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("addrRef").value = extraAddr;

                } else {
                    document.getElementById("addrRef").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById("addrCd").value = data.zonecode;
                document.getElementById("addr").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("addrDetail").focus();
            }
        }).open();
    }

    function submitBtn(button) {
        const rcptNm = $('#rcptNm').val();
        const rcptPhone = $('#rcptPhone').val();
        const addrCd = $('#addrCd').val();
        const addrDetail = $('#addrDetail').val();

        if (rcptNm.length < 1) {
            msg('알림', '수취인 이름을 입력해주세요', 'warning');
            return;
        } else if (rcptPhone.length < 1) {
            msg('알림', '수취인 전화번호를 입력해주세요', 'warning');
            return;
        } else if (addrCd.length < 1) {
            msg('알림', '주소 입력해주세요', 'warning');
            return;
        } else {
            $.ajax({
                url: "/user/addAddr.do",
                type: "POST",
                data: {
                    userKey: $('#userKey').val(),
                    addrNm: $('#addrNm').val(),
                    addrCd: addrCd,
                    addr: $('#addr').val(),
                    addrDetail: addrDetail,
                    addrRef: $('#addrRef').val(),
                    rcptNm: rcptNm,
                    rcptPhone: rcptPhone
                },
                success: function (res) {
                    if (res === "1") {
                        msg('알림', '주소 등록이 완료되었습니다', 'success', "location.href = '/user/addrListFrm.do';");
                    } else {
                        msg('알림', '주소 등록 중 오류가 발생했습니다', 'error');
                    }
                },
                error: function () {
                    console.log()
                }
            })
        }
    }

    function undo(button) {
        location.href = "addrListFrm.do";
    }
</script>
</body>
</html>