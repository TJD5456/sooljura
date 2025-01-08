<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
    background-color: #EFECE5; /* 연한 배경색 */
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
<jsp:include page="/WEB-INF/views/common/textHeader.jsp"/>
<main>
    <h1>주소지 수정</h1>
    <hr>
    <form action="/user/updAddr.do" id="updAddr" method="POST">
        <input type="hidden" name="addrKey" id="addrKey" value="${addrInfo.addrKey}">
        <input type="hidden" name="userKey" id="userKey" value="${addrInfo.userKey}">
        <div class="form-group">
            <input type="text" class="insertInfo" id="rcptNm" name="rcptNm" value="${addrInfo.rcptNm}">
        </div>
        <div class="form-group">
            <input type="text" class="insertInfo" id="rcptPhone" name="rcptPhone" value="${addrInfo.rcptPhone}">
        </div>
        <div class="form-group">
            <input type="text" class="insertInfo" id="addrNm" name="addrNm" value="${addrInfo.addrNm}">
        </div>
        <div class="form-group">
            <input type="text" class="insertInfo" id="addrCd" name="addrCd" value="${addrInfo.addrCd}" readonly>
            <button type="button" onclick="srchAddr()">주소지 검색</button>
        </div>
        <div class="form-group">
            <input type="text" class="insertInfo" id="addr" name="addr" value="${addrInfo.addr}" readonly>
        </div>
        <div class="form-group">
            <input type="text" class="insertInfo" id="addrDetail" name="addrDetail" value="${addrInfo.addrDetail}">
            <input type="text" class="insertInfo" id="addrRef" name="addrRef" value="${addrInfo.addrRef}" readonly>
        </div>
        <c:if test="${addrInfo.defaultYn == 0}">
            <div class="form-group">
                <input type="checkbox" name="defaultYnCheckbox" id="defaultYnCheckbox" onchange="setDefaultYn(this)">
                <span>기본 배송지로 설정</span>
            </div>
            <input type="hidden" name="defaultYn" id="defaultYn" value="0">
        </c:if>
        <div class="btnWrap">
            <button type="button" id="cancelButton" onclick="cancelBtn()">취소</button>
            <button type="button" id="saveButton" onclick="saveBtn()">저장</button>
        </div>
    </form>
</main>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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

    //수정 취소
    function cancelBtn() {
        location.href = "/user/addrListFrm.do";
    }

    //체크박스 체크 시 defaultYn값 1로 변경
    function setDefaultYn(checkbox) {
        document.getElementById('defaultYn').value = checkbox.checked ? 1 : 0;
    }

    //수정내용 저장
    function saveBtn() {
    	const userKey = $('#userKey').val();
    	
        swal({
            title: "알림",
            text: "주소를 수정하시겠습니까?",
            icon: "success",
            buttons: {
                cancel: {
                    text: "취소",
                    value: false,
                    visible: true,
                    closeModal: true
                },
                confirm: {
                    text: "수정",
                    value: true,
                    visible: true,
                    closeModal: true
                }
            }
        }).then(function (isConfirm) {
            if (isConfirm) {
                $.ajax({
                    url: "/user/updAddr.do",
                    type: "POST",
                    data: {
                        addrKey: $('#addrKey').val(),
                        userKey: $('#userKey').val(),
                        addrNm: $('#addrNm').val(),
                        addrCd: $('#addrCd').val(),
                        addr: $('#addr').val(),
                        addrDetail: $('#addrDetail').val(),
                        addrRef: $('#addrRef').val(),
                        rcptNm: $('#rcptNm').val(),
                        rcptPhone: $('#rcptPhone').val(),
                        defaultYn: $('#defaultYn').val()
                    },
                    success: function (res) {
                        if (res == "1" || res == "2") {
                            msg('알림', '수정이 완료되었습니다', 'success', "location.href = '/product/chgAddr.do?userKey="+userKey+"';");
                        } else {
                            msg('알림', '수정 중 오류가 발생했습니다', 'error');
                        }
                    },
                    error: function () {
                        console.log('ajax 오류');
                    }
                })
            }
        })
    }
</script>
</body>
</html>