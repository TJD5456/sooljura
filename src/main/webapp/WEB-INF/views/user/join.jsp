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
/* 기본 스타일 초기화 */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box; /* 전체 요소에 패딩 포함한 너비 계산 */
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
button >.submit {
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

.insert-wrap{
	display:flex;
	justify-content: center;
	padding: 130px;
}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="insert-wrap">
        <div class="insert">
            <form action="/user/join.do" method="post">
                <div class="form-group">
                    <input type="text" class="insertInfo" id="userId" name="userId" placeholder="아이디 : 영어,숫자 8~12글자">
                    <input type="button" id="chkId" name="chkId" value="중복체크">
                </div>
                <div class="form-group">
                    <input type="password" class="insertInfo" id="userPw" name="userPw" placeholder="비밀번호 : 영어,숫자,특수기호(!@#$%^&*) 8~16글자">
                </div>
                <div class="form-group">
                    <input type="password" class="insertInfo" id="userPwChk" name="userPwChk" placeholder="비밀번호 확인">
                </div>
                <div class="form-group">
                    <input type="text" class="insertInfo" id="userNickname" name="userNickname" placeholder="닉네임 : 영어,숫자,한글 6~10글자">
                    <input type="button" id="chkNickname" name="chkNickname" value="중복체크">
                </div>
                <div class="form-group">
                    <input type="text" class="insertInfo" id="userName" name="userName" placeholder="이름">
                </div>
                <div class="form-group">
                    <input type="text" class="insertInfo" id="userEmail" name="userEmail" placeholder="이메일">
                </div>
                <div class="form-group">
                    <input type="text" class="insertInfo" id="userPhone" name="userPhone" placeholder="전화번호(-제외하고 입력)">
                </div>
                <div class="form-group">
                    <input type="text" class="insertInfo" id="userAddr" name="userAddr" placeholder="주소">
                    <input type="button" name="chkAddr" value="주소지 검색">
                </div>
                <div class="form-group">
                    <input type="text" class="insertInfo" id="DetailAddr" name="DetailAddr" placeholder="상세주소">
                </div>
                <button type="submit" class="submit" name="insertBtn">회원가입</button>
            </form>
        </div>
    </div>
<script>
	//유효성 검사
	const chkInfo = {
			"userId" : false,
			"idChkBtn" : false,
			"userPw" : false,
			"userPwChk" : false,
			"userNickname" : false,
			"userNicknameBtn" : false,
			"userPhone" : false,
			"userEmail" : false
	}
	
	//아이디 유효성 체크
	const idVal = $('#userId').val();
	
	$('#chkId').on('click', function(){
		const regExp = /^[a-zA-z0-9]{8,12}$/;
		if(!regExp.test(idVal)){
			msg('알림', '영어,숫자 8~12글자로 입력해주세요', 'error');
			return;
		}else{
			chkInfo.userId = true;
		}
		$.ajax({
			url : "/user/chkId.do",
			data : {userId : idVal},
			type : "GET",
			success : function(res){
				if(res == '0'){
					//아이디 중복 체크
					msg('알림', '사용 가능한 아이디입니다', 'success');
					chkInfo.idChkBtn = true;
				}else{
					msg('알림', '중복된 아이디입니다', 'error');
				}
			},
			error : function(){
				console.log('ajax 오류');
			}
		});	
	});
	
	//닉네임 유효성 체크
	const nicknameVal = $('#userNickname').val();
	
	$('#chkNickname').on('click', function(){
		const regExp = /^[a-zA-z가-힇0-9]{6,10}$/;
		if(!regExp.test(nicknameVal)){
			msg('알림','영어,숫자,한글 6~10글자로 입력해주세요');
			return;
		}else{
			chkInfo.userNickname = true;
		}
		$.ajax({
			url : "/user/chkNickname.do",
			data : {userNickname : nicknameVal},
			type : "GET",
			success : function(){
				//닉네임 중복체크
				if(res == '0'){
					msg('알림', '사용 가능한 닉네임입니다', 'success');
					chkInf.nicknameChkBtn = true;
				}else{
					msg('알림', '중복된 닉네임입니다', 'error');
				}
			},
			error : function(){
				console.log('ajax 오류');
			}
		});
	});
	
	//전화번호 유효성 체크
	const userPhoneVal = $('#userPhone').val();
	
	userPhone.on('input', function(){
		const regExp = /^[0-9]{11}$/;
		
		if(regExp.test(userPhoneVal)){
			chkInfo.userPhone = true;
		}
	});
	
	//이메일 유효성 체크
	const userEmailVal = $('#userEmail').val();
	
	userEmail.on('input', function(){
		const regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{3}$/;
		
		if(regExp.test(userEmailVal)){
			chkInfo.userEmail = true;
		}
	});
	
	//비밀번호 유효성 체크

	
	//비밀번호체크 

	
	function joinValidate(){
		let str = "";
		
		for (let key in chkInfo) {
	        if (!chkInfo[key]) {
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
	                case "userEmail": 
	                    str = "이메일 형식이 유효하지 않습니다."; 
	                    break;
	                case "userPhone": 
	                    str = "전화번호 형식이 유효하지 않습니다."; 
	                    break;
	                case "userNickname": 
	                    str = "닉네임 형식이 유효하지 않습니다."; 
	                    break;
	                case "nicknameChkBtn": 
	                    str = "닉네임 중복 체크를 진행하세요."; 
	                    break;
	            }

	            // 오류 메시지 출력 후 종료
	            msg("회원가입 실패", str, "error");
	            return false;
	        }
	    }
		//오류 없음
		return true;
	}
</script>
</body>
</html>