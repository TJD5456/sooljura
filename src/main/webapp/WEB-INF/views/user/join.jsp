<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>sooljura</title>
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <style>
        /* 기본 스타일 초기화 */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box; /* 전체 요소에 패딩 포함한 너비 계산 */
        }

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

        .idVerif {
            justify-content: center;
        }

        #idVerif {
            width: 100%;
            height: 20px;
            border-radius: 5px;
            border: none; /* 테두리 제거 */
            box-shadow: none;

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

        input[type="button"]:hover {
            background-color: #f5afa5;
        }

        .insert-wrap {
            display: flex;
            justify-content: center;
            padding: 100px;
            margin-right: 130px;
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<main>
    <div class="insert-wrap">
        <div class="insert">
            <form action="/user/join.do" method="post">
                <div class="form-group">
                    <input type="text" class="insertInfo" id="userId" name="userId" placeholder="아이디 : 영어,숫자 8~12글자">
                    <input type="button" id="chkId" name="chkId" value="중복체크">
                </div>
                <div class="form-group">
                    <input type="password" class="insertInfo" id="userPw" name="userPw"
                           placeholder="비밀번호 : 영어,숫자,특수기호(!@#$%^&*) 8~16글자">
                </div>
                <div class="form-group">
                    <input type="password" class="insertInfo" id="userPwChk" name="userPwChk" placeholder="비밀번호 확인">
                </div>
                <div class="form-group">
                    <input type="text" class="insertInfo" id="userNickNm" name="userNickNm"
                           placeholder="닉네임 : 영어,숫자,한글 6~10글자">
                    <input type="button" id="chkNickname" name="chkNickname" value="중복체크">
                </div>
                <div class="form-group idVerif">
                    <button id="idVerif" type="button">본인인증</button>
                    <input type="hidden" name="adultChk" id="adultChk" value="">
                </div>
                <div class="form-group userNm">
                    <input type="text" class="insertInfo" id="userNm" name="userNm" placeholder="이름" value="">
                </div>
                <div class="form-group">
                    <input type="text" class="insertInfo" id="userEmail" name="userEmail" placeholder="이메일">
                </div>
                <div class="form-group userPhone">
                    <input type="text" class="insertInfo" id="userPhone" name="userPhone" placeholder="전화번호(-제외하고 입력)"
                           value="">
                </div>
                <div class="form-group">
                    <input type="text" class="insertInfo" id="addrCd" name="addrCd" placeholder="우편번호" readonly>
                    <input type="button" onclick="srchAddr()" value="주소지 검색">
                </div>
                <div class="form-group">
                    <input type="text" class="insertInfo" id="addr" name="addr" placeholder="주소" readonly>
                </div>
                <div class="form-group">
                    <input type="text" class="insertInfo" id="addrDetail" name="addrDetail" placeholder="상세주소">
                    <input type="text" class="insertInfo" id="addrRef" name="addrRef" placeholder="참고주소" readonly>
                </div>
                <%--<input type="hidden" name="adultChk" value=""> --%>
                <input type="button" onclick="insertBtn()" value="회원가입">
            </form>
        </div>
    </div>
</main>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>

    $('#idVerif').click(function () {
        //가맹점 식별코드 세팅(계정별 고유 Key)
        IMP.init("imp33782182");// 결제 연동 - 연동 정보 - 식별코드 . API Keys 탭
        // IMP.certification(param, callback) 호출
        IMP.certification(
            {   // param
                channelKey: "channel-key-460e5d65-a6eb-4c56-a371-431d22098b12",
                merchant_uid: "ORD20180131-0000011", // 주문 번호
                m_redirect_url: "/user/idVerif.do", // 모바일환경에서 popup:false(기본값) 인 경우 필수, 예: https://www.myservice.com/payments/complete/mobile
                popup: true, // PC환경에서는 popup 파라미터가 무시되고 항상 true 로 적용됨
            },
            function (rsp) {
                // callback
                if (rsp.success) {
                    // 인증 성공 시 로직
                    console.log(rsp.imp_uid);
                    console.log(rsp.success);
                    // jQuery로 HTTP 요청
                    $.ajax({
                        url: "/user/idVerif.do",
                        method: "POST",
                        //headers: { "Content-Type": "application/json" },
                        data: {
                            impUid: rsp.imp_uid,
                            success: rsp.success
                        },
                        success: function (res) {
                            console.log(res.userNm);
                            console.log(res.userPhone);
                            console.log(res.adultChk);
                            if (!res) {
                                setTimeout(function () {
                                    location.href = "/";
                                }, 2000); // 2초 후 리다이렉트
                                msg('알림', '만 20세 이상만 회원가입 할 수 있습니다.', 'error');
                            }
                            $('#idVerif').empty();
                            $('#idVerif').html('<p id="idVerifConfirm">본인인증 완료<p>');

                            $('.userNm').empty();
                            $('.userNm').html('<input type="text" class="insertInfo" id="userNm" name="userNm" placeholder="이름" value="' + res.userNm + '">');

                            $('.userPhone').empty();
                            $('.userPhone').html('<input type="text" class="insertInfo" id="userPhone" name="userPhone" placeholder="전화번호(-제외하고 입력)" value="' + res.userPhone + '">');

                            $('.idVerif').empty();
                            $('.idVerif').html('<input type="hidden" name="adultChk" id="adultChk" value="' + res.adultChk + '">');

                            setTimeout(function () {
                                $('#adultChk').trigger('change');
                            }, 10);
                        },
                        error: function () {
                            msg('알림', '성인', 'error');
                        }
                    });
                } else {
                    //alert("인증에 실패하였습니다. 에러 내용: " + rsp.error_msg);
                }
            }
        );


    });

    //유효성 검사
    const chkInfo = {
        "userId": false,
        "idChkBtn": false,
        "userPw": false,
        "userPwChk": false,
        "userNickNm": false,
        "userNickNmBtn": false,
        "userEmail": false,
        "addrCd": false,
        "adultChk": false
        //"userNm" : false,
        //"userPhone" : false,
    }
    //아이디 유효성 체크
    $('#chkId').on('click', function () {
        const idVal = $('#userId').val();
        const regExp = /^[a-zA-Z0-9]{8,12}$/;

        if (!regExp.test(idVal)) {
            msg('알림', '영어,숫자 8~12글자로 입력해주세요', 'error');
            return;
        } else {
            chkInfo.userId = true;
            $.ajax({
                url: "/user/chkId.do",
                data: {userId: idVal},
                type: "GET",
                success: function (res) {
                    if (res == "0") {
                        //아이디 중복 체크
                        msg('알림', '사용 가능한 아이디입니다', 'success');
                        chkInfo.idChkBtn = true;
                    } else {
                        msg('알림', '중복된 아이디입니다', 'error');
                    }
                },
                error: function () {
                    console.log('ajax 오류');
                }
            });
        }
    });

    //닉네임 유효성 체크
    $('#chkNickname').on('click', function () {
        const nicknameVal = $('#userNickNm').val();
        const regExp = /^[a-zA-Z가-힇0-9]{6,10}$/;

        if (!regExp.test(nicknameVal)) {
            msg('알림', '영어,숫자,한글 6~10글자로 입력해주세요', 'error');
            return;
        } else {
            chkInfo.userNickNm = true;
            $.ajax({
                url: "/user/chkNickname.do",
                data: {userNickNm: nicknameVal},
                type: "GET",
                success: function (res) {
                    //닉네임 중복체크
                    if (res == "0") {
                        msg('알림', '사용 가능한 닉네임입니다', 'success');
                        chkInfo.userNickNmBtn = true;
                    } else {
                        msg('알림', '중복된 닉네임입니다', 'error');
                    }
                },
                error: function () {
                    console.log('ajax 오류');
                }
            });
        }
    });

    //이메일 유효성 체크
    $('#userEmail').on('input', function () {
        const userEmailVal = $('#userEmail').val();
        const regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{3}$/;

        chkInfo.userEmail = regExp.test(userEmailVal);
        console.log('chkInfo.userEmail:' + chkInfo.userEmail);
    });

    //비밀번호 유효성 체크
    $('#userPw').on('input', function () {
        const regExp = /^[a-zA-Z0-9!@#$%^&*]{8,16}$/;
        const userPwVal = $('#userPw').val();

        chkInfo.userPw = regExp.test(userPwVal);
    });

    //비밀번호체크
    $('#userPwChk').on('input', function () {
        const userPwVal = $('#userPw').val();
        const userPwChkVal = $('#userPwChk').val();

        chkInfo.userPwChk = (userPwVal === userPwChkVal);
    });
    /*
    //이름 체크(null만 아니면 가능하게 + 영어,한글만 가능)
    $('#userNm').on('input', function(){
        const userNmVal = $('#userNm').val();
        const regExp = /^[a-zA-Z가-힇]{1,20}$/;
        chkInfo.userNm = regExp.test(userNmVal);
        console.log('chkInfo.userNm:', chkInfo.userNm);
    });

    //전화번호 유효성 체크
    $('#userPhone').on('input', function(){
        const userPhoneVal = $('#userPhone').val();
        const regExp = /^[0-9]{11}$/;

        chkInfo.userPhone = regExp.test(userPhoneVal);
        console.log('chkInfo.userPhone:', chkInfo.userPhone);
    });

    $('#addrCd').on('change', function(){
        const addrCdVal = $('#addrCd').val();
        if(addrCdVal != null){
            chkInfo.addrCd = true;
        }
        console.log('chkInfo.addrCd:'+ chkInfo.addrCd + " | " + addrCdVal);
    });

    if ($('#adultChk').val() == 1) {
        chkInfo.adultChk = true;
    }
    */
    $('#addrCd').on('change', function () {
        const addrCdVal = $(this).val().trim();
        if (addrCdVal != '') {
            chkInfo.addrCd = true;
            console.log('chkInfo.addrCd set to true | Value: ' + addrCdVal);
        }
    });
    $(document).on('change', '#adultChk', function () {
        const adultChkVal = $(this).val();
        if (adultChkVal === "1" || adultChkVal == 1) {
            chkInfo.adultChk = true;
        } else {
            chkInfo.adultChk = false;
        }
        console.log('chkInfo.adultChk: ', chkInfo.adultChk);
    });

    function insertBtn() {
        let str = "";
        console.log(chkInfo);
        for (let key in chkInfo) {
            if (!chkInfo[key]) {
                console.log(key);
                switch (key) {
                    case "userId":
                        str = "아이디 형식이 유효하지 않습니다.";
                        break;
                    case "idChkBtn":
                        str = "아이디 중복 체크를 진행하세요.";
                        break;
                    case "userPw":
                        str = "비밀번호 형식이 유효하지 않습니다.";
                        break;
                    case "userPwChk":
                        str = "비밀번호 확인 값이 일치하지 않습니다.";
                        break;
                    case "userNickNm":
                        str = "닉네임 형식이 유효하지 않습니다.";
                        break;
                    case "userNickNmBtn":
                        str = "닉네임 중복 체크를 진행하세요.";
                        break;
                    case "userNm":
                        str = "이름을 입력해주세요.";
                        break;
                    case "userEmail":
                        str = "이메일 형식이 유효하지 않습니다.";
                        break;
                    case "userPhone":
                        str = "전화번호 형식이 유효하지 않습니다.";
                        break;
                    case "addrCd":
                        str = "주소지 형식이 유효하지 않습니다.";
                        break;
                    case "adultChk":
                        str = "본인인증이 완료되지 않았습니다.";
                        break;
                }

                // 오류 메시지 출력 후 종료
                msg("회원가입 실패", str, "error");
                return false;
            }
        }
        //오류 없음
        document.querySelector('form').submit();
    }

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
                document.getElementById('addrCd').value = data.zonecode;
                document.getElementById("addr").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("addrDetail").focus();

                //function 완료시 JavaScript로 직접 변경되므로
                //사용자 이벤트로 트리거된 변경이 아니기 때문에 change 이벤트가 발생하지 않음
                //
                $('#addrCd').trigger('change');
            }
        }).open();
    }
</script>
</body>
</html>